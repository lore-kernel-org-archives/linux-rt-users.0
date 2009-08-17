From: Dale Stimson <DaleStimson@gmail.com>
Subject: 2.6.31-rc6-rt2 bug report
Date: Mon, 17 Aug 2009 09:08:07 -0700
Message-ID: <20090817160807.GA13679@cupro.opengvs.com>
References: <alpine.LFD.2.00.0905130122250.3561@localhost.localdomain> <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain> <alpine.LFD.2.00.0906101803210.3367@localhost.localdomain> <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain> <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain> <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain> <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain> <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain> <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain> <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 68-185-24-58.static.mdfd.or.charter.com ([68.185.24.58]:60825
	"EHLO cupro.opengvs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104AbZHQQX5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Aug 2009 12:23:57 -0400
Received: from cupro.opengvs.com (cupro.opengvs.com [127.0.0.1])
	by cupro.opengvs.com (8.14.3/8.14.3) with ESMTP id n7HG87ld013922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Mon, 17 Aug 2009 09:08:07 -0700
Received: (from dale@localhost)
	by cupro.opengvs.com (8.14.3/8.14.3/Submit) id n7HG879u013921
	for linux-rt-users@vger.kernel.org; Mon, 17 Aug 2009 09:08:07 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

With 2.6.31-rc6-rt2, on a Dell XPS-GEN2 laptop of 2005 vintage,
I'm seeing hundreds of bugs like the following reported to the
system log.  X graphics go away (as if screen-saver activated)
apparently at random, after maybe 10 seconds.

All reported bugs are of the type:
    "sleeping function called from invalid context at kernel/rtmutex.c:684"

However, the callers that trigger the bug vary.  I've included a
few representative call traces below.

----------------------------------------------------------------
Aug 17 08:28:46 ddl kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
Aug 17 08:28:46 ddl kernel: in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: init
Aug 17 08:28:46 ddl kernel: Pid: 1, comm: init Not tainted 2.6.31-0.1.rc6.rt2.ds.fc11.i686.PAE #1
Aug 17 08:28:46 ddl kernel: Call Trace:
Aug 17 08:28:46 ddl kernel: [<c042f594>] __might_sleep+0xc4/0xc9
Aug 17 08:28:46 ddl kernel: [<c04620c5>] rt_spin_lock_fastlock.clone.1+0x29/0x62
Aug 17 08:28:46 ddl kernel: [<c0764c79>] rt_spin_lock+0xd/0xf
Aug 17 08:28:46 ddl kernel: [<c0472856>] res_counter_uncharge+0x21/0x3d
Aug 17 08:28:46 ddl kernel: [<c04c39f1>] __mem_cgroup_uncharge_common+0x8e/0xf2
Aug 17 08:28:46 ddl kernel: [<c04c3a64>] mem_cgroup_uncharge_cache_page+0xf/0x11
Aug 17 08:28:46 ddl kernel: [<c049d6e3>] remove_from_page_cache+0x37/0x3b
Aug 17 08:28:46 ddl kernel: [<c04a399a>] truncate_complete_page+0x3b/0x4a
Aug 17 08:28:46 ddl kernel: [<c04a3a8a>] truncate_inode_pages_range+0xe1/0x26c
Aug 17 08:28:46 ddl kernel: [<c04a3c27>] truncate_inode_pages+0x12/0x1b
Aug 17 08:28:46 ddl kernel: [<c04e63e8>] kill_bdev+0x31/0x34
Aug 17 08:28:46 ddl kernel: [<c04e6ec9>] __blkdev_put+0x48/0xf5
Aug 17 08:28:46 ddl kernel: [<c04e6f85>] blkdev_put+0xf/0x11
Aug 17 08:28:46 ddl kernel: [<c04e6fb7>] blkdev_close+0x30/0x34
Aug 17 08:28:46 ddl kernel: [<c04c7b45>] __fput+0xee/0x17e
Aug 17 08:28:46 ddl kernel: [<c04c7bed>] fput+0x18/0x1a
Aug 17 08:28:46 ddl kernel: [<c04c4eeb>] filp_close+0x56/0x60
Aug 17 08:28:46 ddl kernel: [<c04c4f66>] sys_close+0x71/0xa5
Aug 17 08:28:46 ddl kernel: [<c040904c>] sysenter_do_call+0x12/0x28

----------------------------------------------------------------

Aug 17 08:28:46 ddl kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
Aug 17 08:28:46 ddl kernel: in_atomic(): 1, irqs_disabled(): 0, pid: 1, name: init
Aug 17 08:28:46 ddl kernel: Pid: 1, comm: init Not tainted 2.6.31-0.1.rc6.rt2.ds.fc11.i686.PAE #1
Aug 17 08:28:46 ddl kernel: Call Trace:
Aug 17 08:28:46 ddl kernel: [<c042f594>] __might_sleep+0xc4/0xc9
Aug 17 08:28:46 ddl kernel: [<c04620c5>] rt_spin_lock_fastlock.clone.1+0x29/0x62
Aug 17 08:28:46 ddl kernel: [<c0764c79>] rt_spin_lock+0xd/0xf
Aug 17 08:28:46 ddl kernel: [<c0472856>] res_counter_uncharge+0x21/0x3d
Aug 17 08:28:46 ddl kernel: [<c04c39f1>] __mem_cgroup_uncharge_common+0x8e/0xf2
Aug 17 08:28:46 ddl kernel: [<c04c3a8b>] mem_cgroup_uncharge_page+0x25/0x27
Aug 17 08:28:46 ddl kernel: [<c04b6309>] page_remove_rmap+0x24/0x43
Aug 17 08:28:46 ddl kernel: [<c04ae78a>] unmap_vmas+0x404/0x5a5
Aug 17 08:28:46 ddl kernel: [<c04b305c>] unmap_region+0x60/0xa1
Aug 17 08:28:46 ddl kernel: [<c04b3abb>] ? split_vma+0x101/0x114
Aug 17 08:28:46 ddl kernel: [<c04b3c97>] do_munmap+0x1c9/0x222
Aug 17 08:28:46 ddl kernel: [<c04b3d27>] sys_munmap+0x37/0x47
Aug 17 08:28:46 ddl kernel: [<c040904c>] sysenter_do_call+0x12/0x28

----------------------------------------------------------------

Aug 17 08:28:46 ddl kernel: BUG: sleeping function called from invalid context at kernel/rtmutex.c:684
Aug 17 08:28:46 ddl kernel: in_atomic(): 1, irqs_disabled(): 0, pid: 164, name: udevd
Aug 17 08:28:46 ddl kernel: Pid: 164, comm: udevd Not tainted 2.6.31-0.1.rc6.rt2.ds.fc11.i686.PAE #1
Aug 17 08:28:46 ddl kernel: Call Trace:
Aug 17 08:28:46 ddl kernel: [<c042f594>] __might_sleep+0xc4/0xc9
Aug 17 08:28:46 ddl kernel: [<c04620c5>] rt_spin_lock_fastlock.clone.1+0x29/0x62
Aug 17 08:28:46 ddl kernel: [<c0764c79>] rt_spin_lock+0xd/0xf
Aug 17 08:28:46 ddl kernel: [<c0472856>] res_counter_uncharge+0x21/0x3d
Aug 17 08:28:46 ddl kernel: [<c04c39f1>] __mem_cgroup_uncharge_common+0x8e/0xf2
Aug 17 08:28:46 ddl kernel: [<c04c3a64>] mem_cgroup_uncharge_cache_page+0xf/0x11
Aug 17 08:28:46 ddl kernel: [<c049d6e3>] remove_from_page_cache+0x37/0x3b
Aug 17 08:28:46 ddl kernel: [<c04a399a>] truncate_complete_page+0x3b/0x4a
Aug 17 08:28:46 ddl kernel: [<c04a3a8a>] truncate_inode_pages_range+0xe1/0x26c
Aug 17 08:28:46 ddl kernel: [<c04a3c27>] truncate_inode_pages+0x12/0x1b
Aug 17 08:28:46 ddl kernel: [<c04aee19>] vmtruncate+0xc9/0x117
Aug 17 08:28:46 ddl kernel: [<c04d704b>] inode_setattr+0x61/0x132
Aug 17 08:28:46 ddl kernel: [<c04a8708>] shmem_notify_change+0x9f/0xce
Aug 17 08:28:46 ddl kernel: [<c04d728b>] notify_change+0x16f/0x2bc
Aug 17 08:28:46 ddl kernel: [<c04c5bf2>] do_truncate+0x64/0x7d
Aug 17 08:28:46 ddl kernel: [<c0764ccf>] ? _mutex_lock+0xd/0xf
Aug 17 08:28:46 ddl kernel: [<c04c5bf2>] ? do_truncate+0x64/0x7d
Aug 17 08:28:46 ddl kernel: [<c04cf2eb>] may_open+0x187/0x18b
Aug 17 08:28:46 ddl kernel: [<c04cf944>] do_filp_open+0x3c3/0x6ea
Aug 17 08:28:46 ddl kernel: [<c04620c5>] ? rt_spin_lock_fastlock.clone.1+0x29/0x62
Aug 17 08:28:46 ddl kernel: [<c04620c5>] ? rt_spin_lock_fastlock.clone.1+0x29/0x62
Aug 17 08:28:46 ddl kernel: [<c04d7d88>] ? alloc_fd+0xc2/0xcf
Aug 17 08:28:46 ddl kernel: [<c04c4fe7>] do_sys_open+0x4d/0xe4
Aug 17 08:28:46 ddl kernel: [<c047951b>] ? audit_syscall_entry+0x12a/0x14c
Aug 17 08:28:46 ddl kernel: [<c04c50ca>] sys_open+0x23/0x2b
Aug 17 08:28:46 ddl kernel: [<c040904c>] sysenter_do_call+0x12/0x28

----------------------------------------------------------------

