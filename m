From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Re: Regarding interrupt task latency
Date: Fri, 24 Sep 2010 20:57:43 -0400
Message-ID: <AANLkTi=dg=i2CM7PNS4ALboT4p08iB1Dq_faLOT7AKm9@mail.gmail.com>
References: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
	<4C9BB2F80200005A00072A37@soto.provo.novell.com>
	<AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
	<4C9D025D0200005A00072B6D@soto.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53373 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993Ab0IYA5o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Sep 2010 20:57:44 -0400
Received: by pwj6 with SMTP id 6so762946pwj.19
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Sep 2010 17:57:44 -0700 (PDT)
In-Reply-To: <4C9D025D0200005A00072B6D@soto.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Gregory,

   Thanks for clarification. I got it.

 So, the reason for checking in the locks whether need_resched is set,
to call schedule and other "low latency patch" which checks need_resch
after few lines of code execution, is to eliminate task latency.


> Likewise, if the irq-thread is suddenly _not_ the highest priority, i=
t will be preempted ASAP. =C2=A0This will happen either immediately as =
soon as the higher task enters RUNNING, or "at the conclusion of any cr=
itical section that the irq-thread may have entered". =C2=A0Since -rt e=
liminates most critical sections (and makes the few that remain very sh=
ort), this usually means the former.

What is that situation where higher priority task needs to wait until
some critical section is executed. So, at the end schedule is called.
Can you please clarify such a case, because
when high priority task is in RUNNING mode it is immediately executed.
So, I do not see any use of checking for to schedule at the end of
critical section.

Correct me if I am wrong. Thanks.

Regards,
Sri.





On Fri, Sep 24, 2010 at 7:56 PM, Gregory Haskins <ghaskins@novell.com> =
wrote:
> Hi Sri,
>
>>>> On 9/24/2010 at 12:42 AM, in message
> <AANLkTik=3DLfxm1qnT4FG79k67CTcnPkOvVeAzVUS=3DSP3g@mail.gmail.com>, S=
ri Ram
> Vemulpali <sri.ram.gmu06@gmail.com> wrote:
>> Hi Gregory,
>>
>> =C2=A0 Thanks for the explanation. I got a grasp of what you said.
>>
>> =C2=A0 So, the whole preempt rt is made preemptible, even in the int=
errupt
>> context.
>> =C2=A0 the IRQ now executes as thread, so that it can be preempted.
>>
>> =C2=A0 Now the question is, usually this interrupt task latency
>
> Can you be more specific as to which interrupt task latency you are r=
eferring to?
>
>> occurs when
>> IRQ thread finishes
>> =C2=A0 and sets need_resch. So this is checked in the locks, so that=
 long
>> critical section
>> =C2=A0 determines when to schedule, which is non-deterministic.
>>
>> =C2=A0 why do not we eliminate this by calling schedule immediately =
after
>> IRQ thread context.
>
> I think there is some confusion here. =C2=A0The "after" in any thread=
 context is already a schedule(), so I am not clear on what you are pro=
posing we need to eliminate.
>
> If the irq-thread is the highest priority task, it will run to comple=
tion and then naturally schedule() as part of its "sleep" logic (such a=
s joining a wait-queue). =C2=A0The scheduler will immediately elect the=
 next highest RUNNING task (or idle, if none are available) as a result=
 of the irq-thread going to sleep (there is no latency here, assuming y=
ou correctly prioritized the threads).
>
> Likewise, if the irq-thread is suddenly _not_ the highest priority, i=
t will be preempted ASAP. =C2=A0This will happen either immediately as =
soon as the higher task enters RUNNING, or at the conclusion of any cri=
tical section that the irq-thread may have entered. =C2=A0Since -rt eli=
minates most critical sections (and makes the few that remain very shor=
t), this usually means the former.
>
>> =C2=A0 I think there can be a solution. If such solution exists we w=
ill not
>> have two kinds of patches
>> =C2=A0 "low latency" and "preempt" patches of RT.
>>
>> =C2=A0 Can you please explain, is there any reason or bottle neck to
>> implement solution to call schedule
>> =C2=A0 immediately after IRQ thread context.
>
> I assert we already _do_. =C2=A0If you think otherwise, please clarif=
y the scenario that concerns you.
>
> Kind Regards,
> -Greg
>
>
>



--=20
Regards,
Sri.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
