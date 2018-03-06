Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx1.esisar.grenoble-inp.fr ([195.220.37.33]:49956 "EHLO
        mx1.esisar.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753821AbeCFVQ6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 6 Mar 2018 16:16:58 -0500
Date: Tue, 6 Mar 2018 22:16:50 +0100 (CET)
From: Yann le Chevoir <yann.le-chevoir@etu.esisar.grenoble-inp.fr>
Reply-To: Yann le Chevoir <yann.le-chevoir@grenoble-inp.org>
Message-ID: <2093164410.9598731.1520371010962.JavaMail.zimbra@etu.esisar.grenoble-inp.fr>
In-Reply-To: <20180302094343.xjyr6hndg4yrjxpo@linutronix.de>
References: <1431882400.9091188.1519852270876.JavaMail.zimbra@etu.esisar.grenoble-inp.fr> <20180302094343.xjyr6hndg4yrjxpo@linutronix.de>
Subject: Re: RT-thread on cpu0 affects performance of RT-thread on isolated
 cpu1
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_Part_9598729_1034779985.1520371010959"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

------=_Part_9598729_1034779985.1520371010959
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for helping :)

>> I am an engineering student and I try to proof that a 4000Hz hard real-t=
ime
>> application can run on an ARM board rather than on a more powerful machi=
ne.
>>=20
>> I work with an IMX6 dual-core and PREEMPT_RT patch-4.1.38-rt46.
>> I expected that my 4000Hz thread will perform better if it is the only o=
ne
>> on core1, so I put the boot argument isolcpus=3D1 and bound my thread to=
 cpu1.
>>=20
>> With the isolcpus=3D1, note that it remains these processes on core1:
>>=20
>>    PID    PSR    RTPRIO    CMD
>>    16     1      99        [migration/1]
>>    17     1      -         [rcuc/1]
>>    18     1      1         [ktimersoftd/1]
>>    19     1      -         [ksoftirqd/1]
>>    20     1      99        [posixcputmr/1]
>>    21     1      -         [kworker/1:0]
>>    22     1      -         [kworker/1:0H]
>>=20
>> I tried several permutations in my kernel configuration and boot args
>> (rcu_nocbs is an example) and none affected the results I describe below=
.
>=20
> In general with isolcpus you should be able to get most task off CPU1.
> The rcu_nocbs option should get the RCU callbacks off CPU1. And then you
> can change the IRQ affinity to CPU0. But this looks good.

As I said, in my previous message, I deactivated such options as I was not
sure and as I did not observe any enhancement when activating them.
I agree it is what I want so I reactivated them and my kernel config looks =
like:

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=3Dy
CONFIG_NO_HZ_FULL_ALL=3Dy
# CONFIG_NO_HZ_FULL_SYSIDLE is not set
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy

#
# RCU Subsystem
#
...
CONFIG_RCU_NOCB_CPU=3Dy
# CONFIG_RCU_NOCB_CPU_NONE is not set
# CONFIG_RCU_NOCB_CPU_ZERO is not set
CONFIG_RCU_NOCB_CPU_ALL=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
# CONFIG_CPU_FREQ_STAT is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
...
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
...
CONFIG_ARM_IMX6Q_CPUFREQ=3Dy
...

#
# CPU Idle
#
# CONFIG_CPU_IDLE is not set
# CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is not set

#
# Kernel Features
#
CONFIG_HZ_FIXED=3D0
CONFIG_HZ_100=3Dy
...
CONFIG_HZ=3D100




>> I use a script to stress Linux. I expected that only cpu0 will be stress=
ed
>> as cpu1 is isolated. But it has an impact on thread on cpu1 too.
>> I think it is normal.
>=20
> The CPU-caches might be shared. Locks which which are held by CPU0 and
> required by CPU1 will also slow down CPU1.
> The sched_switch tracer should show you if anything of your "script to
> stress" migrates to CPU1 and/or if the "delays" CPU1. That would make
> your task on CPU1 go from state R to D and back to R.

Thank you, I never used Linux kernel tracing before. It was not enabled in
my Kernel, I just did it. I have some results below.

>> First, as I draw it (in red) on =E2=80=9Cexpected_behavior.png=E2=80=9D,=
 I expected much less
