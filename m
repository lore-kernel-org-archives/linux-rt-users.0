From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: cyclictest - duplicate explanation of cyclictest option
Date: Tue, 7 Apr 2009 08:15:34 +0900
Message-ID: <49b7c2350904061615g525dfec2kdbf14f6ea6f05ee@mail.gmail.com>
References: <49b7c2350904051956n214efbb5pc8cd9990820a534f@mail.gmail.com>
	 <49b7c2350904060129r640a3db6r5487e72f2cf6330f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:33903 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbZDFXPg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2009 19:15:36 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2475228wff.4
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Apr 2009 16:15:34 -0700 (PDT)
In-Reply-To: <49b7c2350904060129r640a3db6r5487e72f2cf6330f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear Thomas,

I read http://kernelnewbies.org/UpstreamMerge/SubmittingPatches about
Submitting patches.
I mistake because I don't understand how to submit patch exactly.
I just appended below "singned-off" contents for convenience.
I am sorry for the confusion.

    Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
    Signed-off-by: Clark Williams <williams@redhat.com>


Regards,


2009/4/6 GeunSik Lim <leemgs1@gmail.com>:
> Dear Thomas & Clark,
>
> This is e-mail about patch to support wakeup & wakeup_rt tracing addi=
tionally
> at the argument of cyclictest.
> Currently, cyclictest v 0.34 support =C2=A0three tracing like PREEMPT=
OFF ,
> IRQSOFF , PREEMPTIRQSOFF.
> I want you to append WAKEUP & WAKEUP_RT at the current cyclictest ver=
sion.
>
> and, cyclictest ver 0.34 have a bug about context switching =C2=A0and=
 event option.
> for example,
> we can not use =C2=A0"-C" option without --context option.
> we can not use =C2=A0"-E" option without --event option.
>
> Belows is result after patching in sequence.
> =C2=A01) adjust =C2=A0"remove-duplicate-h-option.patch" file.
> =C2=A02) and then, =C2=A0adjust
> "add-wakeup-wakeuprt-tracing-and-misc-bugfix.patch" =C2=A0file.
>
> Hope this helps. =C2=A0If I mistake, correct me.
> Thanks.
>
> After Patching ....
>
> #### [ wakeup test]###############################################
> [root@fedora9 rt-tests-temp0]# cat /debug/tracing/available_tracers
> syscall blk kmemtrace power branch function_graph mmiotrace wakeup_rt
> wakeup preemptirqsoff preemptoff irqsoff function sched_switch
> initcall nop
>
> [root@fedora9 rt-tests-temp0]# ./cyclictest =C2=A0-t 2 -b 200 -W -D 5
> could not set latency_hist/wakeup_latency/reset to 1
> 0.16 0.27 0.21 2/308 2521
>
> T: 0 ( 2520) P: 0 I:1000 C: =C2=A0 4288 Min: =C2=A0 =C2=A0 16 Act: =C2=
=A0 27 Avg: =C2=A0 28 Max: =C2=A0 =C2=A0 152
> T: 1 ( 2521) P: 0 I:1500 C: =C2=A0 2859 Min: =C2=A0 =C2=A0 19 Act: =C2=
=A0 29 Avg: =C2=A0 27 Max: =C2=A0 =C2=A0 =C2=A072
>
> [root@fedora9 rt-tests-temp0]# cat /debug/tracing/trace
> # tracer: wakeup
> #
> # wakeup latency trace v1.1.5 on 2.6.29-rt2-ftrace
> # -------------------------------------------------------------------=
-
> # latency: 20 us, #3/3, CPU#2 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4=
)
> # =C2=A0 =C2=A0-----------------
> # =C2=A0 =C2=A0| task: gnome-terminal-3884 (uid:504 nice:0 policy:0 r=
t_prio:0)
> # =C2=A0 =C2=A0-----------------
> #
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_----=
--=3D> CPU#
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / _-----=3D=
> irqs-off
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| / _----=3D=
> need-resched
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| / _---=3D=
> hardirq/softirq
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0||| / _--=3D=
> preempt-depth
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|||| /
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0||||| =C2=A0=
 =C2=A0 delay
