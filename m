From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT PATCH 2/2] timers: wakeup all timer waiters without holding
 the base lock
Date: Thu, 14 Jul 2016 13:21:51 -0400
Message-ID: <20160714132151.7dd5f180@gandalf.local.home>
References: <1468512304-15310-1-git-send-email-bigeasy@linutronix.de>
	<1468512304-15310-2-git-send-email-bigeasy@linutronix.de>
	<20160714120917.038b215b@gandalf.local.home>
	<f0be3636-1189-9bf9-37f0-40ad1d32baf7@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f0be3636-1189-9bf9-37f0-40ad1d32baf7@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 14 Jul 2016 19:19:47 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 07/14/2016 06:09 PM, Steven Rostedt wrote:
> > On Thu, 14 Jul 2016 18:05:04 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >   
> >> There should be no need to hold the base lock during the wakeup. There
> >> should be no boosting involved, the wakeup list has its own lock so it
> >> should be safe to do this without the lock.
> >>
> >> Cc: stable-rt@vger.kernel.org  
> > 
> > Nothing against this patch, but as you marked it for stable, can you
> > add to the change log what issue you had that caused you to make this
> > change?  
> 
> #1 was noticed while looking at the code, it *might* happen.
> #2 Is not strictly required for back porting.
> I just don't see a reason for holding the lock, that is all.
> 

I have no problem backporting them. I just thought that the change log
might have been missing some useful information.

-- Steve
