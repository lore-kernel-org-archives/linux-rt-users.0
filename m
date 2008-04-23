From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: [PATCH 1/2] sched: push rt tasks only if newly activated tasks have been added
Date: Wed, 23 Apr 2008 11:53:47 +0200
Message-ID: <b647ffbd0804230253i32f48fcgb5dc7cf5b55607ac@mail.gmail.com>
References: <20080421180747.4560.67794.stgit@novell1.haskins.net>
	 <20080421181015.4560.7658.stgit@novell1.haskins.net>
	 <b647ffbd0804220830h6524e788n1467b027bc5bc4d2@mail.gmail.com>
	 <Pine.LNX.4.58.0804221144410.21511@gandalf.stny.rr.com>
	 <b647ffbd0804230105u7966ed06wd4ed248f59132849@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Gregory Haskins" <ghaskins@novell.com>, mingo@elte.hu,
	suresh.b.siddha@intel.com, chinang.ma@intel.com,
	arjan@linux.intel.com, willy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Steven Rostedt" <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:22816 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756604AbYDWJxs (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2008 05:53:48 -0400
Received: by wa-out-1112.google.com with SMTP id m16so4512327waf.23
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Apr 2008 02:53:47 -0700 (PDT)
In-Reply-To: <b647ffbd0804230105u7966ed06wd4ed248f59132849@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2008/4/23 Dmitry Adamushko <dmitry.adamushko@gmail.com>:
> Hi Steven,
>
>  > [ ... ]
>
> >  > square#0:
>  >  >
>  >  > cpu1:  T0 is running
>  >  >
>  >  > T1 is of the same prio as T0 (shouldn't really matter but to get the
>  >  > same result it would require altering the flow of events slightly)
>  >  >
>  >  > T1's affinity allows it to be run only on cpu1.
>  >  > T0 can run on both.
>  >  >
>  >  > try_to_wake_up() is called for T1.
>  >  > |
>  >  > --> select_task_rq_rt() => gives cpu1
>  >  > |
>  >  > --> task_wake_up_rt()
>  >  >    |
>  >  >    ---> push_rt_tasks() -> rq->rt.pushed = 1
>  >  >
>  >  > now, neither T1 (due to its affinity), nor T0 (it's running) can be
>  >  > pushed away to cpu0.
>  >
>  >  Ah, this may be what you are talking about. T0 was running, but because
>  >  T1 has its affinity set to cpu1 it wont cause a push. When T0 schedules
>  >  away to give T1 its cpu time, T0 wont push away because of the pushed
>  >  flag.
>  >
>  >  Hmm, interesting. Of course my response is "Don't use SCHED_RR! It's
>  >  evil!" ;-)
>
>  It's not just SCHED_RR ;-) They both can be of SCHED_FIFO.
>
>  T1 _preempts_ T0 and again
>
>
>   --> task_wake_up_rt()
>   |
>   ---> push_rt_tasks() -> rq->rt.pushed = 1
>
>  and T0 won't be pushed away to cpu0 by post_schedule_rt().
>
>  As Gregory has pointed out, at the very least it's a test in
>  task_wake_up_rt() which is wrong.
>
>  push_rt_tasks() should not be called when 'p' (a newly woken up task)
>  is the next one to run.
>
>  IOW, it should be (p->prio < rq->curr->prio) instead of (p->prio >=
>  rq->rt.highest_prio).

No, this argument is wrong indeed.

Something like this:
(white-spaces are broken)

--- sched_rt-prev.c     2008-04-23 11:26:39.000000000 +0200
+++ sched_rt.c  2008-04-23 11:36:20.000000000 +0200
@@ -1121,9 +1121,13 @@ static void post_schedule_rt(struct rq *

 static void task_wake_up_rt(struct rq *rq, struct task_struct *p)
 {
-       if (!task_running(rq, p) &&
-           (p->prio >= rq->rt.highest_prio) &&
-           rq->rt.overloaded)
+       /*
+        * Consider pushing 'p' off to other CPUS only
+        * if it's not the next task to run on this CPU.
+        */
+       if (rq->rt.overloaded &&
+           p->prio > rq->rt.highest_prio &&
+           pick_rt_task(rq, p, -1))
                push_rt_tasks(rq);
 }


or even this (although, it's a bit heavier)

--- sched_rt-prev.c     2008-04-23 11:26:39.000000000 +0200
+++ sched_rt.c  2008-04-23 11:49:03.000000000 +0200
@@ -1118,12 +1118,22 @@ static void post_schedule_rt(struct rq *
        }
 }

 static void task_wake_up_rt(struct rq *rq, struct task_struct *p)
 {
-       if (!task_running(rq, p) &&
-           (p->prio >= rq->rt.highest_prio) &&
-           rq->rt.overloaded)
+       if (!rq->rt.overloaded)
+               return;
+
+       /*
+        * Consider pushing 'p' off to other CPUS only
+        * if it's not the next task to run on this CPU.
+        * i.e. it's not a single task with the highest prio
+        * on the queue.
+        */
+       if (p->prio == rq->rt.highest_prio &&
+           p->rt.run_list.prev == p->rt.run_list.next)
+               return;
+
+       if (pick_rt_task(rq, p, -1))
                push_rt_tasks(rq);
 }


-- 
Best regards,
Dmitry Adamushko
