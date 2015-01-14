From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] timer: upper bound on loops of __run_timers
 processing
Date: Wed, 14 Jan 2015 12:41:51 -0500
Message-ID: <20150114124151.48d9ca69@gandalf.local.home>
References: <20141230195228.GA3057@amt.cnet>
	<20150114172147.GA16570@amt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark.williams@gmail.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Marcelo Tosatti <mtosatti@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150114172147.GA16570@amt.cnet>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 14 Jan 2015 15:21:47 -0200
Marcelo Tosatti <mtosatti@redhat.com> wrote:

> 
> Ping?
> 

Sorry, I've fallen behind since the holidays and still trying to catch
up. I'll try to look at this this week.

-- Steve

> On Tue, Dec 30, 2014 at 05:52:28PM -0200, Marcelo Tosatti wrote:
> > 
> > Commit "timers: do not raise softirq unconditionally", allows for timer
> > wheel processing (__run_timers) to be delayed for long periods of time.
> > 
> > The effect is that 
> > 
> > loops = jiffies - base->timer_jiffies
> > 
> > Can grow to very large values resulting in __run_timers taking hundreds
> > of milliseconds to execute.
> > 
> > Fix by creating an upper bound on the number of loops to be processed.
> > This allows a nohz=off kernel to achieve desired latencies.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > diff --git a/kernel/timer.c b/kernel/timer.c
> > index f59e18c..c128416 100644
> > --- a/kernel/timer.c
> > +++ b/kernel/timer.c
> > @@ -1488,6 +1488,12 @@ void run_local_timers(void)
> >  	}
> >  #endif
> >  
> > +	if (time_after_eq(jiffies, base->timer_jiffies)) {
> > +		unsigned long jiffies_delta = jiffies - base->timer_jiffies;
> > +		if (jiffies_delta > TVR_SIZE)
> > +			raise_softirq(TIMER_SOFTIRQ);
> > +	}
> > +
> >  	if (!base->active_timers)
> >  		goto out;
> >  
