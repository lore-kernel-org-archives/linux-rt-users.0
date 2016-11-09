From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Wed, 9 Nov 2016 14:33:55 +0100
Message-ID: <8a80c2c2-3803-5648-67b2-4dee7381d5a6@redhat.com>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <20161108115958.GO3142@twins.programming.kicks-ass.net>
 <20161108090740.4226ffc9@gandalf.local.home>
 <20161108165133.GI3117@twins.programming.kicks-ass.net>
 <20161108121710.3e7eb664@gandalf.local.home>
 <20161108180548.GN3117@twins.programming.kicks-ass.net>
 <f4095990-3fa0-ac2f-7277-3b8f0cdbc333@redhat.com>
 <20161108195015.GP3117@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
To: Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108195015.GP3117@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/08/2016 08:50 PM, Peter Zijlstra wrote:
>> The problem is that using RT_RUNTIME_SHARE a CPU will almost always
>> > borrow enough runtime to make a CPU intensive rt task to run forever...
>> > well not forever, but until the system crash because a kworker starved
>> > in this CPU. Kworkers are sched fair by design and users do not always
>> > have a way to avoid them in an isolated CPU, for example.
>> > 
>> > The user then can disable RT_RUNTIME_SHARE, but then the user will have
>> > the CPU going idle for (period - runtime) at each period... throwing CPU
>> > time in the trash.
> So why is this a problem? You really should not be running that much
> FIFO tasks to begin with.

I agree that a spinning real-time task is not a good practice, but there
are people using it and they have their own reasons/metrics/evaluations
motivating them.

> So I'm willing to take out (or at least default disable
> RT_RUNTIME_SHARE). But other than this, this never really worked to
> begin with. So it cannot be a regression. And we've lived this long with
> the 'problem'.

I agree! It would work perfectly in the absence of tasks pinned to a
processor, but that is not the case.

Trying to attend the users that want as much CPU time for -rt tasks as
possible, the proposed patch seems to be a better solution when compared
to RT_RUNTIME_SHARE, and it is way simpler! Even though it is not as
perfect as a DL Server would be in the future, it seems to be useful
until there...

> We really should be doing the right thing here, not make a bigger mess.

I see, agree and I am anxious to have it! :-). Tommaso and I discussed
about DL servers implementing such rt throttling. The more complicated
point so far (as Rostedt pointed on another e-mail) will be to have DL
servers with arbitrary affinity, or serving task with arbitrary
affinity. For example, one DL server pinned to each CPU providing
bandwidth for fair tasks to run for (rt_period - rt_runtime)us at each
rt_period... it will take sometime until someone propose it.

-- Daniel
