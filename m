Return-Path: <SRS0=1Nl2=SM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1E9C10F11
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Apr 2019 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E60B20818
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Apr 2019 14:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfDJOn0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Apr 2019 10:43:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60060 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732818AbfDJOn0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Apr 2019 10:43:26 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEERe-0002yE-0n; Wed, 10 Apr 2019 16:43:22 +0200
Date:   Wed, 10 Apr 2019 16:43:21 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     bpf@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     tglx@linutronix.de, Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RT] bpf: Guard bpf_prog_active with a locallock
Message-ID: <20190410144321.q5tlqqzmmojdjrzu@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The bpf_prog_active counter is used to avoid recursion on the same CPU.
On RT we can't keep it with the preempt-disable part because the syscall
may need to acquire locks or allocate memory.

Use a locallock() to avoid recursion on the same CPU.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/bpf.h      |  2 ++
 kernel/bpf/hashtab.c     |  4 ++--
 kernel/bpf/syscall.c     | 13 +++++++------
 kernel/events/core.c     |  3 ++-
 kernel/trace/bpf_trace.c |  5 ++---
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e734f163bd0b9..667f45de65be8 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -16,6 +16,7 @@
 #include <linux/rbtree_latch.h>
 #include <linux/numa.h>
 #include <linux/wait.h>
+#include <linux/locallock.h>
 
 struct bpf_verifier_env;
 struct perf_event;
@@ -467,6 +468,7 @@ _out:							\
 
 #ifdef CONFIG_BPF_SYSCALL
 DECLARE_PER_CPU(int, bpf_prog_active);
+DECLARE_LOCAL_IRQ_LOCK(bpf_prog_active_lock);
 
 extern const struct file_operations bpf_map_fops;
 extern const struct file_operations bpf_prog_fops;
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index b4f903a5ef36e..15120d2d8b659 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -668,11 +668,11 @@ static void htab_elem_free_rcu(struct rcu_head *head)
 	 * we're calling kfree, otherwise deadlock is possible if kprobes
 	 * are placed somewhere inside of slub
 	 */
-	preempt_disable();
+	local_lock(bpf_prog_active_lock);
 	__this_cpu_inc(bpf_prog_active);
 	htab_elem_free(htab, l);
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	local_unlock(bpf_prog_active_lock);
 }
 
 static void free_htab_elem(struct bpf_htab *htab, struct htab_elem *l)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 84470d1480aa4..73f2edbe3b28c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -42,6 +42,7 @@
 #define BPF_OBJ_FLAG_MASK   (BPF_F_RDONLY | BPF_F_WRONLY)
 
 DEFINE_PER_CPU(int, bpf_prog_active);
+DEFINE_LOCAL_IRQ_LOCK(bpf_prog_active_lock);
 static DEFINE_IDR(prog_idr);
 static DEFINE_SPINLOCK(prog_idr_lock);
 static DEFINE_IDR(map_idr);
@@ -716,7 +717,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		goto done;
 	}
 
-	preempt_disable();
+	local_lock(bpf_prog_active_lock);
 	this_cpu_inc(bpf_prog_active);
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -750,7 +751,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 		rcu_read_unlock();
 	}
 	this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	local_unlock(bpf_prog_active_lock);
 
 done:
 	if (err)
@@ -845,7 +846,7 @@ static int map_update_elem(union bpf_attr *attr)
 	/* must increment bpf_prog_active to avoid kprobe+bpf triggering from
 	 * inside bpf map update or delete otherwise deadlocks are possible
 	 */
-	preempt_disable();
+	local_lock(bpf_prog_active_lock);
 	__this_cpu_inc(bpf_prog_active);
 	if (map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
 	    map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
@@ -878,7 +879,7 @@ static int map_update_elem(union bpf_attr *attr)
 		rcu_read_unlock();
 	}
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	local_unlock(bpf_prog_active_lock);
 	maybe_wait_bpf_programs(map);
 out:
 free_value:
@@ -925,13 +926,13 @@ static int map_delete_elem(union bpf_attr *attr)
 		goto out;
 	}
 
-	preempt_disable();
+	local_lock(bpf_prog_active_lock);
 	__this_cpu_inc(bpf_prog_active);
 	rcu_read_lock();
 	err = map->ops->map_delete_elem(map, key);
 	rcu_read_unlock();
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	local_unlock(bpf_prog_active_lock);
 	maybe_wait_bpf_programs(map);
 out:
 	kfree(key);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b3155a155a645..6facb80af7c0e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8546,7 +8546,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 	int ret = 0;
 
 	ctx.regs = perf_arch_bpf_user_pt_regs(regs);
-	preempt_disable();
+	local_lock(bpf_prog_active_lock);
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1))
 		goto out;
 	rcu_read_lock();
@@ -8555,6 +8555,7 @@ static void bpf_overflow_handler(struct perf_event *event,
 out:
 	__this_cpu_dec(bpf_prog_active);
 	preempt_enable();
+	local_unlock(bpf_prog_active_lock);
 	if (!ret)
 		return;
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index f1a86a0d881dd..bb92cf31481b4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -78,8 +78,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 	if (in_nmi()) /* not supported yet */
 		return 1;
 
-	preempt_disable();
-
+	local_lock(bpf_prog_active_lock);
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
 		/*
 		 * since some bpf program is already running on this cpu,
@@ -110,7 +109,7 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 
  out:
 	__this_cpu_dec(bpf_prog_active);
-	preempt_enable();
+	local_unlock(bpf_prog_active_lock);
 
 	return ret;
 }
-- 
2.20.1

