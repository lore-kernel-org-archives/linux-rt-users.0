From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH] 2.6.31-rc4-rt1: Convert xt_info_lock.lock to
	atomic_spinlock_t
Date: Fri, 31 Jul 2009 15:51:46 -0300
Message-ID: <20090731185146.GN22657@unix.sh>
References: <20090731165056.GJ22657@unix.sh>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:2323 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZGaSv5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jul 2009 14:51:57 -0400
Received: by rv-out-0506.google.com with SMTP id f6so661928rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 31 Jul 2009 11:51:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090731165056.GJ22657@unix.sh>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

Please ignore the patch I sent in the last email. I got the diff from the
wrong tree and started seeing even worse messages with my patches on
(though the system keeps running).

Anyway, here I have a better version of the BUG message and backtrace, from
2.6.31-rc4-rt1 without any extra patch:

================================================
[ BUG: lock held when returning to user space! ]
------------------------------------------------
deluge/2889 is leaving the kernel with locks still held!
1 lock held by deluge/2889:
 #0:  (<NULL>){......}, at: [<ffffffffa02889e1>] ipt_do_table+0x10b/0x5ea [ip_tables]
BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
IP: [<ffffffff8108e41c>] wakeup_next_waiter+0x49/0x1a8
PGD 5b677067 PUD 5b678067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP 
last sysfs file: /sys/block/sda/queue/hw_sector_size
CPU 2 
Modules linked in: fuse i915 drm i2c_algo_bit video output sco bridge stp bnep l2cap bluetooth rfkill sunrpc ipv6 ipt_REJECT xt_tcpudp nf_conntrack_ipv4 nf_defrag_ipv4 xt_state iptable_filter ip_tables x_tables dm_mirror dm_region_hash dm_log dm_multipath scsi_dh dm_mod uinput snd_hda_codec_realtek snd_hda_intel snd_hda_codec snd_hwdep snd_pcm snd_timer snd firewire_ohci r8169 i2c_i801 firewire_core iTCO_wdt sr_mod soundcore iTCO_vendor_support i2c_core serio_raw sg pcspkr mii intel_agp snd_page_alloc cdrom button crc_itu_t ahci libata sd_mod scsi_mod crc_t10dif ext3 jbd mbcache uhci_hcd ohci_hcd ehci_hcd [last unloaded: microcode]
Pid: 2879, comm: deluged Not tainted 2.6.31-rc4-rt1 #2 KQ260AA-AC4 a6540br
RIP: 0010:[<ffffffff8108e41c>]  [<ffffffff8108e41c>] wakeup_next_waiter+0x49/0x1a8
RSP: 0018:ffff88005b47f538  EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff88005ca10800 RDI: ffff88005ca10100
RBP: ffff88005b47f578 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000001f80 R11: 00000000d6168ae4 R12: ffff8800047862e0
R13: ffffffffffffffe8 R14: 0000000000000001 R15: ffff8800790eedb0
FS:  00007f9fa0d80910(0000) GS:ffff8800045b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000040 CR3: 000000005b676000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff4ff0 DR7: 0000000000000400
Process deluged (pid: 2879, threadinfo ffff88005b47e000, task ffff88005ca10100)
Stack:
 ffffffff813e6333 000000006e6b1112 ffff88005b47f578 ffff8800047862e0
<0> 0000000000000246 ffff880078ccc340 ffff88007cdb40ec ffff8800790eedb0
<0> ffff88005b47f5a8 ffffffff813e6362 00000000d6168ae4 000000006e6b1112
Call Trace:
 [<ffffffff813e6333>] ? rt_spin_lock_slowunlock+0x27/0x8c
 [<ffffffff813e6362>] rt_spin_lock_slowunlock+0x56/0x8c
 [<ffffffff8108e77a>] rt_spin_lock_fastunlock.clone.2+0x5f/0x75
 [<ffffffff813e6d6e>] rt_spin_unlock+0x3a/0x55
 [<ffffffffa0288acd>] ? ipt_do_table+0x1f7/0x5ea [ip_tables]
 [<ffffffffa0288e52>] ipt_do_table+0x57c/0x5ea [ip_tables]
 [<ffffffff81369d04>] ? dst_output+0x0/0x39
 [<ffffffffa02900fb>] ipt_local_out_hook+0x59/0x7b [iptable_filter]
 [<ffffffff81357f7c>] nf_iterate+0x5c/0xb3
 [<ffffffff81369d04>] ? dst_output+0x0/0x39
 [<ffffffff81358060>] nf_hook_slow+0x8d/0x109
 [<ffffffff81369d04>] ? dst_output+0x0/0x39
 [<ffffffff8136a902>] ? ip_finish_output2+0x2a3/0x314
 [<ffffffff8136a3a5>] nf_hook_thresh.clone.0+0x50/0x6d
 [<ffffffff8136a453>] __ip_local_out+0x91/0xa7
 [<ffffffff8136a48e>] ip_local_out+0x25/0x4d
 [<ffffffff8136ac6a>] ip_queue_xmit+0x2f7/0x3b8
 [<ffffffff8138015e>] tcp_transmit_skb+0x6ae/0x702
 [<ffffffff81381f92>] tcp_write_xmit+0x7dd/0x8e3
 [<ffffffff813820df>] tcp_push_one+0x47/0x5d
 [<ffffffff8137608f>] tcp_sendmsg+0x6e8/0x898
 [<ffffffff81320db0>] __sock_sendmsg+0x73/0x92
 [<ffffffff813219a7>] sock_sendmsg+0xdb/0x108
 [<ffffffff81073a80>] ? autoremove_wake_function+0x0/0x5f
 [<ffffffff81159d7b>] ? ep_poll_callback+0x35/0x11e
 [<ffffffff81159d7b>] ? ep_poll_callback+0x35/0x11e
 [<ffffffff8132c5fa>] ? verify_iovec+0x60/0xb6
 [<ffffffff81321c08>] sys_sendmsg+0x234/0x2c1
 [<ffffffff810656c3>] ? sigprocmask+0x45/0xfb
 [<ffffffff8112ba1c>] ? path_put+0x31/0x4c
 [<ffffffff810b1d25>] ? audit_syscall_entry+0x12d/0x16d
 [<ffffffff813e68a3>] ? lockdep_sys_exit_thunk+0x35/0x67
 [<ffffffff8100c0db>] system_call_fastpath+0x16/0x1b
Code: 8b 3c 25 00 90 00 00 48 81 c7 e8 06 00 00 65 48 8b 04 25 28 00 00 00 48 89 45 c8 31 c0 e8 dd 95 35 00 49 8b 5c 24 50 4c 8d 6b e8 <4d> 39 65 58 74 04 0f 0b eb fe 49 8d 74 24 40 4c 89 ef e8 05 8d 
RIP  [<ffffffff8108e41c>] wakeup_next_waiter+0x49/0x1a8
 RSP <ffff88005b47f538>
CR2: 0000000000000040
---[ end trace 02adbaae7c58a90e ]---
ata3.00: qc timeout (cmd 0xa0)
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00: irq_stat 0x40000001
ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata3.00: status: { DRDY ERR }
ata3: hard resetting link
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: qc timeout (cmd 0xa0)
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
ata3.00: irq_stat 0x40000001
ata3.00: cmd a0/00:00:00:00:00/00:00:00:00:00/a0 tag 0
         cdb 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
         res 51/20:03:00:00:00/00:00:00:00:00/a0 Emask 0x5 (timeout)
ata3.00: status: { DRDY ERR }
ata3: hard resetting link
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)

Looking for his old brown paper bag,
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

