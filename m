From: Mike Galbraith <bitbucket@online.de>
Subject: [patch 2/3] ipc/sem: revert ipc/sem: Rework semaphore wakeups
Date: Fri, 13 Sep 2013 08:12:50 +0200
Message-ID: <1379052770.5455.128.camel@marge.simpson.net>
References: <1379051751.5455.112.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53312 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552Ab3IMGNB (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Sep 2013 02:13:01 -0400
In-Reply-To: <1379051751.5455.112.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ipc/sem: revert ipc/sem: Rework semaphore wakeups

Revert Peterz's -rt wakeup scheme to prepare for replacement with a new
completion scheme by Manfred Spraul.

<original changelog>
ipc/sem: Rework semaphore wakeups
Current sysv sems have a weird ass wakeup scheme that involves keeping
preemption disabled over a potential O(n^2) loop and busy waiting on
that on other CPUs.

Kill this and simply wake the task directly from under the sem_lock.

This was discovered by a migrate_disable() debug feature that
disallows:

  spin_lock();
  preempt_disable();
  spin_unlock()
  preempt_enable();
</original changelog>

Signed-off-by: 	Mike Galbraith <bitbucket@online.de>
---
 ipc/sem.c |   24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -155,7 +155,7 @@ static int sysvipc_sem_proc_show(struct
  *	sem_array.sem_pending{,last},
  *	sem_array.sem_undo: sem_lock() for read/write
  *	sem_undo.proc_next: only "current" is allowed to read/write that field.
- *
+ *
  */
 
 #define sc_semmsl	sem_ctls[0]
@@ -518,7 +518,7 @@ static int try_atomic_semop (struct sem_
 		curr = sma->sem_base + sop->sem_num;
 		sem_op = sop->sem_op;
 		result = curr->semval;
-
+
 		if (!sem_op && result)
 			goto would_block;
 
@@ -545,7 +545,7 @@ static int try_atomic_semop (struct sem_
 			un->semadj[sop->sem_num] -= sop->sem_op;
 		sop--;
 	}
-
+
 	return 0;
 
 out_of_range:
@@ -577,13 +577,6 @@ static int try_atomic_semop (struct sem_
 static void wake_up_sem_queue_prepare(struct list_head *pt,
 				struct sem_queue *q, int error)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
-	struct task_struct *p = q->sleeper;
-	get_task_struct(p);
-	q->status = error;
-	wake_up_process(p);
-	put_task_struct(p);
-#else
 	if (list_empty(pt)) {
 		/*
 		 * Hold preempt off so that we don't get preempted and have the
@@ -595,7 +588,6 @@ static void wake_up_sem_queue_prepare(st
 	q->pid = error;
 
 	list_add_tail(&q->list, pt);
-#endif
 }
 
 /**
@@ -609,7 +601,6 @@ static void wake_up_sem_queue_prepare(st
  */
 static void wake_up_sem_queue_do(struct list_head *pt)
 {
-#ifndef CONFIG_PREEMPT_RT_BASE
 	struct sem_queue *q, *t;
 	int did_something;
 
@@ -622,7 +613,6 @@ static void wake_up_sem_queue_do(struct
 	}
 	if (did_something)
 		preempt_enable();
-#endif
 }
 
 static void unlink_queue(struct sem_array *sma, struct sem_queue *q)
@@ -977,7 +967,7 @@ static int semctl_nolock(struct ipc_name
 		err = security_sem_semctl(NULL, cmd);
 		if (err)
 			return err;
-
+
 		memset(&seminfo,0,sizeof(seminfo));
 		seminfo.semmni = ns->sc_semmni;
 		seminfo.semmns = ns->sc_semmns;
@@ -997,7 +987,7 @@ static int semctl_nolock(struct ipc_name
 		}
 		max_id = ipc_get_maxid(&sem_ids(ns));
 		up_read(&sem_ids(ns).rw_mutex);
-		if (copy_to_user(p, &seminfo, sizeof(struct seminfo)))
+		if (copy_to_user(p, &seminfo, sizeof(struct seminfo)))
 			return -EFAULT;
 		return (max_id < 0) ? 0: max_id;
 	}
@@ -1672,7 +1662,7 @@ SYSCALL_DEFINE4(semtimedop, int, semid,
 	/* We need to sleep on this operation, so we put the current
 	 * task into the pending queue and go to sleep.
 	 */
