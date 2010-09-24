From: Sri Ram Vemulpali <sri.ram.gmu06@gmail.com>
Subject: Re: Regarding interrupt task latency
Date: Fri, 24 Sep 2010 00:42:35 -0400
Message-ID: <AANLkTik=Lfxm1qnT4FG79k67CTcnPkOvVeAzVUS=SP3g@mail.gmail.com>
References: <AANLkTi=EmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>
	<4C9BB2F80200005A00072A37@soto.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:50436 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192Ab0IXEmg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Sep 2010 00:42:36 -0400
Received: by pxi10 with SMTP id 10so689370pxi.19
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Sep 2010 21:42:35 -0700 (PDT)
In-Reply-To: <4C9BB2F80200005A00072A37@soto.provo.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Gregory,

  Thanks for the explanation. I got a grasp of what you said.

  So, the whole preempt rt is made preemptible, even in the interrupt c=
ontext.
  the IRQ now executes as thread, so that it can be preempted.

  Now the question is, usually this interrupt task latency occurs when
IRQ thread finishes
  and sets need_resch. So this is checked in the locks, so that long
critical section
  determines when to schedule, which is non-deterministic.

  why do not we eliminate this by calling schedule immediately after
IRQ thread context.
  I think there can be a solution. If such solution exists we will not
have two kinds of patches
  "low latency" and "preempt" patches of RT.

  Can you please explain, is there any reason or bottle neck to
implement solution to call schedule
  immediately after IRQ thread context. Thanks.

Regards,
Sri.

On Thu, Sep 23, 2010 at 8:05 PM, Gregory Haskins <ghaskins@novell.com> =
wrote:
> Hi Sri,
>
>>>> On 9/23/2010 at 07:00 PM, in message
> <AANLkTi=3DEmZJrC+Dmq_-Oijew2uUQ8Xo1y_xzeAZsaS01@mail.gmail.com>, Sri=
 Ram
> Vemulpali <sri.ram.gmu06@gmail.com> wrote:
>> Hi all,
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0I have a doubt regarding interrupt task l=
atency.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0I know that whenever interrupt context an=
d its associated BH
>> are finished, then need_resch is checked whether to call schedule
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0In such case then the latency is determin=
istic
>
> How? =C2=A0In a way, you answered your own question: =C2=A0Assume top=
-half takes X microseconds, bottom-half takes Y, and the needs_resched(=
)+schedule takes Z. =C2=A0So in your scenario, you have a latency of X+=
Y+Z. =C2=A0What makes you so sure that X and Y are constants for all po=
ssible TH+BH combinations? =C2=A0It doesn't take much imagination to th=
ink of common scenarios that are non-deterministic in this context: =C2=
=A0Think of things like a netif napi_poll operation dequeuing a variabl=
e number of packets and you get the idea.
>
> In addition, what makes you sure that X and Y are reasonably short? =C2=
=A0RT isn't simply about "determinism". =C2=A0Its about "deterministica=
lly low latency". =C2=A0If I told you that X and Y are fixed constants =
equal to 20 seconds each, that would be deterministic but yet result in=
 a completely useless system ;)
>
> What RT does, in essence, is try to make as many things as possible a=
 scheduleable task so that a task priority may be assigned and a schedu=
ling policy may be employed against that priority constraint. =C2=A0The=
 corollary to that is that RT also tries to minimize the number of plac=
es that are _not_ scheduleable tasks by getting rid of most in_atomic()=
 sections, etc with various tricks. =C2=A0The net result is that the ti=
me spent in_atomic() is deterministically very short, allowing your tas=
k priority policy to govern what code is the most critical to run next.=
 =C2=A0This means much much more than the fact that your scenario above=
 _eventually_ checked if it needed to reschedule after some potentially=
 arbitrarily long critical section.
>
> HTH
> -Greg
>
>
>>and one need not
>> to bother about this latency. Why is that rt still considers this as
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0bottle neck on this issue.
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0Any explanation is appreciated. Thanks.
>>
>> --
>> Regards,
>> Sri.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
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
