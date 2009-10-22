From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: A question about cpu_idle()
Date: Thu, 22 Oct 2009 06:34:41 -0600
Message-ID: <4AE019210200005A00057226@sinclair.provo.novell.com>
References: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
 <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
 <a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "yi li" <liyi.dev@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On 10/22/2009 at 12:30 AM, in message
<a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>, yi li
<liyi.dev@gmail.com> wrote: 
> On Wed, Oct 21, 2009 at 12:47 PM, Gregory Haskins <ghaskins@novell.com> wrote:
>>>>> On 10/20/2009 at 11:07 PM, in message
>> <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>, yi li
>> <liyi.dev@gmail.com> wrote:
>>> Hi RT users,
>>>
>>> While reading patch-2.6.31.4-rt14, there is a patch for cpu_idle()
>>> which I cannot understand.
>>>
>>> Could anyone kindly enough to tell me what is patch used for?
>>
>> Hi Yi,
>>
>> I believe that logic is ensuring that the task is put to sleep instead of 
> simply being preempted.  The difference is that a preemption leaves the task 
> on the RQ, whereas calling schedule() may or may not leave the caller on the 
> RQ, depending on the status of current->state.  The 
> local_irq_disable+__preempt_enable_no_resched dance is a way of legally 
> calling schedule() while effectively preventing preemption (since 
> interrupts-off also disables preemption).  The difference is that its legal 
> to call __schedule() with interrupts off, but you can't with 
> preempt_disable().
>>
>> Long story short, the enable_no_resched() + schedule() pattern is only ever 
> used when you want to make sure the task fully sleeps.  However without this 
> patch to disable interrupts, the original code appears racy and thus probably 
> had issues achieving its intended goal.
>>
>> HTH,
>> -Greg
>>
> 
> Thanks Greg for the kind reply.
> 
> But due to my limited knowledge on PREEMPT_RT, I still not fully understand.
> 
> Given schedule() is defined as:
> 
> asmlinkage void __sched schedule(void)
> {
> need_resched:
> 	local_irq_disable();
> 	__schedule();
> 	local_irq_enable();
> 
> 	if (need_resched())
> 		goto need_resched;
> }
> 
> Comparing bellow two code sequences:
> 
> 1)
> preempt_enable_no_resched();
> schedule();
> preempt_disable();
> 
> 
> 2)
> local_irq_disable();
> __preempt_enable_no_resched();
> __schedule();
> preempt_disable();
> local_irq_enable();
> 
> It seems to me, the main difference is to change the order of
> "preempt_enable_no_sched() / local_irq_disable()":
> i.e, from:
> 
> "preempt_enable_no_sched();
> /* Yi: will some race condition happens here? */

This is exactly right.  In a preemptible kernel (which includes standard mainline PREEMPT as well as PREEMPT_RT) we technically may preempt at this point.  Normally a preempt_enable() will induce a type of "voluntary" preemption point when the preempt-disable count goes to zero.  The "no_sched()" variant disables this voluntary reschedule, but it does nothing to prevent an _involuntary_ preemption (such as a RESCHEDULE interprocessor-interrupt (IPI) sent from another core).

>  local_irq_disable();
> __schedule();"
> 
> to:
> 
> "local_irq_disable(); /* Yi: disables irq effectively disables preemption?

Yes, that is right.  irq_disable is a effective superset of preempt-disable() in this context because it also blocks those RESCHED_IPI events from being received.  Of course, disabling interrupts also has other side effects since it also disables *all* interrupts (like timers, etc) so it should be used sparingly.  In this case, we are simply bridging the preempt_enable_no_resched() and schedule() to make sure it is truly an atomic transition to a sleep state, so its use is justified.

I hope this helps, and feel free to ask any more questions you wish.
-Greg
 
> */
> preempt_enable_no_sched();
> __schedule();"
> 
> Regards,
> -Yi
> 
>>>
>>>
>>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
>>> index ebefb54..c8d0ece 100644
>>> --- a/arch/x86/kernel/process_64.c
>>> +++ b/arch/x86/kernel/process_64.c
>>> @@ -152,9 +152,11 @@ void cpu_idle(void)
>>>                 }
>>>
>>>                 tick_nohz_restart_sched_tick();
>>> -               preempt_enable_no_resched();
>>> -               schedule();
>>> +               local_irq_disable();
>>> +               __preempt_enable_no_resched();
>>> +               __schedule();
>>>                 preempt_disable();
>>> +               local_irq_enable();
>>>         }
>>>  }
>>>
>>> Regards,
>>> -Yi
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>>


