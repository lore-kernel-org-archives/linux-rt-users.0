Return-Path: <SRS0=mD49=5B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE101C2BB1D
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACCD9206C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Mar 2020 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584376340;
	bh=4StVk6LLQOCHKnL/01kQ1CtcE19qTA3QaaUjaobztQc=;
	h=Subject:From:To:Date:List-ID:From;
	b=1PqKba/mUJQ79DVLPvObMS6zwr2707PB2lojQ6nI76cfWOcRadXeQMwqYroZK5WT5
	 p/Ohtj+LNCA5kWsVC+Tgmoa1MUuFDrba33qcl4RXN1U7b4F2rvUN+HaLtOB184ZIU5
	 VeM+iJahANRT1uzkzN3PatGM5AX97+pH8sMQ51kM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgCPQcQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731924AbgCPQcQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Mar 2020 12:32:16 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F17520663;
        Mon, 16 Mar 2020 16:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584376335;
        bh=4StVk6LLQOCHKnL/01kQ1CtcE19qTA3QaaUjaobztQc=;
        h=Subject:From:To:Date:From;
        b=QTmS9C16oLJlrYxlzxfCPS83rbPrLy9wR0hOrZ6642qWlUwTY7ae+WG0duBV9mB9H
         R2Ru+k9l8cD8AyyYDHteyhMNGT6795v0MZNYm3QZqGFzC9G6gW0pbFawyH4OZ1tWfV
         CSXvgpj25CoYZTrXeNFdbpNnct3aWON4D0L/JJ38=
Message-ID: <1584376333.8836.3.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.172-rt78
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Mon, 16 Mar 2020 11:32:13 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.172-rt78 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 5c41599ad817e04c88d08a46941fbeafdf778e3d

Or to build 4.14.172-rt78 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.172.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.172-rt78.patch.xz


You can also build from 4.14.172-rt77 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/incr/patch-4.14.172-rt77-rt78.patch.xz

Enjoy!

   Tom

Changes from v4.14.172-rt77:
---

Matt Fleming (1):
      mm/memcontrol: Move misplaced local_unlock_irqrestore()

Scott Wood (2):
      sched: migrate_enable: Use per-cpu cpu_stop_work
      sched: migrate_enable: Remove __schedule() call