> # =C2=A0cmd =C2=A0 =C2=A0 pid =C2=A0 ||||| time =C2=A0| =C2=A0 caller
> # =C2=A0 =C2=A0 \ =C2=A0 / =C2=A0 =C2=A0 =C2=A0||||| =C2=A0 \ =C2=A0 =
| =C2=A0 /
> gnome-te-3884 =C2=A0 =C2=A02d.h. =C2=A0 =C2=A01us+: irq_enter <-smp_a=
pic_timer_interrupt
> gnome-te-3884 =C2=A0 =C2=A02dN.1 =C2=A0 20us : irq_exit <-smp_apic_ti=
mer_interrupt
> gnome-te-3884 =C2=A0 =C2=A02dN.1 =C2=A0 21us : trace_preempt_on <-smp=
_apic_timer_interrupt
>
> #####[ Context Switching Test]#####################################
>
> [root@fedora9 rt-tests-temp0]# ./cyclictest =C2=A0-t 10 -b 100000 -C =
-m -D 5
> could not set latency_hist/wakeup_latency/reset to 1
> 0.17 0.17 0.17 1/326 2706
>
> T: 0 ( 2697) P: 0 I:1000 C: =C2=A0 4000 Min: =C2=A0 =C2=A0 12 Act: =C2=
=A0 21 Avg: =C2=A0 20 Max: =C2=A0 =C2=A0 107
> T: 1 ( 2698) P: 0 I:1500 C: =C2=A0 2667 Min: =C2=A0 =C2=A0 13 Act: =C2=
=A0 27 Avg: =C2=A0 22 Max: =C2=A0 =C2=A0 138
> T: 2 ( 2699) P: 0 I:2000 C: =C2=A0 2000 Min: =C2=A0 =C2=A0 12 Act: =C2=
=A0 13 Avg: =C2=A0 13 Max: =C2=A0 =C2=A0 =C2=A040
> T: 3 ( 2700) P: 0 I:2500 C: =C2=A0 1600 Min: =C2=A0 =C2=A0 12 Act: =C2=
=A0 16 Avg: =C2=A0 13 Max: =C2=A0 =C2=A0 =C2=A041
> T: 4 ( 2701) P: 0 I:3000 C: =C2=A0 1334 Min: =C2=A0 =C2=A0 12 Act: =C2=
=A0 15 Avg: =C2=A0 13 Max: =C2=A0 =C2=A0 =C2=A039
> T: 5 ( 2702) P: 0 I:3500 C: =C2=A0 1143 Min: =C2=A0 =C2=A0 12 Act: =C2=
=A0 28 Avg: =C2=A0 16 Max: =C2=A0 =C2=A0 =C2=A061
> T: 6 ( 2703) P: 0 I:4000 C: =C2=A0 1000 Min: =C2=A0 =C2=A0 12 Act: =C2=
=A0 13 Avg: =C2=A0 13 Max: =C2=A0 =C2=A0 102
> T: 7 ( 2704) P: 0 I:4500 C: =C2=A0 =C2=A0889 Min: =C2=A0 =C2=A0 12 Ac=
t: =C2=A0 13 Avg: =C2=A0 15 Max: =C2=A0 =C2=A0 184
> T: 8 ( 2705) P: 0 I:5000 C: =C2=A0 =C2=A0800 Min: =C2=A0 =C2=A0 12 Ac=
t: =C2=A0 13 Avg: =C2=A0 13 Max: =C2=A0 =C2=A0 =C2=A032
> T: 9 ( 2706) P: 0 I:5500 C: =C2=A0 =C2=A0728 Min: =C2=A0 =C2=A0 12 Ac=
t: =C2=A0 15 Avg: =C2=A0 15 Max: =C2=A0 =C2=A0 =C2=A054
> [root@fedora9 rt-tests-temp0]# cat /debug/tracing/trace |head
> # tracer: sched_switch
> #
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 TASK-PID =C2=A0 =C2=A0CPU# =C2=A0=
 =C2=A0TIMESTAMP =C2=A0FUNCTION
