From: "Christian Meier" <chmeie@gmx.com>
Subject: Combining priority concepts of softirqs and rt
Date: Tue, 20 Mar 2012 22:41:37 +0100
Message-ID: <000001cd06e2$47f05240$d7d0f6c0$@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:57153 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754832Ab2CTViY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 Mar 2012 17:38:24 -0400
Content-Language: de
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am not sure but I think I am now stuck at some kind of conceptional
problem of softirqs in combination with rt-tasks.

Imagine a system with only three relevant kernel modules A, B and C.
Each uses an own irq and an own tasklet.
Additionally there are two realtime applications named APP_A and APP_B.
APP_A only depends on module A.
APP_B only depends on module B.

APP_B and B should not defer any action of APP_A and module A.
Module C should not defer anything of A, APP_A, B and APP_B.

Example of resulting priority layout:
IRQ-Thread of module A has prio 80
Process APP_A has prio 70
IRQ-Thread of module B has prio 60
Process APP_B has prio 50
IRQ-Thread of module C has prio 40
ksoftirqd has prio 2 ???

As long as irq action of A can be handled without any tasklet action,
everything will be fine.
But when A's tasklet is scheduled, irq of B, APP_B and irq of C can defer
A's tasklet.

Moving the ksoftirqd prio higher omits the problem, but creates other
problems, for example:
IRQ-Thread of module A has prio 80
Process APP_A has prio 70
ksoftirqd has prio 65
IRQ-Thread of module B has prio 60
Process APP_B has prio 50
IRQ-Thread of module C has prio 40

Now tasklets of C can defer APP_B and IRQ-thread of B.

My first thought was:
Shouldn't it be possible to use rt-priority of the irq that activated the
tasklet to sort the softirqd queue and additionally inherit the currently
highest priority of the tasklet queue to the softirqd thread priority?

But then I noticed that this would be almost identical to throw away the
ksoftirqd and execute all tasklets directy after finishing the workload if
the irq that scheduled the tasklet is finished.

So my resulting question is:

Wouldn't it be possible to completely run softirqs and tasklets directly in
irq thread context after finishing the irq handler?
As softirqs can run at the same time on more than one cpu but only once on a
single cpu, this would apply to the irq-thread semantics.
Additionally to get tasklet semantics (only one tasklet of the same type at
a given time on all cpus) a tasklet specific spinlock_t could be used as a
wrapper around the call to the tasklet code.
Would this break anything else?

Thanks



