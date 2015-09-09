From: Austin Schuh <austin@peloton-tech.com>
Subject: [RT XFS] BUG from lockdep in xfs
Date: Tue, 8 Sep 2015 23:54:07 -0700
Message-ID: <CANGgnMa7jXARYkfCKOgvphunKvVaxRWZcSFgGC1b2m74Dgt+jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: rt-users <linux-rt-users@vger.kernel.org>, xfs <xfs@oss.sgi.com>,
	Philipp Schrader <philipp@peloton-tech.com>,
	Brian Silverman <brian@peloton-tech.com>,
	Dave Chinner <david@fromorbit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36827 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbIIGy1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Sep 2015 02:54:27 -0400
Received: by qgx61 with SMTP id 61so475890qgx.3
        for <linux-rt-users@vger.kernel.org>; Tue, 08 Sep 2015 23:54:26 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm running xfstests and got the following BUG with lockdep enabled.
I'm running the 4.1.6-rt5 kernel from TI's tree on a TI ARM chip.

Any ideas on what could be causing it, or if it is a real problem?

I see some patches in Dave's latest 4.3 pull request that discuss
lockdep.  Are there any ones there that are worth backporting to my
4.1.6 kernel?

[ 4349.692989] run fstests generic/078 at 2015-09-09 04:58:56
[ 4357.394974] BUG: looking up invalid subclass: 8
[ 4357.394979] turning off the locking correctness validator.
[ 4357.394989] CPU: 0 PID: 22963 Comm: renameat2 Not tainted 4.1.6-rt5+ #9
[ 4357.394993] Hardware name: Generic DRA74X (Flattened Device Tree)
[ 4357.395012] [<c00196b8>] (unwind_backtrace) from [<c001515c>]
(show_stack+0x20/0x24)
[ 4357.395026] [<c001515c>] (show_stack) from [<c07bb6e0>]
(dump_stack+0x84/0xa0)
[ 4357.395038] [<c07bb6e0>] (dump_stack) from [<c009ef0c>]
(__lock_acquire+0x694/0x1ec0)
[ 4357.395046] [<c009ef0c>] (__lock_acquire) from [<c00a1014>]
(lock_acquire+0x10c/0x354)
[ 4357.395055] [<c00a1014>] (lock_acquire) from [<c00a60ac>]
(rt_down_write_nested+0x3c/0x4c)
[ 4357.395069] [<c00a60ac>] (rt_down_write_nested) from [<c03b9874>]
(xfs_ilock+0x110/0x328)
[ 4357.395080] [<c03b9874>] (xfs_ilock) from [<c03baa84>]
(xfs_lock_inodes+0x80/0x1b0)
[ 4357.395088] [<c03baa84>] (xfs_lock_inodes) from [<c03bede0>]
(xfs_rename+0x214/0xd24)
[ 4357.395097] [<c03bede0>] (xfs_rename) from [<c03b7398>]
(xfs_vn_rename+0x94/0xa8)
[ 4357.395110] [<c03b7398>] (xfs_vn_rename) from [<c01a9c64>]
(vfs_rename+0x5c0/0x870)
[ 4357.395119] [<c01a9c64>] (vfs_rename) from [<c01af684>]
(SyS_renameat2+0x458/0x48c)
[ 4357.395130] [<c01af684>] (SyS_renameat2) from [<c0010940>]
(ret_fast_syscall+0x0/0x54)

Thanks!
Austin
