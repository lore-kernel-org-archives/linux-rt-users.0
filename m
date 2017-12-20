From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [v4.14-rt][report] arm: run: stress-ng --class os --all 0 -t 5m
Date: Tue, 19 Dec 2017 18:33:59 -0600
Message-ID: <40bb8ed5-d0e7-72e8-ab20-89431263af48@ti.com>
References: <e421665a-8438-a1c0-4516-1b23dc758fc8@ti.com>
 <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:46849 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753947AbdLTAeM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Dec 2017 19:34:12 -0500
In-Reply-To: <20171219082739.d6oxzkjkdicfu3hq@linutronix.de>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 12/19/2017 02:27 AM, Sebastian Andrzej Siewior wrote:
> On 2017-12-18 20:01:05 [-0600], Grygorii Strashko wrote:
>> Hi All,
> Hi,
> 
>> Below results of running stress-ng --class os --all 0 -t 5m on TI am57xx-evm (SMP, 2 cpu)
>> git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
>> branch: linux-4.14.y-rt
>> commit: d3d9904 v4.14.6-rt7
>> - only config changes applied.
>>
>> one "WARNING: possible circular locking dependency detected"
>> [   85.943562] ======================================================
>> [   85.943564] WARNING: possible circular locking dependency detected
>> [   85.943568] 4.14.6-rt7-dirty #29 Not tainted
>> [   85.943570] ------------------------------------------------------
>> [   85.943573] stress-ng-cpu-o/764 is trying to acquire lock:
>> [   85.943576]  (&p->pi_lock){-...}, at: [<c0169ce8>] try_to_wake_up+0x28/0x924
>> [   85.943594]
>> [   85.943594] but task is already holding lock:
>> [   85.943596]  (hrtimer_bases.lock){-...}, at: [<c01c12ac>] hrtimer_interrupt+0x68/0x2b0
>>
>> one "WARNING: CPU: 0 PID: 3514 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x3e8/0x988"
>> ^ sorry, log not very readable
> 
> This should cure it, does it?
> 
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index c2c344fda487..3971fa0c7194 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -1952,6 +1952,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
>   	BUG_ON(cpu_online(scpu));
>   	tick_cancel_sched_timer(scpu);
>   
> +	local_bh_disable();
>   	local_irq_disable();
>   	old_base = &per_cpu(hrtimer_bases, scpu);
>   	new_base = this_cpu_ptr(&hrtimer_bases);
> @@ -1979,6 +1980,7 @@ int hrtimers_dead_cpu(unsigned int scpu)
>   	/* Check, if we got expired work to do */
>   	__hrtimer_peek_ahead_timers();
>   	local_irq_enable();
> +	local_bh_enable();
>   	return 0;
>   }
> 

I've run test few times - can't see "WARNING: possible circular locking dependency detected"
any more. Below warning happened once.

[ 3091.593894] ------------[ cut here ]------------
[ 3091.593909] WARNING: CPU: 0 PID: 1797 at kernel/rcu/tree_plugin.h:310 rcu_note_context_switch+0x554/0x950
[ 3091.593912] Modules linked in:
[ 3091.593923] CPU: 0 PID: 1797 Comm: stress-ng-clock Not tainted 4.14.6-rt7-dirty #37
[ 3091.593926] Hardware name: Generic DRA74X (Flattened Device Tree)
[ 3091.593941] [<c0110090>] (unwind_backtrace) from [<c010c710>] (show_stack+0x10/0x14)
[ 3091.593952] [<c010c710>] (show_stack) from [<c08388b8>] (dump_stack+0xa0/0xd4)
[ 3091.593964] [<c08388b8>] (dump_stack) from [<c013668c>] (__warn+0xd8/0x104)
[ 3091.593975] [<c013668c>] (__warn) from [<c0136764>] (warn_slowpath_null+0x20/0x28)
[ 3091.593984] [<c0136764>] (warn_slowpath_null) from [<c01b8efc>] (rcu_note_context_switch+0x554/0x950)
[ 3091.593996] [<c01b8efc>] (rcu_note_context_switch) from [<c084e08c>] (__schedule+0xc4/0xa7c)
[ 3091.594005] [<c084e08c>] (__schedule) from [<c084eaa4>] (schedule+0x60/0xf8)
[ 3091.594016] [<c084eaa4>] (schedule) from [<c08505b4>] (rt_spin_lock_slowlock_locked+0xa8/0x304)
[ 3091.594026] [<c08505b4>] (rt_spin_lock_slowlock_locked) from [<c0851060>] (__read_rt_lock+0xc0/0xf4)
[ 3091.594036] [<c0851060>] (__read_rt_lock) from [<c01398cc>] (pin_current_cpu+0x3c/0x11c)
[ 3091.594047] [<c01398cc>] (pin_current_cpu) from [<c0167ce0>] (migrate_disable+0x78/0x1e8)
[ 3091.594057] [<c0167ce0>] (migrate_disable) from [<c085248c>] (rt_spin_lock+0x14/0x4c)
[ 3091.594066] [<c085248c>] (rt_spin_lock) from [<c01cb150>] (__lock_timer+0xc0/0x220)
[ 3091.594076] [<c01cb150>] (__lock_timer) from [<c01cc2b8>] (SyS_timer_gettime+0x14/0xb8)
[ 3091.594087] [<c01cc2b8>] (SyS_timer_gettime) from [<c01079c8>] (__sys_trace_return+0x0/0x10)
[ 3091.594091] ---[ end trace 0000000000000002 ]---


-- 
regards,
-grygorii
