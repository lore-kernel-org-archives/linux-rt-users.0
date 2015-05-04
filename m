From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Mon, 4 May 2015 10:48:44 +1000
Message-ID: <20150504004844.GA21261@dastard>
References: <20150430123303.30f5bd12@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:63290 "EHLO
	ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751013AbbEDAvm (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 May 2015 20:51:42 -0400
Content-Disposition: inline
In-Reply-To: <20150430123303.30f5bd12@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 30, 2015 at 12:33:03PM -0400, Steven Rostedt wrote:
> Running a test on a large CPU count box with xfs, I hit a live lock
> with the following backtraces on several CPUs:
> 
>  Call Trace:              
>   [<ffffffff812c34f8>] __const_udelay+0x28/0x30 
>   [<ffffffffa033ab9a>] xfs_icsb_lock_cntr+0x2a/0x40 [xfs] 
>   [<ffffffffa033c871>] xfs_icsb_modify_counters+0x71/0x280 [xfs] 
>   [<ffffffffa03413e1>] xfs_trans_reserve+0x171/0x210 [xfs] 
>   [<ffffffffa0378cfd>] xfs_create+0x24d/0x6f0 [xfs] 
>   [<ffffffff8124c8eb>] ? avc_has_perm_flags+0xfb/0x1e0 
>   [<ffffffffa0336eeb>] xfs_vn_mknod+0xbb/0x1e0 [xfs] 
>   [<ffffffffa0337043>] xfs_vn_create+0x13/0x20 [xfs] 
>   [<ffffffff811b0edd>] vfs_create+0xcd/0x130 
>   [<ffffffff811b21ef>] do_last+0xb8f/0x1240 
>   [<ffffffff811b39b2>] path_openat+0xc2/0x490 
> 
> Looking at the code I see it was stuck at: 
> 
> STATIC void
> xfs_icsb_lock_cntr(
> 	xfs_icsb_cnts_t	*icsbp)
> {
> 	while (test_and_set_bit(XFS_ICSB_FLAG_LOCK, &icsbp->icsb_flags)) {
> 		ndelay(1000);
> 	}
> }
> 
> I'm not sure why it does the ndelay() and not just a cpu_relax(), but

Because the code was writtenlong before cpu_relax() existed, just
like it was written long before the generic percpu counter code was
added...

....

> Now, when PREEMPT_RT is not enabled, that spin_lock() disables
> preemption. But for PREEMPT_RT, it does not. Although with my test box I
> was not able to produce a task state of all tasks, but I'm assuming that
> some task called the xfs_icsb_lock_all_counters() and was preempted by
> an RT task and could not finish, causing all callers of that lock to
> block indefinitely.
> 
> Looking at all users of xfs_icsb_lock_all_counters(), they are leaf
> functions and do not call anything that may block on PREEMPT_RT. I
> believe the proper fix here is to simply disable preemption in
> xfs_icsb_lock_all_counters() when PREEMPT_RT is enabled.

RT is going to have other performance problems that are probably
going to negate the scalability this code provides. If you want a
hack that you can easily backport (as this code now uses the generic
percpu counters) then have a look at fs/xfs/xfs_linux.h:

/*
 * Feature macros (disable/enable)
 */
#ifdef CONFIG_SMP
#define HAVE_PERCPU_SB  /* per cpu superblock counters are a 2.6 feature */
#else
#undef  HAVE_PERCPU_SB  /* per cpu superblock counters are a 2.6 feature */
#endif

You can turn off all that per-cpu code simply by:

-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT)

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
