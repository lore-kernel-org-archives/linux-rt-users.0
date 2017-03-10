From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: oops with 4.9.13-rt12 under mild load (and no rt-tasks active)
Date: Fri, 10 Mar 2017 19:47:17 +0000
Message-ID: <20170310194717.GE32625@osadl.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 92-243-34-74.adsl.nanet.at ([92.243.34.74]:46182 "EHLO
        mail.osadl.at" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1755485AbdCJTrl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Mar 2017 14:47:41 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi !

 got the following oops with 4.9.13-rt12 on a i7 920 octocore running Debian 8.1 the 
 v2 in the kernel name here refers to the kernel config in use (wich is lost because 
 the fs is somewhat damaged after the reboot it seems) - there is no patch applied other
 than the rt patch. reboot after this oops only possible by sysrq.

 It seems to have corrupted internal state as well as it initially reports
 the kernel as "Not tainted" in the imediatly following oops the kernel is
 though marked as tainted (there was no module loaded in the meaintime though -
 actually /lib/modules/4.9.13-v2-rt12+/kernel/drivers/net/ethernet/realtek/r8169.ko
 is the only module on the system available)

 At time of the hang dpkg -i was running (aside from default system tasks this was
 the only thing ongoing) just after completing compile - after reboot the recently
 created files are empty so it seems that they were no longer being flushed to
 disk - not sure though as after reboot Im getting:

[ 5329.000726] EXT4-fs (sda2): unable to read superblock
[ 5329.001648] EXT4-fs (sda2): unable to read superblock
[ 5329.002564] EXT4-fs (sda2): unable to read superblock
[ 5329.003584] FAT-fs (sda2): bogus number of reserved sectors
[ 5329.003588] FAT-fs (sda2): Can't find a valid FAT filesystem
[ 5329.004645] FAT-fs (sda2): bogus number of reserved sectors
[ 5329.004649] FAT-fs (sda2): Can't find a valid FAT filesystem
[ 5329.005561] isofs_fill_super: bread failed, dev=sda2, iso_blknum=16, block=32

 but sda2 is the Extended partition - sda5 is the swap and it is mounted.

 I´ll see if this is reproducible - unfortunately the v2 config was lost as
 the files that seem to have been in buffer-cache are all 0 size (many of the compiled
 files in the kernel tree are 0 size - the sources seem ok as it can be recompiled).

Device     Boot     Start       End   Sectors   Size Id Type
/dev/sda1  *         2048 470427647 470425600 224.3G 83 Linux
/dev/sda2       470429694 490348543  19918850   9.5G  5 Extended
/dev/sda5       470429696 490348543  19918848   9.5G 82 Linux swap / Solaris


[ 9007.810069] ------------[ cut here ]------------
[ 9007.810071] kernel BUG at fs/inode.c:508!
[ 9007.810074] invalid opcode: 0000 [#1] PREEMPT SMP
[ 9007.810076] Modules linked in: r8169
[ 9007.810078] CPU: 0 PID: 827 Comm: kswapd0 Not tainted 4.9.13-v2-rt12+ #2
[ 9007.810079] Hardware name: System manufacturer System Product Name/P6T6 WS REVOLUTION, BIOS 0407    02/26/2009
[ 9007.810081] task: ffff88032fc1d780 task.stack: ffffc9000354c000
[ 9007.810086] RIP: 0010:[<ffffffff8115debc>]  [<ffffffff8115debc>] clear_inode+0x7c/0x90
[ 9007.810088] RSP: 0018:ffffc9000354fc10  EFLAGS: 00010202
[ 9007.810089] RAX: 0000000000000000 RBX: ffff880066d22860 RCX: 0000000000000000
[ 9007.810090] RDX: ffff88032fc1d780 RSI: ffff88032fc1d780 RDI: ffff88033320c880
[ 9007.810091] RBP: ffffc9000354fc20 R08: ffff88002f9c1ff0 R09: 0000000000000000
[ 9007.810091] R10: ffff88002f9c1ff1 R11: 0000000000000040 R12: ffff880066d22a10
[ 9007.810092] R13: ffffffff81a22b40 R14: ffffc9000354fd70 R15: 00000000000001b3
[ 9007.810093] FS:  0000000000000000(0000) GS:ffff880333200000(0000) knlGS:0000000000000000
[ 9007.810094] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9007.810095] CR2: 00000000022c3028 CR3: 0000000310add000 CR4: 00000000000006f0
[ 9007.810095] Stack:
[ 9007.810098]  ffff880066d22860 ffff880066d229f8 ffffc9000354fc38 ffffffff811d7005
[ 9007.810100]  ffff880066d22860 ffffc9000354fc58 ffffffff811c6ea9 ffff880066d22860
[ 9007.810102]  ffff880066d229a0 ffffc9000354fc80 ffffffff8115ed50 ffffc9000354fca8
[ 9007.810103] Call Trace:
[ 9007.810107]  [<ffffffff811d7005>] ext4_clear_inode+0x15/0x80
[ 9007.810109]  [<ffffffff811c6ea9>] ext4_evict_inode+0x69/0x3d0
[ 9007.810111]  [<ffffffff8115ed50>] evict+0xc0/0x190
[ 9007.810112]  [<ffffffff8115ee54>] dispose_list+0x34/0x40
[ 9007.810114]  [<ffffffff8115ff06>] prune_icache_sb+0x46/0x60
[ 9007.810117]  [<ffffffff8114662c>] super_cache_scan+0x14c/0x1a0
[ 9007.810121]  [<ffffffff810fce65>] shrink_slab.part.52.constprop.73+0x1b5/0x250
[ 9007.810124]  [<ffffffff8110047c>] shrink_node+0x5c/0x190
[ 9007.810126]  [<ffffffff81100dc1>] kswapd+0x2d1/0x5c0
[ 9007.810128]  [<ffffffff81100af0>] ? node_reclaim+0x200/0x200
[ 9007.810132]  [<ffffffff8105f388>] ? call_usermodehelper_exec_async+0x148/0x160
[ 9007.810135]  [<ffffffff810684b7>] kthread+0xd7/0xf0
[ 9007.810137]  [<ffffffff810683e0>] ? kthread_park+0x60/0x60
[ 9007.810139]  [<ffffffff8105f240>] ? umh_complete+0x20/0x20
[ 9007.810143]  [<ffffffff81830612>] ret_from_fork+0x22/0x30
[ 9007.810163] Code: 74 2d a8 40 75 2b 48 8b 83 50 01 00 00 48 8d 93 50 01 00 00 48 39 c2 75 1a 48 c7 83 c8 00 00 00 60 00 00 00 5b 41 5c 5d c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f 0b 66 2e 0f 1f 84 00 00 00 00 00 55 
[ 9007.810166] RIP  [<ffffffff8115debc>] clear_inode+0x7c/0x90
[ 9007.810166]  RSP <ffffc9000354fc10>
[ 9007.810202] ---[ end trace 0000000000000002 ]---
[ 9007.810209] BUG: unable to handle kernel NULL pointer dereference at 0000000000000003
[ 9007.810213] IP: [<ffffffff810865a6>] swake_up_locked+0x16/0x40
[ 9007.810215] PGD 310aec067 
[ 9007.810215] PUD 310aed067 
[ 9007.810216] PMD 0 

[ 9007.810218] Oops: 0000 [#2] PREEMPT SMP
[ 9007.810219] Modules linked in: r8169
[ 9007.810221] CPU: 0 PID: 827 Comm: kswapd0 Tainted: G      D         4.9.13-v2-rt12+ #2
[ 9007.810222] Hardware name: System manufacturer System Product Name/P6T6 WS REVOLUTION, BIOS 0407    02/26/2009
[ 9007.810223] task: ffff88032fc1d780 task.stack: ffffc9000354c000
[ 9007.810226] RIP: 0010:[<ffffffff810865a6>]  [<ffffffff810865a6>] swake_up_locked+0x16/0x40
[ 9007.810227] RSP: 0018:ffffc9000354fe90  EFLAGS: 00010092
[ 9007.810227] RAX: 000000000000000b RBX: 000000000000000b RCX: 0000000000000000
[ 9007.810228] RDX: ffffc9000354ff20 RSI: 0000000000000000 RDI: ffffc9000354ff18
[ 9007.810229] RBP: ffffc9000354fe98 R08: 0000000000000002 R09: 0000000000000000
[ 9007.810230] R10: 0000000000000361 R11: 0000000000000361 R12: ffffc9000354ff10
[ 9007.810230] R13: 0000000000000282 R14: 0000000000000000 R15: 0000000000000000
[ 9007.810232] FS:  0000000000000000(0000) GS:ffff880333200000(0000) knlGS:0000000000000000
[ 9007.810233] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 9007.810234] CR2: 0000000000000003 CR3: 0000000310add000 CR4: 00000000000006f0
[ 9007.810235] Stack:
[ 9007.810237]  ffffc9000354ff18 ffffc9000354fec0 ffffffff81086c88 ffff88032fc1df10
[ 9007.810239]  ffff88032fc1d780 0000000000000246 ffffc9000354fee0 ffffffff81049033
[ 9007.810241]  ffff88032fc1d780 000000000000000b ffffc9000354ff48 ffffffff8104e1e6
[ 9007.810242] Call Trace:
[ 9007.810244]  [<ffffffff81086c88>] complete+0x28/0x40
[ 9007.810247]  [<ffffffff81049033>] mm_release+0xb3/0x130
[ 9007.810249]  [<ffffffff8104e1e6>] do_exit+0x116/0xb20
[ 9007.810252]  [<ffffffff81831da7>] rewind_stack_do_exit+0x17/0x20
[ 9007.810273] Code: 48 89 e5 48 89 47 08 48 89 47 10 5d c3 0f 1f 84 00 00 00 00 00 48 8b 47 08 48 8d 57 08 48 39 c2 74 29 55 48 89 e5 53 48 8b 5f 08 <48> 8b 7b f8 e8 a1 a4 fe ff 48 8b 13 48 8b 43 08 48 89 42 08 48 
[ 9007.810276] RIP  [<ffffffff810865a6>] swake_up_locked+0x16/0x40
[ 9007.810276]  RSP <ffffc9000354fe90>
[ 9007.810277] CR2: 0000000000000003
[ 9007.810305] ---[ end trace 0000000000000003 ]---
[ 9007.810306] Fixing recursive fault but reboot is needed!
[ 9007.810307] BUG: scheduling while atomic: kswapd0/827/0x00000002
[ 9007.810308] Modules linked in: r8169
[ 9007.810310] CPU: 0 PID: 827 Comm: kswapd0 Tainted: G      D         4.9.13-v2-rt12+ #2
[ 9007.810311] Hardware name: System manufacturer System Product Name/P6T6 WS REVOLUTION, BIOS 0407    02/26/2009
[ 9007.810314]  ffffc9000354fe60 ffffffff812ceae3 ffff880333217580 0000000000000000
[ 9007.810316]  ffffc9000354fe70 ffffffff8106d06c ffffc9000354feb8 ffffffff8182cbb6
[ 9007.810318]  ffffc9000354fee0 ffffffff810eac17 ffff88032fc1d780 ffff88032fc1d780
[ 9007.810319] Call Trace:
[ 9007.810322]  [<ffffffff812ceae3>] dump_stack+0x4d/0x6a
[ 9007.810325]  [<ffffffff8106d06c>] __schedule_bug+0x4c/0x70
[ 9007.810329]  [<ffffffff8182cbb6>] __schedule+0x396/0x410
[ 9007.810332]  [<ffffffff810eac17>] ? printk+0x43/0x4b
[ 9007.810334]  [<ffffffff8182cc7b>] schedule+0x4b/0xe0
[ 9007.810336]  [<ffffffff8104e957>] do_exit+0x887/0xb20
[ 9007.810339]  [<ffffffff81831da7>] rewind_stack_do_exit+0x17/0x20
[11818.037764] grep (17532) used greatest stack depth: 11024 bytes left

 Aside from hoping that I get this a second time - is there any other meaningful
 info I could provide ?

 Has anyone seen 4.9.13-rt12 oopses related to ext4 or vfs in general ?

thx!
hofrat
