From: Clark Williams <williams@redhat.com>
Subject: [RT] oops in 4.1.3-rt3
Date: Mon, 3 Aug 2015 14:27:00 -0500
Message-ID: <20150803142700.1de720e4@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sebastian,

Below is a traceback I hit while running 4.1.3-rt3 on my Lenovo T530.

I was doing my normal, play music, copy files over the lan, do compiles,
do email, etc., so I I can't really point you at a reproducer. The graphics
system stayed up somewhat but the actual trace I hit scrolled off. This was
extracted from the syslog with 'journalctl'. 

If I encounter it again, I'll see if I can force a kdump. 

Clark


Jul 28 20:29:07 sluggy systemd-udevd[831]: worker [13548] did not accept message -111 (Connection refused), kill it
Jul 28 20:29:07 sluggy kernel: general protection fault: 0000 [#1] PREEMPT SMP 
Jul 28 20:29:07 sluggy kernel: Modules linked in: hidp cmac rfcomm fuse xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 tun 
Jul 28 20:29:07 sluggy kernel:  snd_hda_codec snd_usbmidi_lib snd_rawmidi snd_hda_core videodev iwlwifi btusb snd_hwdep btbcm 
Jul 28 20:29:07 sluggy kernel: CPU: 4 PID: 13548 Comm: systemd-udevd Not tainted 4.1.3-rt3 #3
Jul 28 20:29:07 sluggy kernel: Hardware name: LENOVO 24293E8/24293E8, BIOS G4ET94WW (2.54 ) 05/23/2013
Jul 28 20:29:07 sluggy kernel: task: ffff8802ffb0aa40 ti: ffff88007871c000 task.ti: ffff88007871c000
Jul 28 20:29:07 sluggy kernel: RIP: 0010:[<ffffffff8168a35d>]  [<ffffffff8168a35d>] sock_prot_inuse_add+0x2d/0x50
Jul 28 20:29:07 sluggy kernel: RSP: 0018:ffff88007871fb68  EFLAGS: 00010296
Jul 28 20:29:07 sluggy kernel: RAX: 0000000000000004 RBX: 00000000ffffffff RCX: 0000000000000000
Jul 28 20:29:07 sluggy kernel: RDX: ffffffff81810428 RSI: ffffffff81ae0d87 RDI: ffffffff81a7f8c0
Jul 28 20:29:07 sluggy kernel: RBP: ffff88007871fb88 R08: 0000000000000001 R09: 0000000000000000
Jul 28 20:29:07 sluggy kernel: R10: ffff880088ebb390 R11: 0000000000000001 R12: 20303d6469752031
Jul 28 20:29:08 sluggy kernel: R13: ffffffff81cea7a0 R14: 0000000000000000 R15: 0000000000000018
Jul 28 20:29:08 sluggy kernel: FS:  0000000000000000(0000) GS:ffff88041e300000(0000) knlGS:0000000000000000
Jul 28 20:29:08 sluggy kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Jul 28 20:29:08 sluggy kernel: CR2: 000055da9fd30060 CR3: 0000000001c0e000 CR4: 00000000001407e0
Jul 28 20:29:08 sluggy kernel: Stack:
Jul 28 20:29:08 sluggy kernel:  ffff88031abe42d8 ffff88031abe42d8 ffff88031abe4000 ffff88031abe45d8
Jul 28 20:29:08 sluggy kernel:  ffff88007871fbf8 ffffffff816db0b6 ffff880407f06400 ffff88040afbd1d0
Jul 28 20:29:08 sluggy kernel:  0000000100000000 20303d6469752031 0000000fffffef45 00000000fa86c4d0
Jul 28 20:29:08 sluggy kernel: Call Trace:
Jul 28 20:29:08 sluggy kernel:  [<ffffffff816db0b6>] netlink_release+0x316/0x540
Jul 28 20:29:08 sluggy kernel:  [<ffffffff8168615f>] sock_release+0x1f/0x90
Jul 28 20:29:08 sluggy kernel:  [<ffffffff816861e2>] sock_close+0x12/0x20
Jul 28 20:29:08 sluggy kernel:  [<ffffffff8123899b>] __fput+0xcb/0x1e0
Jul 28 20:29:08 sluggy kernel:  [<ffffffff81238afe>] ____fput+0xe/0x10
Jul 28 20:29:08 sluggy kernel:  [<ffffffff810c4db4>] task_work_run+0xd4/0xf0
Jul 28 20:29:08 sluggy kernel:  [<ffffffff810a8b57>] do_exit+0x3f7/0xbe0
Jul 28 20:29:08 sluggy kernel:  [<ffffffff810a93e0>] do_group_exit+0x50/0xd0
Jul 28 20:29:08 sluggy kernel:  [<ffffffff810b5fbb>] get_signal+0x29b/0x6e0
Jul 28 20:29:08 sluggy kernel:  [<ffffffff810165b7>] do_signal+0x37/0x7c0
Jul 28 20:29:08 sluggy kernel:  [<ffffffff812833b3>] ? ep_poll+0x3b3/0x460
Jul 28 20:29:08 sluggy kernel:  [<ffffffff81157816>] ? __audit_syscall_exit+0x1f6/0x290
Jul 28 20:29:08 sluggy kernel:  [<ffffffff81016de8>] do_notify_resume+0xa8/0x100
Jul 28 20:29:08 sluggy kernel:  [<ffffffff817cc1be>] int_signal+0x12/0x17
Jul 28 20:29:08 sluggy kernel: Code: 44 00 00 55 48 89 e5 41 55 41 54 53 49 89 fc 49 89 f5 48 c7 c7 87 0d ae 81 89 d3 48 83 ec
Jul 28 20:29:08 sluggy kernel: RIP  [<ffffffff8168a35d>] sock_prot_inuse_add+0x2d/0x50
Jul 28 20:29:08 sluggy kernel:  RSP <ffff88007871fb68>
Jul 28 20:29:08 sluggy kernel: ---[ end trace 0000000000000002 ]---
