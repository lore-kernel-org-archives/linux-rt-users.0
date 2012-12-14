From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: [PATCH RT 1/2] sched: Queue RT tasks to head when prio drops
Date: Fri, 14 Dec 2012 09:13:10 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA339629E283782@KEBMXSPMB01.keba.co.at>
References: <20121212004557.110050982@goodmis.org>
 <20121212004820.598190405@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>
To: 'Steven Rostedt' <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xgmegw04.mdcs.at ([217.13.183.4]:58986 "EHLO xgmegw04.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750986Ab2LNIVA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Dec 2012 03:21:00 -0500
In-Reply-To: <20121212004820.598190405@goodmis.org>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

we tested this patch successfully with 3.2.35-rt53-rc1. The failure
could not be reproduced in a 16 hours test run, so we are pretty
sure that the failure is gone.

Thanks for the quick inclusion of this pacth in stable-rt series!

Best Regards, Gerhard Engleder

-----Urspr=FCngliche Nachricht-----
Von: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@=
vger.kernel.org] Im Auftrag von Steven Rostedt
Gesendet: Mittwoch, 12. Dezember 2012 01:46
An: linux-kernel@vger.kernel.org; linux-rt-users
Cc: Thomas Gleixner; Carsten Emde; John Kacur; stable@vger.kernel.org; =
stable-rt@vger.kernel.org
Betreff: [PATCH RT 1/2] sched: Queue RT tasks to head when prio drops

=46rom: Thomas Gleixner <tglx@linutronix.de>

The following scenario does not work correctly:

Runqueue of CPU1 contains two runnable and pinned tasks:
	 T1: SCHED_FIFO, prio 80
	 T2: SCHED_FIFO, prio 80

T1 is on the cpu and executes the following syscalls (classic priority =
ceiling scenario):

 sys_sched_setscheduler(pid(T1), SCHED_FIFO, .prio =3D 90);  ...
 sys_sched_setscheduler(pid(T1), SCHED_FIFO, .prio =3D 80);  ...

Now T1 gets preempted by T3 (SCHED_FIFO, prio 95). After T3 goes back t=
o sleep the scheduler picks T2. Surprise!

The same happens w/o actual preemption when T1 is forced into the sched=
uler due to a sporadic NEED_RESCHED event. The scheduler invokes
pick_next_task() which returns T2. So T1 gets preempted and scheduled o=
ut.

This happens because sched_setscheduler() dequeues T1 from the prio 90 =
list and then enqueues it on the tail of the prio 80 list behind T2.
This violates the POSIX spec and surprises user space which relies on t=
he guarantee that SCHED_FIFO tasks are not scheduled out unless they gi=
ve the CPU up voluntarily or are preempted by a higher priority task. I=
n the latter case the preempted task must get back on the CPU after the=
 preempting task schedules out again.

We fixed a similar issue already in commit 60db48c(sched: Queue a deboo=
sted task to the head of the RT prio queue). The same treatment is nece=
ssary for sched_setscheduler().

While analyzing the problem I noticed that the fix in
rt_mutex_setprio() is one off. The head queueing depends on old priorit=
y greater than new priority (user space view), but in fact it needs to =
have the same treatment for equal priority. Instead of blindly changing=
 the condition to <=3D it's better to avoid the whole dequeue/requeue b=
usiness for the equal priority case completely.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/sched/core.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c index 1f9d6f5..0=
54e669 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4117,6 +4117,8 @@ void rt_mutex_setprio(struct task_struct *p, int =
prio)
=20
 	trace_sched_pi_setprio(p, prio);
 	oldprio =3D p->prio;
+	if (oldprio =3D=3D prio)
+		goto out_unlock;
 	prev_class =3D p->sched_class;
 	on_rq =3D p->on_rq;
 	running =3D task_current(rq, p);
@@ -4472,6 +4474,13 @@ recheck:
 		task_rq_unlock(rq, p, &flags);
 		goto recheck;
 	}
+
+	p->sched_reset_on_fork =3D reset_on_fork;
+
+	oldprio =3D p->prio;
+	if (oldprio =3D=3D param->sched_priority)
+		goto out;
+
 	on_rq =3D p->on_rq;
 	running =3D task_current(rq, p);
 	if (on_rq)
@@ -4479,18 +4488,17 @@ recheck:
 	if (running)
 		p->sched_class->put_prev_task(rq, p);
=20
-	p->sched_reset_on_fork =3D reset_on_fork;
-
-	oldprio =3D p->prio;
 	prev_class =3D p->sched_class;
 	__setscheduler(rq, p, policy, param->sched_priority);
=20
 	if (running)
 		p->sched_class->set_curr_task(rq);
 	if (on_rq)
-		enqueue_task(rq, p, 0);
+		enqueue_task(rq, p, oldprio < param->sched_priority ?
+			     ENQUEUE_HEAD : 0);
=20
 	check_class_changed(rq, p, prev_class, oldprio);
+out:
 	task_rq_unlock(rq, p, &flags);
=20
 	rt_mutex_adjust_pi(p);
--
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
