From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus rt_mutex
 deadlock report for absolutely free!
Date: Mon, 16 Jul 2012 12:02:27 -0400
Message-ID: <1342454547.5410.3.camel@gandalf.stny.rr.com>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <20120713125043.GH30128@shiny> <1342260883.7368.30.camel@marge.simpson.net>
	 <20120715175612.GF25961@shiny.int.fusionio.com>
	 <1342404140.7659.27.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <chris.mason@fusionio.com>,
	"Chris L. Mason" <clmason@fusionio.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26856 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab2GPQCa (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jul 2012 12:02:30 -0400
In-Reply-To: <1342404140.7659.27.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2012-07-16 at 04:02 +0200, Mike Galbraith wrote:

> > Great, thanks!  I got stuck in bug land on Friday.  You mentioned
> > performance problems earlier on Saturday, did this improve performance?
> 
> Yeah, the read_trylock() seems to improve throughput.  That's not
> heavily tested, but it certainly looks like it does.  No idea why.

Ouch, you just turned the rt_read_lock() into a spin lock. If a higher
priority process preempted a lower priority process that holds the same
lock, it will deadlock.

I'm not sure why you would get a performance benefit from this, as the
mutex used is an adaptive one (failure to acquire the lock will only
sleep if preempted or if the owner is not running).

We should look at why this performs better (if it really does).

-- Steve

> 
> WRT performance, dbench isn't thrilled, but btrfs seems to work just
> fine for my routine usage, and spinning rust bucket is being all it can
> be.  I hope I don't have to care overly much about dbench's opinon.  It
> doesn't make happy multi-thread numbers with btrfs, but those numbers
> suddenly look great if you rebase relative to xfs -rt throughput :)
> 
> > One other question:
> > 
> > >  again:
> > > +#ifdef CONFIG_PREEMPT_RT_BASE
> > > +	while (atomic_read(&eb->blocking_readers))
> > > +		cpu_chill();
> > > +	while(!read_trylock(&eb->lock))
> > > +		cpu_chill();
> > > +	if (atomic_read(&eb->blocking_readers)) {
> > > +		read_unlock(&eb->lock);
> > > +		goto again;
> > > +	}
> > 
> > Why use read_trylock() in a loop instead of just trying to take the
> > lock?  Is this an RTism or are there other reasons?
> 
> First stab paranoia.  It worked, so I removed it.  It still worked but
> lost throughput, removed all my bits leaving only the lockdep bits, it
> still worked.
> 
> -Mike


