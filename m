From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: How to use latency trace
Date: Thu,  1 Nov 2007 23:53:26 +0100 (CET)
Message-ID: <30746519.1640811193957606209.JavaMail.www@wwinf6101>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-2.orange.nl ([193.252.22.242]:43183 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753079AbXKAWx3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Nov 2007 18:53:29 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6108.orange.nl (SMTP Server) with ESMTP id 390037000084
	for <linux-rt-users@vger.kernel.org>; Thu,  1 Nov 2007 23:53:26 +0100 (CET)
Received: from wwinf6101 (wwinf6101 [172.22.153.28])
	by mwinf6108.orange.nl (SMTP Server) with ESMTP id 363D47000082
	for <linux-rt-users@vger.kernel.org>; Thu,  1 Nov 2007 23:53:26 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello,

Below is a latency trace from cyclictest at a pentm4 1.8G with cyclictest stopping the
latency tracer at a latency of 25us.
The disknoise script is running in the background together with a self made loadgen appl.
The latency is in the 5th line from the bottom in clockevents_program_events, a function 
which in most cases only takes one us.
Why is it now taking 40us? Or is sys_getdents64() causing the problem?

Another question: can you ever guarantee a max. latency if a user has access to the system?

> preemption latency trace v1.1.5 on 2.6.22.1-rt4
> --------------------------------------------------------------------
> latency: 1832319 us, #65536/3501832508, CPU#0 | (M:rt VP:0, KP:0, SP:1
> HP:1)
> -----------------
> | task: cyclictest-647 (uid:0 nice:0 policy:1 rt_prio:80)
> -----------------
> => started at: sys_prctl+0x21/0x1a4 
> => ended at: 0
> 
> loadgen-738 0D..2 439508us!: __schedule+0x3c4/0x4f3 (150 0)
> loadgen-738 0D.h. 439745us : do_IRQ+0x96/0xfb (8048563 17 0)
> loadgen-738 0D.h1 439745us : try_to_wake_up+0x19/0x188 (c0115f37 0 0)
> loadgen-738 0D.h2 439746us : activate_task+0x83/0xce (150 1)
> loadgen-738 0DN.1 439747us : __schedule+0xb7/0x4f3 (c0102afa 0 0)
> IRQ-17-294 0D..2 439748us : __schedule+0x3c4/0x4f3 (0 150)
> IRQ-17-294 0D.h. 439748us+: do_IRQ+0x96/0xfb (c035c1aa 17 0)
> IRQ-17-294 0D..1 439763us : __schedule+0xb7/0x4f3 (c035c18c 0 0)
> IRQ-17-294 0D..2 439763us : deactivate_task+0x83/0xce (150 2)
> loadgen-738 0D..2 439764us+: __schedule+0x3c4/0x4f3 (150 0)
> loadgen-738 0D.h. 439795us : do_IRQ+0x96/0xfb (8048563 17 0)
> loadgen-738 0D.h1 439795us : try_to_wake_up+0x19/0x188 (c0115f37 0 0)
> loadgen-738 0D.h2 439796us : activate_task+0x83/0xce (150 1)
> loadgen-738 0DN.1 439797us : __schedule+0xb7/0x4f3 (c0102afa 0 0)
> IRQ-17-294 0D..2 439798us : __schedule+0x3c4/0x4f3 (0 150)
> IRQ-17-294 0D.h. 439798us+: do_IRQ+0x96/0xfb (c01487e3 17 0)
> IRQ-17-294 0.... 439819us : try_to_wake_up+0x19/0x188 (c0115e57 0 0)
> IRQ-17-294 0D..1 439819us+: activate_task+0x83/0xce (0 2)
> IRQ-17-294 0D..1 439825us : __schedule+0xb7/0x4f3 (c035c18c 0 0)
> IRQ-17-294 0D..2 439825us : deactivate_task+0x83/0xce (150 3)
> find-742 0D..2 439826us!: __schedule+0x3c4/0x4f3 (150 0)
> find-742 0.... 440000us > sys_getdents64+0x0/0xb2 (00000004 080cc054 00000000)
> find-742 0D..1 440000us : smp_apic_timer_interrupt+0x2d/0x97 (c02329c9 1 0)
> find-742 0D.h1 440001us : hrtimer_interrupt+0x60/0x20a (54040878530431 0)
> find-742 0D.h2 440001us : hrtimer_interrupt+0xef/0x20a (54040878529874 -134680768)
> find-742 0D.h2 440002us : try_to_wake_up+0x19/0x188 (c0115f37 0 0)
> find-742 0D.h3 440002us : activate_task+0x83/0xce (180 2)
> find-742 0DNh3 440003us : try_to_wake_up+0x15a/0x188 (180 0)
> find-742 0DNh1 440003us+: clockevents_program_event+0x33/0xb2 (54040879000000 467212)
> find-742 0DN.1 440043us : __schedule+0xb7/0x4f3 (c035bffe 0 0)
> cyclicte-647 0D..2 440045us : __schedule+0x3c4/0x4f3 (0 180)
> cyclicte-647 0.... 440046us > sys_clock_gettime+0x0/0x9c (00000001 b7f2c448 00000000)
> cyclicte-647 0.... 440047us > sys_prctl+0x0/0x1a4 (00000000 00000000 00000000)
