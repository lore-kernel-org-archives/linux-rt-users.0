From: Adeel Arshad <adeel_arshad@mentor.com>
Subject: BUG: sleeping function called from invalid context at
	kernel/rtmutex.c:684..... target: PowerPC
Date: Mon, 18 Oct 2010 18:45:51 +0500
Message-ID: <1287409551.11482.5.camel@pkl-zanwar-01.pkl.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:61326 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755088Ab0JRNpy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Oct 2010 09:45:54 -0400
Received: from nat-dem.mentorg.com ([195.212.93.2] helo=eu2-mail.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1P7q2D-00029c-W1 from Adeel_Arshad@mentor.com
	for linux-rt-users@vger.kernel.org; Mon, 18 Oct 2010 06:45:54 -0700
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am testing/evaluating PREEMPT_RT patch on a Freescale's board with
following details,

target system : mpc8572ds (powerpc)
kernel version : 2.6.31 now 2.6.31-rt21

after patching the kernel when I enable Full Preemption mode I receive
following messages in the log (dmesg). Although I am not facing any
hang/crash issue yet due to/in effect of these messages but I am looking
to fix these. On investigating I found that this issue occurs when an
rt_spin_lock is acquired while the interrupt/preemption is disabled.
Also analyzing the patch in detail I found that many spin_lock are
replaced with atomic_spin_lock. Should I replace the remaining ones..?
or please guide me how to fix this issue...


 at kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2369, name: smbd
Call Trace:
[eeb21e60] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb21e90] [c0040af8] __might_sleep+0xf0/0xf4
[eeb21ea0] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb21eb0] [c00dde70] mprotect_fixup+0x1b4/0x3e4
[eeb21f10] [c00de208] sys_mprotect+0x168/0x1e4
[eeb21f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2370, name: smbd
Call Trace:
[ef2b1df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ef2b1e20] [c0040af8] __might_sleep+0xf0/0xf4
[ef2b1e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ef2b1e40] [c00d4ef0] __do_fault+0x154/0x508
[ef2b1e90] [c0017174] do_page_fault+0x214/0x4b0
[ef2b1f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: scheduling while atomic: rc/0x00000001/2373, CPU#0
Modules linked in: t23xrm
Call Trace:
[ee9079b0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee9079e0] [c00470a8] __schedule_bug+0xac/0xb0
[ee907a00] [c045c638] __schedule+0x448/0x89c
[ee907a70] [c045cd6c] schedule+0x20/0x44
[ee907a80] [c045e1f4] rt_spin_lock_slowlock+0x2cc/0x334
[ee907b00] [c00bef28] get_zone_pcp+0x70/0xd4
[ee907b30] [c00c0a40] free_hot_cold_page+0x134/0x3d4
[ee907b70] [c00c5ca0] put_page+0x60/0x198
[ee907b90] [c00e40e0] free_page_and_swap_cache+0x38/0x7c
[ee907ba0] [c00d642c] unmap_vmas+0x48c/0x690
[ee907c30] [c00db86c] exit_mmap+0x108/0x21c
[ee907c90] [c004d674] mmput+0x74/0x12c
[ee907cb0] [c00f8b2c] flush_old_exec+0x3a0/0x658
[ee907cf0] [c013cd6c] load_elf_binary+0x468/0x1394
[ee907d70] [c00f80c8] search_binary_handler+0x214/0x43c
[ee907dd0] [c013aed0] load_script+0x270/0x284
[ee907e80] [c00f80c8] search_binary_handler+0x214/0x43c
[ee907ee0] [c00f98bc] do_execve+0x30c/0x35c
[ee907f20] [c00097bc] sys_execve+0x68/0xa4
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
LDA version 0.9.6 (aarshad@pkl-zanwar-01.pkl.mentorg.com) NR_CPUS=2 Wed
Oct 6 08:22:39 UTC 2010
BUG: using smp_processor_id() in preemptible [00000000] code:
modprobe/2380
caller is init_lda+0x60/0x2b0 [lda]
Call Trace:
[ee919e80] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee919eb0] [c025458c] debug_smp_processor_id+0xf8/0xfc
[ee919ed0] [f917b060] init_lda+0x60/0x2b0 [lda]
[ee919ef0] [c0001d78] do_one_initcall+0x54/0x218
[ee919f20] [c008fb70] sys_init_module+0x120/0x230
[ee919f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2334, name: named
Call Trace:
[eeb19df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb19e20] [c0040af8] __might_sleep+0xf0/0xf4
[eeb19e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb19e40] [c00d4ef0] __do_fault+0x154/0x508
[eeb19e90] [c0017174] do_page_fault+0x214/0x4b0
[eeb19f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2365, name: ntpd
Call Trace:
[ee99bdf0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee99be20] [c0040af8] __might_sleep+0xf0/0xf4
[ee99be30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee99be40] [c00d4ef0] __do_fault+0x154/0x508
[ee99be90] [c0017174] do_page_fault+0x214/0x4b0
[ee99bf40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2365, name: ntpd
Call Trace:
[ee99bdf0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee99be20] [c0040af8] __might_sleep+0xf0/0xf4
[ee99be30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee99be40] [c00d4ef0] __do_fault+0x154/0x508
[ee99be90] [c0017174] do_page_fault+0x214/0x4b0
[ee99bf40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907e20] [c0040af8] __might_sleep+0xf0/0xf4
[ee907e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907e40] [c00d4ef0] __do_fault+0x154/0x508
[ee907e90] [c0017174] do_page_fault+0x214/0x4b0
[ee907f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907b20] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907b50] [c0040af8] __might_sleep+0xf0/0xf4
[ee907b60] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907b70] [c00d7634] handle_mm_fault+0x564/0x81c
[ee907bd0] [c0017174] do_page_fault+0x214/0x4b0
[ee907c80] [c0012f10] handle_page_fault+0xc/0x80
[ee907d40] [c00b9128] file_read_actor+0x27c/0x2d0
[ee907d70] [c00bbf38] generic_file_aio_read+0x364/0x79c
[ee907e00] [c0198804] nfs_file_read+0x1a0/0x21c
[ee907e30] [c00f12fc] do_sync_read+0xd0/0x15c
[ee907ef0] [c00f238c] vfs_read+0xcc/0x19c
[ee907f10] [c00f2594] sys_read+0x58/0xc8
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907b20] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907b50] [c0040af8] __might_sleep+0xf0/0xf4
[ee907b60] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907b70] [c00d7634] handle_mm_fault+0x564/0x81c
[ee907bd0] [c0017174] do_page_fault+0x214/0x4b0
[ee907c80] [c0012f10] handle_page_fault+0xc/0x80
[ee907d40] [c00b9128] file_read_actor+0x27c/0x2d0
[ee907d70] [c00bbf38] generic_file_aio_read+0x364/0x79c
[ee907e00] [c0198804] nfs_file_read+0x1a0/0x21c
[ee907e30] [c00f12fc] do_sync_read+0xd0/0x15c
[ee907ef0] [c00f238c] vfs_read+0xcc/0x19c
[ee907f10] [c00f2594] sys_read+0x58/0xc8
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907de0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907e10] [c0040af8] __might_sleep+0xf0/0xf4
[ee907e20] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907e30] [c00d7634] handle_mm_fault+0x564/0x81c
[ee907e90] [c0017174] do_page_fault+0x214/0x4b0
[ee907f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907b20] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907b50] [c0040af8] __might_sleep+0xf0/0xf4
[ee907b60] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907b70] [c00d7634] handle_mm_fault+0x564/0x81c
[ee907bd0] [c0017174] do_page_fault+0x214/0x4b0
[ee907c80] [c0012f10] handle_page_fault+0xc/0x80
[ee907d40] [c00b9128] file_read_actor+0x27c/0x2d0
[ee907d70] [c00bbf38] generic_file_aio_read+0x364/0x79c
[ee907e00] [c0198804] nfs_file_read+0x1a0/0x21c
[ee907e30] [c00f12fc] do_sync_read+0xd0/0x15c
[ee907ef0] [c00f238c] vfs_read+0xcc/0x19c
[ee907f10] [c00f2594] sys_read+0x58/0xc8
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907b20] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907b50] [c0040af8] __might_sleep+0xf0/0xf4
[ee907b60] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907b70] [c00d7634] handle_mm_fault+0x564/0x81c
[ee907bd0] [c0017174] do_page_fault+0x214/0x4b0
[ee907c80] [c0012f10] handle_page_fault+0xc/0x80
[ee907d40] [c00b9128] file_read_actor+0x27c/0x2d0
[ee907d70] [c00bbf38] generic_file_aio_read+0x364/0x79c
[ee907e00] [c0198804] nfs_file_read+0x1a0/0x21c
[ee907e30] [c00f12fc] do_sync_read+0xd0/0x15c
[ee907ef0] [c00f238c] vfs_read+0xcc/0x19c
[ee907f10] [c00f2594] sys_read+0x58/0xc8
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2372, name: nmbd
Call Trace:
[eeb21df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb21e20] [c0040af8] __might_sleep+0xf0/0xf4
[eeb21e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb21e40] [c00d4ef0] __do_fault+0x154/0x508
[eeb21e90] [c0017174] do_page_fault+0x214/0x4b0
[eeb21f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2365, name: ntpd
Call Trace:
[ee99bdf0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee99be20] [c0040af8] __might_sleep+0xf0/0xf4
[ee99be30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee99be40] [c00d4ef0] __do_fault+0x154/0x508
[ee99be90] [c0017174] do_page_fault+0x214/0x4b0
[ee99bf40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2372, name: nmbd
Call Trace:
[eeb21df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb21e20] [c0040af8] __might_sleep+0xf0/0xf4
[eeb21e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb21e40] [c00d4ef0] __do_fault+0x154/0x508
[eeb21e90] [c0017174] do_page_fault+0x214/0x4b0
[eeb21f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2391, name: getty
Call Trace:
[eea31de0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eea31e10] [c0040af8] __might_sleep+0xf0/0xf4
[eea31e20] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eea31e30] [c00d7634] handle_mm_fault+0x564/0x81c
[eea31e90] [c0017174] do_page_fault+0x214/0x4b0
[eea31f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2391, name: sh
Call Trace:
[eea31d50] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eea31d80] [c0040af8] __might_sleep+0xf0/0xf4
[eea31d90] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eea31da0] [c00d8bc4] copy_page_range+0x160/0x4dc
[eea31e20] [c004dcec] dup_mm+0x2b4/0x3e4
[eea31e60] [c004ea1c] copy_process+0xbb4/0xfac
[eea31ec0] [c004eeac] do_fork+0x98/0x3d4
[eea31f20] [c0008cb8] sys_clone+0x68/0xac
[eea31f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2391, name: sh
Call Trace:
[eea31b20] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eea31b50] [c0040af8] __might_sleep+0xf0/0xf4
[eea31b60] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eea31b70] [c00d7634] handle_mm_fault+0x564/0x81c
[eea31bd0] [c0017174] do_page_fault+0x214/0x4b0
[eea31c80] [c0012f10] handle_page_fault+0xc/0x80
[eea31d40] [c00b9128] file_read_actor+0x27c/0x2d0
[eea31d70] [c00bbf38] generic_file_aio_read+0x364/0x79c
[eea31e00] [c0198804] nfs_file_read+0x1a0/0x21c
[eea31e30] [c00f12fc] do_sync_read+0xd0/0x15c
[eea31ef0] [c00f238c] vfs_read+0xcc/0x19c
[eea31f10] [c00f2594] sys_read+0x58/0xc8
[eea31f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2365, name: ntpd
Call Trace:
[ee99bdf0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee99be20] [c0040af8] __might_sleep+0xf0/0xf4
[ee99be30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee99be40] [c00d4ef0] __do_fault+0x154/0x508
[ee99be90] [c0017174] do_page_fault+0x214/0x4b0
[ee99bf40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2334, name: named
Call Trace:
[eeb19df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb19e20] [c0040af8] __might_sleep+0xf0/0xf4
[eeb19e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb19e40] [c00d4ef0] __do_fault+0x154/0x508
[eeb19e90] [c0017174] do_page_fault+0x214/0x4b0
[eeb19f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907da0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907dd0] [c0040af8] __might_sleep+0xf0/0xf4
[ee907de0] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907df0] [c00d6190] unmap_vmas+0x1f0/0x690
[ee907e80] [c00db574] unmap_region+0xf0/0x214
[ee907ef0] [c00dca78] do_munmap+0x2b8/0x33c
[ee907f20] [c00dcb44] sys_munmap+0x48/0x78
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907da0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907dd0] [c0040af8] __might_sleep+0xf0/0xf4
[ee907de0] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907df0] [c00d6190] unmap_vmas+0x1f0/0x690
[ee907e80] [c00db574] unmap_region+0xf0/0x214
[ee907ef0] [c00dca78] do_munmap+0x2b8/0x33c
[ee907f20] [c00dcb44] sys_munmap+0x48/0x78
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2372, name: nmbd
Call Trace:
[eeb21df0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb21e20] [c0040af8] __might_sleep+0xf0/0xf4
[eeb21e30] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb21e40] [c00d4ef0] __do_fault+0x154/0x508
[eeb21e90] [c0017174] do_page_fault+0x214/0x4b0
[eeb21f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2386, name: freshclam
Call Trace:
[ee907da0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[ee907dd0] [c0040af8] __might_sleep+0xf0/0xf4
[ee907de0] [c045ed0c] rt_spin_lock+0xa4/0xa8
[ee907df0] [c00d6190] unmap_vmas+0x1f0/0x690
[ee907e80] [c00db574] unmap_region+0xf0/0x214
[ee907ef0] [c00dca78] do_munmap+0x2b8/0x33c
[ee907f20] [c00dcb44] sys_munmap+0x48/0x78
[ee907f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2372, name: nmbd
Call Trace:
[eeb21de0] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eeb21e10] [c0040af8] __might_sleep+0xf0/0xf4
[eeb21e20] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eeb21e30] [c00d750c] handle_mm_fault+0x43c/0x81c
[eeb21e90] [c0017174] do_page_fault+0x214/0x4b0
[eeb21f40] [c0012f10] handle_page_fault+0xc/0x80
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2391, name: sh
Call Trace:
[eea31b20] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eea31b50] [c0040af8] __might_sleep+0xf0/0xf4
[eea31b60] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eea31b70] [c00d7634] handle_mm_fault+0x564/0x81c
[eea31bd0] [c0017174] do_page_fault+0x214/0x4b0
[eea31c80] [c0012f10] handle_page_fault+0xc/0x80
[eea31d40] [c00b9128] file_read_actor+0x27c/0x2d0
[eea31d70] [c00bbf38] generic_file_aio_read+0x364/0x79c
[eea31e00] [c0198804] nfs_file_read+0x1a0/0x21c
[eea31e30] [c00f12fc] do_sync_read+0xd0/0x15c
[eea31ef0] [c00f238c] vfs_read+0xcc/0x19c
[eea31f10] [c00f2594] sys_read+0x58/0xc8
[eea31f40] [c0012ad0] ret_from_syscall+0x0/0x3c
BUG: sleeping function called from invalid context at
kernel/rtmutex.c:684
in_atomic(): 1, irqs_disabled(): 0, pid: 2391, name: sh
Call Trace:
[eea31d50] [c0008840] show_stack+0x70/0x1b4 (unreliable)
[eea31d80] [c0040af8] __might_sleep+0xf0/0xf4
[eea31d90] [c045ed0c] rt_spin_lock+0xa4/0xa8
[eea31da0] [c00d8bc4] copy_page_range+0x160/0x4dc
[eea31e20] [c004dcec] dup_mm+0x2b4/0x3e4
[eea31e60] [c004ea1c] copy_process+0xbb4/0xfac
[eea31ec0] [c004eeac] do_fork+0x98/0x3d4
[eea31f20] [c0008cb8] sys_clone+0x68/0xac
[eea31f40] [c0012ad0] ret_from_syscall+0x0/0x3c


--
Regards:

Adeel Arshad