> # =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| | =C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
> ##### CPU 0 buffer started ####
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<idle>-0 =C2=A0 =C2=A0 [000] =C2=A0=
1107.917632: =C2=A0 =C2=A0 =C2=A00:140:R =C2=A0 + [000]
> 10: 49:D sirq-sched/0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<idle>-0 =C2=A0 =C2=A0 [000] =C2=A0=
1107.917635: =C2=A0 =C2=A0 =C2=A00:140:R =C2=A0 + [000]
> 5: 49:D sirq-timer/0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<idle>-0 =C2=A0 =C2=A0 [000] =C2=A0=
1107.917642: =C2=A0 =C2=A0 =C2=A00:140:R =3D=3D> [000]
> 10: 49:R sirq-sched/0
> =C2=A0 =C2=A0sirq-sched/0-10 =C2=A0 =C2=A0[000] =C2=A01107.917655: =C2=
=A0 =C2=A0 10: 49:D =3D=3D> [000]
> 5: 49:R sirq-timer/0
> =C2=A0 =C2=A0sirq-timer/0-5 =C2=A0 =C2=A0 [000] =C2=A01107.917660: =C2=
=A0 =C2=A0 =C2=A05: 49:D =3D=3D> [000]
> 0:140:R <idle>
> [root@fedora9 rt-tests-temp0]#
>
>
> #####################################################################=
############
>
>
>
>
>
> 2009/4/6 GeunSik Lim <leemgs1@gmail.com>:
>> Dear Clark,
>>
>> This is trivial contents about option of cyclictest.
>>
>> Cyclictest utiltiy (ver 0.34) display the information with duplicate
>> "-h" options,
>> when a user run "cyclictest --help" command.
>> User will confuse =C2=A0exact understanding because of duplicate
>> description of -h option.
>> How about you remove "-h H_MAX =C2=A0*****" line?
>> Thanks reading.
>>
>> Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
>>
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest=
=2Ec
>> index f878217..cedc36f 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -688,7 +688,8 @@ static void display_help(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-d DIST =C2=A0--di=
stance=3DDIST =C2=A0 distance of thread
>> intervals in us default=3D500\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-E =C2=A0 =C2=A0 =C2=
=A0 --event =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event tracing (used with=
 -b)\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-f =C2=A0 =C2=A0 =C2=
=A0 --ftrace =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0function trace (when -b =
is active)\n"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h H_MAX =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 latency histogram =
size in
>> us default 0 (off)\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h =C2=A0 =C2=A0 =
=C2=A0 --histogram=3DUS =C2=A0 =C2=A0dump a latency histogram to
>> stdout after the run\n"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 US is the max time to be be
>> tracked in microseconds\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-i INTV =C2=A0--in=
terval=3DINTV =C2=A0 base interval of thread in
>> us default=3D1000\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-I =C2=A0 =C2=A0 =C2=
=A0 --irqsoff =C2=A0 =C2=A0 =C2=A0 =C2=A0 Irqsoff tracing (used with -b=
)\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-l LOOPS --loops=3D=
LOOPS =C2=A0 =C2=A0 number of loops:
>> default=3D0(endless)\n"
>> @@ -710,8 +711,6 @@ static void display_help(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-D =C2=A0 =C2=A0 =C2=
=A0 --duration=3Dt =C2=A0 =C2=A0 =C2=A0specify a length for the test ru=
n\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 default is in seconds, but
>> 'm', 'h', or 'd' maybe added\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 to modify value to minutes,
>> hours or days\n"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h =C2=A0 =C2=A0 =
=C2=A0 --histogram=3DUS =C2=A0 =C2=A0dump a latency histogram to
>> stdout after the run\n"
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 US is the max time to be be
>> tracked in microseconds\n"
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);
>> =C2=A0}
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