>> variations in the Latency and especially the Execution time.
>> (My thread always does the same thing).
>=20
> You could try cyclictest and compare its latency. However from the plot
> it looks at about 25us so it is not that bad.
>=20
>> How can we explain so much time variations? As I said, I tried to deacti=
vate
>> all interrupts on cpu1 (rcu and others processes above) but I am not ver=
y
>> familiar with that.
>>
> As I suggested above, run sched_switch, measure the latency and if you
> hit an execution time of 150us then tell your application to disable the
> trace (a write '0' to the tracing_on sysfs file would do it) and then
> you can look at the trace and see if got interrupted by anything.
>=20
>> Then, I am even more surprised when, trying to debug that, I decided to =
put
>> another thread on core0 and it improved the behavior of the thread on co=
re1!
>=20
> If you put more load on the system and the numbers improve then this
> might be because the caches are filled with the "right" data. Also it
> might prevent power management from doing its job.

About power management, as you can see in the kernel conf, *it is enabled*
but *only the performance mode* is enabled.
Indeed, I already worked on that, I first deactivated it but then my clock
was not at its maximum.
I succeeded in getting the max clock frequency back by doing this.


>> My application looks like:

Thanks for reading the code :)
I already checked if next <=3D now, look how I did it in the updated code.
I changed to CLOCK_MONOTONIC, thanks.
I try to do error checking!

> =E2=80=A6
>> thread1(){
>>=20
>>      struct timespec start, stop, next, interval =3D 250us;
>>=20
>>      /* Initialization of the periodicity */
>>      clock_gettime(CLOCK_MONOTONIC, &next);
>>
>>      /* as time basis, try not to use a random time but start with usec =
=3D 25 *
>>       * or 50 or so. You should be able to avoid the HZ timer.          =
     */
>>      next.tv_sec +=3D 1;
>>      next.tv_nsec =3D 250000;

Is it what you expected I did?

>>      next +=3D interval;
>>=20
>>      while(1){
>>           /*Releases at specified rate*/
>>           if(clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &next, NULL=
) !=3D 0){
>>                perror("error");
>>                exit(-1);
>>           }
>>           /*Get time to check jitter and execution time*/
>>           if(clock_gettime(CLOCK_MONOTONIC, &start) !=3D 0){
>>                perror("error");
>>                exit(-1);
>>           }
>>           do_job();
>>           /*Get time to check execution time*/
>>           if(clock_gettime(CLOCK_MONOTONIC, &stop) !=3D 0){
>>                perror("error");
>>                exit(-1);
>>           }
>>           do_stat(); //jitter =3D start-next; exec_time =3D stop-start
>>           while(next <=3D stop){
>>                next +=3D interval;
>>           }
>>      }
>>=20
>> }
>>=20
>>=20
>> thread0(){
>>     struct timespec next, interval =3D 250us;
>>=20
>>      /* Initialization of the periodicity */
>>      clock_gettime(CLOCK_REALTIME, &next);
>>      next +=3D interval;
>>=20
>>      while(1){
>>           /*Releases at specified rate*/
>>           clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
>>           usleep(100);
>>           /*************************************************************=
***
>>            * Without sleeping 100us, only the Latency of the other threa=
d *
>>            * (on cpu1) is improved.                                     =
  *
>>            * Sleeping 100us in this new 4000Hz thread (cpu0) improved   =
  *
>>            * the execution time of the other thread (on cpu1)...        =
  *
>>            *************************************************************=
***/
>=20
> I'm not sure but it looks like the usleep() is implemented as a
> busy loop. A busy loop of 100us isn't *that* bad but if all RT tasks
> take around 950us then the scheduler will prevent all RT tasks from
> running (in order to prevent a possible lockup).
>=20
>>           next +=3D interval;
>>      }
>>=20
>> }
>>=20
>> As you can see in =E2=80=9Cbackground_thread_on_core_0.png=E2=80=9D, the=
 Latency and the
>> Execution time (of the thread on core1) are improved (in comparison with
>> =E2=80=9Cno_background_thread.png=E2=80=9D) when there is a new 4000Hz t=
hread on cpu0
>> AND when this thread does something...
>>=20
>> I tried a lot of permutations and I do not understand:
>> - If the new thread (cpu0) is at 5000Hz (>4000Hz), then observations
>>   are the same (performance of the thread on cpu1 improves)
>> - If the new thread is at 2000HZ (<4000Hz), then there is no improvement=
...
>>=20
>> - If the new thread (4000Hz on cpu0) does something (even sleeping enoug=
h
>>   time), then the Execution time of the thread on cpu1 improves.
>> - If the new thread does nothing (or do too few stuff), then, ONLY the
>>   Latency of the thread on cpu1 is improved...
>>=20
>> Do you have any experience with that, any idea to debug?
>=20
> - tracing to see if the scheduler puts another task on while your RT is
>  running
> - tracing to see if an interrupts fires which prevents your task from
>  running. This should only be the timer interrupt since everything else
>  should be only on CPU0.

