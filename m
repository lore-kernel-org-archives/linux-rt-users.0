From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched: fix race in schedule
Date: Mon, 10 Mar 2008 19:36:37 +0100
Message-ID: <1205174197.8514.159.camel@twins>
References: <47D57770.50909@ct.jp.nec.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, hpj@urpla.net
To: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:39568 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbYCJSgr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Mar 2008 14:36:47 -0400
In-Reply-To: <47D57770.50909@ct.jp.nec.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-03-10 at 11:01 -0700, Hiroshi Shimamoto wrote:
> Hi Ingo,
> 
> I found a race condition in scheduler.
> The first report is the below;
> http://lkml.org/lkml/2008/2/26/459
> 
> It took a bit long time to investigate and I couldn't have much time last week.
> It is hard to reproduce but -rt is little easier because it has preemptible
> spin lock and rcu.
> 
> Could you please check the scenario and the patch.
> It will be needed for the stable, too.
> 
> ---
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> There is a race condition between schedule() and some dequeue/enqueue
> functions; rt_mutex_setprio(), __setscheduler() and sched_move_task().
> 
> When scheduling to idle, idle_balance() is called to pull tasks from
> other busy processor. It might drop the rq lock.
> It means that those 3 functions encounter on_rq=0 and running=1.
> The current task should be put when running.
> 
> Here is a possible scenario;
>    CPU0                               CPU1
>     |                              schedule()
>     |                              ->deactivate_task()
>     |                              ->idle_balance()
>     |                              -->load_balance_newidle()
> rt_mutex_setprio()                     |
>     |                              --->double_lock_balance()
>     *get lock                          *rel lock
>     * on_rq=0, ruuning=1               |
>     * sched_class is changed           |
>     *rel lock                          *get lock
>     :                                  |
>                                        :
>                                    ->put_prev_task_rt()
>                                    ->pick_next_task_fair()
>                                        => panic
> 
> The current process of CPU1(P1) is scheduling. Deactivated P1,
> and the scheduler looks for another process on other CPU's runqueue
> because CPU1 will be idle. idle_balance(), load_balance_newidle()
> and double_lock_balance() are called and double_lock_balance() could
> drop the rq lock. On the other hand, CPU0 is trying to boost the
> priority of P1. The result of boosting only P1's prio and sched_class
> are changed to RT. The sched entities of P1 and P1's group are never
> put. It makes cfs_rq invalid, because the cfs_rq has curr and no leaf,
> but pick_next_task_fair() is called, then the kernel panics.

Very nice catch, this had me puzzled for a while. I'm not quite sure I
fully understand. Could you explain why the below isn't sufficient?

---
diff --git a/kernel/sched.c b/kernel/sched.c
index a0c79e9..ebd9fc5 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -4067,10 +4067,11 @@ need_resched_nonpreemptible:
 		prev->sched_class->pre_schedule(rq, prev);
 #endif
 
+	prev->sched_class->put_prev_task(rq, prev);
+
 	if (unlikely(!rq->nr_running))
 		idle_balance(cpu, rq);
 
-	prev->sched_class->put_prev_task(rq, prev);
 	next = pick_next_task(rq, prev);
 
 	sched_info_switch(prev, next);


