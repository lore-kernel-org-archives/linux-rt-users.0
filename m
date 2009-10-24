From: yi li <liyi.dev@gmail.com>
Subject: Re: A question about cpu_idle()
Date: Sat, 24 Oct 2009 18:04:00 +0800
Message-ID: <a0e7fce50910240304o43b43b91qe109cffed3cdd966@mail.gmail.com>
References: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
	 <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
	 <a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>
	 <4AE019210200005A00057226@sinclair.provo.novell.com>
	 <a0e7fce50910220924s4b640cbi51af6d7e791e98e9@mail.gmail.com>
	 <4AE0733F0200005A00057289@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:47793 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZJXKD4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Oct 2009 06:03:56 -0400
Received: by ywh40 with SMTP id 40so7103087ywh.33
        for <linux-rt-users@vger.kernel.org>; Sat, 24 Oct 2009 03:04:00 -0700 (PDT)
In-Reply-To: <4AE0733F0200005A00057289@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Oct 23, 2009 at 2:59 AM, Gregory Haskins <ghaskins@novell.com> =
wrote:
>>>> On 10/22/2009 at 12:24 PM, in message
> <a0e7fce50910220924s4b640cbi51af6d7e791e98e9@mail.gmail.com>, yi li
> <liyi.dev@gmail.com> wrote:
>> On Thu, Oct 22, 2009 at 8:34 PM, Gregory Haskins <ghaskins@novell.co=
m> wrote:
>>> Yes, that is right. =A0irq_disable is a effective superset of preem=
pt-disable()
>> in this context because it also blocks those RESCHED_IPI events from=
 being
>> received. =A0Of course, disabling interrupts also has other side eff=
ects since
>> it also disables *all* interrupts (like timers, etc) so it should be=
 used
>> sparingly. =A0In this case, we are simply bridging the
>> preempt_enable_no_resched() and schedule() to make sure it is truly =
an atomic
>> transition to a sleep state, so its use is justified.
>>>
>>> I hope this helps, and feel free to ask any more questions you wish=
=2E
>>
>> Thanks. Yes it make sense to me.
>>
>> Another question may be basic - but I just cannot figure out.
>>
>> Why PREEMPT_RT patch disables local irq (with local_irq_disable())
>> before __schedule()?
>
> Yes, but note that even mainline disables interrupts before doing a c=
ontext switch. =A0It just does it in a different place within schedule(=
) (see spin_lock_irq(rq->lock)).
>
> I believe PREEMPT_RT introduces the non-irq disabled form of __schedu=
le() so that it can be used in those no_sched() + schedule() instances =
that we already discussed. =A0The schedule() function then becomes a cl=
ient of __schedule(), properly disabling interrupts first as is require=
d
>
>> Is it to ensure atomic excution of __schedule()?
>
> Yes, atomic execution of the context switch is a requirement for both=
 mainline and PREEMPT_RT, and thus interrupts must eventually be turned=
 off as the registers are reloaded.
>
>> If so, does that mean, linux kernel without PREEMPT_RT patch suffers
>> from racy problem in schedule()?
>
> No, mainline schedule() works just fine to my knowledge. =A0The issue=
 is for the implementation of preempt_enable_no_resched() + schedule().=
 =A0On a preemptible kernel (such as PREEMPT or PREEMPT_RT), you may ha=
ve a narrow race w.r.t. a preemption point occurring between the time t=
hat preemption is enabled and we call schedule(). =A0IOW: The code woul=
d still work fine even if we hit the race, but it results in suboptimal=
 behavior.
>
> What would happen is that the system may preempt the task, leave it o=
n the RQ, run some other task, and then return control to this original=
 task only to have it finish putting itself to sleep. =A0It is more eff=
icient to just let it fully complete the deactivation than it would be =
to allow the one extra context switch, but it technically works either =
way. =A0Since RT is about reducing latency, and the scheduler itself is=
 a source of latency, it is wise to eliminate any extraneous switches w=
henever possible. =A0However, this enhancement is technically applicabl=
e for CONFIG_PREEMPT mainline as well, afaict.
>
> Kind Regards,
> -Greg
>
Thanks Greg. This makes sense to me. I appreciate your explanation.

-Yi
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
