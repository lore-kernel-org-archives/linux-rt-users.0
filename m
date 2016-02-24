From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 3/4] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 23 Feb 2016 23:29:13 -0300
Message-ID: <56CD1579.2070300@redhat.com>
References: <cover.1456157869.git.bristot@redhat.com>
 <f3b54958f216d36be59363815a3d75a0636cda8b.1456157869.git.bristot@redhat.com>
 <20160222173259.GM6357@twins.programming.kicks-ass.net>
 <20160222124854.3816fec4@gandalf.local.home>
 <20160222213017.GN6357@twins.programming.kicks-ass.net>
 <20160222173043.24873ae8@gandalf.local.home>
 <20160223104408.GO6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160223104408.GO6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 02/23/2016 07:44 AM, Peter Zijlstra wrote:
> Now ideally we'd do something like the below, but because trainwreck, we
> cannot actually do this I think :-(

Some other considerations:

1) The majority of tasks run on NORMAL scheduler with default nice. So,
prev=NORMAL:{0,0,0} and next=NORMAL:{0,0,0} does not help too much.
The tracepoint size increase from 64 to 112, but this difference will not
be useful for the majority of the user/use-cases.

2) The sched:switch can be wider than this 212 characters output:
"              m-1604  [004] d...  1940.393070: sched_switch: prev_comm=m prev_pid=1604 prev=DEADLINE:{-967616,1940402119572,30000000} prev_state=Rt ==> next_comm=kworker/4:2H next_pid=1507 next=NORMAL:{-20,0,0}"

3) On the other tracepoints, rostedt suggested me to also include the
now= field because the clock printed in the trace prefix is
not the same clock used by the deadline scheduler.

4) Although neither perf record/script nor trace-cmd record/report broke,
both printed only the old fields. So, both would need to be updated and
carry both the old and the new version.

Well, I bet there will be many other applications that were not well
written as perf and trace-cmd :-(

5) A new scheduler will probably require modifications on this
tracepoint, hence on all other tools that use this tracepoint too.

6) I liked all the code to compose the output string! But it is not
fair to say that the "format" is intuitive. One may need to put the
finger in the monitor and use a calculator to see that the filter
for a yielded tasks is "prev_state == 8192".

Btw, it only works for deadline task yield, and the yield call of all
other classes will need to be changed to support this. The question
is, is it worth for other classes?

7) This patch is currently showing the runtime zeroed on yield.
So, it needs the clean up on yield_task_dl() to properly
inform the unused runtime of the task's activation.

More than it, to be precise, it must push the zeroing of the
runtime of an yielded task to the replenishment code. Your
patch for the sched yield already do it :-) but once there,
the zeroing can't be moved back without break this
tracepoint :-(.

8) we still need to define a tracepoint for replenishment, but
as it takes place on the following points:

a) sched_setattr()
b) periodic replenishment
c) on the wakeup after a blocking.

There is no a "single tracepoint" already available to "attach" this
information. So seems the replenishment tracepoint is still needed.

Moreover, although other scheduler may have this concept, I am
not sure if they take place under the same conditions.

So, AFAICS, this integrate approach is neither adding more information,
nor preventing ABI problems now and possibly in the future.

On the other hand, although a per-scheduler approach would increase
the number of tracepoints, the tracepoints tends to be simpler, confined
to the scheduler's .c and more coherent to the scheduler's abstractions.

I fear that the mix of the deadline scheduler and other schedulers
information, and the adaptation on other tracepoints to make the deadline
scheduler points of interest fit on current tracepoints, would add
undesired noise/imprecision on the interpretation of the sched deadline
actions/abstractions :-(.

-- Daniel
