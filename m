From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to
 check_dl_overrun
Date: Wed, 7 Nov 2018 11:31:06 -0500
Message-ID: <20181107113106.475914e1@gandalf.local.home>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
        <20181107095627.13e9c187@gandalf.local.home>
        <20181107150221.GJ9761@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        bristot@redhat.com, linux-rt-users@vger.kernel.org,
        mtk.manpages@gmail.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107150221.GJ9761@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 7 Nov 2018 16:02:21 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 07, 2018 at 09:56:27AM -0500, Steven Rostedt wrote:
> > On Wed,  7 Nov 2018 12:10:32 +0100
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> >   
> > > check_dl_overrun is used to send a SIGXCPU to users that asked to be
> > > informed when SCHED_DEADLINE runtime overruns occur.
> > > 
> > > The function is called by check_thread_timers already, so the call in
> > > check_process_timers is redundant/wrong (even though harmless).
> > > 
> > > Remove it.
> > > 
> > > Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
> > > Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Luca Abeni <luca.abeni@santannapisa.it>
> > > Cc: Claudio Scordino <claudio@evidence.eu.com>
> > > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > ---
> > >  kernel/time/posix-cpu-timers.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > > 
> > > diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> > > index ce32cf741b25..8f0644af40be 100644
> > > --- a/kernel/time/posix-cpu-timers.c
> > > +++ b/kernel/time/posix-cpu-timers.c
> > > @@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
> > >  	struct task_cputime cputime;
> > >  	unsigned long soft;
> > >  
> > > -	if (dl_task(tsk))
> > > -		check_dl_overrun(tsk);
> > > -  
> > 
> > Hmm, I wonder if we should just move this check directly into
> > run_posix_cpu_timers() directly. Why is it hidden in this call?  
> 
> It is not; it is duplicated in this call. The one in
> check_thread_timeres() makes sense (it is a thread property).

OK, in that case.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
