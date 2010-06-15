From: Gowrishankar Muthukrishnan <gowrishankar.m@linux.vnet.ibm.com>
Subject: 2.6.33.5-rt23: BUG (lock count overflow) while booting
Date: Tue, 15 Jun 2010 12:31:29 +0530
Message-ID: <4C172549.3080601@linux.vnet.ibm.com>
Reply-To: gowrishankar.m@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>,
	Darren Hart <dvhltc@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:41077 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146Ab0FOHBe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Jun 2010 03:01:34 -0400
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5F71T86015269
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jun 2010 17:01:29 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o5F71WWc1491166
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jun 2010 17:01:32 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o5F71Vo7007457
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Jun 2010 17:01:32 +1000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
Just noticed  this bug while booting 2.6.33.5-rt23 on power7.

---
Jun 15 02:26:21 eagle kernel: BUG: swapper/1: lock count overflow!

Jun 15 02:26:21 eagle kernel: Call Trace:

Jun 15 02:26:21 eagle kernel: [c0000001d379ebe0] [c000000000015494]
.show_stack+0xd8/0x218 (unreliable)

Jun 15 02:26:21 eagle kernel: [c0000001d379ecc0] [c0000000006a9350]
.dump_stack+0x28/0x3c

Jun 15 02:26:21 eagle kernel: [c0000001d379ed40] [c0000000000c96d8]
.rt_mutex_deadlock_account_lock+0x5c/0xa8

Jun 15 02:26:21 eagle kernel: [c0000001d379edd0] [c0000000000c8194]
.do_try_to_take_rt_mutex+0x164/0x1c0

Jun 15 02:26:21 eagle kernel: [c0000001d379ee80] [c0000000006a1cd4]
.rt_spin_lock_slowlock+0x130/0x38c

Jun 15 02:26:21 eagle kernel: [c0000001d379efe0] [c0000000006a2b0c]
.rt_spin_lock+0x80/0x9c

Jun 15 02:26:21 eagle kernel: [c0000001d379f070] [c0000000001aa0f8]
.vfsmount_write_lock+0x50/0xa8

Jun 15 02:26:21 eagle kernel: [c0000001d379f100] [c0000000001abc8c]
.mntput_no_expire+0x11c/0x2dc

Jun 15 02:26:21 eagle kernel: [c0000001d379f1b0] [c0000000001abe90]
.mntput+0x44/0x58

Jun 15 02:26:21 eagle kernel: [c0000001d379f240] [c0000000001b22e4]
.simple_pin_fs+0xec/0x120

Jun 15 02:26:21 eagle kernel: [c0000001d379f2f0] [c00000000054ec0c]
.usbfs_notify+0x16c/0x2f8

Jun 15 02:26:21 eagle kernel: [c0000001d379f3a0] [c0000000006a624c]
.notifier_call_chain+0x74/0xec

Jun 15 02:26:21 eagle kernel: [c0000001d379f450] [c0000000000b7fa0]
.__blocking_notifier_call_chain+0x84/0xc8

Jun 15 02:26:21 eagle kernel: [c0000001d379f510] [c0000000000b8024]
.blocking_notifier_call_chain+0x40/0x54

Jun 15 02:26:21 eagle kernel: [c0000001d379f5b0] [c00000000054c348]
.usb_notify_add_bus+0x3c/0x5c

Jun 15 02:26:21 eagle kernel: [c0000001d379f640] [c00000000053c7ec]
.usb_add_hcd+0x178/0x6c4

Jun 15 02:26:21 eagle kernel: [c0000001d379f700] [c00000000054db10]
.usb_hcd_pci_probe+0x1f4/0x2b4

Jun 15 02:26:21 eagle kernel: [c0000001d379f7b0] [c0000000003c4048]
.local_pci_probe+0x4c/0x68

Jun 15 02:26:21 eagle kernel: [c0000001d379f840] [c0000000003c4558]
.pci_device_probe+0xfc/0x148

Jun 15 02:26:21 eagle kernel: [c0000001d379f900] [c000000000445864]
.driver_probe_device+0xe0/0x1a0

Jun 15 02:26:21 eagle kernel: [c0000001d379f9a0] [c0000000004459d0]
.__driver_attach+0xac/0xf4

Jun 15 02:26:21 eagle kernel: [c0000001d379fa40] [c000000000444af8]
.bus_for_each_dev+0x98/0x104

Jun 15 02:26:21 eagle kernel: [c0000001d379fb00] [c0000000004455f8]
.driver_attach+0x40/0x60

Jun 15 02:26:21 eagle kernel: [c0000001d379fb90] [c000000000444094]
.bus_add_driver+0x194/0x358

Jun 15 02:26:21 eagle kernel: [c0000001d379fc40] [c000000000445f18]
.driver_register+0xe8/0x1ac

Jun 15 02:26:21 eagle kernel: [c0000001d379fcf0] [c0000000003c48a4]
.__pci_register_driver+0x84/0x134

Jun 15 02:26:21 eagle kernel: [c0000001d379fd90] [c00000000098f364]
.ehci_hcd_init+0x90/0xd4

Jun 15 02:26:21 eagle kernel: [c0000001d379fe20] [c000000000009890]
.do_one_initcall+0xac/0x1fc

Jun 15 02:26:21 eagle kernel: [c0000001d379fed0] [c00000000095a500]
.kernel_init+0x238/0x33c

Jun 15 02:26:21 eagle kernel: [c0000001d379ff90] [c0000000000343e8]
.kernel_thread+0x54/0x70
---
Thanks,
Gowri

