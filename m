From: "Gregory Haskins" <ghaskins@novell.com>
Subject: Re: A question about cpu_idle()
Date: Thu, 22 Oct 2009 12:59:11 -0600
Message-ID: <4AE0733F0200005A00057289@sinclair.provo.novell.com>
References: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
 <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
 <a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>
 <4AE019210200005A00057226@sinclair.provo.novell.com>
 <a0e7fce50910220924s4b640cbi51af6d7e791e98e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Cc: <linux-rt-users@vger.kernel.org>
To: "yi li" <liyi.dev@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
In-Reply-To: <a0e7fce50910220924s4b640cbi51af6d7e791e98e9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>>> On 10/22/2009 at 12:24 PM, in message
<a0e7fce50910220924s4b640cbi51af6d7e791e98e9@mail.gmail.com>, yi li
<liyi.dev@gmail.com> wrote: 
> On Thu, Oct 22, 2009 at 8:34 PM, Gregory Haskins <ghaskins@novell.com> wrote:
>> Yes, that is right.  irq_disable is a effective superset of preempt-disable() 
> in this context because it also blocks those RESCHED_IPI events from being 
> received.  Of course, disabling interrupts also has other side effects since 
> it also disables *all* interrupts (like timers, etc) so it should be used 
> sparingly.  In this case, we are simply bridging the 
> preempt_enable_no_resched() and schedule() to make sure it is truly an atomic 
> transition to a sleep state, so its use is justified.
>>
>> I hope this helps, and feel free to ask any more questions you wish.
> 
> Thanks. Yes it make sense to me.
> 
> Another question may be basic - but I just cannot figure out.
> 
> Why PREEMPT_RT patch disables local irq (with local_irq_disable())
> before __schedule()?

Yes, but note that even mainline disables interrupts before doing a context switch.  It just does it in a different place within schedule() (see spin_lock_irq(rq->lock)).

I believe PREEMPT_RT introduces the non-irq disabled form of __schedule() so that it can be used in those no_sched() + schedule() instances that we already discussed.  The schedule() function then becomes a client of __schedule(), properly disabling interrupts first as is required

> Is it to ensure atomic excution of __schedule()?

Yes, atomic execution of the context switch is a requirement for both mainline and PREEMPT_RT, and thus interrupts must eventually be turned off as the registers are reloaded.

> If so, does that mean, linux kernel without PREEMPT_RT patch suffers
> from racy problem in schedule()?

No, mainline schedule() works just fine to my knowledge.  The issue is for the implementation of preempt_enable_no_resched() + schedule().  On a preemptible kernel (such as PREEMPT or PREEMPT_RT), you may have a narrow race w.r.t. a preemption point occurring between the time that preemption is enabled and we call schedule().  IOW: The code would still work fine even if we hit the race, but it results in suboptimal behavior.

What would happen is that the system may preempt the task, leave it on the RQ, run some other task, and then return control to this original task only to have it finish putting itself to sleep.  It is more efficient to just let it fully complete the deactivation than it would be to allow the one extra context switch, but it technically works either way.  Since RT is about reducing latency, and the scheduler itself is a source of latency, it is wise to eliminate any extraneous switches whenever possible.  However, this enhancement is technically applicable for CONFIG_PREEMPT mainline as well, afaict. 

Kind Regards,
-Greg


