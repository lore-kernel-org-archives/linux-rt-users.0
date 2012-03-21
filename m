From: Christian Meier <chmeie@gmx.com>
Subject: Re: Combining priority concepts of softirqs and rt
Date: Wed, 21 Mar 2012 18:07:43 +0100
Message-ID: <4F6A0ADF.8020507@gmx.com>
References: <000001cd06e2$47f05240$d7d0f6c0$@gmx.com> <1332338313.23924.34.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:46587 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754485Ab2CUREI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 13:04:08 -0400
In-Reply-To: <1332338313.23924.34.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Steve,

On 21.03.2012 14:58, Steven Rostedt wrote:
> On Tue, 2012-03-20 at 22:41 +0100, Christian Meier wrote:
>> Hi,
>>
>> I am not sure but I think I am now stuck at some kind of conceptional
>> problem of softirqs in combination with rt-tasks.
>
> Right, softirqs are evil.
>
>>
>> Imagine a system with only three relevant kernel modules A, B and C.
>> Each uses an own irq and an own tasklet.
>
> There's your first bug. Change the modules to not use tasklets, and use
> a thread or something else. Note, a module can now (even in mainline)
> make their interrupt handler into a thread. It should do that and not
> rely on tasklets.

I missed something in my example. Not all modules are using only 
tasklets, but also other softirqs (my current topic: net-tx and net-rx, 
by e1000 driver).

I wanted to do some latency experiments measured from ethernet to high 
prio rt-thread and back.

I am not sure whether it is a good idea to touch e1000, net-tx and net-rx.

>
>
>> Additionally there are two realtime applications named APP_A and APP_B.
>> APP_A only depends on module A.
>> APP_B only depends on module B.
>>
>> APP_B and B should not defer any action of APP_A and module A.
>> Module C should not defer anything of A, APP_A, B and APP_B.
>>
>> Example of resulting priority layout:
>> IRQ-Thread of module A has prio 80
>> Process APP_A has prio 70
>> IRQ-Thread of module B has prio 60
>> Process APP_B has prio 50
>> IRQ-Thread of module C has prio 40
>> ksoftirqd has prio 2 ???
>
> You can change the priority of ksoftirqd. In fact, we made the default
> for ksoftirqd poor, to force you to change it.
>
>>
>> As long as irq action of A can be handled without any tasklet action,
>> everything will be fine.
>> But when A's tasklet is scheduled, irq of B, APP_B and irq of C can defer
>> A's tasklet.
>
> Right, that's why softirqd (and tasklets) suck. For now, up the
> priority. Even though all tasklets will preempt everything else, it will
> solve some of the issues.
>
>>
>> Moving the ksoftirqd prio higher omits the problem, but creates other
>
> Ah, I'm replying as I read this. So you decided to up it but..
>
>> problems, for example:
>> IRQ-Thread of module A has prio 80
>> Process APP_A has prio 70
>> ksoftirqd has prio 65
>> IRQ-Thread of module B has prio 60
>> Process APP_B has prio 50
>> IRQ-Thread of module C has prio 40
>>
>> Now tasklets of C can defer APP_B and IRQ-thread of B.
>
> Just the tasklet.

Sorry, typo.

>
>>
>> My first thought was:
>> Shouldn't it be possible to use rt-priority of the irq that activated the
>> tasklet to sort the softirqd queue and additionally inherit the currently
>> highest priority of the tasklet queue to the softirqd thread priority?
>
> Yes it is possible and we actually implemented it once. But it caused so
> much hell that we ripped it out. It's a hack. The real answer is to get
> rid of tasklets.
>
>>
>> But then I noticed that this would be almost identical to throw away the
>> ksoftirqd and execute all tasklets directy after finishing the workload if
>> the irq that scheduled the tasklet is finished.
>
> Yep! That's the real answer.
>
>>
>> So my resulting question is:
>>
>> Wouldn't it be possible to completely run softirqs and tasklets directly in
>> irq thread context after finishing the irq handler?
>
> It should be executed in the module irq handler, not default by the
> softirqd code.

To enable transparent behaviour for existing code, the triggered softirq 
or tasklet could be executed in the same thread, maybe hooking somewhere 
inside or after call to irq_thread_fn or irq_forced_thread_fn.

Something that I tried today was inserting the restart behaviour in 
__do_softirq_common similar to the non preempt_rt_full variant, but 
without max_restart counter. (Just goto restart as long as pending != 0)

This indeed forced all net_tx and net_rx softirq into the e1000 irq thread.

I am now just thinking about whether this could also cause executing a 
softirq of another irq-thread inside the currently running irq thread 
thus stealing the current thread resource. Did not come so far til now 
inside the kernel source.

There are still parts that wakeup ksoftirqd: code that calls irq_exit(). 
So this does not eliminate ksoftirqd completely, but reduces its usage 
drastically.

>
>> As softirqs can run at the same time on more than one cpu but only once on a
>> single cpu, this would apply to the irq-thread semantics.
>
> No it would not. The irq-thread is a single thread and can not be run on
> more than one CPU at the same time. We tried this too, and it broke some
> workloads.

Ah, right. I missed that fact. So that means we almost have tasklet 
behaviour, just migration makes the difference.

>
>> Additionally to get tasklet semantics (only one tasklet of the same type at
>> a given time on all cpus) a tasklet specific spinlock_t could be used as a
>> wrapper around the call to the tasklet code.
>> Would this break anything else?
>
> We actually tried all this and found several issues. Here's one.
>
> You have a irq thread that decides to run softirq. But softirqs must run
> on a single CPU, which means the irq thread must disable migration as it
> runs the softirq. If a higher prio process preempts it, it will prevent
> the irq thread from migrating to another CPU to run, delaying the
> thread.

Wouldn't this also happen if the irq thread itself does the same actions 
by design inside its thread, that are now packed into a softirq/tasklet? 
If the programmer relies on "non migration" he has to disable migration 
inside the irq-thread part doing what has been done in softirq resulting 
in the same behaviour.

>
> Of course today, we have migrate disable at every spin_lock() that is
> converted to a mutex, and we have some of the same issues that we
> encountered back then. But regardless, we learned from doing this, and
> figured that the real solution is to move Linux away from softirqs and
> towards a way that does things in more a threaded context.
>
> -- Steve
>
>

Thanks for your answer

Christian
