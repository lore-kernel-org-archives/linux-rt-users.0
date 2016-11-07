From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 21:06:50 +0100
Message-ID: <1e79f711-95f1-da2f-f572-1ac4329c8be7@bristot.me>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
 <alpine.DEB.2.20.1611071054320.17809@east.gentwo.org>
 <20161107133207.4282de69@gandalf.local.home>
 <alpine.DEB.2.20.1611071328470.19249@east.gentwo.org>
 <20161107144738.4811a5dd@gandalf.local.home>
 <alpine.DEB.2.20.1611071353440.19543@east.gentwo.org>
 <20161107150003.66777b43@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161107150003.66777b43@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/07/2016 09:00 PM, Steven Rostedt wrote:
> On Mon, 7 Nov 2016 13:54:12 -0600 (CST)
> Christoph Lameter <cl@linux.com> wrote:
> 
>> On Mon, 7 Nov 2016, Steven Rostedt wrote:
>>
>>> On Mon, 7 Nov 2016 13:30:15 -0600 (CST)
>>> Christoph Lameter <cl@linux.com> wrote:
>>>  
>>>> SCHED_RR tasks alternately running on on cpu can cause endless deferral of
>>>> kworker threads. With the global effect of the OS processing reserved
>>>> it may be the case that the processor we are executing never gets any
>>>> time. And if that kworker threads role is releasing a mutex (like the
>>>> cgroup_lock) then deadlocks can result.  
>>>
>>> I believe SCHED_RR tasks will still throttle if they use up too much of
>>> the CPU. But I still don't see how this patch helps your situation.  
>>
>> The kworker thread will be able to make progress? Or am I not reading this
>> correctly?
>>
> 
> If kworker is SCHED_OTHER, then it will be able to make progress if the
> RT tasks are throttled.
> 
> What Daniel's patch does, is to turn off throttling of the RT tasks if
> there's no other task on the run queue.


Here in the example of two spinning RR tasks (f-22466 & f-22473) and an
other task (o-22506):  
               f-22466 [002] d... 79045.641364: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=o next_pid=22506 next_prio=120
               o-22506 [002] d... 79045.690379: sched_switch: prev_comm=o prev_pid=22506 prev_prio=120 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79045.725359: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79045.825356: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79045.925350: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79046.025346: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79046.125346: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79046.225337: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79046.325333: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79046.425328: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79046.525324: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79046.625319: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79046.641320: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=o next_pid=22506 next_prio=120
               o-22506 [002] d... 79046.690335: sched_switch: prev_comm=o prev_pid=22506 prev_prio=120 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94

The throttling is per-rq, so even if the RR tasks keep switching
between each other, the throttling will take place if there is
any sched other task.

On Christoph's case, the other task will be the kworker, like bellow:

               f-22466 [002] d... 79294.430542: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79294.483539: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=kworker/2:1 next_pid=22198 next_prio=120
     kworker/2:1-22198 [002] d... 79294.483544: sched_switch: prev_comm=kworker/2:1 prev_pid=22198 prev_prio=120 prev_state=S ==> next_comm=f next_pid=22473 next_prio=94
               f-22473 [002] d... 79294.530537: sched_switch: prev_comm=f prev_pid=22473 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22466 next_prio=94
               f-22466 [002] d... 79294.630541: sched_switch: prev_comm=f prev_pid=22466 prev_prio=94 prev_state=R ==> next_comm=f next_pid=22473 next_prio=94

The throttling allowed the kworker to run, but once the kworker went to
sleep, the RT tasks started to work again. In the previous behavior,
the system would either go idle, or the kworker would starve because 
the runtime become infinity for RR tasks.

-- Daniel
