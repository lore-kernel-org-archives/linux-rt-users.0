From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Thu, 23 Nov 2017 15:50:40 +0100
Message-ID: <1511448640.6505.30.camel@gmx.de>
References: <20171117145744.t366d2ztxj2qqnco@linutronix.de>
         <1511030230.12841.42.camel@gmx.de>
         <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
         <1511234430.7672.26.camel@gmx.de>
         <alpine.DEB.2.20.1711210931460.1782@nanos>
         <1511255884.7672.49.camel@gmx.de>
         <alpine.LRH.2.02.1711211107550.12859@file01.intranet.prod.int.rdu2.redhat.com>
         <1511285619.30074.13.camel@gmx.de>
         <alpine.LRH.2.02.1711211450410.10766@file01.intranet.prod.int.rdu2.redhat.com>
         <1511299251.30074.72.camel@gmx.de> <20171123144231.GD2384@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Cc: Mikulas Patocka <mpatocka@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Sebastian Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171123144231.GD2384@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2017-11-23 at 15:42 +0100, Sebastian Siewior wrote:
> On 2017-11-21 22:20:51 [+0100], Mike Galbraith wrote:
> > On Tue, 2017-11-21 at 14:56 -0500, Mikulas Patocka wrote:
> > > 
> > > If we don't have any reason why it is needed to unplug block requests when 
> > > a spinlock is taken - so let's not do this.
> > 
> > That's perfectly fine.  I guess I shouldn't have even mentioned having
> > encountered unplug at mutex being insufficient.
> 
> While at it, I intend to drop
> fs-jbd2-pull-your-plug-when-waiting-for-space.patch from the -RT queue
> for v4.14 which does
> 
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -116,6 +116,8 @@ void __jbd2_log_wait_for_space(journal_t
>  	nblocks = jbd2_space_needed(journal);
>  	while (jbd2_log_space_left(journal) < nblocks) {
>  		write_unlock(&journal->j_state_lock);
> +		if (current->plug)
> +			io_schedule();
>  		mutex_lock(&journal->j_checkpoint_mutex);
>  
>  		/*
> 
> and is/was probably a workaround for the missing schedule while blocking
> on mutex/rwsem.

Yeah, that's now code without a meaningful job.

	-Mike
