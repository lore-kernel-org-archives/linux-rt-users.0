From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Combining priority concepts of softirqs and rt
Date: Wed, 21 Mar 2012 09:58:33 -0400
Message-ID: <1332338313.23924.34.camel@gandalf.stny.rr.com>
References: <000001cd06e2$47f05240$d7d0f6c0$@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Christian Meier <chmeie@gmx.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20521 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030269Ab2CUN6f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 09:58:35 -0400
In-Reply-To: <000001cd06e2$47f05240$d7d0f6c0$@gmx.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-03-20 at 22:41 +0100, Christian Meier wrote:
> Hi,
> 
> I am not sure but I think I am now stuck at some kind of conceptional
> problem of softirqs in combination with rt-tasks.

Right, softirqs are evil.

> 
> Imagine a system with only three relevant kernel modules A, B and C.
> Each uses an own irq and an own tasklet.

There's your first bug. Change the modules to not use tasklets, and use
a thread or something else. Note, a module can now (even in mainline)
make their interrupt handler into a thread. It should do that and not
rely on tasklets.


> Additionally there are two realtime applications named APP_A and APP_B.
> APP_A only depends on module A.
> APP_B only depends on module B.
> 
> APP_B and B should not defer any action of APP_A and module A.
> Module C should not defer anything of A, APP_A, B and APP_B.
> 
> Example of resulting priority layout:
> IRQ-Thread of module A has prio 80
> Process APP_A has prio 70
> IRQ-Thread of module B has prio 60
> Process APP_B has prio 50
> IRQ-Thread of module C has prio 40
> ksoftirqd has prio 2 ???

You can change the priority of ksoftirqd. In fact, we made the default
for ksoftirqd poor, to force you to change it.

> 
> As long as irq action of A can be handled without any tasklet action,
> everything will be fine.
> But when A's tasklet is scheduled, irq of B, APP_B and irq of C can defer
> A's tasklet.

Right, that's why softirqd (and tasklets) suck. For now, up the
priority. Even though all tasklets will preempt everything else, it will
solve some of the issues.

> 
> Moving the ksoftirqd prio higher omits the problem, but creates other

Ah, I'm replying as I read this. So you decided to up it but..

> problems, for example:
> IRQ-Thread of module A has prio 80
> Process APP_A has prio 70
> ksoftirqd has prio 65
> IRQ-Thread of module B has prio 60
> Process APP_B has prio 50
> IRQ-Thread of module C has prio 40
> 
> Now tasklets of C can defer APP_B and IRQ-thread of B.

Just the tasklet.

> 
> My first thought was:
> Shouldn't it be possible to use rt-priority of the irq that activated the
> tasklet to sort the softirqd queue and additionally inherit the currently
> highest priority of the tasklet queue to the softirqd thread priority?

Yes it is possible and we actually implemented it once. But it caused so
much hell that we ripped it out. It's a hack. The real answer is to get
rid of tasklets.

> 
> But then I noticed that this would be almost identical to throw away the
> ksoftirqd and execute all tasklets directy after finishing the workload if
> the irq that scheduled the tasklet is finished.

Yep! That's the real answer.

> 
> So my resulting question is:
> 
> Wouldn't it be possible to completely run softirqs and tasklets directly in
> irq thread context after finishing the irq handler?

It should be executed in the module irq handler, not default by the
softirqd code.

> As softirqs can run at the same time on more than one cpu but only once on a
> single cpu, this would apply to the irq-thread semantics.

No it would not. The irq-thread is a single thread and can not be run on
more than one CPU at the same time. We tried this too, and it broke some
workloads.

> Additionally to get tasklet semantics (only one tasklet of the same type at
> a given time on all cpus) a tasklet specific spinlock_t could be used as a
> wrapper around the call to the tasklet code.
> Would this break anything else?

We actually tried all this and found several issues. Here's one.

You have a irq thread that decides to run softirq. But softirqs must run
on a single CPU, which means the irq thread must disable migration as it
runs the softirq. If a higher prio process preempts it, it will prevent
the irq thread from migrating to another CPU to run, delaying the
thread.

Of course today, we have migrate disable at every spin_lock() that is
converted to a mutex, and we have some of the same issues that we
encountered back then. But regardless, we learned from doing this, and
figured that the real solution is to move Linux away from softirqs and
towards a way that does things in more a threaded context.

-- Steve


