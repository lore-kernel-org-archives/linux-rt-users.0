From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] sched/deadline: runtime overrun signal
Date: Tue, 19 Dec 2017 20:32:32 +0100
Message-ID: <20171219193232.gxkwvtz7f4gj7ffz@hirez.programming.kicks-ass.net>
References: <1513077024-25461-1-git-send-email-claudio@evidence.eu.com>
 <20171212115040.iffj4plu3iow7qoi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Juri Lelli <juri.lelli@gmail.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171212115040.iffj4plu3iow7qoi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Dec 12, 2017 at 12:50:40PM +0100, Ingo Molnar wrote:
> 
> * Claudio Scordino <claudio@evidence.eu.com> wrote:
> 
> > From: Juri Lelli <juri.lelli@gmail.com>
> 
> > -		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM))
> > +		~(SCHED_FLAG_RESET_ON_FORK | SCHED_FLAG_RECLAIM |
> > +			SCHED_FLAG_DL_OVERRUN))

Introduced SCHED_FLAG_ALL for this

> 
> > +		if (dl_runtime_exceeded(dl_se) &&
> > +				(dl_se->flags & SCHED_FLAG_DL_OVERRUN))

realigned this one

> 
> > +		pr_info("runtime overrun: %s[%d]\n",
> > +				tsk->comm, task_pid_nr(tsk));

And simply took this out, you asked for it, no reason to tell world
about getting one.
