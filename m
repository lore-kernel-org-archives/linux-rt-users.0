From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] xfs: Disable preemption when grabbing all icsb
 counter locks
Date: Mon, 4 May 2015 10:14:33 -0400
Message-ID: <20150504101433.07f4ae35@gandalf.local.home>
References: <20150430123303.30f5bd12@gandalf.local.home>
	<20150504004844.GA21261@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:36630 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750918AbbEDOOi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 May 2015 10:14:38 -0400
In-Reply-To: <20150504004844.GA21261@dastard>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 4 May 2015 10:48:44 +1000
Dave Chinner <david@fromorbit.com> wrote:


> > I'm not sure why it does the ndelay() and not just a cpu_relax(), but
> 
> Because the code was writtenlong before cpu_relax() existed, just
> like it was written long before the generic percpu counter code was
> added...

Ah, legacy code.

> 
> ....
> 
> > Now, when PREEMPT_RT is not enabled, that spin_lock() disables
> > preemption. But for PREEMPT_RT, it does not. Although with my test box I
> > was not able to produce a task state of all tasks, but I'm assuming that
> > some task called the xfs_icsb_lock_all_counters() and was preempted by
> > an RT task and could not finish, causing all callers of that lock to
> > block indefinitely.
> > 
> > Looking at all users of xfs_icsb_lock_all_counters(), they are leaf
> > functions and do not call anything that may block on PREEMPT_RT. I
> > believe the proper fix here is to simply disable preemption in
> > xfs_icsb_lock_all_counters() when PREEMPT_RT is enabled.
> 
> RT is going to have other performance problems that are probably
> going to negate the scalability this code provides. If you want a
> hack that you can easily backport (as this code now uses the generic
> percpu counters) then have a look at fs/xfs/xfs_linux.h:
> 
> /*
>  * Feature macros (disable/enable)
>  */
> #ifdef CONFIG_SMP
> #define HAVE_PERCPU_SB  /* per cpu superblock counters are a 2.6 feature */
> #else
> #undef  HAVE_PERCPU_SB  /* per cpu superblock counters are a 2.6 feature */
> #endif
> 
> You can turn off all that per-cpu code simply by:
> 
> -#ifdef CONFIG_SMP
> +#if defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT)

Oh, I think I like this the best.

Thanks for the advice.

-- Steve
