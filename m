Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951C0CCA481
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Jul 2022 14:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiGDORw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Jul 2022 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiGDORq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jul 2022 10:17:46 -0400
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C277EB85B
        for <linux-rt-users@vger.kernel.org>; Mon,  4 Jul 2022 07:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Type:Message-ID:Subject:Cc:To:From:Date
        :Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        In-Reply-To:References; bh=i6z8BIrp1u2RMzOUSkOU5IuXdv9vdAb7aqlhc4i2bTQ=; b=a4
        xF4eoFCfJgOWefcZXeGJBoNnn4Rb/ylFLfl/zJF8KBlsyuQNhMWzNxZLa48UbxDqVe1kFzFEc4Zpu
        t7N5ALTQBhqkgCHK2vt8XYO+9sAal6wlLwK1qZjgzets7BaMAuzFV2y/FJ4vCQAtDPcNy1znn8Cw4
        JgPL5qh4X4eWaI2M+qePfPd/6zOKi4ecvnbaG3t0bSO7OzZvjSASXajYzb51lhHzZqgNNTMSeYl07
        H8TMEaWN5ifLAR3S9xKC7XPw+j0izze8ne8YodTyMZTZfhSyq5c0NB6Q7g0x4tTu7r9X/1lsvzzZd
        eQEtkJNWKs2Ao4eI8/H1s3hVF4AvQQpw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1o8MtO-0000dE-HW;
        Mon, 04 Jul 2022 15:17:39 +0100
Date:   Mon, 4 Jul 2022 15:17:37 +0100
From:   John Keeping <john@metanate.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RT] Deadlock on filesystem operations v5.15+
Message-ID: <YsL2gTPQk5YnI2W3@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm seeing a deadlock in filesystem operations on v5.15.49-rt47-rebase;
after further testing this is reproducible in all v5.15 releases I
tested as well as v5.19-rc3-rt5-rebase.  I believe it is specific to
CONFIG_PREEMPT_RT.

With added logging, I've confirmed that the kworker here is plugged and
the buffer tar is waiting for is one of those held up by the plug.  The
vfat filesystem here is on a loop device.

Both tasks here are running at normal priority (SCHED_OTHER, nice 0).

This seems to be similar to the issue fixed by b0fdc01354f4
("sched/core: Schedule new worker even if PI-blocked") since the lock
being used here is msdos_sb_info::s_lock which is a normal struct mutex
and thus tsk_is_pi_blocked() will be false for non-RT but is returning
true on RT meaning that blk_schedule_flush_plug() is skipped in
sched_submit_work().  If I remove the tsk_is_pi_blocked() check then I
can't reproduce the hang any more.

Is some further refinement of the condition here needed?

-- >8 --
INFO: task kworker/u8:0:8 blocked for more than 491 seconds.
      Not tainted 5.15.49-rt46 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:    0 pid:    8 ppid:     2 flags:0x00000000
Workqueue: writeback wb_workfn (flush-7:0)
[<c08a3a10>] (__schedule) from [<c08a3d84>] (schedule+0xdc/0x134)
[<c08a3d84>] (schedule) from [<c08a65a0>] (rt_mutex_slowlock_block.constprop.0+0xb8/0x174)
[<c08a65a0>] (rt_mutex_slowlock_block.constprop.0) from [<c08a6708>] (rt_mutex_slowlock.constprop.0+0xac/0x174)
[<c08a6708>] (rt_mutex_slowlock.constprop.0) from [<c0374d60>] (fat_write_inode+0x34/0x54)
[<c0374d60>] (fat_write_inode) from [<c0297304>] (__writeback_single_inode+0x354/0x3ec)
[<c0297304>] (__writeback_single_inode) from [<c0297998>] (writeback_sb_inodes+0x250/0x45c)
[<c0297998>] (writeback_sb_inodes) from [<c0297c20>] (__writeback_inodes_wb+0x7c/0xb8)
[<c0297c20>] (__writeback_inodes_wb) from [<c0297f24>] (wb_writeback+0x2c8/0x2e4)
[<c0297f24>] (wb_writeback) from [<c0298c40>] (wb_workfn+0x1a4/0x3e4)
[<c0298c40>] (wb_workfn) from [<c0138ab8>] (process_one_work+0x1fc/0x32c)
[<c0138ab8>] (process_one_work) from [<c0139120>] (worker_thread+0x22c/0x2d8)
[<c0139120>] (worker_thread) from [<c013e6e0>] (kthread+0x16c/0x178)
[<c013e6e0>] (kthread) from [<c01000fc>] (ret_from_fork+0x14/0x38)
Exception stack(0xc10e3fb0 to 0xc10e3ff8)
3fa0:                                     00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000

INFO: task tar:2083 blocked for more than 491 seconds.
      Not tainted 5.15.49-rt46 #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:tar             state:D stack:    0 pid: 2083 ppid:  2082 flags:0x00000000
[<c08a3a10>] (__schedule) from [<c08a3d84>] (schedule+0xdc/0x134)
[<c08a3d84>] (schedule) from [<c08a41b0>] (io_schedule+0x14/0x24)
[<c08a41b0>] (io_schedule) from [<c08a455c>] (bit_wait_io+0xc/0x30)
[<c08a455c>] (bit_wait_io) from [<c08a441c>] (__wait_on_bit_lock+0x54/0xa8)
[<c08a441c>] (__wait_on_bit_lock) from [<c08a44f4>] (out_of_line_wait_on_bit_lock+0x84/0xb0)
[<c08a44f4>] (out_of_line_wait_on_bit_lock) from [<c0371fb0>] (fat_mirror_bhs+0xa0/0x144)
[<c0371fb0>] (fat_mirror_bhs) from [<c0372a68>] (fat_alloc_clusters+0x138/0x2a4)
[<c0372a68>] (fat_alloc_clusters) from [<c0370b14>] (fat_alloc_new_dir+0x34/0x250)
[<c0370b14>] (fat_alloc_new_dir) from [<c03787c0>] (vfat_mkdir+0x58/0x148)
[<c03787c0>] (vfat_mkdir) from [<c0277b60>] (vfs_mkdir+0x68/0x98)
[<c0277b60>] (vfs_mkdir) from [<c027b484>] (do_mkdirat+0xb0/0xec)
[<c027b484>] (do_mkdirat) from [<c0100060>] (ret_fast_syscall+0x0/0x1c)
Exception stack(0xc2e1bfa8 to 0xc2e1bff0)
bfa0:                   01ee42f0 01ee4208 01ee42f0 000041ed 00000000 00004000
bfc0: 01ee42f0 01ee4208 00000000 00000027 01ee4302 00000004 000dcb00 01ee4190
bfe0: 000dc368 bed11924 0006d4b0 b6ebddfc
-- 8< --


Thanks,
John
