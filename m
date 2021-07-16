Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06887C07E95
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Jul 2021 14:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D184A613F7
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Jul 2021 14:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbhGPODL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233130AbhGPODJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Jul 2021 10:03:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D05A613DF;
        Fri, 16 Jul 2021 14:00:12 +0000 (UTC)
Date:   Fri, 16 Jul 2021 10:00:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: [ANNOUNCE] 5.10.47-rt46
Message-ID: <20210716100010.1f59980c@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 5.10.47-rt46 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: dc5610d093cf6aa8eb3f79a2964c9b1064693f8d


Or to build 5.10.47-rt46 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  http://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.47.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.47-rt46.patch.xz



You can also build from 5.10.47-rt45 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10.47-rt45-rt46.patch.xz



Enjoy,

-- Steve


Changes from v5.10.47-rt45:

---

Peter Zijlstra (6):
      sched: Fix migration_cpu_stop() requeueing
      sched: Simplify migration_cpu_stop()
      sched: Collate affine_move_task() stoppers
      sched: Optimize migration_cpu_stop()
      sched: Fix affine_move_task() self-concurrency
      sched: Simplify set_affinity_pending refcounts

Steven Rostedt (VMware) (1):
      Linux 5.10.47-rt46

Valentin Schneider (1):
      sched: Don't defer CPU pick to migration_cpu_stop()

----
 kernel/sched/core.c | 144 ++++++++++++++++++++++++++--------------------------
 localversion-rt     |   2 +-
 2 files changed, 74 insertions(+), 72 deletions(-)
---------------------------
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d3aa9db1548..b1e87f304ade 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1898,8 +1898,13 @@ struct migration_arg {
 	struct set_affinity_pending	*pending;
 };
 
+/*
+ * @refs: number of wait_for_completion()
+ * @stop_pending: is @stop_work in use
+ */
 struct set_affinity_pending {
 	refcount_t		refs;
+	unsigned int		stop_pending;
 	struct completion	done;
 	struct cpu_stop_work	stop_work;
 	struct migration_arg	arg;
@@ -1934,10 +1939,9 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
  */
 static int migration_cpu_stop(void *data)
 {
-	struct set_affinity_pending *pending;
 	struct migration_arg *arg = data;
+	struct set_affinity_pending *pending = arg->pending;
 	struct task_struct *p = arg->task;
-	int dest_cpu = arg->dest_cpu;
 	struct rq *rq = this_rq();
 	bool complete = false;
 	struct rq_flags rf;
@@ -1957,7 +1961,6 @@ static int migration_cpu_stop(void *data)
 	raw_spin_lock(&p->pi_lock);
 	rq_lock(rq, &rf);
 
-	pending = p->migration_pending;
 	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
@@ -1968,31 +1971,27 @@ static int migration_cpu_stop(void *data)
 			goto out;
 
 		if (pending) {
-			p->migration_pending = NULL;
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
-		}
 
-		/* migrate_enable() --  we must not race against SCA */
-		if (dest_cpu < 0) {
-			/*
-			 * When this was migrate_enable() but we no longer
-			 * have a @pending, a concurrent SCA 'fixed' things
-			 * and we should be valid again. Nothing to do.
-			 */
-			if (!pending) {
-				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
+			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
 				goto out;
-			}
-
-			dest_cpu = cpumask_any_distribute(&p->cpus_mask);
 		}
 
 		if (task_on_rq_queued(p))
-			rq = __migrate_task(rq, &rf, p, dest_cpu);
+			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
 		else
-			p->wake_cpu = dest_cpu;
+			p->wake_cpu = arg->dest_cpu;
+
+		/*
+		 * XXX __migrate_task() can fail, at which point we might end
+		 * up running on a dodgy CPU, AFAICT this can only happen
+		 * during CPU hotplug, at which point we'll get pushed out
+		 * anyway, so it's probably not a big deal.
+		 */
 
-	} else if (dest_cpu < 0 || pending) {
+	} else if (pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -2007,43 +2006,32 @@ static int migration_cpu_stop(void *data)
 		 * ->pi_lock, so the allowed mask is stable - if it got
 		 * somewhere allowed, we're done.
 		 */
-		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			p->migration_pending = NULL;
+		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			if (p->migration_pending == pending)
+				p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
 
-		/*
-		 * When this was migrate_enable() but we no longer have an
-		 * @pending, a concurrent SCA 'fixed' things and we should be
-		 * valid again. Nothing to do.
-		 */
-		if (!pending) {
-			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
-			goto out;
-		}
-
 		/*
 		 * When migrate_enable() hits a rq mis-match we can't reliably
 		 * determine is_migration_disabled() and so have to chase after
 		 * it.
 		 */
+		WARN_ON_ONCE(!pending->stop_pending);
 		task_rq_unlock(rq, p, &rf);
 		stop_one_cpu_nowait(task_cpu(p), migration_cpu_stop,
 				    &pending->arg, &pending->stop_work);
 		return 0;
 	}
 out:
+	if (pending)
+		pending->stop_pending = false;
 	task_rq_unlock(rq, p, &rf);
 
 	if (complete)
 		complete_all(&pending->done);
 
-	/* For pending->{arg,stop_work} */
-	pending = arg->pending;
-	if (pending && refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
-
 	return 0;
 }
 
@@ -2230,11 +2218,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			    int dest_cpu, unsigned int flags)
 {
 	struct set_affinity_pending my_pending = { }, *pending = NULL;
-	struct migration_arg arg = {
-		.task = p,
-		.dest_cpu = dest_cpu,
-	};
-	bool complete = false;
+	bool stop_pending, complete = false;
 
 	/* Can the task run on the task's current CPU? If so, we're done */
 	if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask)) {
@@ -2246,12 +2230,16 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			push_task = get_task_struct(p);
 		}
 
