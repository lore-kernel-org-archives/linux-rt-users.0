From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: cyclictest better values with system load than without (OMAP3530
 target)
Date: Fri, 29 Nov 2013 16:10:03 +0100
Message-ID: <5298AE4B.7070806@osadl.org>
References: <5294681E.10406@gmail.com> <20131126101232.21636c8f@sluggy> <20131129125623.GB31099@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Stefan Roese <stefan.roese@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:33569 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab3K2QJU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 11:09:20 -0500
In-Reply-To: <20131129125623.GB31099@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/29/2013 01:56 PM, Sebastian Andrzej Siewior wrote:
> * Clark Williams | 2013-11-26 10:12:32 [-0600]:
>
>> In my experience (on x86_64 mainly), that behavior (worse times when
>> not under load) is due to the overhead of coming out of power-save/i=
dle
>> states. When you've got a big load on the system and all the cores a=
re
>> active, then the power-save logic and/or the idle logic doesn't kick=
 in
>> and devices aren't being powered down.
> This is the case here, too. The overhead comming out of a deep power
> state plus the invalidated caches.
Sorry, I feel that the discussion a somewhat out of sync with the=20
original posting. Let me explain.

Among others, processors may use two completely different interfaces to=
=20
save power:
1. Sleep states aka C states, Linux interface cpuidle
2. Clock frequency modulation aka P states, Linux interface cpufreq

1. Sleep states
Processors may come with a number of C states from light sleep to deep=20
sleep to save power when idle. The longer a processor is idle, the=20
deeper normally is the sleep state the processor may enter. Sleep state=
s=20
may be disabled i) on a per-processor and per-state basis in=20
/sys/devices/system/cpu/cpuX/cpuidle/stateX/disable or ii) altogether=20
using the somewhat mislabeled /dev/cpu_dma_latency pseudo device. As fa=
r=20
as cyclictest is concerned, sleep states normally are disabled=20
altogether. If this is the case, cyclictest prints the message:
# /dev/cpu_dma_latency set to 0us
The original posting contains this line. In consequence, sleep states=20
cannot be responsible for any observed latency prolongation. To check=20
whether sleep states are disabled, the command
   # cat /sys/devices/system/cpu/cpu0/cpuidle/state?/time
may be used repeatedly for every CPU. If sleep states are disabled=20
correctly, only the first state (poll state) may increase such as

# cat /sys/devices/system/cpu/cpu0/cpuidle/state?/time
444330737734
234393550
1760323375
1234658099
183251179053

and sometime later

# cat /sys/devices/system/cpu/cpu0/cpuidle/state?/time
444417947595
234393550
1760323375
1234658099
183251179053

BTW: The cyclictest source contains a related comment:
/* Latency trick
  * if the file /dev/cpu_dma_latency exists,
  * open it and write a zero into it. This will tell
  * the power management system not to transition to
  * a high cstate (in fact, the system acts like idle=3Dpoll)
  * When the fd to /dev/cpu_dma_latency is closed, the behavior
  * goes back to the system default.
  *
  * Documentation/power/pm_qos_interface.txt
  */

2. Clock frequency modulation
This is an entirely different story as cylictest has no business with i=
t=20
at all. The clock frequency of x86 processors has a more or less linear=
=20
effect on latency, e.g. a system running at 1 GHz will show a latency=20
that is twice as high as when running at 2 GHz. ARM processors, however=
,=20
behave differently. Many ARM cores do not provide acceptable latency=20
values unless running at full speed. It is, therefore, often mandatory=20
to switch to the performance CPU frequency governor before starting=20
cyclictest or before running a real-world user space application that=20
relies on minimum latency. The /sys/devices/system/cpu/cpu0/cpufreq=20
interface is available to manage P states:
Switch to maximum performance:
cd /sys/devices/system/cpu/
for i in cpu?/cpufreq/scaling_governor
do
   echo performance >$i
done
Switch to on-demand frequency modulation:
for i in cpu?/cpufreq/scaling_governor
do
   echo ondemand >$i
done

BTW: Power saving and real-time do not necessarily exclude each other.=20
If a - still deterministic - but a little longer latency is acceptable,=
=20
some light sleep states and a somewhat lower clock frequency may be=20
allowed which still may result in considerable energy saving. If,=20
however, the fastest possible real-time response is required, C states=20
and P states must be disabled (or set to polling and maximum speed,=20
repsectively) and the power bill must be payed.

> So the test now finally has better results on a idle system than on
> one with heavy system load. The numbers are still far away from your
> latency values on the 1.2GHz Kirkwood. Does anybody have OMAP3
> values at hand to compare?
This is why we run the OSADL QA Farm. An AM3359 system is in rack 7,=20
slot 5 -> https://www.osadl.org/?id=3D1590. We run 100 million cycles w=
ith=20
200 =C2=B5s cycle interval (which takes about 5 hours and 33 minutes) t=
o=20
obtain reliable data. In addition, the processor is in idle state but=20
also executing defined load scenarios during the recording. Please do=20
the same before you compare the results. To facilitate the comparison,=20
the cyclictest command line is given below every plot, and any other=20
relevant information (including kernel command line) is available in th=
e=20
systems' profiles.

Hope this helps,
	-Carsten.
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
