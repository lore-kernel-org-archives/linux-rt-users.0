From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.4.4-rt13: btrfs + xfstests 006 = BOOM..  and a bonus
 rt_mutex deadlock report for absolutely free!
Date: Mon, 16 Jul 2012 13:03:15 -0400
Message-ID: <1342458195.2783.5.camel@acer.local.home>
References: <1342072060.7338.102.camel@marge.simpson.net>
	 <20120713125043.GH30128@shiny> <1342260883.7368.30.camel@marge.simpson.net>
	 <20120715175612.GF25961@shiny.int.fusionio.com>
	 <1342404140.7659.27.camel@marge.simpson.net>
	 <1342454547.5410.3.camel@gandalf.stny.rr.com>
	 <1342455968.7659.93.camel@marge.simpson.net>
	 <1342456567.7659.97.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <chris.mason@fusionio.com>,
	"Chris L. Mason" <clmason@fusionio.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1342456567.7659.97.camel@marge.simpson.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-07-16 at 18:36 +0200, Mike Galbraith wrote:
>  
> > > Ouch, you just turned the rt_read_lock() into a spin lock. If a higher
> > > priority process preempted a lower priority process that holds the same
> > > lock, it will deadlock.
> > 
> > Hm, how, it's doing cpu_chill()?
> 
> 'course PI is toast, so *poof*.  Since just enabling the lockdep bits
> seems to fix it up, maybe that's the patchlet to submit (less is more).

There's that too. But the issue I was talking about is with all trylock
loops. As holding an rt-mutex now disables migration, if a high priority
process preempts a task that holds the lock, and then the high prio task
starts spinning waiting for that lock to release, the lower priority
process will never get to run to release it. The cpu_chill() doesn't
help.

-- Steve


