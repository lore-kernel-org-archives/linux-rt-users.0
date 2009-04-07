From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH] Update old Mini-HOWTO for ftrace
Date: Tue, 7 Apr 2009 13:37:17 +0900
Message-ID: <49b7c2350904062137p46661ad8s11c9c2a31e367329@mail.gmail.com>
References: <49b7c2350904060702j3f725a45ub5e7d3ee3af883c1@mail.gmail.com>
	 <49b7c2350904060717l1a87cca7p880b6843ea92c702@mail.gmail.com>
	 <1239067616.4753.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	rt-users <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Steven Rostedt <srostedt@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:49195 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbZDGEhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 00:37:19 -0400
In-Reply-To: <1239067616.4753.12.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 > What's the chrt for?
 We often need simple test to get  latency result  of realtime using
"current_tracers" file.
 In this case, We can run easy testcase as realtime task with the chrt =
command.

 Although we usually use function tracer for tracing internal kernel
functions by ftraced.
 I think that we need simple example like the chrt for monitoring
latencies and the kernel
functoins using sleep command as realtime task.


2009/4/7 Steven Rostedt <srostedt@redhat.com>:
>
> On Mon, 2009-04-06 at 23:17 +0900, GeunSik Lim wrote:
>> I attached patch file again because no-operation is changed
>> from "none"word to "nop" word.
>>
>> for example,
>> - =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff ftr=
ace sched_switch none\n\n"
>> + =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff fun=
ction sched_switch nop\n\n"
>>
>> ./trace_nop.c:struct tracer nop_trace __read_mostly =3D
>> =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =3D "nop",
>> =C2=A0 =C2=A0 =C2=A0 .init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D no=
p_trace_init,
>> =C2=A0 =C2=A0 =C2=A0 .reset =C2=A0=3D nop_trace_reset,
>> =C2=A0 =C2=A0 =C2=A0 .selftest =C2=A0 =C2=A0 =C2=A0 =3D trace_selfte=
st_startup_nop,
>> =C2=A0 =C2=A0 =C2=A0 .flags =C2=A0=3D &nop_flags,
>> =C2=A0 =C2=A0 =C2=A0 .set_flag =C2=A0 =C2=A0 =C2=A0 =3D nop_set_flag
>>
>>
>>
>> 2009/4/6 GeunSik Lim <leemgs1@gmail.com>:
>> > =C2=A0 Dear Steven,
>> >
>> > =C2=A0 The author of ftrace(Internal kernel Function Tracer) featu=
re
>> > renamed the ftrace tracer
>> > =C2=A0 =C2=A0to function to avoid further confusion between the ft=
race
>> > infrastructure and the
>> > =C2=A0 =C2=A0function tracer on Oct-20, 2008.
>> >
>> > =C2=A0 =C2=A0But, Update of Mini-HOWTO document are still not work=
ing
>> > =C2=A0 =C2=A0.
>> > =C2=A0 =C2=A0Most of the developers often utilize "/debug/tracing/=
README" file
>> > as Mini-HOWTO.
>> > =C2=A0 =C2=A0They will confuse definition and usage about ftrace =C2=
=A0between
>> > README(ftrace) file
>> > =C2=A0 =C2=A0and available_tracers(function) file after linux-2.6.=
27 like me.
>> > =C2=A0 =C2=A0And, I want you to append "chrt -f 5 sleep 1" command=
 as simple
>> > example for latency.
>> >
>> > =C2=A0 =C2=A0Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
>> > =C2=A0 =C2=A0Signed-off-by: Steven Rostedt <srostedt@redhat.com>
>> > =C2=A0 =C2=A0Signed-off-by: Ingo Molnar <mingo@elte.hu>
>> > ---
>> > =C2=A0kernel/trace/trace.c | =C2=A0 =C2=A03 ++-
>> > =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>> >
>> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> > index a0174a4..15f0eec 100644
>> > --- a/kernel/trace/trace.c
>> > +++ b/kernel/trace/trace.c
>> > @@ -2358,7 +2358,7 @@ static const char readme_msg[] =3D
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# mkdir /debug\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# mount -t debugfs nodev /debug\n\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# cat /debug/tracing/available_tracers=
\n"
>> > - =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff f=
trace sched_switch none\n\n"
>> > + =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff f=
unction
>> > sched_switch none\n\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# cat /debug/tracing/current_tracer\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"none\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo sched_switch > /debug/tracing/c=
urrent_tracer\n"
>> > @@ -2368,6 +2368,7 @@ static const char readme_msg[] =3D
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"noprint-parent nosym-offset nosym-addr=
 noverbose\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo print-parent > /debug/tracing/t=
race_options\n"
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0"# echo 1 > /debug/tracing/tracing_enab=
led\n"
>> > + =C2=A0 =C2=A0 =C2=A0 "# chrt -f 5 sleep 1\n"
>
>
> What's the chrt for?
>
> -- Steve
>
>
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
