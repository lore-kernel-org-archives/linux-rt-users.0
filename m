From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: allow preemption in check_task_state
Date: Mon, 10 Feb 2014 19:13:00 +0100
Message-ID: <20140210181300.GB17914@opentech.at>
References: <20140210153856.GD20017@opentech.at> <20140210111106.67438d1e@gandalf.local.home> <20140210171712.GA17517@opentech.at> <20140210125245.1afc834d@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140210125245.1afc834d@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 10 Feb 2014, Steven Rostedt wrote:

> On Mon, 10 Feb 2014 18:17:12 +0100
> Nicholas Mc Guire <der.herr@hofr.at> wrote:
> 
> 
> > > 
> > > In rtmutex.c we have:
> > > 
> > > 	pi_lock(&self->pi_lock);
> > > 	__set_current_state(self->saved_state);
> > > 	self->saved_state = TASK_RUNNING;
> > > 	pi_unlock(&self->pi_lock);
> > > 
> > > As there is no wmb() here, it can be very possible that another CPU
> > > will see saved_state as TASK_RUNNING, and current state as
> > > TASK_RUNNING, and miss the update completely.
> > > 
> > > I would not want to add a wmb() unless there is a real bug with the
> > > check state, as the above is in a very fast path and the check state is
> > > in a slower path.
> > >
> > maybe I'm missing/missunderstanding something here but
> > pi_unlock -> arch_spin_unlock is a full mb() 
> > so once any task did an update of the state the loop should be catching
> > this update ? if the loop exits before the updat takes effect (pi_unlock)
> > would that be ncorrect ?
> 
> Even if the spin locks were full memory barriers, it is still buggy.
> The fact that we set current_state to saved_state, and then saved_state
> to TASK_RUNNING without any memory barriers in between those two
> statements, means that the reader (even with a rmb()) can still see
> both as TASK_RUNNING.
>
ok - thanks - I think now I got it.

thx!
hofrat 
