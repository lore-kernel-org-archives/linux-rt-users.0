From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [RFC][PATCH RT 3/4] sched/rt: Use IPI to trigger RT task push
 migration instead of pulling
Date: Tue, 11 Dec 2012 08:07:43 +0100
Message-ID: <1355209663.7057.77.camel@marge.simpson.net>
References: <20121207235615.206108556@goodmis.org>
	 <20121208000900.613917378@goodmis.org> <50C682F6.5030709@am.sony.com>
	 <50C68922.5030203@am.sony.com>
	 <1355190830.17101.280.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: frank.rowand@am.sony.com,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355190830.17101.280.camel@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2012-12-10 at 20:53 -0500, Steven Rostedt wrote: 
> On Mon, 2012-12-10 at 17:15 -0800, Frank Rowand wrote:
> 
> > I should have also mentioned some previous experience using IPIs to
> > avoid runq lock contention on wake up.  Someone encountered IPI
> > storms when using the TTWU_QUEUE feature, thus it defaults to off
> > for CONFIG_PREEMPT_RT_FULL:
> > 
> >   #ifndef CONFIG_PREEMPT_RT_FULL
> >   /*
> >    * Queue remote wakeups on the target CPU and process them
> >    * using the scheduler IPI. Reduces rq->lock contention/bounces.
> >    */
> >   SCHED_FEAT(TTWU_QUEUE, true)
> >   #else
> >   SCHED_FEAT(TTWU_QUEUE, false)
> > 
> 
> Interesting, but I'm wondering if this also does it for every wakeup? If
> you have 1000 tasks waking up on another CPU, this could potentially
> send out 1000 IPIs. The number of IPIs here looks to be # of tasks
> waking up, and perhaps more than that, as there could be multiple
> instances that try to wake up the same task.

Yeah.  In mainline, wakeup via IPI is disabled within a socket, because
it's too much of a performance hit for high frequency switchers.  (It
seems we're limited by the max rate at which we can IPI)

-Mike
