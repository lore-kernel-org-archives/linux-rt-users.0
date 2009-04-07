From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: [PATCH] Update old Mini-HOWTO for ftrace
Date: Tue, 7 Apr 2009 14:08:10 +0900
Message-ID: <49b7c2350904062208qc16ef6ag9a33bef66721f4e@mail.gmail.com>
References: <49b7c2350904060702j3f725a45ub5e7d3ee3af883c1@mail.gmail.com>
	 <1239068812.4753.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>,
	rt-users <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nikanth Karthikensan <knikanth@suse.de>
To: Steven Rostedt <srostedt@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:52831 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbZDGFIM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 01:08:12 -0400
In-Reply-To: <1239068812.4753.15.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear steven,

I  confirm http://lkml.org/lkml/2009/3/23/24 webpage now.
I am gratified with a similar patch that another people sent  this prob=
lem.

In fact, I figured out trivial problem of old mini-HOWTO according to
http://www.redhat.com/docs/en-US/Red_Hat_Enterprise_MRG/1.1/html/Realti=
me_Tuning_Guide/sect-Realtime_Tuning_Guide-Realtime_Specific_Tuning-Usi=
ng_the_ftrace_Utility_for_Tracing_Latencies.html
web manual.

I want you to change MRG Kernel from ftrace to function for
consistency in private.
Thank you for interesting article

Regards,
GeunSik Lim..

2009/4/7 Steven Rostedt <srostedt@redhat.com>:
>
> On Mon, 2009-04-06 at 23:02 +0900, GeunSik Lim wrote:
>> Dear Steven,
>>
>> =C2=A0 =C2=A0The author of ftrace(Internal kernel Function Tracer) f=
eature
>> renamed the ftrace tracer
>> =C2=A0 =C2=A0 to function to avoid further confusion between the ftr=
ace
>> infrastructure and the
>> =C2=A0 =C2=A0 function tracer on Oct-20, 2008.
>>
>> =C2=A0 =C2=A0 But, Update of Mini-HOWTO document are still not worki=
ng
>> =C2=A0 =C2=A0 .
>> =C2=A0 =C2=A0 Most of the developers often utilize "/debug/tracing/R=
EADME" file
>> as Mini-HOWTO.
>> =C2=A0 =C2=A0 They will confuse definition and usage about ftrace =C2=
=A0between
>> README(ftrace) file
>> =C2=A0 =C2=A0 and available_tracers(function) file after linux-2.6.2=
7 like me.
>> =C2=A0 =C2=A0 And, I want you to append "chrt -f 5 sleep 1" command =
as simple
>> example for latency.
>>
>> =C2=A0 =C2=A0 Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
>> =C2=A0 =C2=A0 Signed-off-by: Steven Rostedt <srostedt@redhat.com>
>> =C2=A0 =C2=A0 Signed-off-by: Ingo Molnar <mingo@elte.hu>
>> ---
>> =C2=A0kernel/trace/trace.c | =C2=A0 =C2=A03 ++-
>> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index a0174a4..15f0eec 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2358,7 +2358,7 @@ static const char readme_msg[] =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# mkdir /debug\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# mount -t debugfs nodev /debug\n\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# cat /debug/tracing/available_tracers\=
n"
>> - =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff ftr=
ace sched_switch none\n\n"
>> + =C2=A0 =C2=A0 =C2=A0 "wakeup preemptirqsoff preemptoff irqsoff fun=
ction
>> sched_switch none\n\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# cat /debug/tracing/current_tracer\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "none\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# echo sched_switch > /debug/tracing/cu=
rrent_tracer\n"
>> @@ -2368,6 +2368,7 @@ static const char readme_msg[] =3D
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "noprint-parent nosym-offset nosym-addr =
noverbose\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# echo print-parent > /debug/tracing/tr=
ace_options\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# echo 1 > /debug/tracing/tracing_enabl=
ed\n"
>> + =C2=A0 =C2=A0 =C2=A0 "# chrt -f 5 sleep 1\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "# cat /debug/tracing/trace > /tmp/trace=
=2Etxt\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 "echo 0 > /debug/tracing/tracing_enabled=
\n"
>> =C2=A0;
>>
>
> Actually Nikanth sent a similar patch a month ago, but somehow it
> slipped under the radar. I'll be picking that one up instead.
>
> http://lkml.org/lkml/2009/3/23/24
>
> But thanks anyway.
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
