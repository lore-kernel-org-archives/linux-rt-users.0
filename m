From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: 3.18.7-rt2: NOHZ_FULL warning at boot
Date: Thu, 26 Feb 2015 17:05:47 -0300
Message-ID: <20150226200547.GL4111@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:46296 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbBZUFv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Feb 2015 15:05:51 -0500
Received: by qcxr5 with SMTP id r5so10408440qcx.13
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Feb 2015 12:05:50 -0800 (PST)
Received: from lclaudio.dyndns.org ([177.157.5.90])
        by mx.google.com with ESMTPSA id 191sm1177431qht.13.2015.02.26.12.05.50
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2015 12:05:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I have been seeing the warning below at boot time on 3.18.7-rt2. Anybody
else seeing it?

[    1.537207] ------------[ cut here ]------------
[    1.537215] WARNING: CPU: 1 PID: 20 at /home/lclaudio/SANDBOX/kernel-rt/kernel/time/tick-sched.c:167 can_stop_full_tick+0x1ee/0x2b0()
[    1.537219] Modules linked in: efivarfs
[    1.537224] CPU: 1 PID: 20 Comm: ksoftirqd/1 Not tainted 3.18.7-rt2+ #2
[    1.537225] Hardware name: Hewlett-Packard p7-1512/2ADA, BIOS 8.15 02/05/2013
[    1.537227]  0000000000000000 000000005b4bc999 ffff880191503bb8 ffffffff8175a165
[    1.537228]  0000000000000000 0000000000000000 ffff880191503bf8 ffffffff8107add1
[    1.537229]  ffff880191503be8 ffff880198fce280 ffff880198e00000 0000000000000000
[    1.537229] Call Trace:
[    1.537233]  [<ffffffff8175a165>] dump_stack+0x4f/0x7c
[    1.537235]  [<ffffffff8107add1>] warn_slowpath_common+0x81/0xc0
[    1.537237]  [<ffffffff8107af0a>] warn_slowpath_null+0x1a/0x20
[    1.537238]  [<ffffffff811074fe>] can_stop_full_tick+0x1ee/0x2b0
[    1.537240]  [<ffffffff81107656>] __tick_nohz_full_check+0x76/0xc0
[    1.537241]  [<ffffffff811076ae>] nohz_full_kick_work_func+0xe/0x10
[    1.537243]  [<ffffffff8116ff7c>] irq_work_run_list+0x3c/0x60
[    1.537244]  [<ffffffff8117037e>] irq_work_tick+0x3e/0x90
[    1.537246]  [<ffffffff810f25c4>] run_timer_softirq+0x44/0x3b0
[    1.537248]  [<ffffffff81760855>] ? _raw_spin_unlock+0x35/0x60
[    1.537250]  [<ffffffff810b0b89>] ? vtime_account_system+0x99/0xb0
[    1.537252]  [<ffffffff810b0d9b>] ? vtime_common_account_irq_enter+0x4b/0x80
[    1.537254]  [<ffffffff8107fbd4>] do_current_softirqs.isra.11+0x274/0x550
[    1.537255]  [<ffffffff8107ff86>] run_ksoftirqd+0x26/0x50
[    1.537257]  [<ffffffff810a1a0d>] smpboot_thread_fn+0x18d/0x2d0
[    1.537259]  [<ffffffff810a1880>] ? SyS_setgroups+0x150/0x150
[    1.537260]  [<ffffffff8109d68d>] kthread+0xfd/0x120
[    1.537262]  [<ffffffff8175e177>] ? wait_for_completion+0xe7/0x120
[    1.537264]  [<ffffffff8109d590>] ? kthread_create_on_node+0x260/0x260
[    1.537266]  [<ffffffff817618ac>] ret_from_fork+0x7c/0xb0
[    1.537267]  [<ffffffff8109d590>] ? kthread_create_on_node+0x260/0x260
[    1.537268] ---[ end trace 0000000000000002 ]---


>From kernel/time/tick-sched.c line 167:

static bool can_stop_full_tick(void)
{
        WARN_ON_ONCE(!irqs_disabled());

The config in use, NO_HZ related is:

	CONFIG_NO_HZ_COMMON=y
	# CONFIG_NO_HZ_IDLE is not set
		CONFIG_NO_HZ_FULL=y
	CONFIG_NO_HZ_FULL_ALL=y
	CONFIG_NO_HZ_FULL_SYSIDLE=y
	CONFIG_NO_HZ_FULL_SYSIDLE_SMALL=8
	CONFIG_NO_HZ=y
	CONFIG_HZ_1000=y
	CONFIG_HZ=1000

Cheers,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

