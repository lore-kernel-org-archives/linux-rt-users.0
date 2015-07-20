From: linuxball <linuxball@gmail.com>
Subject: Re: 1 of 23 peformance problems at 30 to 40 percent system load
Date: Mon, 20 Jul 2015 14:43:56 +0200
Message-ID: <55ACED0C.4030403@gmail.com>
References: <CA+Owze7RC95-OD+bQi_M0zAJRke+WVf1t4nL+PF-k5iPg0gS7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: jkraehemann-guest@users.alioth.debian.org,
	linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:33425 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbbGTMoA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 08:44:00 -0400
Received: by wgmn9 with SMTP id n9so129707901wgm.0
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2015 05:43:59 -0700 (PDT)
In-Reply-To: <CA+Owze7RC95-OD+bQi_M0zAJRke+WVf1t4nL+PF-k5iPg0gS7g@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Jo=C3=ABl,

see remarks in the context below.

Best regards,

Wolfgang

On 17.07.2015 22:05, Jo=C3=ABl Kr=C3=A4hemann wrote:
> Hi all,
>
> My name is Jo=C3=ABl Kr=C3=A4hemann, I'm developing:
>
> http://gsequencer.org
>
> and I'm using:
>
> Linux debian 4.0.5 #1 SMP PREEMPT Sat Jul 11 16:32:49 CEST 2015 x86_6=
4 GNU/Linux
 From the output it seems that the kernel you are using is NOT a RT=20
kernel (otherwise "uname -v" should say "#1 SMP PREEMPT RT ..."). If yo=
u=20
want to use a RT kernel you should build the kernel with PREEMPT_RT_FUL=
L=20
defined.
> For now I encounter on my system performance problems at a load of 30
> to 40 % system load, all 8 virtual cpu's have same average load.
What do you mean when you talk about "performance problems"? How do the=
y=20
manifest?

> * `chrt` to higher priority doesn't give wished throughput.
As you certainly know in general a RT kernel has worse throughput (but=20
better response times / lower latencies for time critical threads) than=
=20
a generic kernel.
> * `taskset` has ff as default.
> * `cpufreq-set -g performance` brings a little improvement for first =
seconds
>
> This is my CPU:
>
> Architecture:          x86_64
> CPU op-mode(s):        32-bit, 64-bit
> Byte Order:            Little Endian
> CPU(s):                8
> On-line CPU(s) list:   0-7
> Thread(s) per core:    2
> Core(s) per socket:    4
> Socket(s):             1
> NUMA node(s):          1
> Vendor ID:             GenuineIntel
> CPU family:            6
> Model:                 58
> Model name:            Intel(R) Core(TM) i7-3740QM CPU @ 2.70GHz
> Stepping:              9
> CPU MHz:               3275.648
> CPU max MHz:           3700.0000
> CPU min MHz:           1200.0000
> BogoMIPS:              5387.58
> Virtualization:        VT-x
> L1d cache:             32K
> L1i cache:             32K
> L2 cache:              256K
> L3 cache:              6144K
> NUMA node0 CPU(s):     0-7
>
>
> GSequencer uses many threads but doesn't stay in realtime. What am I
> doing wrong? Or how to gain more Performance out of the system?
How do you define performance? If you want more throughput then try a=20
generic kernel. If you want shorter response times (lower latencies) fo=
r=20
selected RT threads than use a RT kernel and tweak the thread prioritie=
s=20
of the respective user and kernel threads in the processing chain. Make=
=20
sure that you don't get priority inversion by using improper RT prio=20
assignment, e.g. participating IRQ threads from kernel should have=20
higher or same RT prio than threads processing data delivered by those=20
IRQ threads. A good example for audio applications is=20
http://subversion.ffado.org/wiki/IrqPriorities which shows priority=20
settings for JACK audio applications.
> I could imagine on my code side that vary frequency segmentation woul=
d
> bring better throughput. By modeifing AGS_THREAD_DEFAULT_JIFFIE,
> AGS_THREAD_MAX_PRECISION and related.
>
> But for now I search for documentation about linux kernel performance=
 counters.
>
> Best regards,
> Jo=C3=ABl Kr=C3=A4hemann
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
