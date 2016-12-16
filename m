From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 20:43:32 -0600
Message-ID: <585354D4.8000109@windriver.com>
References: <584F27B8.2090406@windriver.com> <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me> <20161215090714.0b62cc03@gandalf.local.home> <5852B4B8.1090600@windriver.com> <20161215190405.GZ3924@linux.vnet.ibm.com> <585317DF.7080502@windriver.com> <20161215233430.GF3924@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        <linux-rt-users@vger.kernel.org>
To: <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33113 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753105AbcLPEHj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 23:07:39 -0500
In-Reply-To: <20161215233430.GF3924@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2016 05:34 PM, Paul E. McKenney wrote:
> On Thu, Dec 15, 2016 at 04:23:27PM -0600, Chris Friesen wrote:
>> On 12/15/2016 01:04 PM, Paul E. McKenney wrote:
>>> On Thu, Dec 15, 2016 at 09:20:24AM -0600, Chris Friesen wrote:
>>
>>>> On a related note, I found an old email from Paul suggesting that
>>>> the various rcuc/X threads could be affined to the management CPUs
>>>> to free up the "realtime" cores, but when I try that it doesn't let
>>>> me change affinity.  Was that disallowed for technical reasons?
>>>> (It's also possible it's something local, in which case I need to go
>>>> digging.)
>>>
>>> The rcuo/X kthreads can be affined, but the rcuc/X kthreads must run on
>>> the corresponding CPU for correctness reasons -- they communicate with
>>> RCU core using protocols that are only single-CPU-safe.  But if you are
>>> running NO_HZ_FULL, these kthreads should never run unless your user
>>> threads are doing syscalls.
>>>
>>> So, are they actually running in your setup?
>>
>> Yes, but I wasn't setting nohz_full.  With "rcu_nocb_poll
>> isolcpus=1-15 rcu_nocbs=1-15 nohz_full=1-15" I'm not seeing the
>> rcuc/X kthreads running.
>>
>> So in the non-nohz_full case, what are they waking up to do?
>> Something timer-related?
>
> Interesting.  I need to look into this a bit.  I would not expect
> that rcuc/X kthreads corresponding to NOCB CPUs to ever wake up.
> (They are created by a per-CPU facility that creates a kthread per
> CPU no matter what.)


Just be aware that this is Centos 7.3, so who knows what mishmash they've got 
going on. :)

This is a typical function trace of rcuc/9, the only thing running on CPU 9 is a 
qemu thread corresponding to a virtual CPU that is pinned to CPU 9.

<idle>-0     [009] dN..2..  3335.422089: pick_next_task_dl <-__schedule
<idle>-0     [009] dN..2..  3335.422089: pick_next_task_rt <-__schedule
rcuc/9-97    [009] d...2..  3335.422089: __switch_to_xtra <-__switch_to
rcuc/9-97    [009] d...2..  3335.422089: finish_task_switch <-__schedule
rcuc/9-97    [009] d...2..  3335.422089: _raw_spin_unlock_irq <-finish_task_switch
rcuc/9-97    [009] ....1..  3335.422090: kthread_should_stop <-smpboot_thread_fn
rcuc/9-97    [009] ....1..  3335.422090: kthread_should_park <-smpboot_thread_fn
rcuc/9-97    [009] ....1..  3335.422090: rcu_cpu_kthread_should_run 
<-smpboot_thread_fn
rcuc/9-97    [009] .......  3335.422090: rcu_cpu_kthread <-smpboot_thread_fn
rcuc/9-97    [009] .......  3335.422090: local_bh_disable <-rcu_cpu_kthread
rcuc/9-97    [009] .......  3335.422090: migrate_disable <-local_bh_disable
rcuc/9-97    [009] ....11.  3335.422090: pin_current_cpu <-migrate_disable
rcuc/9-97    [009] .....11  3335.422090: rcu_process_gp_end <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422090: check_for_new_grace_period.isra.26 
<-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422090: _raw_spin_lock_irqsave <-rcu_cpu_kthread
rcuc/9-97    [009] d...111  3335.422091: rcu_accelerate_cbs <-rcu_cpu_kthread
rcuc/9-97    [009] d...111  3335.422091: rcu_report_qs_rnp <-rcu_cpu_kthread
rcuc/9-97    [009] d...111  3335.422091: _raw_spin_unlock_irqrestore 
<-rcu_report_qs_rnp
rcuc/9-97    [009] d....11  3335.422091: cpu_needs_another_gp <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422091: rcu_process_gp_end <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422091: check_for_new_grace_period.isra.26 
<-rcu_cpu_kthread
rcuc/9-97    [009] d....11  3335.422091: cpu_needs_another_gp <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422091: rcu_process_gp_end <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422091: check_for_new_grace_period.isra.26 
<-rcu_cpu_kthread
rcuc/9-97    [009] d....11  3335.422091: cpu_needs_another_gp <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422091: local_bh_enable <-rcu_cpu_kthread
rcuc/9-97    [009] .....11  3335.422092: migrate_enable <-local_bh_enable
rcuc/9-97    [009] ....11.  3335.422092: unpin_current_cpu <-migrate_enable
rcuc/9-97    [009] .......  3335.422092: _raw_spin_lock_irq <-rcu_cpu_kthread
rcuc/9-97    [009] d...1..  3335.422092: rt_mutex_getprio <-rcu_cpu_kthread
rcuc/9-97    [009] d...1..  3335.422092: _raw_spin_unlock_irq <-rcu_cpu_kthread
rcuc/9-97    [009] ....1..  3335.422092: kthread_should_stop <-smpboot_thread_fn
rcuc/9-97    [009] ....1..  3335.422092: kthread_should_park <-smpboot_thread_fn
rcuc/9-97    [009] ....1..  3335.422092: rcu_cpu_kthread_should_run 
<-smpboot_thread_fn
rcuc/9-97    [009] .......  3335.422092: schedule <-smpboot_thread_fn


Does this give any useful clues as to why it's waking up?

Looking at the code, rcu_cpu_kthread() is calling rcu_process_callbacks(), which 
will loop calling __rcu_process_callbacks() for each rcu flavor.

The fact that rcu_accelerate_cbs() and rcu_report_qs_rnp() are called within the 
spinlock for the first rcu flavor processed indicates that (rnp->qsmask & 
rdp->grpmask) is nonzero in rcu_report_qs_rdp().  I'm not sure what that 
actually means real-world though.

Then we loop through the other two rcu flavors and it doesn't look like we 
really do anything for them.

Then we return from rcu_process_callbacks() and *workp is 0 so we set the 
priority and return to the caller.

Chris