+		/*
+		 * If there are pending waiters, but no pending stop_work,
+		 * then complete now.
+		 */
 		pending = p->migration_pending;
-		if (pending) {
-			refcount_inc(&pending->refs);
+		if (pending && !pending->stop_pending) {
 			p->migration_pending = NULL;
 			complete = true;
 		}
+
 		task_rq_unlock(rq, p, rf);
 
 		if (push_task) {
@@ -2260,7 +2248,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}
 
 		if (complete)
-			goto do_complete;
+			complete_all(&pending->done);
 
 		return 0;
 	}
@@ -2271,10 +2259,25 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
+			my_pending.arg = (struct migration_arg) {
+				.task = p,
+				.dest_cpu = dest_cpu,
+				.pending = &my_pending,
+			};
+
 			p->migration_pending = &my_pending;
 		} else {
 			pending = p->migration_pending;
 			refcount_inc(&pending->refs);
+			/*
+			 * Affinity has changed, but we've already installed a
+			 * pending. migration_cpu_stop() *must* see this, else
+			 * we risk a completion of the pending despite having a
+			 * task on a disallowed CPU.
+			 *
+			 * Serialized by p->pi_lock, so this is safe.
+			 */
+			pending->arg.dest_cpu = dest_cpu;
 		}
 	}
 	pending = p->migration_pending;
@@ -2295,45 +2298,41 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		return -EINVAL;
 	}
 
-	if (flags & SCA_MIGRATE_ENABLE) {
-
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
-		p->migration_flags &= ~MDF_PUSH;
-		task_rq_unlock(rq, p, rf);
-
-		pending->arg = (struct migration_arg) {
-			.task = p,
-			.dest_cpu = -1,
-			.pending = pending,
-		};
-
-		stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
-				    &pending->arg, &pending->stop_work);
-
-		return 0;
-	}
-
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
 		/*
-		 * Lessen races (and headaches) by delegating
-		 * is_migration_disabled(p) checks to the stopper, which will
-		 * run on the same CPU as said p.
+		 * MIGRATE_ENABLE gets here because 'p == current', but for
+		 * anything else we cannot do is_migration_disabled(), punt
+		 * and have the stopper function handle it all race-free.
 		 */
+		stop_pending = pending->stop_pending;
+		if (!stop_pending)
+			pending->stop_pending = true;
+
+		if (flags & SCA_MIGRATE_ENABLE)
+			p->migration_flags &= ~MDF_PUSH;
+
 		task_rq_unlock(rq, p, rf);
-		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 
+		if (!stop_pending) {
+			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
+					    &pending->arg, &pending->stop_work);
+		}
+
+		if (flags & SCA_MIGRATE_ENABLE)
+			return 0;
 	} else {
 
 		if (!is_migration_disabled(p)) {
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
-			p->migration_pending = NULL;
-			complete = true;
+			if (!pending->stop_pending) {
+				p->migration_pending = NULL;
+				complete = true;
+			}
 		}
 		task_rq_unlock(rq, p, rf);
 
-do_complete:
 		if (complete)
 			complete_all(&pending->done);
 	}
@@ -2341,7 +2340,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	wait_for_completion(&pending->done);
 
 	if (refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
+		wake_up_var(&pending->refs); /* No UaF, just an address */
 
 	/*
 	 * Block the original owner of &pending until all subsequent callers
@@ -2349,6 +2348,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
+	/* ARGH */
+	WARN_ON_ONCE(my_pending.stop_pending);
+
 	return 0;
 }
 
diff --git a/localversion-rt b/localversion-rt
index 38c40b21a885..272158183778 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt45
+-rt46