Sebastian Andrzej Siewior (4):
      userfaultfd: Use a seqlock instead of seqcount
      locallock: Include header for the `current' macro
      drm/vmwgfx: Drop preempt_disable() in vmw_fifo_ping_host()
      tracing: make preempt_lazy and migrate_disable counter smaller

Tom Zanussi (1):
      Linux 4.14.172-rt78
---
drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c |  2 --
 fs/userfaultfd.c                     | 12 ++++++------
 include/linux/locallock.h            |  1 +
 include/linux/trace_events.h         |  3 +--
 kernel/sched/core.c                  | 23 ++++++++++++++---------
 kernel/trace/trace_events.c          |  4 ++--
 localversion-rt                      |  2 +-
 mm/memcontrol.c                      |  2 +-
 8 files changed, 26 insertions(+), 23 deletions(-)
---
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
index a1c68e6a689e3..713f202fca2cd 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
@@ -167,10 +167,8 @@ void vmw_fifo_ping_host(struct vmw_private *dev_priv, uint32_t reason)
 {
 	u32 *fifo_mem = dev_priv->mmio_virt;
 
-	preempt_disable();
 	if (cmpxchg(fifo_mem + SVGA_FIFO_BUSY, 0, 1) == 0)
 		vmw_write(dev_priv, SVGA_REG_SYNC, reason);
-	preempt_enable();
 }
 
 void vmw_fifo_release(struct vmw_private *dev_priv, struct vmw_fifo_state *fifo)
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e2b2196fd9428..71886a8e8f71b 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -51,7 +51,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqlock_t refile_seq;
 	/* pseudo fd refcounting */
 	atomic_t refcount;
 	/* userfaultfd syscall flags */
@@ -1047,7 +1047,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			 * waitqueue could become empty if this is the
 			 * only userfault.
 			 */
-			write_seqcount_begin(&ctx->refile_seq);
+			write_seqlock(&ctx->refile_seq);
 
 			/*
 			 * The fault_pending_wqh.lock prevents the uwq
@@ -1073,7 +1073,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			list_del(&uwq->wq.entry);
 			__add_wait_queue(&ctx->fault_wqh, &uwq->wq);
 
-			write_seqcount_end(&ctx->refile_seq);
+			write_sequnlock(&ctx->refile_seq);
 
 			/* careful to always initialize msg if ret == 0 */
 			*msg = uwq->msg;
@@ -1246,11 +1246,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 	 * sure we've userfaults to wake.
 	 */
 	do {
-		seq = read_seqcount_begin(&ctx->refile_seq);
+		seq = read_seqbegin(&ctx->refile_seq);
 		need_wakeup = waitqueue_active(&ctx->fault_pending_wqh) ||
 			waitqueue_active(&ctx->fault_wqh);
 		cond_resched();
-	} while (read_seqcount_retry(&ctx->refile_seq, seq));
+	} while (read_seqretry(&ctx->refile_seq, seq));
 	if (need_wakeup)
 		__wake_userfault(ctx, range);
 }
@@ -1915,7 +1915,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqlock_init(&ctx->refile_seq);
 }
 
 /**
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 921eab83cd34a..81c89d87723b5 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -3,6 +3,7 @@
 
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
+#include <asm/current.h>
 
 #ifdef CONFIG_PREEMPT_RT_BASE
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index edd1e42e8a2f7..01e9ab3107531 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -62,8 +62,7 @@ struct trace_entry {
 	unsigned char		flags;
 	unsigned char		preempt_count;
 	int			pid;
-	unsigned short		migrate_disable;
-	unsigned short		padding;
+	unsigned char		migrate_disable;
 	unsigned char		preempt_lazy_count;
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f30bb249123b5..3ff48df25cff8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6964,6 +6964,9 @@ static void migrate_disabled_sched(struct task_struct *p)
 	p->migrate_disable_scheduled = 1;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
+static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -7002,23 +7005,25 @@ void migrate_enable(void)
 
 	WARN_ON(smp_processor_id() != cpu);
 	if (!is_cpu_allowed(p, cpu)) {
-		struct migration_arg arg = { .task = p };
-		struct cpu_stop_work work;
+		struct migration_arg __percpu *arg;
+		struct cpu_stop_work __percpu *work;
 		struct rq_flags rf;
 
+		work = this_cpu_ptr(&migrate_work);
+		arg = this_cpu_ptr(&migrate_arg);
+		WARN_ON_ONCE(!arg->done && !work->disabled && work->arg);
+
+		arg->task = p;
+		arg->done = false;
+
 		rq = task_rq_lock(p, &rf);
 		update_rq_clock(rq);
-		arg.dest_cpu = select_fallback_rq(cpu, p);
+		arg->dest_cpu = select_fallback_rq(cpu, p);
 		task_rq_unlock(rq, p, &rf);
 
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
-				    &arg, &work);
+				    arg, work);
 		tlb_migrate_finish(p->mm);
-		__schedule(true);
-		if (!work.disabled) {
-			while (!arg.done)
-				cpu_relax();
-		}
 	}
 
 out:
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 60e371451ec31..edd43841c94ad 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -187,8 +187,8 @@ static int trace_define_common_fields(void)
 	__common_field(unsigned char, flags);
 	__common_field(unsigned char, preempt_count);
 	__common_field(int, pid);
-	__common_field(unsigned short, migrate_disable);
-	__common_field(unsigned short, padding);
+	__common_field(unsigned char, migrate_disable);
+	__common_field(unsigned char, preempt_lazy_count);
 
 	return ret;
 }
diff --git a/localversion-rt b/localversion-rt
index 595841feef807..30758e0b2242b 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt77
+-rt78
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0503b31e2a873..a359a24ebd9f0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6102,10 +6102,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
 				     -nr_entries);
 	memcg_check_events(memcg, page);
+	local_unlock_irqrestore(event_lock, flags);
 
 	if (!mem_cgroup_is_root(memcg))
 		css_put_many(&memcg->css, nr_entries);
-	local_unlock_irqrestore(event_lock, flags);
 }
 
 /**
