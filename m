From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 13:30:15 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com> <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org> <20161107133207.4282de69@gandalf.local.home>
Content-Type: text/plain; charset=US-ASCII
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107133207.4282de69@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 7 Nov 2016, Steven Rostedt wrote:

> On Mon, 7 Nov 2016 10:55:38 -0600 (CST)
> Christoph Lameter <cl@linux.com> wrote:
>
> > On Mon, 7 Nov 2016, Daniel Bristot de Oliveira wrote:
> >
> > > With these two options set, the user will guarantee some runtime
> > > for non-rt-tasks on all CPUs, while keeping real-time tasks running
> > > as much as possible.
> >
> > Excellent this would improve the situation with deadlocks as a result of
> > cgroup_locks not being released due to lack of workqueue processing.
>
> ?? What deadlocks do you see? I mean, can you show the situation that
> throttling RT tasks will cause deadlock?
>
> Sorry, but I'm just not seeing it.

SCHED_RR tasks alternately running on on cpu can cause endless deferral of
kworker threads. With the global effect of the OS processing reserved
it may be the case that the processor we are executing never gets any
time. And if that kworker threads role is releasing a mutex (like the
cgroup_lock) then deadlocks can result.
