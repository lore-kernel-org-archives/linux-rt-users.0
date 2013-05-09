From: "Eyal Cohen" <eyalc@asocstech.com>
Subject: Getting "BUG: sleeping function"
Date: Thu, 9 May 2013 11:46:11 +0300
Message-ID: <3AE1C3304537E04B84F686355CB6716501C09073@mail-srv.asocstech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vsp-mail06.ateranetworks.com ([212.79.238.107]:52223 "EHLO
	vsp-mail06.ateranetworks.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752878Ab3EIJEb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 May 2013 05:04:31 -0400
Received: from (unresolved) ([62.219.194.235] HELO=mail-srv.asocstech.com)
	by vsp-mail06.ateranetworks.com (VSP-SMTPd 1.6.8) with ESMTP
	id 518B4026-0 for <linux-rt-users@vger.kernel.org>;
	Thu, 09 May 2013 10:48:35 +0200
Content-class: urn:content-classes:message
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello.
I've written a driver for a PCIe device running on a machine with rt
patches.
(3.0.17-1.rt33.1.fc16.ccrma.x86_64.rt SMP RT to be precise)

All seems to work smoothly, except I'm getting a BUG "sleeping function
called from invalid context" print for calling "pci_unregister_driver()"
from my module exit function.
>From what I understand, the exit function is called from the rmmod
process, using a regular thread and should not be in atomic mode.
Therefore it should be able to acquire spinlocks without problem, since
it could sleep.
So why is this happening?

Entire printout : 
[ 3110.771019] BUG: sleeping function called from invalid context at
kernel/rtmutex.c:645
[ 3110.771021] in_atomic(): 0, irqs_disabled(): 1, pid: 759, name: rmmod
[ 3110.771022] INFO: lockdep is turned off.
[ 3110.771023] irq event stamp: 0
[ 3110.771024] hardirqs last  enabled at (0): [<          (null)>]
(null)
[ 3110.771026] hardirqs last disabled at (0): [<ffffffff81059249>]
copy_process+0x6d0/0x14af
[ 3110.771031] softirqs last  enabled at (0): [<ffffffff81059249>]
copy_process+0x6d0/0x14af
[ 3110.771033] softirqs last disabled at (0): [<          (null)>]
(null)
[ 3110.771036] Pid: 759, comm: rmmod Not tainted
3.0.17-1.rt33.1.fc16.ccrma.x86_64.rt #1
[ 3110.771037] Call Trace:
[ 3110.771040]  [<ffffffff8108e047>] ? print_irqtrace_events+0x9e/0xa2
[ 3110.771043]  [<ffffffff8104c44d>] __might_sleep+0x103/0x108
[ 3110.771047]  [<ffffffff814f1a98>] rt_spin_lock+0x24/0x56
[ 3110.771050]  [<ffffffff81261442>] dma_debug_device_change+0x71/0x1d9
[ 3110.771054]  [<ffffffff814f553e>] notifier_call_chain+0x84/0xbb
[ 3110.771057]  [<ffffffff810954e4>] ? rt_down_read+0x10/0x12
[ 3110.771060]  [<ffffffff8107fa8a>]
__blocking_notifier_call_chain+0x67/0x84
[ 3110.771063]  [<ffffffff8107fabb>]
blocking_notifier_call_chain+0x14/0x16
[ 3110.771067]  [<ffffffff813194de>] __device_release_driver+0xcd/0xd2
[ 3110.771069]  [<ffffffff81319b9e>] driver_detach+0xa4/0xca
[ 3110.771071]  [<ffffffff8131935c>] bus_remove_driver+0xba/0xde
[ 3110.771074]  [<ffffffff8131a23d>] driver_unregister+0x6a/0x75
[ 3110.771077]  [<ffffffff8126ae24>] pci_unregister_driver+0x44/0x97
[ 3110.771081]  [<ffffffffa02c01a7>] MPUExit+0x3f/0x6f [mpu]
[ 3110.771084]  [<ffffffff81099448>] sys_delete_module+0x1d9/0x24d
[ 3110.771087]  [<ffffffff810b5e67>] ? audit_syscall_entry+0x11c/0x148
[ 3110.771090]  [<ffffffff81251f36>] ? trace_hardirqs_on_thunk+0x3a/0x3f
[ 3110.771093]  [<ffffffff814f8482>] system_call_fastpath+0x16/0x1b


Thank you.
EyalC


