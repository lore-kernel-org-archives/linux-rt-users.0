From: Juergen Borleis <jbe@pengutronix.de>
Subject: PowerPC: massive "scheduling while atomic" reports
Date: Thu, 10 Sep 2015 11:06:56 +0200
Message-ID: <201509101106.56931.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wgU8V2bBWZVSTkT"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53189 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbIJJGr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 Sep 2015 05:06:47 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
	by metis.ext.pengutronix.de with esmtp (Exim 4.80)
	(envelope-from <jbe@pengutronix.de>)
	id 1ZZxob-0000x9-S8
	for linux-rt-users@vger.kernel.org; Thu, 10 Sep 2015 11:06:45 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Boundary-00=_wgU8V2bBWZVSTkT
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I'm trying the Linux-4.1.5-rt5 on an older PowerPC platform (MPC5200 SoC). =
Its
mostly the plain kernel, just a few patches added to provide the device tree
for the platform.
When running the system at least every other boot this kernel spits out
massive "scheduling while atomic" reports.

Anyone with an idea what's going wrong here? I already tried with some
debug options enabled but the highly optimised code confuses me where and
what the code does.

Kernel config attached.

=2D--8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----=
8<--
[...]
[c3bfde40] [c00cb1d8] seq_read+0x3dc/0x564 (unreliable)
[c3bfde90] [c00a7aec] __vfs_read+0x2c/0xf0
[c3bfdef0] [c00a82b0] vfs_read+0x8c/0x10c
[c3bfdf10] [c00a8b2c] SyS_read+0x50/0x94
[c3bfdf40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xfe92110
    LR =3D 0xfe3675c
BUG: scheduling while atomic: udevd/518/0x00000002
3 locks held by udevd/518:
 #0:  (&p->lock){+.+.+.}, at: [<c00cae2c>] seq_read+0x30/0x564
 #1:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
 #2:  (&mm->page_table_lock){+.+...}, at: [<c0092028>] handle_mm_fault+0xb7=
c/0x158c
Modules linked in:
CPU: 0 PID: 518 Comm: udevd Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3ba1c10] [c0036790] __schedule_bug+0x64/0x80 (unreliable)
[c3ba1c20] [c034fe58] __schedule+0x54/0x380
[c3ba1c40] [c0350204] schedule+0x80/0xd0
[c3ba1c50] [c03513f0] rt_spin_lock_slowlock+0x114/0x1c4
[c3ba1cb0] [c0352d64] rt_spin_lock+0x34/0x64
[c3ba1cc0] [c007f144] __lru_cache_add+0x30/0x10c
[c3ba1cd0] [c0092064] handle_mm_fault+0xbb8/0x158c
[c3ba1d40] [c000ea78] do_page_fault+0x33c/0x550
[c3ba1d80] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at __copy_tofrom_user+0x110/0x23c
    LR =3D seq_read+0x484/0x564
[c3ba1e40] [c00cb1d8] seq_read+0x3dc/0x564 (unreliable)
[c3ba1e90] [c00a7aec] __vfs_read+0x2c/0xf0
[c3ba1ef0] [c00a82b0] vfs_read+0x8c/0x10c
[c3ba1f10] [c00a8b2c] SyS_read+0x50/0x94
[c3ba1f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xfe92110
    LR =3D 0xfe3675c
BUG: scheduling while atomic: udevd/527/0x00000002
3 locks held by udevd/527:
 #0:  (&p->lock){+.+.+.}, at: [<c00cae2c>] seq_read+0x30/0x564
 #1:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
 #2:  (&mm->page_table_lock){+.+...}, at: [<c0092028>] handle_mm_fault+0xb7=
c/0x158c
Modules linked in:
CPU: 0 PID: 527 Comm: udevd Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3bf5c10] [c0036790] __schedule_bug+0x64/0x80 (unreliable)
[c3bf5c20] [c034fe58] __schedule+0x54/0x380
[c3bf5c40] [c0350204] schedule+0x80/0xd0
[c3bf5c50] [c03513f0] rt_spin_lock_slowlock+0x114/0x1c4
[c3bf5cb0] [c0352d64] rt_spin_lock+0x34/0x64
[c3bf5cc0] [c007f144] __lru_cache_add+0x30/0x10c
[c3bf5cd0] [c0092064] handle_mm_fault+0xbb8/0x158c
[c3bf5d40] [c000ea78] do_page_fault+0x33c/0x550
[c3bf5d80] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at __copy_tofrom_user+0x110/0x23c
    LR =3D seq_read+0x484/0x564
