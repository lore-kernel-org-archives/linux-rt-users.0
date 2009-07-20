From: John Kacur <jkacur@redhat.com>
Subject: i915 oopses w/ experimental rt kernel
Date: Mon, 20 Jul 2009 14:35:02 +0200
Message-ID: <20090720123502.GA3615@tycho.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
To: linux-rt-users@vger.kernel.org, tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:56831 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753406AbZGTMfQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2009 08:35:16 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline




--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.31-rc3-rt1.oops.txt"

BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<(null)>] (null)
PGD 0 
Oops: 0000 [#1] PREEMPT SMP 
last sysfs file: /sys/class/power_supply/BAT0/energy_full
CPU 0 
Modules linked in: i915 drm i2c_algo_bit ipt_MASQUERADE iptable_nat nf_nat brid]
Pid: 3, comm: migration/0 Not tainted 2.6.31-rc3-rt1 #1 2241B48
RIP: 0010:[<0000000000000000>]  [<(null)>] (null)
RSP: 0018:ffff88013bb2bcf8  EFLAGS: 00010046
RAX: ffffffff813f73d0 RBX: ffffffff815a0020 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff815a0020 RDI: ffff8800280702c0
RBP: ffff88013bb2bd20 R08: ffff880028062d28 R09: ffff8800280703a8
R10: 000000000000000f R11: 0000000045fc79eb R12: ffffffff815a0020
R13: ffff8800280702c0 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88002805f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000001001000 CR4: 00000000000026f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
Process migration/0 (pid: 3, threadinfo ffff88013bb2a000, task ffff88013bb280c0)
Stack:
 ffffffff8103e83e 000000013b21e258 0000000045fc79eb 0000000045fc79eb
<0> ffff8800280702c0 ffff88013bb2bd50 ffffffff8103e9a3 0000000000000006
<0> 0000000045fc79eb 0000000045fc79eb 0000000000000000 ffff88013bb2bdb0
Call Trace:
 [<ffffffff8103e83e>] ? enqueue_task+0x6f/0x91
 [<ffffffff8103e9a3>] activate_task+0x3c/0x5b
 [<ffffffff8104c5a6>] try_to_wake_up+0x19f/0x301
 [<ffffffff8104c72f>] default_wake_function+0x27/0x3d
 [<ffffffff8103f444>] __wake_up_common+0x5a/0xa0
 [<ffffffff810501a4>] ? migration_thread+0x0/0x232
 [<ffffffff81049ee0>] complete+0x4a/0x6d
 [<ffffffff81050387>] migration_thread+0x1e3/0x232
 [<ffffffff810501a4>] ? migration_thread+0x0/0x232
 [<ffffffff8107213d>] kthread+0x9c/0xa4
 [<ffffffff8100d1ca>] child_rip+0xa/0x20
 [<ffffffff810720a1>] ? kthread+0x0/0xa4
 [<ffffffff8100d1c0>] ? child_rip+0x0/0x20
Code:  Bad RIP value.
RIP  [<(null)>] (null)
 RSP <ffff88013bb2bcf8>
CR2: 0000000000000000
---[ end trace 4d74503b4efb9750 ]---
note: migration/0[3] exited with preempt_count 1


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.31-rc3-rt1.oops2.txt"

usb 1-5: device not accepting address 7, error -110
hub 1-0:1.0: unable to enumerate USB device on port 5
BUG: unable to handle kernel NULL pointer dereference at (null)
IP: [<(null)>] (null)
PGD 0 
Oops: 0000 [#1] PREEMPT SMP 
last sysfs file: /sys/devices/system/cpu/sched_mc_power_savings
CPU 0 
Modules linked in: i915 drm i2c_algo_bit ipt_MASQUERADE iptable_nat nf_nat brid]
Pid: 3, comm: migration/0 Not tainted 2.6.31-rc3-rt1 #1 2241B48
RIP: 0010:[<0000000000000000>]  [<(null)>] (null)
RSP: 0018:ffff88013bb2bcf8  EFLAGS: 00010046
RAX: ffffffff813f73d0 RBX: ffffffff815a0020 RCX: 0000000000000001
RDX: 0000000000000001 RSI: ffffffff815a0020 RDI: ffff8800280702c0
RBP: ffff88013bb2bd20 R08: ffff880028062d28 R09: ffff8800280703a8
R10: e03e46a1506d4f38 R11: 000000000d037aaa R12: ffffffff815a0020
R13: ffff8800280702c0 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88002805f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000000000 CR3: 0000000001001000 CR4: 00000000000026f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
Process migration/0 (pid: 3, threadinfo ffff88013bb2a000, task ffff88013bb280c0)
Stack:
 ffffffff8103e83e 00000001399886d8 000000000d037aaa 000000000d037aaa
<0> ffff8800280702c0 ffff88013bb2bd50 ffffffff8103e9a3 0000000000000006
<0> 000000000d037aaa 000000000d037aaa 0000000000000000 ffff88013bb2bdb0
Call Trace:
 [<ffffffff8103e83e>] ? enqueue_task+0x6f/0x91
 [<ffffffff8103e9a3>] activate_task+0x3c/0x5b
 [<ffffffff8104c5a6>] try_to_wake_up+0x19f/0x301
 [<ffffffff8104c72f>] default_wake_function+0x27/0x3d
 [<ffffffff8103f444>] __wake_up_common+0x5a/0xa0
 [<ffffffff810501a4>] ? migration_thread+0x0/0x232
 [<ffffffff81049ee0>] complete+0x4a/0x6d
 [<ffffffff81050387>] migration_thread+0x1e3/0x232
 [<ffffffff810501a4>] ? migration_thread+0x0/0x232
 [<ffffffff8107213d>] kthread+0x9c/0xa4
 [<ffffffff8100d1ca>] child_rip+0xa/0x20
 [<ffffffff810720a1>] ? kthread+0x0/0xa4
 [<ffffffff8100d1c0>] ? child_rip+0x0/0x20
Code:  Bad RIP value.
RIP  [<(null)>] (null)
 RSP <ffff88013bb2bcf8>
CR2: 0000000000000000
---[ end trace 8d14e14f6617911e ]---
note: migration/0[3] exited with preempt_count 1


--gKMricLos+KVdGMg--
