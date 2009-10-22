From: yi li <liyi.dev@gmail.com>
Subject: Re: A question about cpu_idle()
Date: Thu, 22 Oct 2009 12:30:06 +0800
Message-ID: <a0e7fce50910212130h385cdbe1ucbb4fe00233eb0bb@mail.gmail.com>
References: <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>
	 <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yw0-f202.google.com ([209.85.211.202]:64198 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbZJVEaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2009 00:30:03 -0400
Received: by ywh40 with SMTP id 40so5155891ywh.33
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Oct 2009 21:30:06 -0700 (PDT)
In-Reply-To: <4ADE5A2B0200005A00057082@sinclair.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Oct 21, 2009 at 12:47 PM, Gregory Haskins <ghaskins@novell.com>=
 wrote:
>>>> On 10/20/2009 at 11:07 PM, in message
> <a0e7fce50910202007l587d2cfcu91b455ff0486110b@mail.gmail.com>, yi li
> <liyi.dev@gmail.com> wrote:
>> Hi RT users,
>>
>> While reading patch-2.6.31.4-rt14, there is a patch for cpu_idle()
>> which I cannot understand.
>>
>> Could anyone kindly enough to tell me what is patch used for?
>
> Hi Yi,
>
> I believe that logic is ensuring that the task is put to sleep instea=
d of simply being preempted. =A0The difference is that a preemption lea=
ves the task on the RQ, whereas calling schedule() may or may not leave=
 the caller on the RQ, depending on the status of current->state. =A0Th=
e local_irq_disable+__preempt_enable_no_resched dance is a way of legal=
ly calling schedule() while effectively preventing preemption (since in=
terrupts-off also disables preemption). =A0The difference is that its l=
egal to call __schedule() with interrupts off, but you can't with preem=
pt_disable().
>
> Long story short, the enable_no_resched() + schedule() pattern is onl=
y ever used when you want to make sure the task fully sleeps. =A0Howeve=
r without this patch to disable interrupts, the original code appears r=
acy and thus probably had issues achieving its intended goal.
>
> HTH,
> -Greg
>

Thanks Greg for the kind reply.

But due to my limited knowledge on PREEMPT_RT, I still not fully unders=
tand.

Given schedule() is defined as:

asmlinkage void __sched schedule(void)
{
need_resched:
	local_irq_disable();
	__schedule();
	local_irq_enable();

	if (need_resched())
		goto need_resched;
}

Comparing bellow two code sequences:

1)
preempt_enable_no_resched();
schedule();
preempt_disable();


2)
local_irq_disable();
__preempt_enable_no_resched();
__schedule();
preempt_disable();
local_irq_enable();

It seems to me, the main difference is to change the order of
"preempt_enable_no_sched() / local_irq_disable()":
i.e, from:

"preempt_enable_no_sched();
/* Yi: will some race condition happens here? */
 local_irq_disable();
__schedule();"

to:

"local_irq_disable(); /* Yi: disables irq effectively disables preempti=
on?  */
preempt_enable_no_sched();
__schedule();"

Regards,
-Yi

>>
>>
>> diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_=
64.c
>> index ebefb54..c8d0ece 100644
>> --- a/arch/x86/kernel/process_64.c
>> +++ b/arch/x86/kernel/process_64.c
>> @@ -152,9 +152,11 @@ void cpu_idle(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tick_nohz_restart_sched_tick();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_enable_no_resched();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_disable();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __preempt_enable_no_resched();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __schedule();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preempt_disable();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 local_irq_enable();
>> =A0 =A0 =A0 =A0 }
>> =A0}
>>
>> Regards,
>> -Yi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
