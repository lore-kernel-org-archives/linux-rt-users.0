From: joel silvestre <j.silvestre@wanadoo.fr>
Subject: 2.6.29.1-rt9 INFO: possible circular locking dependency detected
Date: Sun, 26 Apr 2009 14:09:46 +0200
Message-ID: <1240747786.9289.7.camel@zordi2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2a.orange.fr ([80.12.242.138]:63074 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbZDZMJt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Apr 2009 08:09:49 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a02.orange.fr (SMTP Server) with ESMTP id 5C11480000AE
	for <linux-rt-users@vger.kernel.org>; Sun, 26 Apr 2009 14:09:48 +0200 (CEST)
Received: from [192.168.0.3] (AAnnecy-256-1-91-179.w90-10.abo.wanadoo.fr [90.10.170.179])
	by mwinf2a02.orange.fr (SMTP Server) with ESMTP id 1E7C380000AA
	for <linux-rt-users@vger.kernel.org>; Sun, 26 Apr 2009 14:09:48 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I get this message at boot time on i386:

All the best.

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.29.1-rt9-moa1-debug #1
-------------------------------------------------------
alsactl/2244 is trying to acquire lock:
 (&ice->gpio_mutex){+.+.+.}, at: [<f85a8133>] wm_master_mute_put
+0x2c/0x109 [snd_ice1724]

but task is already holding lock:
 ((struct rw_semaphore *)(&card->controls_rwsem)){++++.+}, at:
[<c0151f4b>] rt_down_read+0xa/0xc

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 ((struct rw_semaphore *)(&card->controls_rwsem)){++++.+}:
       [<c014bbb8>] __lock_acquire+0x105d/0x1397
       [<c014bfa1>] lock_acquire+0xaf/0xcc
       [<c0151fc6>] rt_down_write+0x1b/0x2a
       [<f8408210>] snd_ctl_add+0x3a/0x17b [snd]
       [<f85accc1>] aureon_add_controls+0x169/0x1cd [snd_ice1724]
       [<f85ac641>] snd_vt1724_probe+0xba9/0xcf9 [snd_ice1724]
       [<c0224674>] local_pci_probe+0xe/0x10
       [<c0224fe9>] pci_device_probe+0x46/0x69
       [<c028311b>] driver_probe_device+0xa2/0x13e
       [<c0283206>] __driver_attach+0x4f/0x71
       [<c0282a9f>] bus_for_each_dev+0x40/0x6a
       [<c0282fad>] driver_attach+0x14/0x16
       [<c028249b>] bus_add_driver+0xfa/0x216
       [<c02833bf>] driver_register+0x87/0xe4
       [<c0225244>] __pci_register_driver+0x49/0x75
       [<f85bb017>] 0xf85bb017
       [<c0101137>] do_one_initcall+0x4a/0x111
       [<c0155dae>] sys_init_module+0x87/0x186
       [<c0102ab8>] sysenter_do_call+0x12/0x36
       [<ffffffff>] 0xffffffff

-> #0 (&ice->gpio_mutex){+.+.+.}:
       [<c014b91e>] __lock_acquire+0xdc3/0x1397
       [<c014bfa1>] lock_acquire+0xaf/0xcc
       [<c0312109>] _mutex_lock+0x1b/0x2a
       [<f85a8133>] wm_master_mute_put+0x2c/0x109 [snd_ice1724]
       [<f8408f27>] snd_ctl_ioctl+0x926/0xd7f [snd]
       [<c01a4f6f>] vfs_ioctl+0x22/0x69
       [<c01a54e4>] do_vfs_ioctl+0x46a/0x4a3
       [<c01a555d>] sys_ioctl+0x40/0x5a
       [<c0102ab8>] sysenter_do_call+0x12/0x36
       [<ffffffff>] 0xffffffff

other info that might help us debug this:

2 locks held by alsactl/2244:
 #0:  (&card->power_lock){+.+...}, at: [<f8408e79>] snd_ctl_ioctl
+0x878/0xd7f [snd]
 #1:  ((struct rw_semaphore *)(&card->controls_rwsem)){++++.+}, at:
[<c0151f4b>] rt_down_read+0xa/0xc

stack backtrace:
Pid: 2244, comm: alsactl Not tainted 2.6.29.1-rt9-moa1-debug #1
Call Trace:
 [<c030fc0c>] ? printk+0xf/0x13
 [<c014a770>] print_circular_bug_tail+0xaa/0xb5
 [<c014b91e>] __lock_acquire+0xdc3/0x1397
 [<c014bfa1>] lock_acquire+0xaf/0xcc
 [<f85a8133>] ? wm_master_mute_put+0x2c/0x109 [snd_ice1724]
 [<c0312109>] _mutex_lock+0x1b/0x2a
 [<f85a8133>] ? wm_master_mute_put+0x2c/0x109 [snd_ice1724]
 [<f85a8133>] wm_master_mute_put+0x2c/0x109 [snd_ice1724]
 [<f8408f27>] snd_ctl_ioctl+0x926/0xd7f [snd]
 [<c014bed9>] ? __lock_acquire+0x137e/0x1397
 [<c012ef67>] ? wakeup_softirqd+0x11/0x36
 [<c012f8e8>] ? __do_softirq+0x32/0x196
 [<f8408601>] ? snd_ctl_ioctl+0x0/0xd7f [snd]
 [<c01a4f6f>] vfs_ioctl+0x22/0x69
 [<c01a54e4>] do_vfs_ioctl+0x46a/0x4a3
 [<c0219550>] ? trace_hardirqs_on_thunk+0xc/0x10
 [<c0102b84>] ? restore_nocheck_notrace+0x0/0xe
 [<c019aec9>] ? fget_light+0x1a/0x95
 [<c01a555d>] sys_ioctl+0x40/0x5a
 [<c0102ab8>] sysenter_do_call+0x12/0x36



