From: Brian Foster <bfoster@redhat.com>
Subject: Re: [RT XFS] BUG from lockdep in xfs
Date: Wed, 9 Sep 2015 07:44:51 -0400
Message-ID: <20150909114451.GA30015@bfoster.bfoster>
References: <CANGgnMa7jXARYkfCKOgvphunKvVaxRWZcSFgGC1b2m74Dgt+jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rt-users <linux-rt-users@vger.kernel.org>, xfs <xfs@oss.sgi.com>,
	Philipp Schrader <philipp@peloton-tech.com>,
	Brian Silverman <brian@peloton-tech.com>,
	Dave Chinner <david@fromorbit.com>
To: Austin Schuh <austin@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbbIILox (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Sep 2015 07:44:53 -0400
Content-Disposition: inline
In-Reply-To: <CANGgnMa7jXARYkfCKOgvphunKvVaxRWZcSFgGC1b2m74Dgt+jQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Sep 08, 2015 at 11:54:07PM -0700, Austin Schuh wrote:
> I'm running xfstests and got the following BUG with lockdep enabled.
> I'm running the 4.1.6-rt5 kernel from TI's tree on a TI ARM chip.
> 
> Any ideas on what could be causing it, or if it is a real problem?
> 
> I see some patches in Dave's latest 4.3 pull request that discuss
> lockdep.  Are there any ones there that are worth backporting to my
> 4.1.6 kernel?
> 

I suspect Dave's recent rework of the lockdep namespace bits is what you
want:

	0952c818 xfs: clean up inode lockdep annotations

Note that there are a few follow on patches as well to clean up
directory locking and some kconfig related warnings and such.

Brian

> [ 4349.692989] run fstests generic/078 at 2015-09-09 04:58:56
> [ 4357.394974] BUG: looking up invalid subclass: 8
> [ 4357.394979] turning off the locking correctness validator.
> [ 4357.394989] CPU: 0 PID: 22963 Comm: renameat2 Not tainted 4.1.6-rt5+ #9
> [ 4357.394993] Hardware name: Generic DRA74X (Flattened Device Tree)
> [ 4357.395012] [<c00196b8>] (unwind_backtrace) from [<c001515c>]
> (show_stack+0x20/0x24)
> [ 4357.395026] [<c001515c>] (show_stack) from [<c07bb6e0>]
> (dump_stack+0x84/0xa0)
> [ 4357.395038] [<c07bb6e0>] (dump_stack) from [<c009ef0c>]
> (__lock_acquire+0x694/0x1ec0)
> [ 4357.395046] [<c009ef0c>] (__lock_acquire) from [<c00a1014>]
> (lock_acquire+0x10c/0x354)
> [ 4357.395055] [<c00a1014>] (lock_acquire) from [<c00a60ac>]
> (rt_down_write_nested+0x3c/0x4c)
> [ 4357.395069] [<c00a60ac>] (rt_down_write_nested) from [<c03b9874>]
> (xfs_ilock+0x110/0x328)
> [ 4357.395080] [<c03b9874>] (xfs_ilock) from [<c03baa84>]
> (xfs_lock_inodes+0x80/0x1b0)
> [ 4357.395088] [<c03baa84>] (xfs_lock_inodes) from [<c03bede0>]
> (xfs_rename+0x214/0xd24)
> [ 4357.395097] [<c03bede0>] (xfs_rename) from [<c03b7398>]
> (xfs_vn_rename+0x94/0xa8)
> [ 4357.395110] [<c03b7398>] (xfs_vn_rename) from [<c01a9c64>]
> (vfs_rename+0x5c0/0x870)
> [ 4357.395119] [<c01a9c64>] (vfs_rename) from [<c01af684>]
> (SyS_renameat2+0x458/0x48c)
> [ 4357.395130] [<c01af684>] (SyS_renameat2) from [<c0010940>]
> (ret_fast_syscall+0x0/0x54)
> 
> Thanks!
> Austin
> 
> _______________________________________________
> xfs mailing list
> xfs@oss.sgi.com
> http://oss.sgi.com/mailman/listinfo/xfs
