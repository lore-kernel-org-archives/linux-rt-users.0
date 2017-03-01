From: Tracy Smith <tlsmith3777@gmail.com>
Subject: Re: Regression on rt kernel while using POSIX timers
Date: Wed, 1 Mar 2017 13:03:21 -0600
Message-ID: <472B70D9-E1AF-4D14-BE79-ABAAC74BA4DB@gmail.com>
References: <1486579285.29816.105.camel@intel.com> <20170210190708.gkx5pzxnd6uhfczn@linutronix.de> <1487011713.17279.27.camel@intel.com> <20170215165447.zr4k5rmenwvormdk@linutronix.de> <20170216020516.GB1733@jcartwri.amer.corp.natinst.com> <1487212458.10966.7.camel@intel.com> <1487727789.28401.17.camel@intel.com> <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Cc: "Patel, Vedang" <vedang.patel@intel.com>,
        "julia@ni.com" <julia@ni.com>,
        "ranshalit@gmail.com" <ranshalit@gmail.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Hart, Darren" <darren.hart@intel.com>
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33398 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbdCATMJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2017 14:12:09 -0500
Received: by mail-oi0-f67.google.com with SMTP id 2so3761189oif.0
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Mar 2017 11:10:24 -0800 (PST)
In-Reply-To: <20170301152230.mjoi44so6t5qy3q2@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Pleaee isolate the specific release where latency regression occurred if the=
 community has not already done so. Possibly backing out changes specific to=
 timers and posix threads for that release to see what impacted latency.  Th=
is is crucial for NXP and others as they migrate to later releases of the ke=
rnel.

Also please share your latency numbers while testing for regression for each=
 release if possible.

Using:

taskset -c 2 cyclictest -m -n -P -p 99 -t 1 -i 10000-136000000=20
taskset -c 3 cyclictest -m -n -P -p 99 -t  1 -i 10000000 -l 0

On an ARM-8 Cortex-A53 NXP LS1043ARDB 4x core the latency was approx 3 us mi=
n/avg and max 7 with no latency spikes on 4.1.30-rt34+g667e6ba SMP PREEMPT R=
T NXP SDK 2.0-1609.  Used sar, iperf, and stress for load.

Tracy Smith
Software Engineer
DSC



> On Mar 1, 2017, at 9:22 AM, "bigeasy@linutronix.de" <bigeasy@linutronix.de=
> wrote:
>=20
>> On 2017-02-22 01:43:09 [+0000], Patel, Vedang wrote:
>> Also, I checked the number of cpu migrations and context switches using
>> perf stat. Following are the results for both the cases:
>>=20
>> cyclictest not pinned to CPU: the number of CPU migrations and context
>> switches are equal to the number of loops I am running for cyclictest.
>> Here, there are a lot of context switches with the ktimersoftd process.
>>=20
>> cyclictest pinned to a CPU: there are very few CPU migrations. But, the
>> number of context switches are approximately 3 times the number of
>> loops. Most of the context switches are with the swapper (idle)
>> process.
>>=20
>> In both the cases, the number of page faults are pretty low (~65).
>>=20
>> I also tried similar experiments with mainline kernel (v4.4.47). The
>> number of CPU migrations were pretty low (single digits) for both the
>> cases described above. Also, the number of context switches were equal
>> to the number of loops provided as an argument to cyclictest.
>=20
> The hardware interrupt wakes the "timer-softirq" thread. This RT-thread
> in turn will wake up your application / cyclictest which uses the
> posix-timers. So the priority of this thread is also important. After
> the wakeup it is possible that the newer kernel tries migrate the RT
> task if possible in order to keep it running as soon as possible. If it
> does not migrate it, then either the cyclictest task has to wait or the
> "timer-softirq" thread.
>=20
>> Thanks,
>> Vedang Patel
>> Software Engineer
>> Intel Corporation
>=20
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
