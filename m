Return-Path: <SRS0=zdjp=43=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308F8C18E5A
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBC721927
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Mar 2020 17:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgCJRb6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:31:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJRb6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Mar 2020 13:31:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 812332146E;
        Tue, 10 Mar 2020 17:31:56 +0000 (UTC)
Date:   Tue, 10 Mar 2020 13:31:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 4.19.106-rt45
Message-ID: <20200310133154.6656b339@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 4.19.106-rt45 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: d515995ead09469fbddcb2ffff800caab9cb0c5f


Or to build 4.19.106-rt45 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.106.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.106-rt45.patch.xz



You can also build from 4.19.106-rt44 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.106-rt44-rt45.patch.xz



Enjoy,

-- Steve


Changes from v4.19.106-rt44:

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

Steven Rostedt (VMware) (1):
      Linux 4.19.106-rt45

----
 drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c |  2 --
 fs/userfaultfd.c                     | 12 ++++++------
 include/linux/locallock.h            |  1 +
 include/linux/trace_events.h         |  3 +--
 kernel/sched/core.c                  | 23 ++++++++++++++---------
 kernel/trace/trace_events.c          |  4 ++--
 localversion-rt                      |  2 +-
 mm/memcontrol.c                      |  2 +-
 8 files changed, 26 insertions(+), 23 deletions(-)
---------------------------
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fifo.c
index d0fd147ef75f..fb5a3461bb8c 100644
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
index d269d1139f7f..ff6be687f68e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -61,7 +61,7 @@ struct userfaultfd_ctx {
 	/* waitqueue head for events */
 	wait_queue_head_t event_wqh;
 	/* a refile sequence protected by fault_pending_wqh lock */
-	struct seqcount refile_seq;
+	seqlock_t refile_seq;
 	/* pseudo fd refcounting */
 	atomic_t refcount;
 	/* userfaultfd syscall flags */
@@ -1064,7 +1064,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			 * waitqueue could become empty if this is the
 			 * only userfault.
 			 */
-			write_seqcount_begin(&ctx->refile_seq);
+			write_seqlock(&ctx->refile_seq);
 
 			/*
 			 * The fault_pending_wqh.lock prevents the uwq
@@ -1090,7 +1090,7 @@ static ssize_t userfaultfd_ctx_read(struct userfaultfd_ctx *ctx, int no_wait,
 			list_del(&uwq->wq.entry);
 			add_wait_queue(&ctx->fault_wqh, &uwq->wq);
 
-			write_seqcount_end(&ctx->refile_seq);
+			write_sequnlock(&ctx->refile_seq);
 
 			/* careful to always initialize msg if ret == 0 */
 			*msg = uwq->msg;
@@ -1263,11 +1263,11 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
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
@@ -1938,7 +1938,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 	init_waitqueue_head(&ctx->fault_wqh);
 	init_waitqueue_head(&ctx->event_wqh);
 	init_waitqueue_head(&ctx->fd_wqh);
-	seqcount_init(&ctx->refile_seq);
+	seqlock_init(&ctx->refile_seq);
 }
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 921eab83cd34..81c89d87723b 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -3,6 +3,7 @@
 
 #include <linux/percpu.h>
 #include <linux/spinlock.h>
+#include <asm/current.h>
 
 #ifdef CONFIG_PREEMPT_RT_BASE
 
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 72864a11cec0..e26a85c1b7ba 100644
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
index 4616c086dd26..02e51c74e0bf 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7291,6 +7291,9 @@ static void migrate_disabled_sched(struct task_struct *p)
 	p->migrate_disable_scheduled = 1;
 }
 
+static DEFINE_PER_CPU(struct cpu_stop_work, migrate_work);
+static DEFINE_PER_CPU(struct migration_arg, migrate_arg);
+
 void migrate_enable(void)
 {
 	struct task_struct *p = current;
@@ -7329,23 +7332,25 @@ void migrate_enable(void)
 
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
index 1febb0ca4c81..07b8f5bfd263 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -188,8 +188,8 @@ static int trace_define_common_fields(void)
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
index ac4d836a809d..38c40b21a885 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt44
+-rt45
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 421ac74450f6..519528959eef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6540,10 +6540,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	mem_cgroup_charge_statistics(memcg, page, PageTransHuge(page),
 				     -nr_entries);
 	memcg_check_events(memcg, page);
+	local_unlock_irqrestore(event_lock, flags);
 
 	if (!mem_cgroup_is_root(memcg))
 		css_put_many(&memcg->css, nr_entries);
-	local_unlock_irqrestore(event_lock, flags);
 }
 
 /**
