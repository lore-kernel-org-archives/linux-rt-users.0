From: Maksym Parkachov <lazy.gopher@gmail.com>
Subject: Re: beagleboard RT problem
Date: Sun, 8 Aug 2010 11:41:45 +0200
Message-ID: <AANLkTinXgWGaFX+yDvrgU-KnXfCFpcL+ccP1N4j6fmEX@mail.gmail.com>
References: <AANLkTik4gFjREMEwYqCyg24o6veBaEEa1oiEIkZl50kr@mail.gmail.com>
	<AANLkTikWXBR-ZmsdMrPI3KyAgLV2G1yvuQrAYp07KFCN@mail.gmail.com>
	<alpine.LFD.2.00.1006141301100.26248@localhost.localdomain>
	<1276514850.26993.4.camel@sven.thebigcorporation.com>
	<AANLkTimWSQfXQGedfHHLAbabPrRnUaWlPCMUEC3I9_G0@mail.gmail.com>
	<AANLkTikP0Z8NbhiCd9yJeNJrnJqJkoXkSSErR_9B6dYC@mail.gmail.com>
	<AANLkTilakntJf43kOkuT0EVu6v3s17VNJR6S60lB2ls3@mail.gmail.com>
	<AANLkTinojaU-FL3K3C09hV9-qrr8ZdjA8fzDMWTeQh_k@mail.gmail.com>
	<1277218015.10664.5.camel@sven.thebigcorporation.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED2FC9@dbde02.ent.ti.com>
	<AANLkTileTAXkfHwhSruyWhZqpPkEr4KnEGyf1fUQqaPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55260 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203Ab0HHJlq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 8 Aug 2010 05:41:46 -0400
Received: by iwn33 with SMTP id 33so2795147iwn.19
        for <linux-rt-users@vger.kernel.org>; Sun, 08 Aug 2010 02:41:45 -0700 (PDT)
In-Reply-To: <AANLkTileTAXkfHwhSruyWhZqpPkEr4KnEGyf1fUQqaPw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi folks,

it's me, back, with strange behavior of kernel on beagleboard (arm).

The kernel is the latest one with options recommended by Amit.
Linux version 2.6.33.7-rt29 (oe@server) (gcc version 4.3.3 (GCC) ) #1
PREEMPT RT

last time I made mistake of not enabling the debug correctly.
This time following was reported:

1. During boot the self-test were activated, and now kernel says
something useful:

[    0.000000] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[    0.000000] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000000] ... MAX_LOCK_DEPTH:          48
[    0.000000] ... MAX_LOCKDEP_KEYS:        8191
[    0.000000] ... CLASSHASH_SIZE:          4096
[    0.000000] ... MAX_LOCKDEP_ENTRIES:     16384
[    0.000000] ... MAX_LOCKDEP_CHAINS:      32768
[    0.000000] ... CHAINHASH_SIZE:          16384
[    0.000000]  memory used by lock dependency info: 3951 kB
[    0.000000]  per task-struct memory footprint: 2304 bytes
[    0.000000] ------------------------
[    0.000000] | Locking API testsuite:
[    0.000000] ----------------------------------------------------------------------------
[    0.000000]                                  | spin |wlock |rlock
|mutex | wsem | rsem |
[    0.000000]
--------------------------------------------------------------------------
[    0.000000]                      A-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]                     double unlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]                   initialize held:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]                  bad unlock order:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[    0.000000]
--------------------------------------------------------------------------
[    0.000000]               recursive read-lock:             |  ok  |
            |  ok  |
[    0.000000]            recursive read-lock #2:             |  ok  |
            |  ok  |
[    0.000000]             mixed read-write-lock:             |  ok  |
            |  ok  |
[    0.000000]             mixed write-read-lock:             |  ok  |
            |  ok  |
[    0.000000]
--------------------------------------------------------------------------
[    0.000000] -------------------------------------------------------
[    0.000000] Good, all  68 testcases passed! |
[    0.000000] ---------------------------------
[    0.000000] BUG: swapper/0: lock count overflow!
[    0.000000] [<c0040da8>] (unwind_backtrace+0x0/0xe8) from
[<c05778c8>] (dump_stack+0x1c/0x20)
[    0.000000] [<c05778c8>] (dump_stack+0x1c/0x20) from [<c00a8d2c>]
(rt_mutex_deadlock_account_lock+0x70/0x78)
[    0.000000] [<c00a8d2c>] (rt_mutex_deadlock_account_lock+0x70/0x78)
from [<c00a7a40>] (do_try_to_take_rt_mutex+0x138/0x17c)
[    0.000000] [<c00a7a40>] (do_try_to_take_rt_mutex+0x138/0x17c) from
[<c0579918>] (rt_spin_lock_slowlock+0xe4/0x274)
[    0.000000] [<c0579918>] (rt_spin_lock_slowlock+0xe4/0x274) from
[<c057a4c4>] (rt_spin_lock+0x58/0x98)
[    0.000000] [<c057a4c4>] (rt_spin_lock+0x58/0x98) from [<c011230c>]
(kmem_cache_alloc+0x1d0/0x224)
[    0.000000] [<c011230c>] (kmem_cache_alloc+0x1d0/0x224) from
[<c0112638>] (kmem_cache_create+0x1d4/0x4d0)
[    0.000000] [<c0112638>] (kmem_cache_create+0x1d4/0x4d0) from
[<c001d8d4>] (idr_init_cache+0x2c/0x44)
[    0.000000] [<c001d8d4>] (idr_init_cache+0x2c/0x44) from
[<c0008c18>] (start_kernel+0x210/0x340)
[    0.000000] [<c0008c18>] (start_kernel+0x210/0x340) from
[<80008034>] (0x80008034)
[    0.000000] Calibrating delay loop... 490.49 BogoMIPS (lpj=245248)

After that  kernel with swap switched off was rebuilt, and still
generating the same error. System don't really have or need swap.

2. Latency timer was activated, this is the report of latency under 100% load.

Latency Top version : v0.1
10 3751 864 n_tty_read tty_read vfs_read sys_read ret_fast_syscall
21 2048 298 do_wait sys_wait4 ret_fast_syscall
2 13589 8553 do_get_write_access journal_get_write_access
__ext3_journal_get_write_access ext3_reserve_inode_write
ext3_mark_inode_dirty ext3_dirty_inode
1 5751 5751 do_get_write_access journal_get_undo_access
__ext3_journal_get_undo_access ext3_free_blocks_sb ext3_free_blocks
ext3_clear_blocks ext3_free_d
1 6347 6347 sync_page sync_page_killable __lock_page_killable
generic_file_aio_read do_sync_read vfs_read kernel_read prepare_binprm
do_execve sys_execve
1 2264 2264 sync_page __lock_page find_lock_page filemap_fault
__do_fault handle_mm_fault do_page_fault do_translation_fault
do_DataAbort __dabt_svc __cl
1 5857110 5857110 sync_buffer __lock_buffer do_get_write_access
journal_get_write_access __ext3_journal_get_write_access
ext3_orphan_add ext3_setattr not
1 11715918 11715918 do_get_write_access journal_get_write_access
__ext3_journal_get_write_access ext3_reserve_inode_write
ext3_mark_inode_dirty ext3_dirt
1 417 417 __make_request generic_make_request submit_bio submit_bh
__block_write_full_page block_write_full_page_endio
block_write_full_page ext3_writeb

seems like something wrong on my system with ext3 layer. I will try to
setup system without journal.

If you guys have some more ideas I would really appreciate.

Cheers,
Maksym.