[c3bf5e40] [c00cb1d8] seq_read+0x3dc/0x564 (unreliable)
[c3bf5e90] [c00a7aec] __vfs_read+0x2c/0xf0
[c3bf5ef0] [c00a82b0] vfs_read+0x8c/0x10c
[c3bf5f10] [c00a8b2c] SyS_read+0x50/0x94
[c3bf5f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xfe92110
    LR =3D 0xfe3675c
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 522, name: udevd
2 locks held by udevd/522:
 #0:  (&mm->mmap_sem){++++++}, at: [<c0015340>] copy_process.part.62+0x994/=
0x1204
 #1:  (&mm->mmap_sem/1){+.+.+.}, at: [<c001534c>] copy_process.part.62+0x9a=
0/0x1204
CPU: 0 PID: 522 Comm: udevd Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3ab7dd0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3ab7de0] [c0090b28] copy_page_range+0x154/0x478
[c3ab7e60] [c0015530] copy_process.part.62+0xb84/0x1204
[c3ab7ee0] [c0015d18] do_fork+0xd0/0x4ec
[c3ab7f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c00 at 0xfe6b680
    LR =3D 0xfe6b650
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 526, name: udevd
1 lock held by udevd/526:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 526 Comm: udevd Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3be7e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3be7e90] [c0092028] handle_mm_fault+0xb7c/0x158c
[c3be7f00] [c000ea78] do_page_fault+0x33c/0x550
[c3be7f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xfe37bd0
    LR =3D 0xfe35b30
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 555, name: mount
1 lock held by mount/555:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 555 Comm: mount Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c2d51e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c2d51e90] [c0092028] handle_mm_fault+0xb7c/0x158c
[c2d51f00] [c000ea78] do_page_fault+0x33c/0x550
[c2d51f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xb798fe14
    LR =3D 0xb798fe08
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 561, name: e2fsck
1 lock held by e2fsck/561:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 561 Comm: e2fsck Tainted: G        W       4.1.5-20150730-1-rt5=
 #5
Call Trace:
[c2d51e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c2d51e90] [c0092028] handle_mm_fault+0xb7c/0x158c
[c2d51f00] [c000ea78] do_page_fault+0x33c/0x550
[c2d51f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xfdca52c
    LR =3D 0xfebf254
EXT4-fs (sda2): couldn't mount as ext2 due to feature incompatibilities
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 557, name: S02localfs
1 lock held by S02localfs/557:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 557 Comm: S02localfs Tainted: G        W       4.1.5-20150730-1=
=2Drt5 #5
Call Trace:
[c3b5fe40] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b5fe50] [c008f568] wp_page_copy.isra.101+0x2f8/0x4d0
[c3b5fe90] [c0092970] handle_mm_fault+0x14c4/0x158c
[c3b5ff00] [c000ea78] do_page_fault+0x33c/0x550
[c3b5ff40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xfef5030
    LR =3D 0xff277d8
BUG: scheduling while atomic: S02localfs/568/0x00000002
2 locks held by S02localfs/568:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c00ae694>] prepare_bprm_creds=
+0x20/0x5c
 #1:  (&mm->page_table_lock){+.+...}, at: [<c0090508>] unmap_single_vma+0x1=
9c/0x430
Modules linked in:
CPU: 0 PID: 568 Comm: S02localfs Tainted: G        W       4.1.5-20150730-1=
=2Drt5 #5
Call Trace:
[c2cd5b20] [c0036790] __schedule_bug+0x64/0x80 (unreliable)
[c2cd5b30] [c034fe58] __schedule+0x54/0x380
[c2cd5b50] [c0350204] schedule+0x80/0xd0
[c2cd5b60] [c03513f0] rt_spin_lock_slowlock+0x114/0x1c4
[c2cd5bc0] [c0352d64] rt_spin_lock+0x34/0x64
[c2cd5bd0] [c007a068] get_page_from_freelist+0x148/0x6cc
[c2cd5c50] [c007a710] __alloc_pages_nodemask+0x124/0x5f0
[c2cd5cc0] [c007abf8] __get_free_pages+0x1c/0x50
[c2cd5cd0] [c008f958] __tlb_remove_page+0x6c/0xcc
[c2cd5ce0] [c009064c] unmap_single_vma+0x2e0/0x430
[c2cd5d60] [c0090e98] unmap_vmas+0x4c/0x5c
[c2cd5d80] [c0096074] exit_mmap+0x58/0x15c
[c2cd5de0] [c0014724] mmput+0x4c/0xfc
[c2cd5df0] [c00ae0b8] flush_old_exec+0x460/0x564
[c2cd5e30] [c00ee7e0] load_elf_binary+0x26c/0xf98
[c2cd5eb0] [c00ad73c] search_binary_handler+0x90/0x1b8
[c2cd5ee0] [c00aec78] do_execveat_common+0x5a8/0x6f0
[c2cd5f30] [c00aedf0] do_execve+0x30/0x40
[c2cd5f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff279b4
    LR =3D 0x10015ee4
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 570, name: S03gpio
1 lock held by S03gpio/570:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c00ae694>] prepare_bprm_creds=
+0x20/0x5c
CPU: 0 PID: 570 Comm: S03gpio Tainted: G        W       4.1.5-20150730-1-rt=
5 #5
Call Trace:
[c3b5fdc0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b5fdd0] [c008dbac] follow_page_mask+0xa8/0x388
[c3b5fe00] [c008e000] __get_user_pages.part.26+0x174/0x358
[c3b5fe60] [c00adad8] copy_strings+0x158/0x2a0
[c3b5fee0] [c00aeb74] do_execveat_common+0x4a4/0x6f0
[c3b5ff30] [c00aedf0] do_execve+0x30/0x40
[c3b5ff40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff279b4
    LR =3D 0x10015ee4
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 597, name: usleep
no locks held by usleep/597.
CPU: 0 PID: 597 Comm: usleep Tainted: G        W       4.1.5-20150730-1-rt5=
 #5
Call Trace:
[c3b5fdb0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b5fdc0] [c0090508] unmap_single_vma+0x19c/0x430
[c3b5fe40] [c0090e98] unmap_vmas+0x4c/0x5c
[c3b5fe60] [c0096074] exit_mmap+0x58/0x15c
[c3b5fec0] [c0014724] mmput+0x4c/0xfc
[c3b5fed0] [c00177a4] do_exit+0x2c8/0x764
[c3b5ff10] [c0018dc8] do_group_exit+0x48/0xa8
[c3b5ff30] [c0018e3c] __wake_up_parent+0x0/0x18
[c3b5ff40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff27924
    LR =3D 0xffed254
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 615, name: sudo
1 lock held by sudo/615:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 615 Comm: sudo Tainted: G        W       4.1.5-20150730-1-rt5 #5
Call Trace:
[c3b8bc30] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b8bc40] [c0092028] handle_mm_fault+0xb7c/0x158c
[c3b8bcb0] [c000ea78] do_page_fault+0x33c/0x550
[c3b8bcf0] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at copy_page_to_iter+0x134/0x3e0
    LR =3D copy_page_to_iter+0x12c/0x3e0
[c3b8bdf0] [c0074ecc] generic_file_read_iter+0x3b8/0x670
[c3b8be70] [c0160374] nfs_file_read+0x68/0xb4
[c3b8be90] [c00a7b88] __vfs_read+0xc8/0xf0
[c3b8bef0] [c00a82b0] vfs_read+0x8c/0x10c
[c3b8bf10] [c00a8b2c] SyS_read+0x50/0x94
[c3b8bf40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xfefe110
    LR =3D 0xfea275c
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 521, name: udevd
1 lock held by udevd/521:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 521 Comm: udevd Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3ab3e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3ab3e90] [c009218c] handle_mm_fault+0xce0/0x158c
[c3ab3f00] [c000ea78] do_page_fault+0x33c/0x550
[c3ab3f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xfe3b258
    LR =3D 0xff31254
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 615, name: ntpdate
1 lock held by ntpdate/615:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 615 Comm: ntpdate Tainted: G        W       4.1.5-20150730-1-rt=
5 #5
Call Trace:
[c3b8bd80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b8bd90] [c0091670] handle_mm_fault+0x1c4/0x158c
[c3b8be00] [c000ea78] do_page_fault+0x33c/0x550
[c3b8be40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at do_page_fault+0x164/0x550
    LR =3D do_page_fault+0x148/0x550
[c3b8bf40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 401 at 0xfe9a484
    LR =3D 0xfec6f50
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 622, name: getty
1 lock held by getty/622:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 622 Comm: getty Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c2c83e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c2c83e90] [c0092028] handle_mm_fault+0xb7c/0x158c
[c2c83f00] [c000ea78] do_page_fault+0x33c/0x550
[c2c83f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xff27f00
    LR =3D 0x1000608c
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 622, name: sh
2 locks held by sh/622:
 #0:  (&mm->mmap_sem){++++++}, at: [<c0015340>] copy_process.part.62+0x994/=
0x1204
 #1:  (&mm->mmap_sem/1){+.+.+.}, at: [<c001534c>] copy_process.part.62+0x9a=
0/0x1204
CPU: 0 PID: 622 Comm: sh Tainted: G        W       4.1.5-20150730-1-rt5 #5
Call Trace:
[c2c83dd0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c2c83de0] [c0090b28] copy_page_range+0x154/0x478
[c2c83e60] [c0015530] copy_process.part.62+0xb84/0x1204
[c2c83ee0] [c0015d18] do_fork+0xd0/0x4ec
[c2c83f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c00 at 0xff27680
    LR =3D 0xff27650
root@SmartBox2:~ BUG: sleeping function called from invalid context at kern=
el/locking/rtmutex.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 557, name: S02localfs
1 lock held by S02localfs/557:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 557 Comm: S02localfs Tainted: G        W       4.1.5-20150730-1=
=2Drt5 #5
Call Trace:
[c3b5fe40] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b5fe50] [c008f568] wp_page_copy.isra.101+0x2f8/0x4d0
[c3b5fe90] [c0092970] handle_mm_fault+0x14c4/0x158c
[c3b5ff00] [c000ea78] do_page_fault+0x33c/0x550
[c3b5ff40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xfef5030
    LR =3D 0xff277d8
BUG: scheduling while atomic: S02localfs/568/0x00000002
2 locks held by S02localfs/568:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c00ae694>] prepare_bprm_creds=
+0x20/0x5c
 #1:  (&mm->page_table_lock){+.+...}, at: [<c0090508>] unmap_single_vma+0x1=
9c/0x430
Modules linked in:
CPU: 0 PID: 568 Comm: S02localfs Tainted: G        W       4.1.5-20150730-1=
=2Drt5 #5
Call Trace:
[c2cd5b20] [c0036790] __schedule_bug+0x64/0x80 (unreliable)
[c2cd5b30] [c034fe58] __schedule+0x54/0x380
[c2cd5b50] [c0350204] schedule+0x80/0xd0
[c2cd5b60] [c03513f0] rt_spin_lock_slowlock+0x114/0x1c4
[c2cd5bc0] [c0352d64] rt_spin_lock+0x34/0x64
[c2cd5bd0] [c007a068] get_page_from_freelist+0x148/0x6cc
[c2cd5c50] [c007a710] __alloc_pages_nodemask+0x124/0x5f0
[c2cd5cc0] [c007abf8] __get_free_pages+0x1c/0x50
[c2cd5cd0] [c008f958] __tlb_remove_page+0x6c/0xcc
[c2cd5ce0] [c009064c] unmap_single_vma+0x2e0/0x430
[c2cd5d60] [c0090e98] unmap_vmas+0x4c/0x5c
[c2cd5d80] [c0096074] exit_mmap+0x58/0x15c
[c2cd5de0] [c0014724] mmput+0x4c/0xfc
[c2cd5df0] [c00ae0b8] flush_old_exec+0x460/0x564
[c2cd5e30] [c00ee7e0] load_elf_binary+0x26c/0xf98
[c2cd5eb0] [c00ad73c] search_binary_handler+0x90/0x1b8
[c2cd5ee0] [c00aec78] do_execveat_common+0x5a8/0x6f0
[c2cd5f30] [c00aedf0] do_execve+0x30/0x40
[c2cd5f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff279b4
    LR =3D 0x10015ee4
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 570, name: S03gpio
1 lock held by S03gpio/570:
 #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c00ae694>] prepare_bprm_creds=
+0x20/0x5c
CPU: 0 PID: 570 Comm: S03gpio Tainted: G        W       4.1.5-20150730-1-rt=
5 #5
Call Trace:
[c3b5fdc0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b5fdd0] [c008dbac] follow_page_mask+0xa8/0x388
[c3b5fe00] [c008e000] __get_user_pages.part.26+0x174/0x358
[c3b5fe60] [c00adad8] copy_strings+0x158/0x2a0
[c3b5fee0] [c00aeb74] do_execveat_common+0x4a4/0x6f0
[c3b5ff30] [c00aedf0] do_execve+0x30/0x40
[c3b5ff40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff279b4
    LR =3D 0x10015ee4
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 597, name: usleep
no locks held by usleep/597.
CPU: 0 PID: 597 Comm: usleep Tainted: G        W       4.1.5-20150730-1-rt5=
 #5
Call Trace:
[c3b5fdb0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b5fdc0] [c0090508] unmap_single_vma+0x19c/0x430
[c3b5fe40] [c0090e98] unmap_vmas+0x4c/0x5c
[c3b5fe60] [c0096074] exit_mmap+0x58/0x15c
[c3b5fec0] [c0014724] mmput+0x4c/0xfc
[c3b5fed0] [c00177a4] do_exit+0x2c8/0x764
[c3b5ff10] [c0018dc8] do_group_exit+0x48/0xa8
[c3b5ff30] [c0018e3c] __wake_up_parent+0x0/0x18
[c3b5ff40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff27924
    LR =3D 0xffed254
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 615, name: sudo
1 lock held by sudo/615:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 615 Comm: sudo Tainted: G        W       4.1.5-20150730-1-rt5 #5
Call Trace:
[c3b8bc30] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b8bc40] [c0092028] handle_mm_fault+0xb7c/0x158c
[c3b8bcb0] [c000ea78] do_page_fault+0x33c/0x550
[c3b8bcf0] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at copy_page_to_iter+0x134/0x3e0
    LR =3D copy_page_to_iter+0x12c/0x3e0
[c3b8bdf0] [c0074ecc] generic_file_read_iter+0x3b8/0x670
[c3b8be70] [c0160374] nfs_file_read+0x68/0xb4
[c3b8be90] [c00a7b88] __vfs_read+0xc8/0xf0
[c3b8bef0] [c00a82b0] vfs_read+0x8c/0x10c
[c3b8bf10] [c00a8b2c] SyS_read+0x50/0x94
[c3b8bf40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xfefe110
    LR =3D 0xfea275c
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 521, name: udevd
1 lock held by udevd/521:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 521 Comm: udevd Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3ab3e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3ab3e90] [c009218c] handle_mm_fault+0xce0/0x158c
[c3ab3f00] [c000ea78] do_page_fault+0x33c/0x550
[c3ab3f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xfe3b258
    LR =3D 0xff31254
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 615, name: ntpdate
1 lock held by ntpdate/615:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 615 Comm: ntpdate Tainted: G        W       4.1.5-20150730-1-rt=
5 #5
Call Trace:
[c3b8bd80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b8bd90] [c0091670] handle_mm_fault+0x1c4/0x158c
[c3b8be00] [c000ea78] do_page_fault+0x33c/0x550
[c3b8be40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at do_page_fault+0x164/0x550
    LR =3D do_page_fault+0x148/0x550
[c3b8bf40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 401 at 0xfe9a484
    LR =3D 0xfec6f50
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 622, name: getty
1 lock held by getty/622:
 #0:  (&mm->mmap_sem){++++++}, at: [<c000e8e4>] do_page_fault+0x1a8/0x550
CPU: 0 PID: 622 Comm: getty Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c2c83e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c2c83e90] [c0092028] handle_mm_fault+0xb7c/0x158c
[c2c83f00] [c000ea78] do_page_fault+0x33c/0x550
[c2c83f40] [c000dda4] handle_page_fault+0xc/0x80
=2D-- interrupt: 301 at 0xff27f00
    LR =3D 0x1000608c
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 622, name: sh
2 locks held by sh/622:
 #0:  (&mm->mmap_sem){++++++}, at: [<c0015340>] copy_process.part.62+0x994/=
0x1204
 #1:  (&mm->mmap_sem/1){+.+.+.}, at: [<c001534c>] copy_process.part.62+0x9a=
0/0x1204
CPU: 0 PID: 622 Comm: sh Tainted: G        W       4.1.5-20150730-1-rt5 #5
Call Trace:
[c2c83dd0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c2c83de0] [c0090b28] copy_page_range+0x154/0x478
[c2c83e60] [c0015530] copy_process.part.62+0xb84/0x1204
[c2c83ee0] [c0015d18] do_fork+0xd0/0x4ec
[c2c83f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c00 at 0xff27680
    LR =3D 0xff27650
BUG: sleeping function called from invalid context at kernel/locking/rtmute=
x.c:917
in_atomic(): 1, irqs_disabled(): 0, pid: 638, name: dmesg
no locks held by dmesg/638.
CPU: 0 PID: 638 Comm: dmesg Tainted: G        W       4.1.5-20150730-1-rt5 =
#5
Call Trace:
[c3b89db0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
[c3b89dc0] [c0090508] unmap_single_vma+0x19c/0x430
[c3b89e40] [c0090e98] unmap_vmas+0x4c/0x5c
[c3b89e60] [c0096074] exit_mmap+0x58/0x15c
[c3b89ec0] [c0014724] mmput+0x4c/0xfc
[c3b89ed0] [c00177a4] do_exit+0x2c8/0x764
[c3b89f10] [c0018dc8] do_group_exit+0x48/0xa8
[c3b89f30] [c0018e3c] __wake_up_parent+0x0/0x18
[c3b89f40] [c000d8fc] ret_from_syscall+0x0/0x38
=2D-- interrupt: c01 at 0xff27924
    LR =3D 0xffed254
=2D--8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----8<-----=
8<--

jbe

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Borleis =A0 =A0 =A0 =A0 =A0 =A0 |
Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://=
www.pengutronix.de/ =A0|

--Boundary-00=_wgU8V2bBWZVSTkT
Content-Type: text/plain;
  charset="iso-8859-15";
  name="kernelconfig-4.1"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kernelconfig-4.1"

#
# Automatically generated file; DO NOT EDIT.
# Linux/powerpc 4.1.5-20150730-1 Kernel Configuration
#
# CONFIG_PPC64 is not set

#
# Processor support
#
CONFIG_PPC_BOOK3S_32=y
# CONFIG_PPC_85xx is not set
# CONFIG_PPC_8xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_E200 is not set
CONFIG_PPC_BOOK3S=y
CONFIG_6xx=y
CONFIG_PPC_FPU=y
# CONFIG_ALTIVEC is not set
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_STD_MMU_32=y
# CONFIG_PPC_MM_SLICES is not set
CONFIG_PPC_HAVE_PMU_SUPPORT=y
# CONFIG_SMP is not set
# CONFIG_PPC_DOORBELL is not set
CONFIG_CPU_BIG_ENDIAN=y
# CONFIG_CPU_LITTLE_ENDIAN is not set
CONFIG_PPC32=y
CONFIG_32BIT=y
CONFIG_WORD_SIZE=32
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
# CONFIG_ARCH_DMA_ADDR_T_64BIT is not set
CONFIG_MMU=y
# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
# CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK is not set
CONFIG_NR_IRQS=512
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HAVE_LATENCYTOP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_ARCH_HAS_ILOG2_U32=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_PPC=y
# CONFIG_GENERIC_CSUM is not set
CONFIG_EARLY_PRINTK=y
CONFIG_PANIC_TIMEOUT=180
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
# CONFIG_ARCH_MAY_HAVE_PC_FDC is not set
# CONFIG_PPC_UDBG_16550 is not set
# CONFIG_GENERIC_TBSYNC is not set
CONFIG_AUDIT_ARCH=y
CONFIG_GENERIC_BUG=y
# CONFIG_EPAPR_BOOT is not set
CONFIG_DEFAULT_UIMAGE=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
# CONFIG_PPC_DCR_NATIVE is not set
# CONFIG_PPC_DCR_MMIO is not set
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
# CONFIG_LOCALVERSION_AUTO is not set
CONFIG_DEFAULT_HOSTNAME="generic"
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_IRQ_DOMAIN=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_TIME_VSYSCALL_OLD=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ is not set
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_FANOUT=32
CONFIG_RCU_FANOUT_LEAF=16
# CONFIG_RCU_FANOUT_EXACT is not set
# CONFIG_TREE_RCU_TRACE is not set
CONFIG_RCU_BOOST=y
CONFIG_RCU_KTHREAD_PRIO=1
CONFIG_RCU_BOOST_DELAY=500
# CONFIG_RCU_NOCB_CPU is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_CGROUPS is not set
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_NAMESPACES is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_SYSCTL_SYSCALL=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
# CONFIG_AIO is not set
CONFIG_ADVISE_SYSCALLS=y
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
# CONFIG_VM_EVENT_COUNTERS is not set
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
CONFIG_SLUB=y
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND=y
CONFIG_OLD_SIGACTION=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_BLOCK=y
CONFIG_LBDAF=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
# CONFIG_EFI_PARTITION is not set
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
# CONFIG_IOSCHED_CFQ is not set
CONFIG_DEFAULT_DEADLINE=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
# CONFIG_FREEZER is not set
# CONFIG_PPC_XICS is not set
# CONFIG_PPC_ICP_NATIVE is not set
# CONFIG_PPC_ICP_HV is not set
# CONFIG_PPC_ICS_RTAS is not set
# CONFIG_GE_FPGA is not set

#
# Platform support
#
# CONFIG_PPC_CHRP is not set
# CONFIG_PPC_MPC512x is not set
CONFIG_PPC_MPC52xx=y
CONFIG_PPC_MPC5200_SIMPLE=y
# CONFIG_PPC_EFIKA is not set
# CONFIG_PPC_LITE5200 is not set
# CONFIG_PPC_MEDIA5200 is not set
# CONFIG_PPC_MPC5200_BUGFIX is not set
CONFIG_PPC_MPC5200_LPBFIFO=y
# CONFIG_PPC_PMAC is not set
# CONFIG_PPC_CELL is not set
# CONFIG_PPC_CELL_NATIVE is not set
# CONFIG_PPC_82xx is not set
# CONFIG_PQ2ADS is not set
# CONFIG_PPC_83xx is not set
# CONFIG_PPC_86xx is not set
# CONFIG_EMBEDDED6xx is not set
# CONFIG_AMIGAONE is not set
# CONFIG_KVM_GUEST is not set
# CONFIG_EPAPR_PARAVIRT is not set
# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
# CONFIG_IPIC is not set
# CONFIG_MPIC is not set
# CONFIG_PPC_EPAPR_HV_PIC is not set
# CONFIG_MPIC_WEIRD is not set
# CONFIG_PPC_I8259 is not set
# CONFIG_PPC_RTAS is not set
# CONFIG_MMIO_NVRAM is not set
# CONFIG_MPIC_U3_HT_IRQS is not set
# CONFIG_PPC_MPC106 is not set
# CONFIG_PPC_970_NAP is not set
# CONFIG_PPC_P7_NAP is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# CPUIdle driver
#

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set
# CONFIG_TAU is not set
# CONFIG_FSL_ULI1575 is not set
CONFIG_SIMPLE_GPIO=y

#
# Kernel options
#
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_SCHED_HRTICK=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_RT_BASE=y
CONFIG_HAVE_PREEMPT_LAZY=y
CONFIG_PREEMPT_LAZY=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT__LL is not set
# CONFIG_PREEMPT_RTB is not set
CONFIG_PREEMPT_RT_FULL=y
CONFIG_PREEMPT_COUNT=y
CONFIG_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y
# CONFIG_IOMMU_HELPER is not set
# CONFIG_SWIOTLB is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_HAS_WALK_MEMORY=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_GENERIC_RCU_GUP=y
CONFIG_NO_BOOTMEM=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_MIGRATION is not set
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=1
# CONFIG_BOUNCE is not set
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_NEED_PER_CPU_KM=y
# CONFIG_CLEANCACHE is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
CONFIG_PPC_4K_PAGES=y
CONFIG_FORCE_MAX_ZONEORDER=11
# CONFIG_PPC_COPRO_BASE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_EXTRA_TARGETS=""
# CONFIG_PM is not set
# CONFIG_SECCOMP is not set
# CONFIG_ISA_DMA_API is not set

#
# Bus options
#
CONFIG_ZONE_DMA=y
# CONFIG_NEED_DMA_MAP_STATE is not set
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_PPC_PCI_CHOICE=y
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_SYSCALL is not set
# CONFIG_PCCARD is not set
# CONFIG_HAS_RAPIDIO is not set
# CONFIG_NONSTATIC_KERNEL is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_PAGE_OFFSET=0xc0000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_PHYSICAL_START=0x00000000
CONFIG_TASK_SIZE=0xc0000000
# CONFIG_ARCH_RANDOM is not set
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_NET_IP_TUNNEL is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_GENEVE is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
# CONFIG_INET_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
# CONFIG_INET_XFRM_MODE_TUNNEL is not set
# CONFIG_INET_XFRM_MODE_BEET is not set
# CONFIG_INET_LRO is not set
# CONFIG_INET_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
# CONFIG_IPV6 is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
CONFIG_HAVE_BPF_JIT=y

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set
CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
# CONFIG_DMA_SHARED_BUFFER is not set

#
# Bus devices
#
# CONFIG_CONNECTOR is not set
CONFIG_MTD=y
# CONFIG_MTD_TESTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_OF_PARTS=y
# CONFIG_MTD_AR7_PARTS is not set

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
CONFIG_MTD_CFI_INTELEXT=y
# CONFIG_MTD_CFI_AMDSTD is not set
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_PHYSMAP is not set
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PLATRAM is not set

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# CONFIG_MTD_NAND is not set
# CONFIG_MTD_ONENAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# CONFIG_MTD_SPI_NOR is not set
# CONFIG_MTD_UBI is not set
CONFIG_DTC=y
CONFIG_OF=y

#
# Device Tree and Open Firmware support
#
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_MTD=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_PMEM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_HD is not set
# CONFIG_BLK_DEV_RBD is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
# CONFIG_BMP085_I2C is not set
# CONFIG_BMP085_SPI is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=y
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_SPI is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set

#
# Intel MIC Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
CONFIG_ATA=y
# CONFIG_ATA_NONSTANDARD is not set
CONFIG_ATA_VERBOSE_ERROR=y
# CONFIG_SATA_PMP is not set

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI_PLATFORM is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_MPC52xx=y

#
# PIO-only SFF controllers
#
# CONFIG_PATA_PLATFORM is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
CONFIG_ETHERNET=y
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_CADENCE is not set
# CONFIG_NET_VENDOR_BROADCOM is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_FREESCALE=y
CONFIG_FEC_MPC52xx=y
CONFIG_FEC_MPC52xx_MDIO=y
# CONFIG_FSL_PQ_MDIO is not set
# CONFIG_FSL_XGMAC_MDIO is not set
# CONFIG_NET_VENDOR_INTEL is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MICREL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_NET_VENDOR_XILINX is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_AT803X_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_PPP=y
CONFIG_PPP_BSDCOMP=y
CONFIG_PPP_DEFLATE=y
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPPOE is not set
CONFIG_PPP_ASYNC=y
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_SLIP is not set
CONFIG_SLHC=y
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
# CONFIG_CONSOLE_TRANSLATIONS is not set
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_PPC_EPAPR_HV_BYTECHAN is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_MPC52xx=y
CONFIG_SERIAL_MPC52xx_CONSOLE=y
CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=115200
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_TTY_PRINTK is not set
# CONFIG_HVC_UDBG is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_NVRAM is not set
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
# CONFIG_I2C_MUX is not set
# CONFIG_I2C_HELPER_AUTO is not set
# CONFIG_I2C_SMBUS is not set

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ALGOPCA is not set

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_GPIO is not set
CONFIG_I2C_MPC=y
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_GPIO is not set
CONFIG_SPI_MPC52xx=y
# CONFIG_SPI_MPC52xx_PSC is not set
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_OF_GPIO=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
CONFIG_GPIO_MPC5200=y
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_XILINX is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set

#
# MFD GPIO expanders
#

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set

#
# USB GPIO expanders
#
# CONFIG_W1 is not set
# CONFIG_POWER_SUPPLY is not set
# CONFIG_POWER_AVS is not set
# CONFIG_HWMON is not set
# CONFIG_THERMAL is not set
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_CORE is not set
CONFIG_WATCHDOG_NOWAYOUT=y

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
CONFIG_MPC5200_WDT=y
# CONFIG_MEN_A21_WDT is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_CORE is not set
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_AXP20X is not set
# CONFIG_MFD_CROS_EC is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77686 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_REGULATOR is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#

#
# Direct Rendering Manager
#
# CONFIG_DRM is not set

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
# CONFIG_VGASTATE is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# CONFIG_SOUND is not set

#
# HID support
#
# CONFIG_HID is not set

#
# USB HID support
#
# CONFIG_USB_HID is not set
# CONFIG_HID_PID is not set

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_BIG_ENDIAN_DESC=y
CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
# CONFIG_USB_OHCI_LITTLE_ENDIAN is not set
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
# CONFIG_USB_OTG_FSM is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FUSBH200_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
# CONFIG_USB_OHCI_HCD_PPC_OF_LE is not set
CONFIG_USB_OHCI_HCD_PPC_OF=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_HSIC_USB3503 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_GADGET is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_MMC_BLOCK_BOUNCE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_SDHCI is not set
CONFIG_MMC_SPI=y
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12057 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
CONFIG_RTC_DRV_PCF8563=y
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_MCP795 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_GENERIC is not set
# CONFIG_RTC_DRV_MPC5121 is not set
# CONFIG_RTC_DRV_SNVS is not set
# CONFIG_RTC_DRV_XGENE is not set

#
# HID Sensor RTC drivers
#
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
# CONFIG_DW_DMAC is not set
CONFIG_PPC_BESTCOMM=y
CONFIG_PPC_BESTCOMM_ATA=y
CONFIG_PPC_BESTCOMM_FEC=y
CONFIG_PPC_BESTCOMM_GEN_BD=y
# CONFIG_FSL_EDMA is not set
CONFIG_DMA_ENGINE=y
CONFIG_DMA_OF=y

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_CDCE706 is not set

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
# CONFIG_ATMEL_PIT is not set
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_SOC_TI is not set
# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_PWM is not set
CONFIG_IRQCHIP=y
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Android
#
# CONFIG_ANDROID is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT23=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
# CONFIG_FS_POSIX_ACL is not set
CONFIG_EXPORTFS=y
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
# CONFIG_DNOTIFY is not set
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=850
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_SYSCTL=y
# CONFIG_PROC_PAGE_MONITOR is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
# CONFIG_TMPFS_XATTR is not set
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_SWAP is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=y
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
# CONFIG_NLS_ASCII is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
# CONFIG_HAVE_ARCH_BITREVERSE is not set
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_IO=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC7=y
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
# CONFIG_XZ_DEC is not set
# CONFIG_XZ_DEC_BCJ is not set
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_GENERIC_ATOMIC64=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
# CONFIG_AVERAGE is not set
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_LIBFDT=y
CONFIG_ARCH_HAS_SG_CHAIN=y

#
# Kernel hacking
#

#
# printk and dmesg options
#
# CONFIG_PRINTK_TIME is not set
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_DYNAMIC_DEBUG is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
# CONFIG_DEBUG_SECTION_MISMATCH is not set
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_MEMORY_INIT is not set
CONFIG_HAVE_DEBUG_STACKOVERFLOW=y
# CONFIG_DEBUG_STACKOVERFLOW is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
# CONFIG_LOCKUP_DETECTOR is not set
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set
# CONFIG_DEBUG_PREEMPT is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
# CONFIG_SPARSE_RCU_POINTER is not set
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
CONFIG_RCU_CPU_STALL_INFO=y
# CONFIG_RCU_TRACE is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_TRACING_SUPPORT=y
# CONFIG_FTRACE is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_PPC_DISABLE_WERROR is not set
CONFIG_PPC_WERROR=y
CONFIG_PRINT_STACK_DEPTH=64
# CONFIG_PPC_EMULATED_STATS is not set
# CONFIG_CODE_PATCHING_SELFTEST is not set
# CONFIG_FTR_FIXUP_SELFTEST is not set
# CONFIG_MSI_BITMAP_SELFTEST is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_BOOTX_TEXT is not set
# CONFIG_PPC_EARLY_DEBUG is not set
CONFIG_STRICT_DEVMEM=y

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
# CONFIG_SECURITYFS is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
# CONFIG_CRYPTO_GF128MUL is not set
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_MCRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_SEQIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
CONFIG_CRYPTO_ECB=y
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MD5_PPC is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA1_PPC is not set
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_ANUBIS is not set
CONFIG_CRYPTO_ARC4=y
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_HW is not set
CONFIG_PPC_LIB_RHEAP=y
# CONFIG_VIRTUALIZATION is not set

--Boundary-00=_wgU8V2bBWZVSTkT--
