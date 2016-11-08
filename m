From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 20:50:15 +0100
Message-ID: <20161108195015.GP3117@twins.programming.kicks-ass.net>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <20161108115958.GO3142@twins.programming.kicks-ass.net>
 <20161108090740.4226ffc9@gandalf.local.home>
 <20161108165133.GI3117@twins.programming.kicks-ass.net>
 <20161108121710.3e7eb664@gandalf.local.home>
 <20161108180548.GN3117@twins.programming.kicks-ass.net>
 <f4095990-3fa0-ac2f-7277-3b8f0cdbc333@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f4095990-3fa0-ac2f-7277-3b8f0cdbc333@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Nov 08, 2016 at 08:29:49PM +0100, Daniel Bristot de Oliveira wrote:
> 
> 
> On 11/08/2016 07:05 PM, Peter Zijlstra wrote:
> >> > 
> >> > I know what we want to do, but there's some momentous problems that
> >> > need to be solved first.
> > Like what?
> 
> The problem is that using RT_RUNTIME_SHARE a CPU will almost always
> borrow enough runtime to make a CPU intensive rt task to run forever...
> well not forever, but until the system crash because a kworker starved
> in this CPU. Kworkers are sched fair by design and users do not always
> have a way to avoid them in an isolated CPU, for example.
> 
> The user then can disable RT_RUNTIME_SHARE, but then the user will have
> the CPU going idle for (period - runtime) at each period... throwing CPU
> time in the trash.

So why is this a problem? You really should not be running that much
FIFO tasks to begin with.

So I'm willing to take out (or at least default disable
RT_RUNTIME_SHARE). But other than this, this never really worked to
begin with. So it cannot be a regression. And we've lived this long with
the 'problem'.

And that means this is a 'feature' and that means I say no.

We really should be doing the right thing here, not make a bigger mess.
