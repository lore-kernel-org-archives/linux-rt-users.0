From: Manikandan Ramachandran <crmanik@gmail.com>
Subject: Re: Regarding interrupt task latency
Date: Thu, 23 Sep 2010 22:13:54 -0700
Message-ID: <AANLkTim7NUcDesCPhiVO9yD-tU27Rt_JjYTiQoJMoTPc@mail.gmail.com>
References: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
	<4C9BB2F80200005A00072A37@soto.provo.novell.com>
	<AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Gregory Haskins <ghaskins@novell.com>,
	Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40269 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0IXFN4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Sep 2010 01:13:56 -0400
Received: by qwh6 with SMTP id 6so1592823qwh.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 22:13:55 -0700 (PDT)
In-Reply-To: <AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Once IRQ thread completes[for that matter any process], it will be
scheduled out. The answer to your Qs depends on how you are using IRQ
handler. If it is threaded and if you can afford to yield, use sleep
of any kind in your handler to yield to other process. If the IRQ is
non-threaded, then make sure your handler is atomic.

So my point is RT kernel is fine, it is upto to the user how they
prefer to use it.

HTH,
Mani

On Thu, Sep 23, 2010 at 9:42 PM, Sri Ram Vemulpali
<sri.ram.gmu06@gmail.com> wrote:
> Hi Gregory,
>
> =A0Thanks for the explanation. I got a grasp of what you said.
>
> =A0So, the whole preempt rt is made preemptible, even in the interrup=
t context.
> =A0the IRQ now executes as thread, so that it can be preempted.
>
> =A0Now the question is, usually this interrupt task latency occurs wh=
en
> IRQ thread finishes
> =A0and sets need_resch. So this is checked in the locks, so that long
> critical section
> =A0determines when to schedule, which is non-deterministic.
>
> =A0why do not we eliminate this by calling schedule immediately after
> IRQ thread context.
> =A0I think there can be a solution. If such solution exists we will n=
ot
> have two kinds of patches
> =A0"low latency" and "preempt" patches of RT.
>
> =A0Can you please explain, is there any reason or bottle neck to
> implement solution to call schedule
> =A0immediately after IRQ thread context. Thanks.
>
> Regards,
> Sri.
>
> On Thu, Sep 23, 2010 at 8:05 PM, Gregory Haskins <ghaskins@novell.com=
> wrote:
>> Hi Sri,
>>
>>>>> On 9/23/2010 at 07:00 PM, in message
>> <AANLkTi=3DEmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>, Sr=
i Ram
>> Vemulpali <sri.ram.gmu06@gmail.com> wrote:
>>> Hi all,
>>>
>>> =A0 =A0 =A0 =A0I have a doubt regarding interrupt task latency.
>>> =A0 =A0 =A0 =A0I know that whenever interrupt context and its assoc=
iated BH
>>> are finished, then need_resch is checked whether to call schedule
>>> =A0 =A0 =A0 =A0In such case then the latency is deterministic
>>
>> How? =A0In a way, you answered your own question: =A0Assume top-half=
 takes X microseconds, bottom-half takes Y, and the needs_resched()+sch=
edule takes Z. =A0So in your scenario, you have a latency of X+Y+Z. =A0=
What makes you so sure that X and Y are constants for all possible TH+B=
H combinations? =A0It doesn't take much imagination to think of common =
scenarios that are non-deterministic in this context: =A0Think of thing=
s like a netif napi_poll operation dequeuing a variable number of packe=
ts and you get the idea.
>>
>> In addition, what makes you sure that X and Y are reasonably short? =
=A0RT isn't simply about "determinism". =A0Its about "deterministically=
 low latency". =A0If I told you that X and Y are fixed constants equal =
to 20 seconds each, that would be deterministic but yet result in a com=
pletely useless system ;)
>>
>> What RT does, in essence, is try to make as many things as possible =
a scheduleable task so that a task priority may be assigned and a sched=
uling policy may be employed against that priority constraint. =A0The c=
orollary to that is that RT also tries to minimize the number of places=
 that are _not_ scheduleable tasks by getting rid of most in_atomic() s=
ections, etc with various tricks. =A0The net result is that the time sp=
ent in_atomic() is deterministically very short, allowing your task pri=
ority policy to govern what code is the most critical to run next. =A0T=
his means much much more than the fact that your scenario above _eventu=
ally_ checked if it needed to reschedule after some potentially arbitra=
rily long critical section.
>>
>> HTH
>> -Greg
>>
>>
>>>and one need not
>>> to bother about this latency. Why is that rt still considers this a=
s
>>> =A0 =A0 =A0 =A0bottle neck on this issue.
>>>
>>> =A0 =A0 =A0 =A0Any explanation is appreciated. Thanks.
>>>
>>> --
>>> Regards,
>>> Sri.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
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
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thanks,
Manik

Think twice about a tree before you take a printout
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
