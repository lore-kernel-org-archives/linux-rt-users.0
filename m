From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.6.4-rt8
Date: Fri, 15 Jul 2016 11:37:15 -0400
Message-ID: <20160715113715.302b550a@gandalf.local.home>
References: <20160715114803.GA11606@linutronix.de>
	<20160715112244.4ff6ecab@gandalf.local.home>
	<20160715153122.GC16938@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160715153122.GC16938@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 15 Jul 2016 17:31:22 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2016-07-15 11:22:44 [-0400]:
> 
> >> Changes since v4.6.4-rt8:
> >> 
> >>   - Import Thomas' timer rework known as "timer: Refactor the timer
> >>     wheel" patch set which made its way into the -TIP tree. With this
> >>     changes we get NOHZ_FULL working. Finally.  
> >
> >Does this mean that there's no more 1 second tick?  
> 
> >From tracing there a timer wakeup each second but before we had a wakeup  
> each jiffy because we could not lookup the next timer without taking the
> base lock which we can do now.
> However if there is room for improvement to have a wakeup every two or
> five seconds I am all for it because from RT point of view we should be
> able to do the same things as the non-RT version.

Ah, that's right. I forgot that NOHZ_FULL was broken in -rt, which
sorta defeated the point, as NOHZ_FULL is a birth child of -rt in the
first place.

OK, thanks for clarifying.

-- Steve
