From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: Regarding interrupt task latency
Date: Fri, 24 Sep 2010 22:36:50 -0600
Message-ID: <4C9D44220200005A00072B8A@soto.provo.novell.com>
References: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
 <4C9BB2F80200005A00072A37@soto.provo.novell.com>
 <AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
 <4C9D025D0200005A00072B6D@soto.provo.novell.com>
 <AANLkTi=dg=i2CM7PNS4ALboT4p08iB1Dq_faLOT7AKm9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: "Linux-rt-users" <linux-rt-users@vger.kernel.org>
To: "Sri Ram Vemulpali" <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=dg=i2CM7PNS4ALboT4p08iB1Dq_faLOT7AKm9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On 9/24/2010 at 08:57 PM, in message
<AANLkTi=dg=i2CM7PNS4ALboT4p08iB1Dq_faLOT7AKm9@mail.gmail.com>, Sri Ram
Vemulpali <sri.ram.gmu06@gmail.com> wrote: 
> Hi Gregory,
> 
>    Thanks for clarification. I got it.
> 
>  So, the reason for checking in the locks whether need_resched is set,
> to call schedule and other "low latency patch" which checks need_resch
> after few lines of code execution, is to eliminate task latency.

One thing to note is that the kernel supports various configurable preemption modes (NONE, VOLUNTARY, PREEMPT, etc).  Some of the checks you may be finding are presumably related to the VOLUNTARY mode and are not strictly necessary in PREEMPT/PREEMPT_RT modes.  Likewise, others are indeed needed for both VOLUNTARY and PREEMPT/PREEMPT_RT modes..more details below.

> 
> 
>> Likewise, if the irq-thread is suddenly _not_ the highest priority, it will 
> be preempted ASAP.  This will happen either immediately as soon as the higher 
> task enters RUNNING, or "at the conclusion of any critical section that the 
> irq-thread may have entered".  Since -rt eliminates most critical sections 
> (and makes the few that remain very short), this usually means the former.
> 
> What is that situation where higher priority task needs to wait until
> some critical section is executed.

You cannot run the scheduler if the cpu is in atomic context, period.  Consider what would happen if you preempted the scheduler with the scheduler. ;) Complete chaos.  So if you wake up a task and the cpu has preemption disabled, the task has to wait until preemption is re-enabled no matter how important the task actually is w.r.t. the currently running task.

> So, at the end schedule is called.
> Can you please clarify such a case, because
> when high priority task is in RUNNING mode it is immediately executed.

No, not always.  Consider the following single core example (with prio 60 higher than 50):

thread X (prio 50)           interrupt                thread Y (prio 60)
-------------------------------------------------------
/* work */
/* work */
/* work */
preempt_disable()
/* crit work */
/* crit work */
                                       wakeup(Y)
                                          (check in_atomic())
                                            set(NEEDS_RESCHED)
/* crit work */
/* crit work */
/* crit work */
preempt_enable()
  check(NEEDS_RESCHED)
  schedule(Y)
  (X is preempted)
                                                                    /* work */
                                                                    /* etc.... */

--------------------------------------------------------

In this scenario, both X and Y are concurrently in RUNNING state, yet X will remain on the CPU despite its lower priority rating until its final preempt_disable() critical section completes.  At the conclusion of this critical section, we check to see if anything (like the wakeup(Y)) occurred and will reschedule if necessary (i.e. if anything set the NEEDS_RESCHED flag).

Had X _not_ been in a critical section when the interrupt -> wakup(Y) came in, the scheduler would have involuntarily preempted X at the conclusion of the ISR.  The bottom line is that it is imperative that we employ both mechanisms (involuntary preempt as well as carefully placed voluntary checks) in order to operate properly.

The rub is that PREEMPT_RT gets rid of almost all of the implicit preempt_disable()/preempt_enable() sections in most code paths, leaving only the ones that truly are not preemptible (such as the scheduler code itself, or modes which deviate from process context (such as hard-isrs, traps, etc).  Therefore, the probability that you find something set NEEDS_RESCHED underneath you is low.  However, that doesn't mean we don't have to bother checking, either ;)

Let me know if that is still not clear.

Kind Regards,
-Greg

> So, I do not see any use of checking for to schedule at the end of
> critical section.
> 
> Correct me if I am wrong. Thanks.
> 
> Regards,
> Sri.
> 
> 
> 
> 
> 
> On Fri, Sep 24, 2010 at 7:56 PM, Gregory Haskins <ghaskins@novell.com> wrote:
>> Hi Sri,
>>
>>>>> On 9/24/2010 at 12:42 AM, in message
>> <AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>, Sri Ram
>> Vemulpali <sri.ram.gmu06@gmail.com> wrote:
>>> Hi Gregory,
>>>
>>>   Thanks for the explanation. I got a grasp of what you said.
>>>
>>>   So, the whole preempt rt is made preemptible, even in the interrupt
>>> context.
>>>   the IRQ now executes as thread, so that it can be preempted.
>>>
>>>   Now the question is, usually this interrupt task latency
>>
>> Can you be more specific as to which interrupt task latency you are 
> referring to?
>>
>>> occurs when
>>> IRQ thread finishes
>>>   and sets need_resch. So this is checked in the locks, so that long
>>> critical section
>>>   determines when to schedule, which is non-deterministic.
>>>
>>>   why do not we eliminate this by calling schedule immediately after
>>> IRQ thread context.
>>
>> I think there is some confusion here.  The "after" in any thread context is 
> already a schedule(), so I am not clear on what you are proposing we need to 
> eliminate.
>>
>> If the irq-thread is the highest priority task, it will run to completion 
> and then naturally schedule() as part of its "sleep" logic (such as joining a 
> wait-queue).  The scheduler will immediately elect the next highest RUNNING 
> task (or idle, if none are available) as a result of the irq-thread going to 
> sleep (there is no latency here, assuming you correctly prioritized the 
> threads).
>>
>> Likewise, if the irq-thread is suddenly _not_ the highest priority, it will 
> be preempted ASAP.  This will happen either immediately as soon as the higher 
> task enters RUNNING, or at the conclusion of any critical section that the 
> irq-thread may have entered.  Since -rt eliminates most critical sections 
> (and makes the few that remain very short), this usually means the former.
>>
>>>   I think there can be a solution. If such solution exists we will not
>>> have two kinds of patches
>>>   "low latency" and "preempt" patches of RT.
>>>
>>>   Can you please explain, is there any reason or bottle neck to
>>> implement solution to call schedule
>>>   immediately after IRQ thread context.
>>
>> I assert we already _do_.  If you think otherwise, please clarify the 
> scenario that concerns you.
>>
>> Kind Regards,
>> -Greg
>>
>>
>>
> 
> 
> 
> -- 
> Regards,
> Sri.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