I analyse a trace below.
There is only the ktimersoftd/1 task which comes back every 10000us.
I first had CONFIG_HZ=3D1000 so it was every 1000us then.
I first thought it was responsible for my problems.
But finally it seems not. I am not sure.

> - check if any power management is on and try to disable it.

As I said above, it is *on* but *only perf mode is allowed*. Is it correct?

> - as time basis, try not to use a random time but start with usec =3D 25 =
=20
> or 50 or so. You should be able to avoid the HZ timer.

I tried to start with usec =3D 25. Is it correct in the code above?

Do you talk about the CONFIG_NO_HZ option?
I am confident it is what I want, but, according to the documentation,
I am afraid:
   "POSIX CPU timers prevent CPUs from entering adaptive-tick mode.
   Real-time applications needing to take actions based on CPU time
   consumption need to use other means of doing so."
Indeed, I want to continue to use the POSIX CPU timer (sleep and gettime).

What's more, this test from Frederic fails:
https://kernel.googlesource.com/pub/scm/linux/kernel/git/frederic/dynticks-=
testing/+/9b39ab06956d484d5311e0678e1fba8104a8e2e3
According to this message, I can not stop tick:
user_loop-15296 [001] dn.....  8131.952509: tick_stop: success=3Dno msg=3Dm=
ore than 1 task in runqueue
Moreover, I do not see this message when tracing my application below.




I attached the trace (trace.txt) to this message.
The trace stopped when exec_time was more than 200us.

I "normalized" (put to 0) the timestamp two times to understand what
is going on.

What I understand:

Lines 5-8:   It is the clock_nanosleep handler.
             It takes 13us to wake up the thread. Good.
Line 9:      The thread took 60us to run. Very good.
Line 10:     Let's start again 250us later. Good.
Line 11:     tick_sched_timer... It will wake up the ktimersoftd/1.
             I am afraid :(
Line 15:     It tooks 35us to wake up the thread...
             Not so bad, sometimes it is more...
Line 16:     The thread took 68us to run. Ok.
Lines 17-19: ktimersoftd/1 took 17us to run (370-353).
             I think it is not so embarrassing. I am reassured :)=20
