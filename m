From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: 2.6.33.9-rt31: Lockdep: BUG: circular locking deadlock detected!
Date: Thu, 14 Apr 2011 09:45:04 -0300
Message-ID: <20110414124503.GA18084@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37119 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab1DNMpN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Apr 2011 08:45:13 -0400
Received: by wya21 with SMTP id 21so1352821wya.19
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Apr 2011 05:45:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have been running 2.6.33.9-rt31 for three days now and just noticed this
message in my dmesg:

(I can't investigate it now so I decided to share the message)

============================================
[ BUG: circular locking deadlock detected! ]
--------------------------------------------
udisks-daemon/2229 is deadlocking current task hald-addon-stor/1554


1) hald-addon-stor/1554 is trying to acquire this lock:
 [ffff880075b59220] {&bdev->bd_mutex}
.. ->owner: ffff88005f7ec401
.. held by:     udisks-daemon: 2229 [ffff88005f7ec400, 120]

2) udisks-daemon/2229 is blocked on this lock:
 [ffffffff81aafb90] {kernel_sem.lock}
INFO: lockdep is turned off.
INFO: lockdep is turned off.

udisks-daemon/2229's [blocked] stackdump:

 ffff8800762cb6d8 0000000000000046 0000000000000000 ffffffff8141fc81
 0000000000000000 0000000000000046 000000000000b428 ffff88005f7ec7f0
 ffff880078710b80 ffff88005f7ec400 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff8141fc81>] ? rt_spin_lock_slowunlock+0x23/0x7d
 [<ffffffff8141eb3f>] schedule+0x13/0x23
 [<ffffffff8141eded>] schedule_timeout+0x36/0xed
 [<ffffffff81420bb4>] ? _raw_spin_unlock_irqrestore+0x53/0x61
 [<ffffffff8141fcb1>] ? rt_spin_lock_slowunlock+0x53/0x7d
 [<ffffffff81074714>] ? rt_spin_lock_fastunlock.clone.11+0x2d/0x2f
 [<ffffffff8141e10c>] wait_for_common+0xb1/0x10b
 [<ffffffff8103c147>] ? default_wake_function+0x0/0x16
 [<ffffffff814202cb>] ? rt_spin_unlock+0x2e/0x32
 [<ffffffff8141e209>] wait_for_completion+0x1d/0x1f
 [<ffffffff811f98fb>] blk_execute_rq+0xd3/0x108
 [<ffffffff812b5702>] scsi_execute+0xf5/0x147
 [<ffffffff812b57db>] scsi_execute_req+0x87/0xb9
 [<ffffffff812bfdfb>] sd_revalidate_disk+0x1e8/0x16a4
 [<ffffffff81074714>] ? rt_spin_lock_fastunlock.clone.11+0x2d/0x2f
 [<ffffffff814202cb>] ? rt_spin_unlock+0x2e/0x32
 [<ffffffff81125371>] ? __invalidate_device+0x48/0x53
 [<ffffffff81120000>] ? submit_bh+0x10b/0x11a
 [<ffffffff811254f9>] check_disk_change+0x52/0x5d
 [<ffffffff812be48f>] sd_open+0xf9/0x1a8
 [<ffffffff811262fa>] __blkdev_get+0xde/0x39d
 [<ffffffff811265cb>] ? blkdev_open+0x0/0xbf
 [<ffffffff811265c9>] blkdev_get+0x10/0x12
 [<ffffffff8112664e>] blkdev_open+0x83/0xbf
 [<ffffffff810fccc1>] __dentry_open+0x22a/0x373
 [<ffffffff811e15f4>] ? devcgroup_inode_permission+0xf0/0x11d
 [<ffffffff811c6598>] ? security_inode_permission+0x21/0x23
 [<ffffffff810fdc83>] nameidata_to_filp+0x3f/0x50
 [<ffffffff81109f0b>] do_filp_open+0x591/0xade
 [<ffffffff8106ea1c>] ? lock_acquire+0xd2/0xe1
 [<ffffffff8141fc81>] ? rt_spin_lock_slowunlock+0x23/0x7d
 [<ffffffff81420bb4>] ? _raw_spin_unlock_irqrestore+0x53/0x61
 [<ffffffff81074714>] ? rt_spin_lock_fastunlock.clone.11+0x2d/0x2f
 [<ffffffff814202cb>] ? rt_spin_unlock+0x2e/0x32
 [<ffffffff81113d13>] ? alloc_fd+0x10b/0x11d
 [<ffffffff810fdcf8>] do_sys_open+0x64/0x119
 [<ffffffff810fddcd>] sys_open+0x20/0x22
 [<ffffffff81002db2>] system_call_fastpath+0x16/0x1b

hald-addon-stor/1554's [current] stackdump:

Pid: 1554, comm: hald-addon-stor Not tainted 2.6.33.9-rt31 #8
Call Trace:
 [<ffffffff81074d4a>] debug_rt_mutex_print_deadlock+0x17f/0x1a6
 [<ffffffff81074bfa>] ? debug_rt_mutex_print_deadlock+0x2f/0x1a6
 [<ffffffff8141f64f>] __rt_mutex_slowlock.clone.10+0x86/0xc8
 [<ffffffff8141f80f>] rt_mutex_slowlock+0x17e/0x23a
 [<ffffffff811262a6>] ? __blkdev_get+0x8a/0x39d
 [<ffffffff8141f93c>] rt_mutex_lock+0x35/0x3a
 [<ffffffff8142033c>] _mutex_lock_nested+0x3a/0x41
 [<ffffffff811262a6>] ? __blkdev_get+0x8a/0x39d
 [<ffffffff811262a6>] __blkdev_get+0x8a/0x39d
 [<ffffffff811265cb>] ? blkdev_open+0x0/0xbf
 [<ffffffff811265c9>] blkdev_get+0x10/0x12
 [<ffffffff8112664e>] blkdev_open+0x83/0xbf
 [<ffffffff810fccc1>] __dentry_open+0x22a/0x373
 [<ffffffff811e15f4>] ? devcgroup_inode_permission+0xf0/0x11d
 [<ffffffff811c6598>] ? security_inode_permission+0x21/0x23
 [<ffffffff810fdc83>] nameidata_to_filp+0x3f/0x50
 [<ffffffff81109f0b>] do_filp_open+0x591/0xade
 [<ffffffff8106ea1c>] ? lock_acquire+0xd2/0xe1
 [<ffffffff8141fc81>] ? rt_spin_lock_slowunlock+0x23/0x7d
 [<ffffffff81420bb4>] ? _raw_spin_unlock_irqrestore+0x53/0x61
 [<ffffffff81074714>] ? rt_spin_lock_fastunlock.clone.11+0x2d/0x2f
 [<ffffffff814202cb>] ? rt_spin_unlock+0x2e/0x32
 [<ffffffff81113d13>] ? alloc_fd+0x10b/0x11d
 [<ffffffff810fdcf8>] do_sys_open+0x64/0x119
 [<ffffffff810fddcd>] sys_open+0x20/0x22
 [<ffffffff81002db2>] system_call_fastpath+0x16/0x1b
INFO: lockdep is turned off.
[ turning off deadlock detection.Please report this trace. ]


Cheers,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

