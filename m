From: Drew Richardson <Drew.Richardson@arm.com>
Subject: mod_timer in interrupt context
Date: Tue, 12 Nov 2013 08:39:31 -0800
Message-ID: <42FC60A7A1C0DD469DA8DF3D4125035F012614404F67@SPOCK.usa.Arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Cc: Pawel Moll <Pawel.Moll@arm.com>, Wade Cherry <Wade.Cherry@arm.com>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:45401 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752641Ab3KLQoT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Nov 2013 11:44:19 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I am using a 16 core ARM Cortex-A15 dev board with a PREEMPT_RT patched kernel. When I call mod_timer in the sched_switch tracepoint from a kernel module the board locks up. Here's the stack trace I get

BUG: sleeping function called from invalid context at kernel/rtmutex.c:659
in_atomic(): 1, irqs_disabled(): 128, pid: 0, name: swapper/7
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<  (null)>]   (null)
hardirqs last disabled at (0): [<c0432358>] copy_process.part.49+0x414/0x11bc
softirqs last  enabled at (0): [<c0432358>] copy_process.part.49+0x414/0x11bc
softirqs last disabled at (0): [<  (null)>]   (null)
Preemption disabled at:[<  (null)>]   (null)

CPU: 7 PID: 0 Comm: swapper/7 Tainted: G        W  O 3.10.14-rt9 #3
[<c0424f38>] (unwind_backtrace+0x0/0xf4) from [<c0421750>] (show_stack+0x10/0x14)
[<c0421750>] (show_stack+0x10/0x14) from [<c08f2cac>] (rt_spin_lock+0x24/0x58)
[<c08f2cac>] (rt_spin_lock+0x24/0x58) from [<c0443f48>] (lock_timer_base.isra.38+0x2c/0x50)
[<c0443f48>] (lock_timer_base.isra.38+0x2c/0x50) from [<c04441a8>] (mod_timer+0x60/0x240)
[<c04441a8>] (mod_timer+0x60/0x240) from [<bf000038>] (probe_sched_switch+0x2c/0x3c [gator])
[<bf000038>] (probe_sched_switch+0x2c/0x3c [gator]) from [<c08f1a08>] (__schedule+0x618/0x678)
[<c08f1a08>] (__schedule+0x618/0x678) from [<c08f1a9c>] (schedule+0x34/0xa4)
[<c08f1a9c>] (schedule+0x34/0xa4) from [<c08f2040>] (schedule_preempt_disabled+0x14/0x20)
[<c08f2040>] (schedule_preempt_disabled+0x14/0x20) from [<c0473560>] (cpu_startup_entry+0x114/0x2b4)
[<c0473560>] (cpu_startup_entry+0x114/0x2b4) from [<00af9aa4>] (0xaf9aa4)

The mod_timer function calls lock_timer_base which calls spin_lock. This is fine in non-RT kernels, but in RT_FULL it's a mutex which could block. Is it illegal to call mod_timer in this context?

Thanks,

Drew

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.

ARM Limited, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2557590
ARM Holdings plc, Registered office 110 Fulbourn Road, Cambridge CB1 9NJ, Registered in England & Wales, Company No:  2548782

