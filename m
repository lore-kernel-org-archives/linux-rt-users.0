From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Tue, 8 Nov 2016 20:29:49 +0100
Message-ID: <f4095990-3fa0-ac2f-7277-3b8f0cdbc333@redhat.com>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <20161108115958.GO3142@twins.programming.kicks-ass.net>
 <20161108090740.4226ffc9@gandalf.local.home>
 <20161108165133.GI3117@twins.programming.kicks-ass.net>
 <20161108121710.3e7eb664@gandalf.local.home>
 <20161108180548.GN3117@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Tommaso Cucinotta <tommaso.cucinotta@sssup.it>
To: Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108180548.GN3117@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/08/2016 07:05 PM, Peter Zijlstra wrote:
>> > 
>> > I know what we want to do, but there's some momentous problems that
>> > need to be solved first.
> Like what?

The problem is that using RT_RUNTIME_SHARE a CPU will almost always
borrow enough runtime to make a CPU intensive rt task to run forever...
well not forever, but until the system crash because a kworker starved
in this CPU. Kworkers are sched fair by design and users do not always
have a way to avoid them in an isolated CPU, for example.

The user then can disable RT_RUNTIME_SHARE, but then the user will have
the CPU going idle for (period - runtime) at each period... throwing CPU
time in the trash.

>> > Until then, we may be forced to continue with
>> > hacks.
> Well, the more ill specified hacks we put in, the harder if will be to
> replace because people will end up depending on it.

The proposed patch seems to be the expected behavior for users/rt
throttling - they want a safeguard for fair tasks while allowing -rt
tasks to run as much as possible.

I see (and completely agree) that a DL server for fair/rt task would be
the best way to deal with this problem, but it will take some time until
such solution :-(. We even discussed this at Retis today, but yeah, it
will take sometime even in the best case.

(thinking aloud... a DL Server would react like the proposed patch, in
the sense that it would not be activated without tasks to run and would
return the CPU for other tasks if the tasks inside the server finish
their job before the end of the DL server runtime...)

-- Daniel
