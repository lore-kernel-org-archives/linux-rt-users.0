From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: jffs2 filesystem: possible circular locking dependency
 detected
Date: Wed, 8 Feb 2012 21:09:04 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1202082104470.2794@ionos>
References: <D61182AC8012EA4EBC531B3AF23BE109B3C6C6@tranzeo-mail2.12stewart.tranzeo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Darcy Watkins <DWatkins@tranzeo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60477 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755304Ab2BHUJH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 8 Feb 2012 15:09:07 -0500
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109B3C6C6@tranzeo-mail2.12stewart.tranzeo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 8 Feb 2012, Darcy Watkins wrote:
> [    0.000000] Linux version 3.0.18-rt34 (darcy@tr-pentomino) (gcc version 4.4.6 (crosstool-NG 1.12.4) ) #41 PREEMPT RT Wed Feb 8 10:04:00 PST 2012
> [   20.932000] =======================================================
> [   20.932000] [ INFO: possible circular locking dependency detected ]
> [   20.932000] 3.0.18-rt34 #41
> [   20.932000] -------------------------------------------------------
> [   20.932000] depmod/734 is trying to acquire lock:
> [   20.932000]  (&mm->mmap_sem){++++++}, at: [<800e82d0>] might_fault+0x4c/0xa4
> [   20.932000]
> [   20.932000] but task is already holding lock:
> [   20.932000]  (&f->sem){+.+.+.}, at: [<80184f88>] jffs2_readdir+0x108/0x1c0
> [   20.932000]
> [   20.932000] which lock already depends on the new lock.
> [   20.932000]
> [   20.932000]
> [   20.932000] the existing dependency chain (in reverse order) is:
> [   20.932000]
> [   20.932000] -> #1 (&f->sem){+.+.+.}:
> [   20.932000]        [<800bae14>] lock_acquire+0x60/0x88
> [   20.932000]        [<802d3a84>] _mutex_lock+0x34/0x48
> [   20.932000]        [<80185754>] jffs2_readpage+0x24/0x54
> [   20.932000]        [<800d91e8>] __do_page_cache_readahead+0x274/0x2dc
> [   20.932000]        [<800d9278>] ra_submit+0x28/0x34
> [   20.932000]        [<800d1320>] filemap_fault+0x1a8/0x48c
> [   20.932000]        [<800e898c>] __do_fault+0x70/0x468
> [   20.932000]        [<800e9df8>] handle_pte_fault+0x388/0xd28
> [   20.932000]        [<800eaa44>] handle_mm_fault+0xf4/0x11c
> [   20.932000]        [<8006c230>] do_page_fault+0x110/0x300
> [   20.932000]        [<80062c04>] ret_from_exception+0x0/0x10
> [   20.932000]        [<801c3cb4>] __bzero+0x38/0x164
> [   20.932000]        [<8014121c>] padzero+0x58/0x84
> [   20.932000]        [<80142b18>] load_elf_binary+0x774/0x12fc
> [   20.932000]        [<80102c60>] search_binary_handler+0xec/0x318
> [   20.932000]        [<801044c4>] do_execve+0x158/0x264
> [   20.932000]        [<800670a8>] sys_execve+0x44/0x6c
> [   20.932000]        [<8006a3b8>] stack_done+0x20/0x40
> [   20.932000]
> [   20.932000] -> #0 (&mm->mmap_sem){++++++}:
> [   20.932000]        [<800ba1f4>] __lock_acquire+0x1228/0x1934
> [   20.932000]        [<800bae14>] lock_acquire+0x60/0x88
> [   20.932000]        [<800e82f8>] might_fault+0x74/0xa4
> [   20.932000]        [<8010dd80>] filldir64+0xe0/0x144
> [   20.932000]        [<80184fe4>] jffs2_readdir+0x164/0x1c0
> [   20.932000]        [<8010e070>] vfs_readdir+0x74/0xcc
> [   20.932000]        [<8010e13c>] sys_getdents64+0x74/0xd8
> [   20.932000]        [<8006a3b8>] stack_done+0x20/0x40
> [   20.932000]
> [   20.932000] other info that might help us debug this:
> [   20.932000]
> [   20.932000]  Possible unsafe locking scenario:
> [   20.932000]
> [   20.932000]        CPU0                    CPU1
> [   20.932000]        ----                    ----
> [   20.932000]   lock(&f->sem);
> [   20.932000]                                lock(&mm->mmap_sem);
> [   20.932000]                                lock(&f->sem);
> [   20.932000]   lock(&mm->mmap_sem);
> [   20.932000]
> [   20.932000]  *** DEADLOCK ***
> [   20.932000]
> [   20.932000] 2 locks held by depmod/734:
> [   20.932000]  #0:  (&sb->s_type->i_mutex_key#3){+.+.+.}, at: [<8010e044>] vfs_readdir+0x48/0xcc
> [   20.932000]  #1:  (&f->sem){+.+.+.}, at: [<80184f88>] jffs2_readdir+0x108/0x1c0
> [   20.932000]
> [   20.932000] stack backtrace:
> [   20.932000] Call Trace:
> [   20.932000] [<802d103c>] dump_stack+0x8/0x34
> [   20.932000] [<800b8960>] print_circular_bug+0x2bc/0x2e8
> [   20.932000] [<800ba1f4>] __lock_acquire+0x1228/0x1934
> [   20.932000] [<800bae14>] lock_acquire+0x60/0x88
> [   20.932000] [<800e82f8>] might_fault+0x74/0xa4
> [   20.932000] [<8010dd80>] filldir64+0xe0/0x144
> [   20.932000] [<80184fe4>] jffs2_readdir+0x164/0x1c0
> [   20.932000] [<8010e070>] vfs_readdir+0x74/0xcc
> [   20.932000] [<8010e13c>] sys_getdents64+0x74/0xd8
> [   20.932000] [<8006a3b8>] stack_done+0x20/0x40

Classic ABBA deadlock. I don't think it's RT specific, but I might be
wrong as usual. Will have a look later this week, when noone beats me.

Thanks,

	tglx
