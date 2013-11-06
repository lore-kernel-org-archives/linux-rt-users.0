From: Matt Cowell <matt.cowell@nsn.com>
Subject: Re: [PATCH RT] rtmutex: fix deadlock in spin_trylock
Date: Wed, 06 Nov 2013 14:22:18 -0600
Message-ID: <527AA4FA.2000208@nsn.com>
References: <641D1EBAB8EAD046954CD69996C8FE00164297@USCHMBX003.nsn-intra.net> <alpine.DEB.2.02.1311061832020.23353@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: ext Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:10859 "EHLO
	demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756Ab3KFUWa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 15:22:30 -0500
In-Reply-To: <alpine.DEB.2.02.1311061832020.23353@ionos.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>> There is a deadlock condition with RT spin_locks that may use trylock in
>> hardirq context.  The main user of this is get_next_timer_interrupt, which
>> will deadlock if an IRQ preempts a timer wheel modification.
>
> Errm. No.

Are you saying that spin_trylock will/should not be called from hardirq 
context, or that it is not possible for spin_trylock to deadlock in the 
situation I described?  With PREEMPT_RT_FULL and NO_HZ_FULL on v3.10, 
spin_trylock will definitely will be called from hardirq context.  This 
seems like a valid usage to me as well, as an optimization to prevent 
disabling IRQs and preemption in code that holds the timer spinlock.

Even if this code did not cause a deadlock, is there a reason that 
rt_mutex_slowtrylock is using raw_spin_lock instead of raw_spin_trylock? 
  I would think that we would want to ensure that any *trylock call 
would return as fast as possible without spinning or blocking.

> The cpu is in thread context and therefor not idle.
>
> void tick_nohz_irq_exit(void)
> {
>          if (!ts->inidle)
>                  return;
> 	....
> }
>
> So you are papering over the real issue:
>
>     Why is ts->inidle true, if the CPU is not in idle?

The code you cited is from pre-v3.10 (without NO_HZ_FULL changes).  This 
was changed in commit 5811d99 (nohz: Prepare to stop the tick on irq 
exit).  When ts->idle is false (as it was in my trace), this code now 
calls tick_nohz_full_stop_tick().  This leads to the following trace:

	do_raw_spin_lock
	rt_spin_trylock
	spin_do_trylock
	get_next_timer_interrupt
	tick_nohz_stop_sched_tick
	tick_nohz_full_stop_tick
	tick_nohz_irq_exit
	irq_exit

I see two ways to fix this:
1) The way I did in the patch to ensure that spin_trylock never can spin 
on any locks internally.
2) Converting the timer base lock to a raw_spinlock_t so that it 
actually disables hardirqs in lock_timer_base().  I don't think this 
would be a good idea though.

Thanks,
-Matt
