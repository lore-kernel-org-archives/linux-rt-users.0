From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT PATCH 1/2] timers: wakeup all timer waiters
Date: Thu, 14 Jul 2016 13:19:45 -0400
Message-ID: <20160714131945.67cc8ce5@gandalf.local.home>
References: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
	<20160714121341.2b0e70f5@gandalf.local.home>
	<e014d4ad-316f-3afe-fcac-923cd2f9a7e6@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e014d4ad-316f-3afe-fcac-923cd2f9a7e6@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jul 2016 19:14:58 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 07/14/2016 06:13 PM, Steven Rostedt wrote:
> >>  
> >> -# define wakeup_timer_waiters(b)	wake_up(&(b)->wait_for_running_timer)
> >> +# define wakeup_timer_waiters(b)	wake_up_all(&(b)->wait_for_running_timer)  
> > 
> > OK, I just received this patch (way after patch 2)
> > 
> > I'm assuming that patch two was done such that you don't do a
> > "wake_up_all" under a spinlock.  
> 
> No. I pulled in new timer code in and had to redo this part of RT.
> 
> While doing so I noticed that we drop the base lock during timer
> invocations and so it could be possible that we have two invocations
> of del_timer_sync() on a timer on the same "base" (one after the
> other). This is patch #1.
> 
> After that I saw that we do the wake up under the base lock but there
> is no reason for it. So here is patch #2.
> 
> Patch #1 is something that could happen in theory and I did not run in
> any problem.
>

OK, so patch 2 was just discovered by reviewing code?

-- Steve
