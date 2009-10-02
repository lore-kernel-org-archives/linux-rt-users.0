From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: slab_irq_enable is receiving corrupted / deleted list entries
Date: Fri, 2 Oct 2009 11:47:12 -0300
Message-ID: <20091002144711.GF3466@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, dmarlin@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qy0-f173.google.com ([209.85.221.173]:64603 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168AbZJBPEM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Oct 2009 11:04:12 -0400
Received: by qyk3 with SMTP id 3so939522qyk.4
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Oct 2009 08:04:16 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

The function slab_irq_enable is receiving list entries that are already
deleted. In fact, they seem to be corrupted as entry->next is pointing
to LIST_POISON1, meaning that it was already deleted but entry->prev
points to a valid address.

This email has debug data I have collected, the original report and the
patch I used to gather data. That was observed on 2.6.31-rt11.


-----[ Debug Logs

I have added a few debug lines to slab_irq_disable and was able to see:
    
slab_irq_enable: acting over a deleted entry!
&page->lru: ffffea0005501ee0   (&page->lru)->next: 0000000000100100   (&page->lru)->prev: ffff88049d9e7d60
Pid: 222, comm: events/10 Not tainted 2.6.31-rt11_test #9
Call Trace:
 [<ffffffff8110fcb9>] slab_irq_enable+0x105/0x110
 [<ffffffff811106e4>] drain_array+0xe9/0x115
 [<ffffffff81112f62>] cache_reap+0x10b/0x24c
 [<ffffffff81112e57>] ? cache_reap+0x0/0x24c
 [<ffffffff810707c4>] worker_thread+0x1b0/0x263
 [<ffffffff8107581f>] ? autoremove_wake_function+0x0/0x5e
 [<ffffffff81070614>] ? worker_thread+0x0/0x263
 [<ffffffff81070614>] ? worker_thread+0x0/0x263
 [<ffffffff81075524>] kthread+0x8a/0x92
 [<ffffffff8100d10a>] child_rip+0xa/0x20
 [<ffffffff8107549a>] ? kthread+0x0/0x92
 [<ffffffff8100d100>] ? child_rip+0x0/0x20


slab_irq_enable: acting over a deleted entry!
&page->lru: ffffea000dae0778   (&page->lru)->next: 0000000000100100   (&page->lru)->prev: ffff88049d9f5d60
Pid: 225, comm: events/13 Not tainted 2.6.31-rt11_test #8
Call Trace:
 [<ffffffff8110fcc1>] slab_irq_enable+0x10d/0x118
 [<ffffffff811106ec>] drain_array+0xe9/0x115
 [<ffffffff81112f6a>] cache_reap+0x10b/0x24c
 [<ffffffff81112e5f>] ? cache_reap+0x0/0x24c
 [<ffffffff810707c4>] worker_thread+0x1b0/0x263
 [<ffffffff8107581f>] ? autoremove_wake_function+0x0/0x5e
 [<ffffffff81070614>] ? worker_thread+0x0/0x263
 [<ffffffff81070614>] ? worker_thread+0x0/0x263
 [<ffffffff81075524>] kthread+0x8a/0x92
 [<ffffffff8100d10a>] child_rip+0xa/0x20
 [<ffffffff8107549a>] ? kthread+0x0/0x92
 [<ffffffff8100d100>] ? child_rip+0x0/0x20


-----[ Original Report

Here is the original backtrace reported by David A. Marlin, observed while he
was running hackbench 80 in a machine with 16 processors (8 + hyperthreading):

BUG: unable to handle kernel paging request at 0000000000100108
IP: [<ffffffff8110fca6>] slab_irq_enable+0x5e/0xa5
PGD 46bcc3067 PUD 46bcc4067 PMD 0
Oops: 0002 [#1] PREEMPT SMP
last sysfs file: /sys/devices/system/clocksource/clocksource0/available_clocksource
CPU 0
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth rfkill sunrpc ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables ib_iser libiscsi scsi_transport_iscsi ib_srp scsi_transport_srp scsi_tgt ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_addr ipv6 ib_sa mlx4_ib ib_mad ib_core dm_multipath scsi_dh video output sbs sbshc battery ac parport_pc lp parport ipmi_devintf ipmi_si hpilo ipmi_msghandler hpwdt bnx2x mlx4_core crc32c serio_raw libcrc32c button snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc iTCO_wdt iTCO_vendor_support shpchp pcspkr dm_snapshot dm_zero dm_mirror dm_region_hash dm_log dm_mod usb_storage cciss sd_mod crc_t10dif scsi_mod ext3 jbd mbcache uhci_hcd ohci_
 hcd ehci_hcd [last unloaded: microcode]
Pid: 31443, comm: hackbench Not tainted 2.6.31-rt11 #1 ProLiant BL460c G6
RIP: 0010:[<ffffffff8110fca6>]  [<ffffffff8110fca6>] slab_irq_enable+0x5e/0xa5
RSP: 0018:ffff88047d0a1a78  EFLAGS: 00010202
RAX: ffff88047d0a1a78 RBX: 0000000000000008 RCX: ffffea0005004558
RDX: 0000000000100100 RSI: 0000000000000000 RDI: ffffea0005004530
RBP: ffff88047d0a1aa8 R08: ffff8800284018c0 R09: ffff88047d0a1958
R10: 0000000085717c2e R11: ffff88047d0a1938 R12: ffff88018997c800
R13: ffffffff81321cd7 R14: ffff88046bcc0a80 R15: 0000000000000001
FS:  00007fa64e7526e0(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 000000046bcc2000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process hackbench (pid: 31443, threadinfo ffff88047d0a0000, task ffff88045ac96580)
Stack:
 ffffea0005004558 ffffc9000100e5e0 ffff88018997c800 0000000085717c2e
<0> ffff88046bcc0a80 ffff88047d0a1ac4 ffff88047d0a1ae8 ffffffff81110b41
<0> ffff8801d39b8d80 0000000800000246 0000000085717c2e ffff8801ad10b380
Call Trace:
 [<ffffffff81110b41>] kfree+0xbb/0xda
 [<ffffffff813b849e>] ? unix_stream_recvmsg+0x434/0x50a
 [<ffffffff81321cd7>] skb_release_data+0xb9/0xd4
 [<ffffffff81322484>] skb_release_all+0x28/0x43
 [<ffffffff81089f1b>] ? rt_spin_lock_fastunlock+0x4f/0x80
 [<ffffffff8132185e>] __kfree_skb+0x20/0x9e
 [<ffffffff813219e3>] kfree_skb+0xb6/0xd5
 [<ffffffff813b849e>] unix_stream_recvmsg+0x434/0x50a
 [<ffffffff81318923>] __sock_recvmsg+0x7c/0x9f
 [<ffffffff81318a18>] sock_aio_read+0xd2/0xfa
 [<ffffffff81118e4a>] do_sync_read+0xf4/0x14c
 [<ffffffff811a8f3a>] ? file_has_perm+0xb4/0xd7
 [<ffffffff81075827>] ? autoremove_wake_function+0x0/0x5e
 [<ffffffff811a0ff4>] ? security_file_permission+0x24/0x3a
 [<ffffffff811196cd>] vfs_read+0xce/0x12c
 [<ffffffff811199ee>] sys_read+0x56/0x90
 [<ffffffff8100c0ab>] system_call_fastpath+0x16/0x1b
Code: c0 48 89 75 d8 e8 a9 f4 ff ff 48 c7 c7 a0 e5 00 00 48 03 3c dd e0 19 69 81 e8 ab 13 2d 00 eb 2a 48 8b 11 48 8b 41 08 48 8d 79 d8 <48> 89 42 08 48 89 10 48 8b 71 f8 48 c7 01 00 01 10 00 48 c7 41
RIP  [<ffffffff8110fca6>] slab_irq_enable+0x5e/0xa5
 RSP <ffff88047d0a1a78>
CR2: 0000000000100108
BUG: unable to handle kernel paging request at 0000000000100108
IP: [<ffffffff810df559>] free_hot_cold_page+0xfe/0x195
PGD 3f9409067 PUD 3f940a067 PMD 0
Oops: 0002 [#2] PREEMPT SMP
last sysfs file: /sys/devices/system/clocksource/clocksource0/available_clocksource
CPU 0
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth rfkill sunrpc ip6t_REJECT xt_tcpudp ip6table_filter ip6_tables x_tables ib_iser libiscsi scsi_transport_iscsi ib_srp scsi_transport_srp scsi_tgt ib_ipoib rdma_ucm ib_ucm ib_uverbs ib_umad rdma_cm ib_cm iw_cm ib_addr ipv6 ib_sa mlx4_ib ib_mad ib_core dm_multipath scsi_dh video output sbs sbshc battery ac parport_pc lp parport ipmi_devintf ipmi_si hpilo ipmi_msghandler hpwdt bnx2x mlx4_core crc32c serio_raw libcrc32c button snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_page_alloc iTCO_wdt iTCO_vendor_support shpchp pcspkr dm_snapshot dm_zero dm_mirror dm_region_hash dm_log dm_mod usb_storage cciss sd_mod crc_t10dif scsi_mod ext3 jbd mbcache uhci_hcd ohci_
 hcd ehci_hcd [last unloaded: microcode]
Pid: 31136, comm: hackbench Tainted: G      D     2.6.31-rt11 #1 ProLiant BL460c G6
RIP: 0010:[<ffffffff810df559>]  [<ffffffff810df559>] free_hot_cold_page+0xfe/0x195
RSP: 0018:ffff88047353f9c8  EFLAGS: 00010246
RAX: 0000000000100100 RBX: ffffea00058d34f0 RCX: ffff88049f80c510
---[ end trace 14031f012a0f5abf ]---
Kernel panic - not syncing: Fatal exception
RDX: ffffea00058d3518 RSI: 0000000000000003 RDI: ffff88047353e000
RBP: ffff88047353fa28 R08: ffff880028401b80 R09: ffff88047353fa48
R10: 00000000c0365e55 R11: ffff88047353f968 R12: 0000000000000000
R13: ffff88049f80c500 R14: ffff880000002100 R15: 0000000000000000
FS:  00007fa64e7526e0(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000100108 CR3: 00000003f9408000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process hackbench (pid: 31136, threadinfo ffff88047353e000, task ffff88047353c240)
Stack:
 ffff88049f8103c0 ffff88021fc00800 ffff88047353f9f8 ffffffff813e1067
<0> 00000000c0365e55 00000000c0365e55 ffff88047353fa28 0000000000000000
<0> ffff88016dd94c00 ffffffff81321cd7 ffff880481889040 0000000000000001
Call Trace:
 [<ffffffff813e1067>] ? rt_spin_unlock+0x23/0x39
 [<ffffffff81321cd7>] ? skb_release_data+0xb9/0xd4
 [<ffffffff810df6a4>] free_hot_page+0x1e/0x34
 [<ffffffff810df84f>] __free_pages+0x2b/0x48
 [<ffffffff8110fcc5>] slab_irq_enable+0x7d/0xa5
 [<ffffffff81110b41>] kfree+0xbb/0xda
 [<ffffffff813b849e>] ? unix_stream_recvmsg+0x434/0x50a
 [<ffffffff81321cd7>] skb_release_data+0xb9/0xd4
 [<ffffffff81322484>] skb_release_all+0x28/0x43
 [<ffffffff81089f1b>] ? rt_spin_lock_fastunlock+0x4f/0x80
 [<ffffffff8132185e>] __kfree_skb+0x20/0x9e
 [<ffffffff813219e3>] kfree_skb+0xb6/0xd5
 [<ffffffff813b849e>] unix_stream_recvmsg+0x434/0x50a
 [<ffffffff81318923>] __sock_recvmsg+0x7c/0x9f
 [<ffffffff81318a18>] sock_aio_read+0xd2/0xfa
 [<ffffffff81118e4a>] do_sync_read+0xf4/0x14c
 [<ffffffff811a8f3a>] ? file_has_perm+0xb4/0xd7
 [<ffffffff81075827>] ? autoremove_wake_function+0x0/0x5e
 [<ffffffff811a0ff4>] ? security_file_permission+0x24/0x3a
 [<ffffffff811196cd>] vfs_read+0xce/0x12c
 [<ffffffff811199ee>] sys_read+0x56/0x90
 [<ffffffff8100c0ab>] system_call_fastpath+0x16/0x1b
Code: e8 71 03 30 00 45 85 ff 49 8d 4d 10 48 8d 53 28 74 15 48 8b 41 08 48 89 4b 28 48 89 51 08 48 89 10 48 89 42 08 eb 14 49 8b 45 10 <48> 89 50 08 48 89 43 28 48 89 4a 08 49 89 55 10 41 8b 45 00 ff
RIP  [<ffffffff810df559>] free_hot_cold_page+0xfe/0x195
 RSP <ffff88047353f9c8>
CR2: 0000000000100108
    

-----[ Debug Patch

diff --git a/mm/slab.c b/mm/slab.c
index a4bd906..0fe3dd3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -198,8 +198,26 @@ static inline void slab_irq_enable(int cpu)
 
 	while (!list_empty(&list)) {
 		struct page *page = list_first_entry(&list, struct page, lru);
-		list_del(&page->lru);
-		__free_pages(page, page->index);
+		if ((&page->lru != LIST_POISON1) &&
+		    ((&page->lru)->next != LIST_POISON1) &&
+		    ((&page->lru)->prev != LIST_POISON2)) {
+			list_del(&page->lru);
+			__free_pages(page, page->index);
+		} else {
+			static int must_print = 1;
+			if (must_print) {
+				printk(KERN_ERR "slab_irq_enable acting over "
+						"a deleted entry!\n");
+				printk(KERN_ERR "&page->lru: %p   "
+						"(&page->lru)->next: %p   "
+						"(&page->lru)->prev: %p\n",
+						&page->lru, (&page->lru)->next,
+						(&page->lru)->prev);
+				must_print = 0;
+				dump_stack();
+				break;
+			}
+		}
 	}
 }
 
------
Luis
-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

