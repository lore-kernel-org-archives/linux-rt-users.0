From: Christoph Mathys <eraserix@gmail.com>
Subject: [4.1.15-rt17] BUG: unable to handle kernel NULL pointer dereference
 at 0000000000000001
Date: Wed, 23 Dec 2015 14:55:08 +0100
Message-ID: <CALqGcGpG8ShUjPtuwG8BzToLszLHhyf9ELZkaWE2ziq3TL3YrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linux RT Users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35023 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbbLWNzK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Dec 2015 08:55:10 -0500
Received: by mail-lb0-f182.google.com with SMTP id bc4so46879502lbc.2
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Dec 2015 05:55:09 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

While running my "infamous" tests with containers[0] on 4.1, I get
system freezes regularly. I have tried with and without PREEMPT_RT.
The lockups did only occur on RT and when the cgroup "memory" was in
use. Without rt or this particular cgroup (cgroup_disable kernel
parameter), my test ran for ~15h before I stopped it manually.

tldr; CONFIG_MEMCG seem to be broken for PREEMPT_RT.

I don't know if the errors below are directly responsible for the
system freeze, but they are the last thing I see from the system
before it freezes.

The second dump below might contain some typos because I had to
convert it manually from a screenshot to text.

[0] http://www.spinics.net/lists/linux-rt-users/msg14262.html


[ 2610.792465] BUG: unable to handle kernel NULL pointer dereference
at 0000000000000001
[ 2610.792471] IP: [<ffffffff811d9d2b>] page_counter_cancel+0xb/0x40
[ 2610.792474] PGD d556e067 PUD cfe1b067 PMD 0
[ 2610.792476] Oops: 0002 [#1] PREEMPT SMP
[ 2610.792493] Modules linked in: veth(E) xt_CHECKSUM(E)
iptable_mangle(E) ipt_MASQUERADE(E) nf_nat_masquerade_ipv4(E)
iptable_nat(E) nf_conntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E)
nf_nat(E) nf_conntrack(E) xt_tcpudp(E) bridge(E) stp(E) llc(E)
iptable_filter(E) ip_tables(E) x_tables(E) coretemp(E) kvm_intel(E)
kvm(E) cryptd(E) gpio_ich(E) ppdev(E) microcode(E) i915(E) video(E)
drm_kms_helper(E) drm(E) i2c_algo_bit(E) parport_pc(E) lpc_ich(E)
shpchp(E) tpm_tis(E) mac_hid(E) lp(E) parport(E) hid_generic(E)
usbhid(E) hid(E) ahci(E) libahci(E) e1000e(E) ptp(E) pps_core(E)
[ 2610.792495] CPU: 0 PID: 7996 Comm: rm Tainted: G        W   E
4.1.15-i915-patch-realtime-1-rt17+ #4
[ 2610.792496] Hardware name: Komax AG, Dierikon Komax-PC/DH61DL, BIOS
BEH6110H.86A.0042.2012.0327.2202 03/27/2012
[ 2610.792497] task: ffff8800ce7d0000 ti: ffff8800ce514000 task.ti:
ffff8800ce514000
[ 2610.792499] RIP: 0010:[<ffffffff811d9d2b>]  [<ffffffff811d9d2b>]
page_counter_cancel+0xb/0x40
[ 2610.792500] RSP: 0018:ffff8800ce517ad0  EFLAGS: 00010297
[ 2610.792501] RAX: fffffffffffffff3 RBX: 0000000000000001 RCX: 000000000000000d
[ 2610.792501] RDX: 0000000000000000 RSI: 000000000000000d RDI: 0000000000000001
[ 2610.792502] RBP: ffff8800ce517ae8 R08: ffffea0003345440 R09: 0000000000000001
[ 2610.792503] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000d
[ 2610.792503] R13: 000000000000000d R14: 0000000000000000 R15: ffff8800ce7aa000
[ 2610.792504] FS:  00007f492931c700(0000) GS:ffff88011a400000(0000)
knlGS:0000000000000000
[ 2610.792505] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2610.792506] CR2: 0000000000000001 CR3: 00000000ce477000 CR4: 00000000000406f0
[ 2610.792506] Stack:
[ 2610.792508]  ffffffff811d9e7b 000000000000000d ffff8800ce517bb8
ffff8800ce517b48
[ 2610.792509]  ffffffff811deee3 ffff88011f5f7fd8 ffff88011f5f7fc0
ffffea0003345440
[ 2610.792511]  000000000000000d 0000000000000004 ffffea0003345460
ffff8800ce517bb8
[ 2610.792511] Call Trace:
[ 2610.792513]  [<ffffffff811d9e7b>] ? page_counter_uncharge+0x2b/0x40
[ 2610.792516]  [<ffffffff811deee3>] uncharge_batch.constprop.42+0x43/0x390
[ 2610.792518]  [<ffffffff811df2cd>] uncharge_list+0x9d/0xb0
[ 2610.792520]  [<ffffffff811e45ae>] mem_cgroup_uncharge_list+0x1e/0x30
[ 2610.792523]  [<ffffffff81180165>] release_pages+0x1c5/0x250
[ 2610.792525]  [<ffffffff81181edb>] __pagevec_release+0x2b/0x40
[ 2610.792527]  [<ffffffff81182be8>] truncate_inode_pages_range+0x2f8/0x750
[ 2610.792530]  [<ffffffff810b348e>] ? lock_release_holdtime.part.31+0x11e/0x1a0
[ 2610.792532]  [<ffffffff811830b6>] truncate_inode_pages_final+0x56/0x60
[ 2610.792535]  [<ffffffff812afefe>] ext4_evict_inode+0x19e/0x850
[ 2610.792538]  [<ffffffff8120dc52>] evict+0xc2/0x1a0
[ 2610.792539]  [<ffffffff8120e6ff>] iput+0x21f/0x3f0
[ 2610.792541]  [<ffffffff81200818>] do_unlinkat+0x1f8/0x330
[ 2610.792544]  [<ffffffff81014d94>] ? syscall_trace_enter_phase1+0xc4/0x160
[ 2610.792546]  [<ffffffff8120197b>] SyS_unlinkat+0x1b/0x40
[ 2610.792548]  [<ffffffff8180d6db>] system_call_fastpath+0x16/0x73
[ 2610.792565] Code: c7 20 b1 e5 81 e8 a6 9a ed ff 85 c0 0f 85 be fd
ff ff eb ab 66 2e 0f 1f 84 00 00 00 00 00 66 90 66 66 66 66 90 48 89
f0 48 f7 d8 <f0> 48 0f c1 07 48 39 f0 78 01 c3 80 3d 7c 57 d5 00 00 75
f6 55
[ 2610.792567] RIP  [<ffffffff811d9d2b>] page_counter_cancel+0xb/0x40
[ 2610.792567]  RSP <ffff8800ce517ad0>
[ 2610.792568] CR2: 0000000000000001

