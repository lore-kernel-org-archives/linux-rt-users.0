From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 12:17:10 -0500
Message-ID: <20161108121710.3e7eb664@gandalf.local.home>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
        <20161108115958.GO3142@twins.programming.kicks-ass.net>
        <20161108090740.4226ffc9@gandalf.local.home>
        <20161108165133.GI3117@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108165133.GI3117@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 8 Nov 2016 17:51:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> You really should already know this.

I know what we want to do, but there's some momentous problems that
need to be solved first. Until then, we may be forced to continue with
hacks.

> 
> As stands the current rt cgroup code (and all this throttling code) is a
> giant mess (as in, its not actually correct from a RT pov). We should
> not make it worse by adding random hacks to it.
> 
> The right way to to about doing this is by replacing it with something
> better; like the proposed DL server for FIFO tasks -- which is entirely
> non-trivial as well, see existing discussion on that.

Right. The biggest issue that I see is how to assign affinities to
FIFO tasks and use a DL server to keep them from starving other tasks?

> 
> I'm not entirely sure what this patch was supposed to fix, but it could
> be running CFS tasks with higher priority than RT for a window, instead

I'm a bit confused with the above sentence. Do you mean that this patch
causes CFS tasks to run for a period with a higher priority than RT?
Well, currently we have the both CFS tasks and the "idle" task run
higher than RT, but this patch changes that to be just CFS tasks.

> of throttling RT tasks. This seems fairly ill specified, but something
> like that could easily done with an explicit or slack time DL server for
> CFS tasks.

If we can have a DL scheduler that can handle arbitrary affinities,
then all could be solved with that.

-- Steve
