From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH V2 3/3] sched/deadline: Tracepoints for deadline scheduler
Date: Tue, 29 Mar 2016 16:12:38 -0300
Message-ID: <56FAD3A6.20205@redhat.com>
References: <cover.1459182044.git.bristot@redhat.com>
 <14f6caa05f73ceba69eff035ac542cad671552b3.1459182044.git.bristot@redhat.com>
 <20160329151649.GA12845@twins.programming.kicks-ass.net>
 <56FAA8FA.5060407@redhat.com> <20160329131343.3b2bcf76@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Juri Lelli <juri.lelli@arm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54207 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753513AbcC2TMm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 15:12:42 -0400
In-Reply-To: <20160329131343.3b2bcf76@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 03/29/2016 02:13 PM, Steven Rostedt wrote:
>>           <idle>-0     [007] d..3 78377.688969: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=18973 next_prio=-1
>> >                b-18973 [007] d..3 78377.688979: sched_deadline_block: now=78377.688976271 deadline=78377.718945137 remaining_runtime=9968866
>> >                b-18973 [007] d..3 78377.688981: sched_switch: prev_comm=b prev_pid=18973 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120
> Why did it go to sleep? The above is still not very useful. What do you
> mean "blocking on a system call"?

A task can go can to sleep in a blocking system call, like waiting
a network packet, or any other external event.

The "block state" is a possible state of a task running in the deadline
scheduler. It means that a task voluntarily left the processor, not
by calling sched_yield(), but by blocking (or sleeping) waiting another
event.

This state is described in the Figure 2 of the article "Deadline
scheduling in the Linux kernel", available at:
http://onlinelibrary.wiley.com/doi/10.1002/spe.2335/abstract

The block state affects the replenishment of the task, and that is why
it is different of both yeild and throttle. If the task blocks and is
awakened prior to the deadline, the task's runtime will not be
replenished. On the other hand it will. For example:

Blocking, and then waking up after the deadline:
               b-5152  [007] d..3  3983.376428: sched_deadline_replenish: comm=b pid=5152 now=3983.376425148 deadline=3983.406425148 runtime=10000000
               b-5152  [007] d..3  3983.376515: sched_deadline_block: now=3983.376511101 deadline=3983.406425148 remaining_runtime=9909566
               b-5152  [007] d..3  3983.376529: sched_switch: prev_comm=b prev_pid=5152 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120

          <idle>-0     [007] d.h4  3983.476592: sched_deadline_replenish: comm=b pid=5152 now=3983.476589573 deadline=3983.506589573 runtime=10000000
          <idle>-0     [007] dNh4  3983.476596: sched_wakeup: comm=b pid=5152 prio=-1 target_cpu=007
          <idle>-0     [007] d..3  3983.476648: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=5152 next_prio=-1
               b-5152  [007] d..3  3983.476660: sched_deadline_block: now=3983.476656613 deadline=3983.506589573 remaining_runtime=9932960
               b-5152  [007] d..3  3983.476663: sched_switch: prev_comm=b prev_pid=5152 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120


Blocking, and then waking up before the deadline:
               b-5139  [007] d..3  3964.148290: sched_deadline_replenish: comm=b pid=5139 now=3964.148285227 deadline=3964.178285227 runtime=10000000
               b-5139  [007] d..3  3964.148396: sched_deadline_block: now=3964.148385308 deadline=3964.178285227 remaining_runtime=9895243
               b-5139  [007] d..3  3964.148400: sched_switch: prev_comm=b prev_pid=5139 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120

          <idle>-0     [007] dNh5  3964.148411: sched_wakeup: comm=b pid=5139 prio=-1 target_cpu=007
          <idle>-0     [007] d..3  3964.148419: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=b next_pid=5139 next_prio=-1
               b-5139  [007] d..3  3964.148427: sched_deadline_block: now=3964.148426022 deadline=3964.178285227 remaining_runtime=9878164
               b-5139  [007] d..3  3964.148429: sched_switch: prev_comm=b prev_pid=5139 prev_prio=-1 prev_state=S ==> next_comm=swapper/7 next_pid=0 next_prio=120

-- Daniel
