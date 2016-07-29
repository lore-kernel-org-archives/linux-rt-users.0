From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: v3.18-RT
Date: Fri, 29 Jul 2016 18:19:34 +0200
Message-ID: <20160729161933.GG21715@linutronix.de>
References: <FCC5AC80E299464B82E1345E2C10FC9D8098CE51@S1P5DAG4C.EXCHPROD.USA.NET>
 <20160603163732.GD4496@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D8099ACF6@S1P5DAG4C.EXCHPROD.USA.NET>
 <16d5e3f2-dd20-c802-37aa-86eab553fcfc@linutronix.de>
 <FCC5AC80E299464B82E1345E2C10FC9D809A150B@S1P5DAG4C.EXCHPROD.USA.NET>
 <4061065f-dd2b-0a76-299e-ce66783d85dd@linutronix.de>
 <82DB755727433D4A981ED5650C27BBEF729546A9@S1P5DAG9E.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	David Hauck <davidh@netacquire.com>,
	Preston Hauck <prestonh@netacquire.com>
To: Carol Wong <carolw@netacquire.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51942 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130AbcG2QTh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2016 12:19:37 -0400
Content-Disposition: inline
In-Reply-To: <82DB755727433D4A981ED5650C27BBEF729546A9@S1P5DAG9E.EXCHPROD.USA.NET>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carol Wong | 2016-07-20 20:53:21 [+0000]:

>Hi Sebastian,
Hi Carol,

>We finally traced the boot-up crash to the following patch in kernel/sched/core.c:
>
>https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.18-rt&id=62044e554f14547061afcfef7f0aceda43e28982
>
>After reverting the two-line patch in 3.18.29-rt30, the crash no longer occurs on our dual Xeon (2x12 core) system.
>
>Other observations:
>- Does not reproduce on single processor (2 and 4 core) systems
>- Reproduces under 3.18.27-rt27 and 3.18.36-rt38 on the dual Xeon
>- Does not reproduce on 3.18.27-rt26 and earlier on the dual Xeon
>- Reproduces more frequently on .29-rt30 (1 in 20 reboots) compared to .27-rt27 (1 in 100 reboots)
>
>So far we've not observed any side effects after reverting this patch.

This was part of CPU hotplug fixups. Lockdep might be broken without it
but I am not sure if is most of the time the case or just during
hotplug.

>I understand that a high core count system may not be easy to come by, so if there are diagnostics or patches you would like to try on the dual Xeon system, we can assist with that.

With that patch, migrate_disable() skips the whole preempt-lazy +
pin-cpu code if called with IRQs off. Since interrupts are disabled we
can't migrate to another so it is a possible optimsation.
It only makes a difference if migrate_disable() + migrate_enable() calls
are not in balance. The commit
  https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.18-rt&id=8d51d3a296b6ec4aebd0d6d7e1b7162cd9bf6662
is one example where I fixed the inbalance.
Do you get additional backtraces with CONFIG_SCHED_DEBUG enabled?

There is one thing the debug code does not cover, so could you please
add this chunk?

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 140ee06079b6..1f8613f77598 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3229,6 +3229,7 @@ void migrate_enable(void)
 
 	if (in_atomic() || irqs_disabled()) {
 #ifdef CONFIG_SCHED_DEBUG
+		WARN_ON_ONCE(p->migrate_disable_atomic <= 0);
 		p->migrate_disable_atomic--;
 #endif
 		return;

>Cheers,
>Carol Wong
>NetAcquire Corporation

Sebastian
