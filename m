From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH] Update old Mini-HOWTO for ftrace
Date: Tue, 7 Apr 2009 08:09:50 +0900
Message-ID: <49b7c2350904061609q7984d5f0u478a092ffcabe12c@mail.gmail.com>
References: <49b7c2350904060702j3f725a45ub5e7d3ee3af883c1@mail.gmail.com>
	 <49b7c2350904060717l1a87cca7p880b6843ea92c702@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.224]:28907 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752677AbZDFXJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2009 19:09:53 -0400
In-Reply-To: <49b7c2350904060717l1a87cca7p880b6843ea92c702@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sorry,
I mistake because I don't understand how to submit patch exactly.
I just appended below "singned-off" contents for convenience.
Sorry again.

   Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
   Signed-off-by: Steven Rostedt <srostedt@redhat.com>
   Signed-off-by: Ingo Molnar <mingo@elte.hu>

2009/4/6 GeunSik Lim <leemgs1@gmail.com>:
> I attached patch file again because no-operation is changed
> from "none"word to "nop" word.
>
> for example,
> - =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff ftra=
ce sched_switch none\n\n"
> + =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff func=
tion sched_switch nop\n\n"
>
> ./trace_nop.c:struct tracer nop_trace __read_mostly =3D
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.name =C2=A0 =3D "nop",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 nop_trace_init,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.reset =C2=A0=3D nop_trace_reset,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.selftest =C2=A0 =C2=A0 =C2=A0 =3D trace_s=
elftest_startup_nop,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0=3D &nop_flags,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0.set_flag =C2=A0 =C2=A0 =C2=A0 =3D nop_set=
_flag
>
>
>
> 2009/4/6 GeunSik Lim <leemgs1@gmail.com>:
>> =C2=A0 Dear Steven,
>>
>> =C2=A0 The author of ftrace(Internal kernel Function Tracer) feature
>> renamed the ftrace tracer
>> =C2=A0 =C2=A0to function to avoid further confusion between the ftra=
ce
>> infrastructure and the
>> =C2=A0 =C2=A0function tracer on Oct-20, 2008.
>>
>> =C2=A0 =C2=A0But, Update of Mini-HOWTO document are still not workin=
g
>> =C2=A0 =C2=A0.
>> =C2=A0 =C2=A0Most of the developers often utilize "/debug/tracing/RE=
ADME" file
>> as Mini-HOWTO.
>> =C2=A0 =C2=A0They will confuse definition and usage about ftrace =C2=
=A0between
>> README(ftrace) file
>> =C2=A0 =C2=A0and available_tracers(function) file after linux-2.6.27=
 like me.
>> =C2=A0 =C2=A0And, I want you to append "chrt -f 5 sleep 1" command a=
s simple
>> example for latency.
>>
>> =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
>> =C2=A0 =C2=A0Signed-off-by: Steven Rostedt <srostedt@redhat.com>
>> =C2=A0 =C2=A0Signed-off-by: Ingo Molnar <mingo@elte.hu>
>> ---
>> =C2=A0kernel/trace/trace.c | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index a0174a4..15f0eec 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2358,7 +2358,7 @@ static const char readme_msg[] =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# mkdir /debug\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# mount -t debugfs nodev /debug\n\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# cat /debug/tracing/available_tracers\n=
"
>> - =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff ftr=
ace sched_switch none\n\n"
>> + =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff fun=
ction
>> sched_switch none\n\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# cat /debug/tracing/current_tracer\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"none\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo sched_switch > /debug/tracing/cur=
rent_tracer\n"
>> @@ -2368,6 +2368,7 @@ static const char readme_msg[] =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"noprint-parent nosym-offset nosym-addr n=
overbose\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo print-parent > /debug/tracing/tra=
ce_options\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo 1 > /debug/tracing/tracing_enable=
d\n"
>> + =C2=A0 =C2=A0 =C2=A0 "# chrt -f 5 sleep 1\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"# cat /debug/tracing/trace > /tmp/trace.=
txt\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0"echo 0 > /debug/tracing/tracing_enabled\=
n"
>> =C2=A0;
>>
>>
>>
>> --
>> Regards,
>> GeunSik Lim
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>>
>
>
>
> --
> Regards,
> GeunSik Lim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
