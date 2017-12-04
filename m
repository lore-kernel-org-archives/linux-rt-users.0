From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: Do not pull from current CPU if only one cpu
 to pull
Date: Mon, 4 Dec 2017 04:55:59 -0500
Message-ID: <20171204045559.190f707b@vmware.local.home>
References: <20171202130454.4cbbfe8d@vmware.local.home>
        <20171204074517.GA26712@localhost.localdomain>
        <20171204030916.0cf09b0f@vmware.local.home>
        <20171204090757.GB26712@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Juri Lelli <juri.lelli@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171204090757.GB26712@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 4 Dec 2017 10:07:57 +0100
Juri Lelli <juri.lelli@redhat.com> wrote:

> On 04/12/17 03:09, Steven Rostedt wrote:
> > On Mon, 4 Dec 2017 08:45:17 +0100
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> >   
> > > Right. I was wondering however if for the truly UP case we shouldn't be
> > > initiating/queueing callbacks (pull/push) at all?  
> > 
> > If !CONFIG_SMP then it's not compiled in. The issue came up when Daniel
> > ran a CONFIG_SMP kernel on an arch that only supports UP.
> >   
> 
> Right, sorry. I meant num_online_cpus() == 1.
>

Correct. But we need to disable the push/pull when CPUs go down to 1,
or if we see "num_possible_cpus() == 1" at boot up. It woulld need
to be re-enabled when CPUs are onlined and count goes greater than
one. Which we could also add, and I started going that route first. My
first patch had that check at each push/pull, but num_online_cpus() is
a weight of the cpumask, and for machines with more than 64 CPUs,
calculating that number becomes a bigger task and we want to keep that
out of the scheduler fast path, which push/pull logic happens to be in.

When looking at changing this code, I realized that rt_overloaded()
returns the count of overloaded CPUs, and the check to see if the
current CPU is overloaded is a single bit check of a cpumask (all very
quick). This not only fixes the issue with what Daniel found, but also
can help in certain cases on large CPU count machines.

-- Steve
