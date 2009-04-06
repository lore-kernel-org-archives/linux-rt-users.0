From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: cyclictest - duplicate explanation of cyclictest option
Date: Mon, 6 Apr 2009 17:29:04 +0900
Message-ID: <49b7c2350904060129r640a3db6r5487e72f2cf6330f@mail.gmail.com>
References: <49b7c2350904051956n214efbb5pc8cd9990820a534f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e1fca2f89a060466deb04c
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:56564 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZDFI3G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2009 04:29:06 -0400
Received: by wf-out-1314.google.com with SMTP id 29so2149643wff.4
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Apr 2009 01:29:04 -0700 (PDT)
In-Reply-To: <49b7c2350904051956n214efbb5pc8cd9990820a534f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--001636e1fca2f89a060466deb04c
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Thomas & Clark,

This is e-mail about patch to support wakeup & wakeup_rt tracing additional=
ly
at the argument of cyclictest.
Currently, cyclictest v 0.34 support  three tracing like PREEMPTOFF ,
IRQSOFF , PREEMPTIRQSOFF.
I want you to append WAKEUP & WAKEUP_RT at the current cyclictest version.

and, cyclictest ver 0.34 have a bug about context switching  and event opti=
on.
for example,
we can not use  "-C" option without --context option.
we can not use  "-E" option without --event option.

Belows is result after patching in sequence.
 1) adjust  "remove-duplicate-h-option.patch" file.
 2) and then,  adjust
"add-wakeup-wakeuprt-tracing-and-misc-bugfix.patch"  file.

Hope this helps.  If I mistake, correct me.
Thanks.

After Patching ....

#### [ wakeup test]###############################################
[root@fedora9 rt-tests-temp0]# cat /debug/tracing/available_tracers
syscall blk kmemtrace power branch function_graph mmiotrace wakeup_rt
wakeup preemptirqsoff preemptoff irqsoff function sched_switch
initcall nop

[root@fedora9 rt-tests-temp0]# ./cyclictest  -t 2 -b 200 -W -D 5
could not set latency_hist/wakeup_latency/reset to 1
0.16 0.27 0.21 2/308 2521

T: 0 ( 2520) P: 0 I:1000 C:   4288 Min:     16 Act:   27 Avg:   28 Max:    =
 152
T: 1 ( 2521) P: 0 I:1500 C:   2859 Min:     19 Act:   29 Avg:   27 Max:    =
  72

[root@fedora9 rt-tests-temp0]# cat /debug/tracing/trace
# tracer: wakeup
#
# wakeup latency trace v1.1.5 on 2.6.29-rt2-ftrace
# --------------------------------------------------------------------
# latency: 20 us, #3/3, CPU#2 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:4)
#    -----------------
#    | task: gnome-terminal-3884 (uid:504 nice:0 policy:0 rt_prio:0)
#    -----------------
#
#                  _------=3D> CPU#
#                 / _-----=3D> irqs-off
#                | / _----=3D> need-resched
#                || / _---=3D> hardirq/softirq
#                ||| / _--=3D> preempt-depth
#                |||| /
#                |||||     delay
#  cmd     pid   ||||| time  |   caller
#     \   /      |||||   \   |   /
gnome-te-3884    2d.h.    1us+: irq_enter <-smp_apic_timer_interrupt
gnome-te-3884    2dN.1   20us : irq_exit <-smp_apic_timer_interrupt
gnome-te-3884    2dN.1   21us : trace_preempt_on <-smp_apic_timer_interrupt

#####[ Context Switching Test]#####################################

[root@fedora9 rt-tests-temp0]# ./cyclictest  -t 10 -b 100000 -C -m -D 5
could not set latency_hist/wakeup_latency/reset to 1
0.17 0.17 0.17 1/326 2706

T: 0 ( 2697) P: 0 I:1000 C:   4000 Min:     12 Act:   21 Avg:   20 Max:    =
 107
T: 1 ( 2698) P: 0 I:1500 C:   2667 Min:     13 Act:   27 Avg:   22 Max:    =
 138
T: 2 ( 2699) P: 0 I:2000 C:   2000 Min:     12 Act:   13 Avg:   13 Max:    =
  40
T: 3 ( 2700) P: 0 I:2500 C:   1600 Min:     12 Act:   16 Avg:   13 Max:    =
  41
T: 4 ( 2701) P: 0 I:3000 C:   1334 Min:     12 Act:   15 Avg:   13 Max:    =
  39
