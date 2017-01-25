From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] x86/mm/cpa: avoid wbinvd() for PREEMPT_RT_FULL
Date: Wed, 25 Jan 2017 17:12:17 +0100
Message-ID: <20170125161217.k6h5weu34i2knl3f@linutronix.de>
References: <87o9z1ic9a.fsf@linutronix.de>
 <20170121141915.GT6485@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Ogness <john.ogness@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170121141915.GT6485@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-01-21 15:19:15 [+0100], Peter Zijlstra wrote:
> On Fri, Jan 20, 2017 at 11:42:57PM +0100, John Ogness wrote:
> > Although wbinvd() is faster than flushing many individual pages, it
> > blocks the memory bus for "long" periods of time (>100us), thus
> > directly causing unusually large latencies for PREEMPT_RT_FULL. For
> > 1024 pages, flushing those pages individually can take up to 2200us,
> > but the task remains fully preemptible during that time.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  arch/x86/mm/pageattr.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> > index e3353c9..a182477 100644
> > --- a/arch/x86/mm/pageattr.c
> > +++ b/arch/x86/mm/pageattr.c
> > @@ -214,7 +214,12 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
> >  			    int in_flags, struct page **pages)
> >  {
> >  	unsigned int i, level;
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +	/* wbinvd() causes ugly latencies, avoid it */
> > +	unsigned long do_wbinvd = 0;
> 
> Arguably we should do the same for CONFIG_PREEMPT and possibly even
> always, esp. when considering CAT.

So you want to see this patch again with CONFIG_PREEMPT instead of
CONFIG_PREEMPT_RT_FULL and also targeting lkml?
I don't get quite the link between wbindv and CAT (assuming it stands
for Intel's Cache Allocation support). But if you want unconditionally
want to drop that wbinvd because it is bad for another !RT usecase, fine
by me :)
Any preferences from the x86 folks?

Sebastian
