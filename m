From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Thu, 30 Apr 2015 20:07:21 +0200
Message-ID: <20150430180721.GX5029@twins.programming.kicks-ass.net>
References: <20150430123303.30f5bd12@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Dave Chinner <david@fromorbit.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:41873 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbD3SHd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Apr 2015 14:07:33 -0400
Content-Disposition: inline
In-Reply-To: <20150430123303.30f5bd12@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 30, 2015 at 12:33:03PM -0400, Steven Rostedt wrote:
> diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
> index 51435dbce9c4..dbaa1ce3f308 100644
> --- a/fs/xfs/xfs_mount.c
> +++ b/fs/xfs/xfs_mount.c
> @@ -1660,6 +1660,12 @@ xfs_icsb_lock_all_counters(
>  	xfs_icsb_cnts_t *cntp;
>  	int		i;
>  
> +	/*
> +	 * In PREEMPT_RT, preemption is not disabled here, and it
> +	 * must be to take the xfs_icsb_lock_cntr.
> +	 */
> +	preempt_disable_rt();
> +
>  	for_each_online_cpu(i) {
>  		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
>  		xfs_icsb_lock_cntr(cntp);
> @@ -1677,6 +1683,8 @@ xfs_icsb_unlock_all_counters(
>  		cntp = (xfs_icsb_cnts_t *)per_cpu_ptr(mp->m_sb_cnts, i);
>  		xfs_icsb_unlock_cntr(cntp);
>  	}
> +
> +	preempt_enable_rt();
>  }

The irony, this is distinctly non deterministic code you're putting
under a RT specific preempt_disable ;-)