T: 5 ( 2702) P: 0 I:3500 C:   1143 Min:     12 Act:   28 Avg:   16 Max:    =
  61
T: 6 ( 2703) P: 0 I:4000 C:   1000 Min:     12 Act:   13 Avg:   13 Max:    =
 102
T: 7 ( 2704) P: 0 I:4500 C:    889 Min:     12 Act:   13 Avg:   15 Max:    =
 184
T: 8 ( 2705) P: 0 I:5000 C:    800 Min:     12 Act:   13 Avg:   13 Max:    =
  32
T: 9 ( 2706) P: 0 I:5500 C:    728 Min:     12 Act:   15 Avg:   15 Max:    =
  54
[root@fedora9 rt-tests-temp0]# cat /debug/tracing/trace |head
# tracer: sched_switch
#
#           TASK-PID    CPU#    TIMESTAMP  FUNCTION
#              | |       |          |         |
##### CPU 0 buffer started ####
          <idle>-0     [000]  1107.917632:      0:140:R   + [000]
10: 49:D sirq-sched/0
          <idle>-0     [000]  1107.917635:      0:140:R   + [000]
5: 49:D sirq-timer/0
          <idle>-0     [000]  1107.917642:      0:140:R =3D=3D> [000]
10: 49:R sirq-sched/0
    sirq-sched/0-10    [000]  1107.917655:     10: 49:D =3D=3D> [000]
5: 49:R sirq-timer/0
    sirq-timer/0-5     [000]  1107.917660:      5: 49:D =3D=3D> [000]
0:140:R <idle>
[root@fedora9 rt-tests-temp0]#


###########################################################################=
######





