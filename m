From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 4/6] rt/locking: Reenable migration accross schedule
Date: Fri, 25 Mar 2016 10:13:16 +0100
Message-ID: <1458897196.3870.8.camel@gmail.com>
References: <1455318168-7125-1-git-send-email-bigeasy@linutronix.de>
	 <1455318168-7125-4-git-send-email-bigeasy@linutronix.de>
	 <1458463425.3908.5.camel@gmail.com> <1458814024.23732.35.camel@gmail.com>
	 <alpine.DEB.2.11.1603241140510.3978@nanos>
	 <1458817594.3972.16.camel@gmail.com> <1458884330.3836.21.camel@gmail.com>
	 <alpine.DEB.2.11.1603250951100.3978@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35159 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCYJNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 Mar 2016 05:13:20 -0400
In-Reply-To: <alpine.DEB.2.11.1603250951100.3978@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2016-03-25 at 09:52 +0100, Thomas Gleixner wrote:
> On Fri, 25 Mar 2016, Mike Galbraith wrote:
> > On Thu, 2016-03-24 at 12:06 +0100, Mike Galbraith wrote:
> > > On Thu, 2016-03-24 at 11:44 +0100, Thomas Gleixner wrote:
> > > >  
> > > > > On the bright side, with the busted migrate enable business reverted,
> > > > > plus one dinky change from me [1], master-rt.today has completed 100
> > > > > iterations of Steven's hotplug stress script along side endless
> > > > > futexstress, and is happily doing another 900 as I write this, so the
> > > > > next -rt should finally be hotplug deadlock free.
> > > > > 
> > > > > Thomas's state machinery seems to work wonders.  'course this being
> > > > > hotplug, the other shoe will likely apply itself to my backside soon.
> > > > 
> > > > That's a given :)
> > > 
> > > blk-mq applied it shortly after I was satisfied enough to poke xmit.
> > 
> > The other shoe is that notifiers can depend upon RCU grace periods, so
> > when pin_current_cpu() snags rcu_sched, the hotplug game is over.
> > 
> > blk_mq_queue_reinit_notify:
> >         /*
> >          * We need to freeze and reinit all existing queues.  Freezing
> >          * involves synchronous wait for an RCU grace period and doing it
> >          * one by one may take a long time.  Start freezing all queues in
> >          * one swoop and then wait for the completions so that freezing can
> >          * take place in parallel.
> >          */
> >         list_for_each_entry(q, &all_q_list, all_q_node)
> >                 blk_mq_freeze_queue_start(q);
> >         list_for_each_entry(q, &all_q_list, all_q_node) {
> >                 blk_mq_freeze_queue_wait(q);
> 
> Yeah, I stumbled over that already when analysing all the hotplug notifier
> sites. That's definitely a horrible one.
>  
> > Hohum (sharpens rock), next.
> 
> /me recommends frozen sharks

With the sharp rock below and the one I'll follow up with, master-rt on
my DL980 just passed 3 hours of endless hotplug stress concurrent with
endless tbench 8, stockfish and futextest.  It has never survived this
long with this load by a long shot.

hotplug/rt: Do not let pin_current_cpu() block RCU grace periods

Notifiers may depend upon grace periods continuing to advance
as blk_mq_queue_reinit_notify() below.

crash> bt ffff8803aee76400
PID: 1113   TASK: ffff8803aee76400  CPU: 0   COMMAND: "stress-cpu-hotp"
 #0 [ffff880396fe7ad8] __schedule at ffffffff816b7142
 #1 [ffff880396fe7b28] schedule at ffffffff816b797b
 #2 [ffff880396fe7b48] blk_mq_freeze_queue_wait at ffffffff8135c5ac
 #3 [ffff880396fe7b80] blk_mq_queue_reinit_notify at ffffffff8135f819
 #4 [ffff880396fe7b98] notifier_call_chain at ffffffff8109b8ed
 #5 [ffff880396fe7bd8] __raw_notifier_call_chain at ffffffff8109b91e
 #6 [ffff880396fe7be8] __cpu_notify at ffffffff81072825
 #7 [ffff880396fe7bf8] cpu_notify_nofail at ffffffff81072b15
 #8 [ffff880396fe7c08] notify_dead at ffffffff81072d06
 #9 [ffff880396fe7c38] cpuhp_invoke_callback at ffffffff81073718
#10 [ffff880396fe7c78] cpuhp_down_callbacks at ffffffff81073a70
#11 [ffff880396fe7cb8] _cpu_down at ffffffff816afc71
#12 [ffff880396fe7d38] do_cpu_down at ffffffff8107435c
#13 [ffff880396fe7d60] cpu_down at ffffffff81074390
#14 [ffff880396fe7d70] cpu_subsys_offline at ffffffff814cd854
#15 [ffff880396fe7d80] device_offline at ffffffff814c7cda
#16 [ffff880396fe7da8] online_store at ffffffff814c7dd0
#17 [ffff880396fe7dd0] dev_attr_store at ffffffff814c4fc8
#18 [ffff880396fe7de0] sysfs_kf_write at ffffffff812cfbe4
#19 [ffff880396fe7e08] kernfs_fop_write at ffffffff812cf172
#20 [ffff880396fe7e50] __vfs_write at ffffffff81241428
#21 [ffff880396fe7ed0] vfs_write at ffffffff81242535
#22 [ffff880396fe7f10] sys_write at ffffffff812438f9
#23 [ffff880396fe7f50] entry_SYSCALL_64_fastpath at ffffffff816bb4bc
    RIP: 00007fafd918acd0  RSP: 00007ffd2ca956e8  RFLAGS: 00000246
    RAX: ffffffffffffffda  RBX: 000000000226a770  RCX: 00007fafd918acd0
    RDX: 0000000000000002  RSI: 00007fafd9cb9000  RDI: 0000000000000001
    RBP: 00007ffd2ca95700   R8: 000000000000000a   R9: 00007fafd9cb3700
    R10: 00000000ffffffff  R11: 0000000000000246  R12: 0000000000000007
    R13: 0000000000000001  R14: 0000000000000009  R15: 000000000000000a
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

blk_mq_queue_reinit_notify:
        /*
         * We need to freeze and reinit all existing queues.  Freezing
         * involves synchronous wait for an RCU grace period and doing it
         * one by one may take a long time.  Start freezing all queues in
         * one swoop and then wait for the completions so that freezing can
         * take place in parallel.
         */
        list_for_each_entry(q, &all_q_list, all_q_node)
                blk_mq_freeze_queue_start(q);
        list_for_each_entry(q, &all_q_list, all_q_node) {
                blk_mq_freeze_queue_wait(q);

crash> bt ffff880176cc9900
PID: 17     TASK: ffff880176cc9900  CPU: 0   COMMAND: "rcu_sched"
 #0 [ffff880176cd7ab8] __schedule at ffffffff816b7142
 #1 [ffff880176cd7b08] schedule at ffffffff816b797b
 #2 [ffff880176cd7b28] rt_spin_lock_slowlock at ffffffff816b974d
 #3 [ffff880176cd7bc8] rt_spin_lock_fastlock at ffffffff811b0f3c
 #4 [ffff880176cd7be8] rt_spin_lock__no_mg at ffffffff816bac1b
 #5 [ffff880176cd7c08] pin_current_cpu at ffffffff8107406a
 #6 [ffff880176cd7c50] migrate_disable at ffffffff810a0e9e
 #7 [ffff880176cd7c70] rt_spin_lock at ffffffff816bad69
 #8 [ffff880176cd7c90] lock_timer_base at ffffffff810fc5e8
 #9 [ffff880176cd7cc8] try_to_del_timer_sync at ffffffff810fe290
#10 [ffff880176cd7cf0] del_timer_sync at ffffffff810fe381
#11 [ffff880176cd7d58] schedule_timeout at ffffffff816b9e4b
#12 [ffff880176cd7df0] rcu_gp_kthread at ffffffff810f52b4
#13 [ffff880176cd7e70] kthread at ffffffff8109a02f
#14 [ffff880176cd7f50] ret_from_fork at ffffffff816bb6f2

Game Over.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 include/linux/sched.h |    1 +
 kernel/cpu.c          |    2 +-
 kernel/rcu/tree.c     |    3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1492,6 +1492,7 @@ struct task_struct {
 #ifdef CONFIG_COMPAT_BRK
 	unsigned brk_randomized:1;
 #endif
+	unsigned sched_is_rcu:1; /* RT: is a critical RCU thread */
 
 	unsigned long atomic_flags; /* Flags needing atomic access. */
 
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -156,7 +156,7 @@ void pin_current_cpu(void)
 	hp = this_cpu_ptr(&hotplug_pcp);
 
 	if (!hp->unplug || hp->refcount || force || preempt_count() > 1 ||
-	    hp->unplug == current) {
+	    hp->unplug == current || current->sched_is_rcu) {
 		hp->refcount++;
 		return;
 	}
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2100,6 +2100,9 @@ static int __noreturn rcu_gp_kthread(voi
 	struct rcu_state *rsp = arg;
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
+	/* RT: pin_current_cpu() MUST NOT block RCU grace periods. */
+	current->sched_is_rcu = 1;
+
 	rcu_bind_gp_kthread();
 	for (;;) {
 