[ 4988.312771] BUG: unable to handle kernel paging request at 0000000000002038
[ 4988.312777] IP: [<ffffffff810bb768>] task_blocks_on_rt_mutex+0x98/0x220
[ 4988.312779] PGD c1650067 PUD d3ab3067 PMD 0
[ 4988.312781] Oops: 0000 [#2] PREEMPT SMP
[ 4988.312804] Modules linked in: btrfs(E) xor(E) raid6_pq(E) ufs(E)
qnx4(E) hfsplus(E) hfs(E) minix(E) ntfs(E) msdos(E) jfs(E) xfs(E)
libcrc32c(E) e _MASQUERADE(E) nf_nat_masquerade_ipu4(E) iptable_nat(E)
nf_conntrack_ipu4(E) nf_defrag_ipu4(E) nf_nat_ipu4(E) nf_nat(E)
nf_conntrack(E) xt_tcpudp(E) (E) x_tables(E) coretemp(E) kum_intel(E)
kum(E) gpio_ich(E) ppdeu(E) cryptd(E) 1915(E) uideo(E)
drm_kms_helper(E) microcode(E) drm(E) i2c_algo_bit(E) hid(E) 1p(E)
parport(E) hid_generic(E) usbhid(E) hid(E) ahci(E) libahci(E)
e1000e(E) ptp(E) pps_core(E)
[ 4988.312807] CPU: 1 PID: 7539 Comm: kworker/u4:3 Tainted: G D W E
4.1.13-realtime-1-rt15 #3
[ 4988.312808] Hardware name: Xomax AG, Dierikon Homax-PC/DH61DL, BIOS
BEH6110H.86A.0042.2012.0327.2202 03/27/2012
[ 4988.312812] Workqueue: writeback bdi_writeback_workfn (flush-8:0)
[ 4988.312813] task: ffff8800d4614cc0 ti: ffff8801124e8000 task.ti:
ffff8801124e8000
[ 4988.312816] RIP: 0010:[<ffffffff810bb768>] [<ffffffff810bb768>]
task_blocks_on_rt_mutex+0x98/0x220
[ 4988.312817] RSP: 0000:ffff8801124eb608 EFLAGS: 00010006
[ 4988.312818] RAX: 0000000000002000 RBX: ffff8800ae758488 RCX: 0000000000006968
[ 4988.312819] RDX: 0000000000000000 RSI: 0000000000000078 RDI: ffff8800d4614cc0
[ 4988.312819] RBP: ffff8801124eb658 R08: 0000000000000000 R09: 0000000000000001
[ 4988.312820] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8800d4614cc0
[ 4988.312821] R13: ffff8801124eb690 R14: ffffea0002bcf280 R15: ffff8800d4615590
[ 4988.312822] FS: 0000000000000000(0000) GS:ffff88011a800000(0000)
kn1GS:0000000000000000
[ 4988.312823] CS: 0010 DS: 0000 ES: 0000 CRO: 0000000080050033
[ 4988.312824] CR2: 0000000000002038 CR3: 0000000115909000 CR4: 00000000000406e0
[ 4988.312824] Stack:
[ 4988.312826]  ffff8800d46155a8 ffff8800d4615590 00000000d4615590
0000000000000292
[ 4988.312828]  ffff8800d4614cc0 ffff8801124eb690 ffff8800d4615590
ffff8800d4614cc0
[ 4988.312829]  ffff8800d4614cc0 ffff8800ae758488 ffff8801124eb728
ffffffff81808520
[ 4988.312829] Call Trace:
[ 4988.312831]  [<ffffffff81808520>] rt_spin_lock_slowlock+0xd0/0x380
[ 4988.312836]  [<ffffffff818081ae>] ? rt_spin_lock_slowlock+0x5e/0x380
[ 4988.312839]  [<ffffffff8180a5ec>] rt_spin_lock+0x2e/0x60
[ 4988.312812]  [<ffffffff8108b17c)] ? migrate_disable+0x6c/0xe0
[ 4988.312811]  [<ffffffff811e09e1>] mem_cgroup_begin_page_stat+0x81/0x120
[ 4988.312815]  [<ffffffff811e0965>] ? men_cgroup_begin_page_stat+0x5/0x120
[ 4988.312818]  [<ffffffff8117c06c>] __test_set_page_writeback+0x20/0x190
[ 4988.312852]  [<ffffffff812b1e7a>] ext4_bio_write_page+0x1aa/0x310
[ 4988.312851]  [<ffffffff812a5521>] mpage_submit_page+0x61/0x80
[ 4988.312855]  [(ffffffff812a5650)] mpage_process_page_bufs+0x110/0x130
[ 4988.312857]  [<ffffffff812a5d23>] mpage_prepare_extent_to_map+0x233/0x2e0
[ 4988.312859]  [<ffffffff812ac618>] ? ext4_writepages+0x67b/0x14d0
[ 4988.312862]  [<ffffffff812dff57>] ? __ext4_journal_start_sb+0xb7/0x2e0
[ 4988.312883]  [<ffffffff812ae686>] ext4_writepages+0x6ee/0x14d0
[ 4988.312866]  [<ffffffff818087ed>] ? rt_spin_lock_slownlock+0x1d/0x70
[ 4988.312868]  [(ffffffff818087ed>] ? rt_spin_lock_slownlock+0x1d/0x70
[ 4988.312870]  [<ffffffff8117d911>] do_writepages+0x21/0x50
[ 4988.312871]  [<ffffffff8122052f>] __writeback_single_inode+0x8f/0xc70
[ 4988.312873]  [<ffffffff8122113d)] writeback_sb_inodes+0x32d/0x760
[ 4988.312875]  [<ffffffff81221a7d>] wb_writeback+0x13d/0x8a0
[ 4988.312877]  [<ffffffff81222963>] bdi_writeback_workfn+0x193/0xa30
[ 4988.312880]  [<ffffffff81079660>] ? process_one_work+0x170/0x880
[ 4988.312882]  [<ffffffff8107970f>] process_one_work+0x21f/0x8b0
[ 4988.312881]  [<ffffffff81079660>] ? process_one_work+0x170/0x8b0
[ 4988.312886]  [<ffffffff81079f09>] worker_thread+0x169/0x1e0
[ 4988.312889]  [<ffffffff8180a2a5>] ? _raw_spin_unlock_irqrestore+0x65/0x80
[ 4988.312891]  [<ffffffff81079da0>] ? process_one_work+0x8b0/0x880
[ 4988.312893]  [<ffffffff81080851>] kthread+0xe1/0x100
[ 4988.312895]  [<ffffffff810b519d>] ? trace_hardirqs_on+0xd/0x10
[ 4988.312897]  [<ffffffff81080770>] ? kthread_create_pn_node+0x210/0x210
[ 4988.312899]  [<ffffffff8180b122>] ret_from_fork+0x12/0x70
[ 4988.312900]  [<ffffffff81080770>] ? kthread_create_on_node+0x210/0x210
[ 4988.312916] Code: 01 00 00 1c 89 e7 e8 38 f3 ff ff 4d 89 65 30 49
89 5d 38 41 8b 44 24 58 41 89 45 60 48 83 7b 48 00 0f 84 04 01 00 00
48 8b 43 50 <4
ee 48 89 df e8
[ 4988.312918] RIP [<ffffffff810bb768>] task_blocks_on_rt_mutex+0x98/0x220
[ 4988.312919]  RSP <ffff8801124eb608>
[ 4988.312919] CR2: 0000000000002038

Thanks!
Christoph