2009/4/6 GeunSik Lim <leemgs1@gmail.com>:
> Dear Clark,
>
> This is trivial contents about option of cyclictest.
>
> Cyclictest utiltiy (ver 0.34) display the information with duplicate
> "-h" options,
> when a user run "cyclictest --help" command.
> User will confuse =C2=A0exact understanding because of duplicate
> description of -h option.
> How about you remove "-h H_MAX =C2=A0*****" line?
> Thanks reading.
>
> Signed-off-by: GeunSik Lim <leemgs1@gmail.com>
>
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f878217..cedc36f 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -688,7 +688,8 @@ static void display_help(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-d DIST =C2=A0--distanc=
e=3DDIST =C2=A0 distance of thread
> intervals in us default=3D500\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-E =C2=A0 =C2=A0 =C2=A0=
 --event =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 event tracing (used with -b)\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-f =C2=A0 =C2=A0 =C2=A0=
 --ftrace =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0function trace (when -b is acti=
ve)\n"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h H_MAX =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 latency histogram size in
> us default 0 (off)\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h =C2=A0 =C2=A0 =C2=
=A0 --histogram=3DUS =C2=A0 =C2=A0dump a latency histogram to
> stdout after the run\n"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 US is=
 the max time to be be
> tracked in microseconds\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-i INTV =C2=A0--interva=
l=3DINTV =C2=A0 base interval of thread in
> us default=3D1000\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-I =C2=A0 =C2=A0 =C2=A0=
 --irqsoff =C2=A0 =C2=A0 =C2=A0 =C2=A0 Irqsoff tracing (used with -b)\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-l LOOPS --loops=3DLOOP=
S =C2=A0 =C2=A0 number of loops:
> default=3D0(endless)\n"
> @@ -710,8 +711,6 @@ static void display_help(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "-D =C2=A0 =C2=A0 =C2=A0=
 --duration=3Dt =C2=A0 =C2=A0 =C2=A0specify a length for the test run\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 defau=
lt is in seconds, but
> 'm', 'h', or 'd' maybe added\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to mo=
dify value to minutes,
> hours or days\n"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"-h =C2=A0 =C2=A0 =C2=
=A0 --histogram=3DUS =C2=A0 =C2=A0dump a latency histogram to
> stdout after the run\n"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0" =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 US is=
 the max time to be be
> tracked in microseconds\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(0);
> =C2=A0}
>
>
> --
> Regards,
> GeunSik Lim
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>



--=20
Regards,
GeunSik Lim
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

--001636e1fca2f89a060466deb04c
Content-Type: application/octet-stream;
	name="add-wakeup-wakeuprt-tracing-and-misc-bugfix.patch"
Content-Disposition: attachment;
	filename="add-wakeup-wakeuprt-tracing-and-misc-bugfix.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft6w9w3i1

QXV0aG9yOiBHZXVuU2lrIExpbSA8bGVlbWdzMUBnbWFpbC5jb20+CkRhdGU6ICAgTW9uIEFwciA2
IDE3OjE1OjA5IDIwMDkgKzA5MDAKCiAgICBTdXBwb3J0IHdha2V1cCB0cmFjaW5nIGFuZCBtaXNj
IGJ1Z2ZpeC4KICAgIAogICAgVGhpcyBpcyBwYXRjaCB0byBzdXBwb3J0IHdha2V1cCAmIHdha2V1
cF9ydCB0cmFjaW5nIGF0IHRoZSBhcmd1bWVudCBvZiBjeWNsaWN0ZXN0IGFkZGl0aW9uYWxseS4K
ICAgIEN1cnJlbnRseSwgY3ljbGljdGVzdCh2ZXIgMC4zNCkgc3VwcG9ydCB0aHJlZSB0cmFjaW5n
IGxpa2UgUFJFRU1QVE9GRiwgSVJRU09GRiwgUFJFRU1QVElSUVNPRkYuCiAgICBJIHdhbnQgeW91
IHRvIGFwcGVuZCBXQUtFVVAgJiBXQUtFVVBfUlQgdHJhY2luZyBhdCB0aGUgY3VycmVudCBjeWNs
aWN0ZXN0IHZlcnNpb24uCiAgICAKICAgIGFuZCwgY3ljbGljdGVzdCB2ZXIgMC4zNCBoYXZlIGEg
bWlzYyBidWcgYWJvdXQgY29udGV4dCBzd2l0Y2hpbmcgYW5kIGV2ZW50IG9wdGlvbi4KICAgIGZv
ciBleGFtcGxlLAogICAgd2UgY2FuIG5vdCB1c2UgICItQyIgb3B0aW9uIHdpdGhvdXQgLS1jb250
ZXh0IG9wdGlvbi4KICAgIHdlIGNhbiBub3QgdXNlICAiLUUiIG9wdGlvbiB3aXRob3V0IC0tZXZl
bnQgb3B0aW9uLgogICAgCiAgICBTaWduZWQtb2ZmLWJ5OiBHZXVuU2lrIExpbSA8bGVlbWdzMUBn
bWFpbC5jb20+CiAgICBTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRy
b25peC5kZT4KICAgIFNpZ25lZC1vZmYtYnk6IENsYXJrIFdpbGxpYW1zIDx3aWxsaWFtc0ByZWRo
YXQuY29tPgoKZGlmZiAtLWdpdCBhL3NyYy9jeWNsaWN0ZXN0L2N5Y2xpY3Rlc3QuYyBiL3NyYy9j
eWNsaWN0ZXN0L2N5Y2xpY3Rlc3QuYwppbmRleCBjZWRjMzZmLi43NDZiNDRmIDEwMDY0NAotLS0g
YS9zcmMvY3ljbGljdGVzdC9jeWNsaWN0ZXN0LmMKKysrIGIvc3JjL2N5Y2xpY3Rlc3QvY3ljbGlj
dGVzdC5jCkBAIC05Myw2ICs5Myw4IEBAIGVudW0gewogICAgICAgIElSUVNPRkYsCiAgICAgICAg
UFJFRU1QVE9GRiwKICAgICAgICBJUlFQUkVFTVBUT0ZGLAorICAgICAgIFdBS0VVUCwKKyAgICAg
ICBXQUtFVVBSVCwKIH07CiAKICNkZWZpbmUgSElTVF9NQVggICAgICAgICAgICAgICAxMDAwMDAw
CkBAIC00MTUsNiArNDE3LDEyIEBAIHN0YXRpYyB2b2lkIHNldHVwX3RyYWNlcih2b2lkKQogICAg
ICAgICAgICAgICAgY2FzZSBDVFhUU1dJVENIOgogICAgICAgICAgICAgICAgICAgICAgICByZXQg
PSBzZXR0cmFjZXIoInNjaGVkX3N3aXRjaCIpOwogICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsKKyAgICAgICAgICAgICAgIGNhc2UgV0FLRVVQOgorICAgICAgICAgICAgICAgICAgICAgICBy
ZXQgPSBzZXR0cmFjZXIoIndha2V1cCIpOworICAgICAgICAgICAgICAgICAgICAgICBicmVhazsK
KyAgICAgICAgICAgICAgIGNhc2UgV0FLRVVQUlQ6CisgICAgICAgICAgICAgICAgICAgICAgIHJl
dCA9IHNldHRyYWNlcigid2FrZXVwX3J0Iik7CisgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
OwogICAgICAgICAgICAgICAgZGVmYXVsdDoKICAgICAgICAgICAgICAgICAgICAgICAgcHJpbnRm
KCJjeWNsaWN0ZXN0OiB1bmtub3duIHRyYWNlciFcbiIpOwogICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSAwOwpAQCAtNjg2LDYgKzY5NCw5IEBAIHN0YXRpYyB2b2lkIGRpc3BsYXlfaGVscCh2
b2lkKQogICAgICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgMSA9IENMT0NL
X1JFQUxUSU1FXG4iCiAgICAgICAgICAgICAgICItQyAgICAgICAtLWNvbnRleHQgICAgICAgICBj
b250ZXh0IHN3aXRjaCB0cmFjaW5nICh1c2VkIHdpdGggLWIpXG4iCiAgICAgICAgICAgICAgICIt
ZCBESVNUICAtLWRpc3RhbmNlPURJU1QgICBkaXN0YW5jZSBvZiB0aHJlYWQgaW50ZXJ2YWxzIGlu
IHVzIGRlZmF1bHQ9NTAwXG4iCisgICAgICAgICAgICAgICItRCAgICAgICAtLWR1cmF0aW9uPXQg
ICAgICBzcGVjaWZ5IGEgbGVuZ3RoIGZvciB0aGUgdGVzdCBydW5cbiIKKyAgICAgICAgICAgICAg
IiAgICAgICAgICAgICAgICAgICAgICAgICAgIGRlZmF1bHQgaXMgaW4gc2Vjb25kcywgYnV0ICdt
JywgJ2gnLCBvciAnZCcgbWF5YmUgYWRkZWRcbiIKKyAgICAgICAgICAgICAgIiAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHRvIG1vZGlmeSB2YWx1ZSB0byBtaW51dGVzLCBob3VycyBvciBkYXlz
XG4iCiAgICAgICAgICAgICAgICItRSAgICAgICAtLWV2ZW50ICAgICAgICAgICBldmVudCB0cmFj
aW5nICh1c2VkIHdpdGggLWIpXG4iCiAgICAgICAgICAgICAgICItZiAgICAgICAtLWZ0cmFjZSAg
ICAgICAgICBmdW5jdGlvbiB0cmFjZSAod2hlbiAtYiBpcyBhY3RpdmUpXG4iCiAgICAgICAgICAg
ICAgICItaCAgICAgICAtLWhpc3RvZ3JhbT1VUyAgICBkdW1wIGEgbGF0ZW5jeSBoaXN0b2dyYW0g
dG8gc3Rkb3V0IGFmdGVyIHRoZSBydW5cbiIKQEAgLTcwOCw5ICs3MTksOCBAQCBzdGF0aWMgdm9p
ZCBkaXNwbGF5X2hlbHAodm9pZCkKICAgICAgICAgICAgICAgIiAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHdpdGhvdXQgLXQgZGVmYXVsdCA9IDFcbiIKICAgICAgICAgICAgICAgIi12ICAgICAg
IC0tdmVyYm9zZSAgICAgICAgIG91dHB1dCB2YWx1ZXMgb24gc3Rkb3V0IGZvciBzdGF0aXN0aWNz
XG4iCiAgICAgICAgICAgICAgICIgICAgICAgICAgICAgICAgICAgICAgICAgICBmb3JtYXQ6IG46
Yzp2IG49dGFza251bSBjPWNvdW50IHY9dmFsdWUgaW4gdXNcbiIKLSAgICAgICAgICAgICAgIi1E
ICAgICAgIC0tZHVyYXRpb249dCAgICAgIHNwZWNpZnkgYSBsZW5ndGggZm9yIHRoZSB0ZXN0IHJ1
blxuIgotICAgICAgICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVmYXVsdCBp
cyBpbiBzZWNvbmRzLCBidXQgJ20nLCAnaCcsIG9yICdkJyBtYXliZSBhZGRlZFxuIgotICAgICAg
ICAgICAgICAiICAgICAgICAgICAgICAgICAgICAgICAgICAgdG8gbW9kaWZ5IHZhbHVlIHRvIG1p
bnV0ZXMsIGhvdXJzIG9yIGRheXNcbiIKKyAgICAgICAgICAgICAgIi13ICAgICAgIC0td2FrZXVw
ICAgICAgICAgIHJ0IHRhc2sgd2FrZXVwIHRyYWNpbmcgKHVzZWQgd2l0aCAtYilcbiIKKyAgICAg
ICAgICAgICAgIi1XICAgICAgIC0td2FrZXVwcnQgICAgICAgIG5vbl9ydCB0YXNrIHdha2V1cF9y
dCB0cmFjaW5nICh1c2VkIHdpdGggLWIpXG4iCiAgICAgICAgICAgICAgICApOwogICAgICAgIGV4
aXQoMCk7CiB9CkBAIC03NTUsNiArNzY1LDcgQEAgc3RhdGljIHZvaWQgcHJvY2Vzc19vcHRpb25z
IChpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICAgICAgICAgICAgICAgICAgICB7ImNsb2Nr
IiwgcmVxdWlyZWRfYXJndW1lbnQsIE5VTEwsICdjJ30sCiAgICAgICAgICAgICAgICAgICAgICAg
IHsiY29udGV4dCIsIG5vX2FyZ3VtZW50LCBOVUxMLCAnQyd9LAogICAgICAgICAgICAgICAgICAg
ICAgICB7ImRpc3RhbmNlIiwgcmVxdWlyZWRfYXJndW1lbnQsIE5VTEwsICdkJ30sCisgICAgICAg
ICAgICAgICAgICAgICAgIHsiZHVyYXRpb24iLHJlcXVpcmVkX2FyZ3VtZW50LCBOVUxMLCAnRCd9
LAogICAgICAgICAgICAgICAgICAgICAgICB7ImV2ZW50Iiwgbm9fYXJndW1lbnQsIE5VTEwsICdF
J30sCiAgICAgICAgICAgICAgICAgICAgICAgIHsiZnRyYWNlIiwgbm9fYXJndW1lbnQsIE5VTEws
ICdmJ30sCiAgICAgICAgICAgICAgICAgICAgICAgIHsiaGlzdG9ncmFtIiwgcmVxdWlyZWRfYXJn
dW1lbnQsIE5VTEwsICdoJ30sCkBAIC03NzIsMTEgKzc4MywxMiBAQCBzdGF0aWMgdm9pZCBwcm9j
ZXNzX29wdGlvbnMgKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgICAgICAgICAgICAgICAg
ICAgIHsic3lzdGVtIiwgbm9fYXJndW1lbnQsIE5VTEwsICdzJ30sCiAgICAgICAgICAgICAgICAg
ICAgICAgIHsidGhyZWFkcyIsIG9wdGlvbmFsX2FyZ3VtZW50LCBOVUxMLCAndCd9LAogICAgICAg
ICAgICAgICAgICAgICAgICB7InZlcmJvc2UiLCBub19hcmd1bWVudCwgTlVMTCwgJ3YnfSwKLSAg
ICAgICAgICAgICAgICAgICAgICAgeyJkdXJhdGlvbiIscmVxdWlyZWRfYXJndW1lbnQsIE5VTEws
ICdEJ30sCisgICAgICAgICAgICAgICAgICAgICAgIHsid2FrZXVwIiwgbm9fYXJndW1lbnQsIE5V
TEwsICd3J30sCisgICAgICAgICAgICAgICAgICAgICAgIHsid2FrZXVwcnQiLCBub19hcmd1bWVu
dCwgTlVMTCwgJ1cnfSwKICAgICAgICAgICAgICAgICAgICAgICAgeyJoZWxwIiwgbm9fYXJndW1l
bnQsIE5VTEwsICc/J30sCiAgICAgICAgICAgICAgICAgICAgICAgIHtOVUxMLCAwLCBOVUxMLCAw
fQogICAgICAgICAgICAgICAgfTsKLSAgICAgICAgICAgICAgIGludCBjID0gZ2V0b3B0X2xvbmcg
KGFyZ2MsIGFyZ3YsICJhOjpiOkJjOmQ6Zmg6aTpJbDpuTm86cDpQbXFyc3Q6OnZEOiIsCisgICAg
ICAgICAgICAgICBpbnQgYyA9IGdldG9wdF9sb25nIChhcmdjLCBhcmd2LCAiYTo6YjpCY0M6ZEQ6
RWZoOmk6SWw6bW5ObzpwOlBxcnN0Ojp2OndXOiIsCiAgICAgICAgICAgICAgICAgICAgICAgIGxv
bmdfb3B0aW9ucywgJm9wdGlvbl9pbmRleCk7CiAgICAgICAgICAgICAgICBpZiAoYyA9PSAtMSkK
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7CkBAIC03OTcsMTIgKzgwOSwxNCBAQCBzdGF0
aWMgdm9pZCBwcm9jZXNzX29wdGlvbnMgKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgICAg
ICAgICAgICBjYXNlICdjJzogY2xvY2tzZWwgPSBhdG9pKG9wdGFyZyk7IGJyZWFrOwogICAgICAg
ICAgICAgICAgY2FzZSAnQyc6IHRyYWNldHlwZSA9IENUWFRTV0lUQ0g7IGJyZWFrOwogICAgICAg
ICAgICAgICAgY2FzZSAnZCc6IGRpc3RhbmNlID0gYXRvaShvcHRhcmcpOyBicmVhazsKKyAgICAg
ICAgICAgICAgIGNhc2UgJ0QnOiBkdXJhdGlvbiA9IHBhcnNlX3RpbWVfc3RyaW5nKG9wdGFyZyk7
IGJyZWFrOwogICAgICAgICAgICAgICAgY2FzZSAnRSc6IHRyYWNldHlwZSA9IEVWRU5UUzsgYnJl
YWs7CiAgICAgICAgICAgICAgICBjYXNlICdmJzogZnRyYWNlID0gMTsgYnJlYWs7CiAgICAgICAg
ICAgICAgICBjYXNlICdoJzogaGlzdG9ncmFtID0gYXRvaShvcHRhcmcpOyBicmVhazsKICAgICAg
ICAgICAgICAgIGNhc2UgJ2knOiBpbnRlcnZhbCA9IGF0b2kob3B0YXJnKTsgYnJlYWs7CiAgICAg
ICAgICAgICAgICBjYXNlICdJJzogdHJhY2V0eXBlID0gSVJRU09GRjsgYnJlYWs7CiAgICAgICAg
ICAgICAgICBjYXNlICdsJzogbWF4X2N5Y2xlcyA9IGF0b2kob3B0YXJnKTsgYnJlYWs7CisgICAg
ICAgICAgICAgICBjYXNlICdtJzogbG9ja2FsbCA9IDE7IGJyZWFrOwogICAgICAgICAgICAgICAg
Y2FzZSAnbic6IHVzZV9uYW5vc2xlZXAgPSBNT0RFX0NMT0NLX05BTk9TTEVFUDsgYnJlYWs7CiAg
ICAgICAgICAgICAgICBjYXNlICdOJzogdXNlX25zZWNzID0gMTsgYnJlYWs7CiAgICAgICAgICAg
ICAgICBjYXNlICdvJzogb3Njb3BlX3JlZHVjdGlvbiA9IGF0b2kob3B0YXJnKTsgYnJlYWs7CkBA
IC04MjAsOSArODM0LDggQEAgc3RhdGljIHZvaWQgcHJvY2Vzc19vcHRpb25zIChpbnQgYXJnYywg
Y2hhciAqYXJndltdKQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG51bV90aHJlYWRz
ID0gbWF4X2NwdXM7CiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAg
ICAgY2FzZSAndic6IHZlcmJvc2UgPSAxOyBicmVhazsKLSAgICAgICAgICAgICAgIGNhc2UgJ20n
OiBsb2NrYWxsID0gMTsgYnJlYWs7Ci0gICAgICAgICAgICAgICBjYXNlICdEJzogZHVyYXRpb24g
PSBwYXJzZV90aW1lX3N0cmluZyhvcHRhcmcpOwotICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsKKyAgICAgICAgICAgICAgIGNhc2UgJ3cnOiB0cmFjZXR5cGUgPSBXQUtFVVA7IGJyZWFrOwor
ICAgICAgICAgICAgICAgY2FzZSAnVyc6IHRyYWNldHlwZSA9IFdBS0VVUFJUOyBicmVhazsKICAg
ICAgICAgICAgICAgIGNhc2UgJz8nOiBlcnJvciA9IDE7IGJyZWFrOwogICAgICAgICAgICAgICAg
fQogICAgICAgIH0KCg==
--001636e1fca2f89a060466deb04c--