...
Line 69:     1000us, ok
Line 74:     1256us, 6us late :(
Line 77:     36us to wake up the thread, +6us =3D 42us jitter :( :(
Line 78:     ***255us (1547-1292) execution time !!!***
Line 79:     Overrun, next rdv at 1750us, 8us late...

Does this trace help?
According to me, there is nothing on CPU1. There is just this ktimersoftd/1=
.
Can the idle task (on cpu0) be delayed by the stress on cpu0?
Can we migrate the Linux scheduler to cpu1?

Thanks again,

Yann
------=_Part_9598729_1034779985.1520371010959
Content-Type: text/plain; name=trace.txt
Content-Disposition: attachment; filename=trace.txt
Content-Transfer-Encoding: base64

CS4JDQoJLgkNCgkuCQ0KCQkNCiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZC4uaDEuLiAg
CTAJOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+
LTAgICAgIFswMDFdIGQuLmgxLi4gIAkyCTogaHJ0aW1lcl9leHBpcmVfZW50cnk6IGhydGltZXI9
OTgxMTdlZjAgZnVuY3Rpb249aHJ0aW1lcl93YWtldXAgbm93PTE4NjQ1Njk3NTQ4ODYNCiAgICAg
ICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZG4uaDEuLiAgCTcJOiBpcnFfaGFuZGxlcl9leGl0OiBp
cnE9MTYgcmV0PWhhbmRsZWQNCiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZC4uLjIuLiAg
CTEzCTogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09c3dhcHBlci8xIHByZXZfcGlkPTAgcHJldl9w
cmlvPTEyMCBwcmV2X3N0YXRlPVIgPT0+IG5leHRfY29tbT10ZXN0X3ByZWVtcHQgbmV4dF9waWQ9
NTU4MyBuZXh0X3ByaW89MQ0KICAgIHRlc3RfcHJlZW1wdC01NTgzICBbMDAxXSBkLi4uMi4uICAJ
NzMJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT10ZXN0X3ByZWVtcHQgcHJldl9waWQ9NTU4MyBw
cmV2X3ByaW89MSBwcmV2X3N0YXRlPVMgPT0+IG5leHRfY29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9
MCBuZXh0X3ByaW89MTIwDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAky
NTAJOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+
LTAgICAgIFswMDFdIGQuLmgxLi4gIAkyNTMJOiBocnRpbWVyX2V4cGlyZV9lbnRyeTogaHJ0aW1l
cj1iZjdhZjk5MCBmdW5jdGlvbj10aWNrX3NjaGVkX3RpbWVyIG5vdz0xODY0NTcwMDA1NTUzDQog
ICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAkyNTkJOiBzb2Z0aXJxX3JhaXNl
OiB2ZWM9MSBbYWN0aW9uPVRJTUVSXQ0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkLi5o
MS4uICAJMjYzCTogaHJ0aW1lcl9leHBpcmVfZW50cnk6IGhydGltZXI9OTgxMTdlZjAgZnVuY3Rp
b249aHJ0aW1lcl93YWtldXAgbm93PTE4NjQ1NzAwMDU1NTMNCiAgICAgICAgICA8aWRsZT4tMCAg
ICAgWzAwMV0gZG4uaDEuLiAgCTI2OAk6IGlycV9oYW5kbGVyX2V4aXQ6IGlycT0xNiByZXQ9aGFu
ZGxlZA0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkLi4uMi4uICAJMjg1CTogc2NoZWRf
c3dpdGNoOiBwcmV2X2NvbW09c3dhcHBlci8xIHByZXZfcGlkPTAgcHJldl9wcmlvPTEyMCBwcmV2
X3N0YXRlPVIgPT0+IG5leHRfY29tbT10ZXN0X3ByZWVtcHQgbmV4dF9waWQ9NTU4MyBuZXh0X3By
aW89MQ0KICAgIHRlc3RfcHJlZW1wdC01NTgzICBbMDAxXSBkLi4uMi4uICAJMzUzCTogc2NoZWRf
c3dpdGNoOiBwcmV2X2NvbW09dGVzdF9wcmVlbXB0IHByZXZfcGlkPTU1ODMgcHJldl9wcmlvPTEg
cHJldl9zdGF0ZT1TID09PiBuZXh0X2NvbW09a3RpbWVyc29mdGQvMSBuZXh0X3BpZD0yMSBuZXh0
X3ByaW89OTgNCiAgIGt0aW1lcnNvZnRkLzEtMjEgICAgWzAwMV0gLi4uLi4xMSAgCTM2MQk6IHNv
ZnRpcnFfZW50cnk6IHZlYz0xIFthY3Rpb249VElNRVJdDQogICBrdGltZXJzb2Z0ZC8xLTIxICAg
IFswMDFdIC4uLi4uMTEgIAkzNjQJOiBzb2Z0aXJxX2V4aXQ6IHZlYz0xIFthY3Rpb249VElNRVJd
DQogICBrdGltZXJzb2Z0ZC8xLTIxICAgIFswMDFdIGQuLi4yLi4gIAkzNzAJOiBzY2hlZF9zd2l0
Y2g6IHByZXZfY29tbT1rdGltZXJzb2Z0ZC8xIHByZXZfcGlkPTIxIHByZXZfcHJpbz05OCBwcmV2
X3N0YXRlPVMgPT0+IG5leHRfY29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9MCBuZXh0X3ByaW89MTIw
DQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAk1MDEJOiBpcnFfaGFuZGxl
cl9lbnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQu
LmgxLi4gIAk1MDUJOiBocnRpbWVyX2V4cGlyZV9lbnRyeTogaHJ0aW1lcj05ODExN2VmMCBmdW5j
dGlvbj1ocnRpbWVyX3dha2V1cCBub3c9MTg2NDU3MDI1NzIyMA0KICAgICAgICAgIDxpZGxlPi0w
ICAgICBbMDAxXSBkbi5oMS4uICAJNTEyCTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE2IHJldD1o
YW5kbGVkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLi4yLi4gIAk1MjAJOiBzY2hl
ZF9zd2l0Y2g6IHByZXZfY29tbT1zd2FwcGVyLzEgcHJldl9waWQ9MCBwcmV2X3ByaW89MTIwIHBy
ZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21tPXRlc3RfcHJlZW1wdCBuZXh0X3BpZD01NTgzIG5leHRf
cHJpbz0xDQogICAgdGVzdF9wcmVlbXB0LTU1ODMgIFswMDFdIGQuLi4yLi4gIAk2MDUJOiBzY2hl
ZF9zd2l0Y2g6IHByZXZfY29tbT10ZXN0X3ByZWVtcHQgcHJldl9waWQ9NTU4MyBwcmV2X3ByaW89
MSBwcmV2X3N0YXRlPVMgPT0+IG5leHRfY29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9MCBuZXh0X3By
aW89MTIwDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAk3NTAJOiBpcnFf
aGFuZGxlcl9lbnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFsw
MDFdIGQuLmgxLi4gIAk3NTQJOiBocnRpbWVyX2V4cGlyZV9lbnRyeTogaHJ0aW1lcj05ODExN2Vm
MCBmdW5jdGlvbj1ocnRpbWVyX3dha2V1cCBub3c9MTg2NDU3MDUwNjIyMA0KICAgICAgICAgIDxp
ZGxlPi0wICAgICBbMDAxXSBkbi5oMS4uICAJNzYwCTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE2
IHJldD1oYW5kbGVkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLi4yLi4gIAk3NjcJ
OiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT1zd2FwcGVyLzEgcHJldl9waWQ9MCBwcmV2X3ByaW89
MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21tPXRlc3RfcHJlZW1wdCBuZXh0X3BpZD01NTgz
IG5leHRfcHJpbz0xDQogICAgdGVzdF9wcmVlbXB0LTU1ODMgIFswMDFdIGQuLi4yLi4gIAk4NDEJ
OiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT10ZXN0X3ByZWVtcHQgcHJldl9waWQ9NTU4MyBwcmV2
X3ByaW89MSBwcmV2X3N0YXRlPVMgPT0+IG5leHRfY29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9MCBu
ZXh0X3ByaW89MTIwDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAkxMDAw
CTogaXJxX2hhbmRsZXJfZW50cnk6IGlycT0xNiBuYW1lPXR3ZA0KICAgICAgICAgIDxpZGxlPi0w
ICAgICBbMDAxXSBkLi5oMS4uICAJMTAwNAk6IGhydGltZXJfZXhwaXJlX2VudHJ5OiBocnRpbWVy
PTk4MTE3ZWYwIGZ1bmN0aW9uPWhydGltZXJfd2FrZXVwIG5vdz0xODY0NTcwNzU1MjIwDQogICAg
ICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGRuLmgxLi4gIAkxMDEwCTogaXJxX2hhbmRsZXJfZXhp
dDogaXJxPTE2IHJldD1oYW5kbGVkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLi4y
Li4gIAkxMDE2CTogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09c3dhcHBlci8xIHByZXZfcGlkPTAg
cHJldl9wcmlvPTEyMCBwcmV2X3N0YXRlPVIgPT0+IG5leHRfY29tbT10ZXN0X3ByZWVtcHQgbmV4
dF9waWQ9NTU4MyBuZXh0X3ByaW89MQ0KICAgIHRlc3RfcHJlZW1wdC01NTgzICBbMDAxXSBkLi4u
Mi4uICAJMTA4OAk6IHNjaGVkX3N3aXRjaDogcHJldl9jb21tPXRlc3RfcHJlZW1wdCBwcmV2X3Bp
ZD01NTgzIHByZXZfcHJpbz0xIHByZXZfc3RhdGU9UyA9PT4gbmV4dF9jb21tPXN3YXBwZXIvMSBu
ZXh0X3BpZD0wIG5leHRfcHJpbz0xMjANCiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZC4u
aDEuLiAgCTEyNTAJOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAg
ICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAkxMjU0CTogaHJ0aW1lcl9leHBpcmVfZW50
cnk6IGhydGltZXI9OTgxMTdlZjAgZnVuY3Rpb249aHJ0aW1lcl93YWtldXAgbm93PTE4NjQ1NzEw
MDU4ODYNCiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZG4uaDEuLiAgCTEyNTkJOiBpcnFf
aGFuZGxlcl9leGl0OiBpcnE9MTYgcmV0PWhhbmRsZWQNCiAgICAgICAgICA8aWRsZT4tMCAgICAg
WzAwMV0gZC4uLjIuLiAgCTEyNjUJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT1zd2FwcGVyLzEg
cHJldl9waWQ9MCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21tPXRlc3Rf
cHJlZW1wdCBuZXh0X3BpZD01NTgzIG5leHRfcHJpbz0xDQoJCQ0KCS4JDQoJLgkNCgkuCQ0KCQkN
CiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZC4uaDEuLiAgCTAJOiBpcnFfaGFuZGxlcl9l
bnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgx
Li4gIAkzCTogaHJ0aW1lcl9leHBpcmVfZW50cnk6IGhydGltZXI9YmY3YWY5OTAgZnVuY3Rpb249
dGlja19zY2hlZF90aW1lciBub3c9MTg2NDU4MDAwNTg4Ng0KICAgICAgICAgIDxpZGxlPi0wICAg
ICBbMDAxXSBkLi5oMS4uICAJMTAJOiBzb2Z0aXJxX3JhaXNlOiB2ZWM9MSBbYWN0aW9uPVRJTUVS
XQ0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkLi5oMS4uICAJMTUJOiBocnRpbWVyX2V4
cGlyZV9lbnRyeTogaHJ0aW1lcj05ODExN2VmMCBmdW5jdGlvbj1ocnRpbWVyX3dha2V1cCBub3c9
MTg2NDU4MDAwNTg4Ng0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkbi5oMS4uICAJMjEJ
OiBpcnFfaGFuZGxlcl9leGl0OiBpcnE9MTYgcmV0PWhhbmRsZWQNCiAgICAgICAgICA8aWRsZT4t
MCAgICAgWzAwMV0gZC4uLjIuLiAgCTQxCTogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09c3dhcHBl
ci8xIHByZXZfcGlkPTAgcHJldl9wcmlvPTEyMCBwcmV2X3N0YXRlPVIgPT0+IG5leHRfY29tbT10
ZXN0X3ByZWVtcHQgbmV4dF9waWQ9NTU4MyBuZXh0X3ByaW89MQ0KICAgIHRlc3RfcHJlZW1wdC01
NTgzICBbMDAxXSBkLi4uMi4uICAJMTIzCTogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09dGVzdF9w
cmVlbXB0IHByZXZfcGlkPTU1ODMgcHJldl9wcmlvPTEgcHJldl9zdGF0ZT1TID09PiBuZXh0X2Nv
bW09a3RpbWVyc29mdGQvMSBuZXh0X3BpZD0yMSBuZXh0X3ByaW89OTgNCiAgIGt0aW1lcnNvZnRk
LzEtMjEgICAgWzAwMV0gLi4uLi4xMSAgCTEzNQk6IHNvZnRpcnFfZW50cnk6IHZlYz0xIFthY3Rp
b249VElNRVJdDQogICBrdGltZXJzb2Z0ZC8xLTIxICAgIFswMDFdIC4uLi4uMTEgIAkxMzgJOiBz
b2Z0aXJxX2V4aXQ6IHZlYz0xIFthY3Rpb249VElNRVJdDQogICBrdGltZXJzb2Z0ZC8xLTIxICAg
IFswMDFdIGQuLi4yLi4gIAkxNDcJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT1rdGltZXJzb2Z0
ZC8xIHByZXZfcGlkPTIxIHByZXZfcHJpbz05OCBwcmV2X3N0YXRlPVMgPT0+IG5leHRfY29tbT1z
d2FwcGVyLzEgbmV4dF9waWQ9MCBuZXh0X3ByaW89MTIwDQogICAgICAgICAgPGlkbGU+LTAgICAg
IFswMDFdIGQuLmgxLi4gIAkyNTEJOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTE2IG5hbWU9dHdk
DQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAkyNTUJOiBocnRpbWVyX2V4
cGlyZV9lbnRyeTogaHJ0aW1lcj05ODExN2VmMCBmdW5jdGlvbj1ocnRpbWVyX3dha2V1cCBub3c9
MTg2NDU4MDI1NjU1Mw0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkbi5oMS4uICAJMjYw
CTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE2IHJldD1oYW5kbGVkDQogICAgICAgICAgPGlkbGU+
LTAgICAgIFswMDFdIGQuLi4yLi4gIAkyNjcJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT1zd2Fw
cGVyLzEgcHJldl9waWQ9MCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21t
PXRlc3RfcHJlZW1wdCBuZXh0X3BpZD01NTgzIG5leHRfcHJpbz0xDQogICAgdGVzdF9wcmVlbXB0
LTU1ODMgIFswMDFdIGQuLi4yLi4gIAkzNTkJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT10ZXN0
X3ByZWVtcHQgcHJldl9waWQ9NTU4MyBwcmV2X3ByaW89MSBwcmV2X3N0YXRlPVMgPT0+IG5leHRf
Y29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9MCBuZXh0X3ByaW89MTIwDQogICAgICAgICAgPGlkbGU+
LTAgICAgIFswMDFdIGQuLmgxLi4gIAk1MDAJOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJxPTE2IG5h
bWU9dHdkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAk1MDQJOiBocnRp
bWVyX2V4cGlyZV9lbnRyeTogaHJ0aW1lcj05ODExN2VmMCBmdW5jdGlvbj1ocnRpbWVyX3dha2V1
cCBub3c9MTg2NDU4MDUwNjIyMA0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkbi5oMS4u
ICAJNTEwCTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE2IHJldD1oYW5kbGVkDQogICAgICAgICAg
PGlkbGU+LTAgICAgIFswMDFdIGQuLi4yLi4gIAk1MTkJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29t
bT1zd2FwcGVyLzEgcHJldl9waWQ9MCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4
dF9jb21tPXRlc3RfcHJlZW1wdCBuZXh0X3BpZD01NTgzIG5leHRfcHJpbz0xDQogICAgdGVzdF9w
cmVlbXB0LTU1ODMgIFswMDFdIGQuLi4yLi4gIAk2MTAJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29t
bT10ZXN0X3ByZWVtcHQgcHJldl9waWQ9NTU4MyBwcmV2X3ByaW89MSBwcmV2X3N0YXRlPVMgPT0+
IG5leHRfY29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9MCBuZXh0X3ByaW89MTIwDQogICAgICAgICAg
PGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAk3NTAJOiBpcnFfaGFuZGxlcl9lbnRyeTogaXJx
PTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAk3NTQJ
OiBocnRpbWVyX2V4cGlyZV9lbnRyeTogaHJ0aW1lcj05ODExN2VmMCBmdW5jdGlvbj1ocnRpbWVy
X3dha2V1cCBub3c9MTg2NDU4MDc1NTg4Ng0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBk
bi5oMS4uICAJNzYwCTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE2IHJldD1oYW5kbGVkDQogICAg
ICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLi4yLi4gIAk3NjkJOiBzY2hlZF9zd2l0Y2g6IHBy
ZXZfY29tbT1zd2FwcGVyLzEgcHJldl9waWQ9MCBwcmV2X3ByaW89MTIwIHByZXZfc3RhdGU9UiA9
PT4gbmV4dF9jb21tPXRlc3RfcHJlZW1wdCBuZXh0X3BpZD01NTgzIG5leHRfcHJpbz0xDQogICAg
dGVzdF9wcmVlbXB0LTU1ODMgIFswMDFdIGQuLi4yLi4gIAk4NTYJOiBzY2hlZF9zd2l0Y2g6IHBy
ZXZfY29tbT10ZXN0X3ByZWVtcHQgcHJldl9waWQ9NTU4MyBwcmV2X3ByaW89MSBwcmV2X3N0YXRl
PVMgPT0+IG5leHRfY29tbT1zd2FwcGVyLzEgbmV4dF9waWQ9MCBuZXh0X3ByaW89MTIwDQogICAg
ICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLmgxLi4gIAkxMDAwCTogaXJxX2hhbmRsZXJfZW50
cnk6IGlycT0xNiBuYW1lPXR3ZA0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkLi5oMS4u
ICAJMTAwNAk6IGhydGltZXJfZXhwaXJlX2VudHJ5OiBocnRpbWVyPTk4MTE3ZWYwIGZ1bmN0aW9u
PWhydGltZXJfd2FrZXVwIG5vdz0xODY0NTgxMDA1ODg2DQogICAgICAgICAgPGlkbGU+LTAgICAg
IFswMDFdIGRuLmgxLi4gIAkxMDEwCTogaXJxX2hhbmRsZXJfZXhpdDogaXJxPTE2IHJldD1oYW5k
bGVkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFswMDFdIGQuLi4yLi4gIAkxMDE3CTogc2NoZWRf
c3dpdGNoOiBwcmV2X2NvbW09c3dhcHBlci8xIHByZXZfcGlkPTAgcHJldl9wcmlvPTEyMCBwcmV2
X3N0YXRlPVIgPT0+IG5leHRfY29tbT10ZXN0X3ByZWVtcHQgbmV4dF9waWQ9NTU4MyBuZXh0X3By
aW89MQ0KICAgIHRlc3RfcHJlZW1wdC01NTgzICBbMDAxXSBkLi4uMi4uICAJMTExMAk6IHNjaGVk
X3N3aXRjaDogcHJldl9jb21tPXRlc3RfcHJlZW1wdCBwcmV2X3BpZD01NTgzIHByZXZfcHJpbz0x
IHByZXZfc3RhdGU9UyA9PT4gbmV4dF9jb21tPXN3YXBwZXIvMSBuZXh0X3BpZD0wIG5leHRfcHJp
bz0xMjANCiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZC4uaDEuLiAgCTEyNTYJOiBpcnFf
aGFuZGxlcl9lbnRyeTogaXJxPTE2IG5hbWU9dHdkDQogICAgICAgICAgPGlkbGU+LTAgICAgIFsw
MDFdIGQuLmgxLi4gIAkxMjY1CTogaHJ0aW1lcl9leHBpcmVfZW50cnk6IGhydGltZXI9OTgxMTdl
ZjAgZnVuY3Rpb249aHJ0aW1lcl93YWtldXAgbm93PTE4NjQ1ODEyNjQyMjANCiAgICAgICAgICA8
aWRsZT4tMCAgICAgWzAwMV0gZG4uaDEuLiAgCTEyNzcJOiBpcnFfaGFuZGxlcl9leGl0OiBpcnE9
MTYgcmV0PWhhbmRsZWQNCiAgICAgICAgICA8aWRsZT4tMCAgICAgWzAwMV0gZC4uLjIuLiAgCTEy
OTIJOiBzY2hlZF9zd2l0Y2g6IHByZXZfY29tbT1zd2FwcGVyLzEgcHJldl9waWQ9MCBwcmV2X3By
aW89MTIwIHByZXZfc3RhdGU9UiA9PT4gbmV4dF9jb21tPXRlc3RfcHJlZW1wdCBuZXh0X3BpZD01
NTgzIG5leHRfcHJpbz0xDQogICAgdGVzdF9wcmVlbXB0LTU1ODMgIFswMDFdIGQuLi4yLi4gIAkx
NTQ3CTogc2NoZWRfc3dpdGNoOiBwcmV2X2NvbW09dGVzdF9wcmVlbXB0IHByZXZfcGlkPTU1ODMg
cHJldl9wcmlvPTEgcHJldl9zdGF0ZT1TID09PiBuZXh0X2NvbW09c3dhcHBlci8xIG5leHRfcGlk
PTAgbmV4dF9wcmlvPTEyMA0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkLi5oMS4uICAJ
MTc1OAk6IGlycV9oYW5kbGVyX2VudHJ5OiBpcnE9MTYgbmFtZT10d2QNCiAgICAgICAgICA8aWRs
ZT4tMCAgICAgWzAwMV0gZC4uaDEuLiAgCTE3NzAJOiBocnRpbWVyX2V4cGlyZV9lbnRyeTogaHJ0
aW1lcj05ODExN2VmMCBmdW5jdGlvbj1ocnRpbWVyX3dha2V1cCBub3c9MTg2NDU4MTc2NzIyMA0K
ICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBkbi5oMS4uICAJMTc4OAk6IGlycV9oYW5kbGVy
X2V4aXQ6IGlycT0xNiByZXQ9aGFuZGxlZA0KICAgICAgICAgIDxpZGxlPi0wICAgICBbMDAxXSBk
Li4uMi4uICAJMTgwOAk6IHNjaGVkX3N3aXRjaDogcHJldl9jb21tPXN3YXBwZXIvMSBwcmV2X3Bp
ZD0wIHByZXZfcHJpbz0xMjAgcHJldl9zdGF0ZT1SID09PiBuZXh0X2NvbW09dGVzdF9wcmVlbXB0
IG5leHRfcGlkPTU1ODMgbmV4dF9wcmlvPTENCg0KCWV4ZWNfdGltZSA+IDIwMCA6IGVjaG8gMCA+
IHRyYWNpbmdfb24NCgkJDQo=
------=_Part_9598729_1034779985.1520371010959--
