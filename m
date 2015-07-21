From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: 1 of 23 peformance problems at 30 to 40 percent system load
Date: Tue, 21 Jul 2015 03:47:21 +0200
Message-ID: <CA+Owze7Z244hAi7KH4SvP_XQoexmYvRsZDZLUx0oeUmD4-=45A@mail.gmail.com>
References: <CA+Owze7RC95-OD+bQi_M0zAJRke+WVf1t4nL+PF-k5iPg0gS7g@mail.gmail.com>
	<55ACED0C.4030403@gmail.com>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: linuxball <linuxball@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34079 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbbGUBrV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 20 Jul 2015 21:47:21 -0400
Received: by ykax123 with SMTP id x123so154198939yka.1
        for <linux-rt-users@vger.kernel.org>; Mon, 20 Jul 2015 18:47:21 -0700 (PDT)
In-Reply-To: <55ACED0C.4030403@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

The problem was more related to a memory leak what slowed the down the =
computer.
This is fixed for now. For me performance means you can do your work
during a period in time.
So good performance means stay in realtime.

cheers,
Jo=C3=ABl

On Mon, Jul 20, 2015 at 2:43 PM, linuxball <linuxball@gmail.com> wrote:
> Hi Jo=C3=ABl,
>
> see remarks in the context below.
>
> Best regards,
>
> Wolfgang
>
> On 17.07.2015 22:05, Jo=C3=ABl Kr=C3=A4hemann wrote:
>>
>> Hi all,
>>
>> My name is Jo=C3=ABl Kr=C3=A4hemann, I'm developing:
>>
>> http://gsequencer.org
>>
>> and I'm using:
>>
>> Linux debian 4.0.5 #1 SMP PREEMPT Sat Jul 11 16:32:49 CEST 2015 x86_=
64
>> GNU/Linux
>
> From the output it seems that the kernel you are using is NOT a RT ke=
rnel
> (otherwise "uname -v" should say "#1 SMP PREEMPT RT ..."). If you wan=
t to
> use a RT kernel you should build the kernel with PREEMPT_RT_FULL defi=
ned.
>>
>> For now I encounter on my system performance problems at a load of 3=
0
>> to 40 % system load, all 8 virtual cpu's have same average load.
>
> What do you mean when you talk about "performance problems"? How do t=
hey
> manifest?
>
>> * `chrt` to higher priority doesn't give wished throughput.
>
> As you certainly know in general a RT kernel has worse throughput (bu=
t
> better response times / lower latencies for time critical threads) th=
an a
> generic kernel.
>
>> * `taskset` has ff as default.
>> * `cpufreq-set -g performance` brings a little improvement for first
>> seconds
>>
>> This is my CPU:
>>
>> Architecture:          x86_64
>> CPU op-mode(s):        32-bit, 64-bit
>> Byte Order:            Little Endian
>> CPU(s):                8
>> On-line CPU(s) list:   0-7
>> Thread(s) per core:    2
>> Core(s) per socket:    4
>> Socket(s):             1
>> NUMA node(s):          1
>> Vendor ID:             GenuineIntel
>> CPU family:            6
>> Model:                 58
>> Model name:            Intel(R) Core(TM) i7-3740QM CPU @ 2.70GHz
>> Stepping:              9
>> CPU MHz:               3275.648
>> CPU max MHz:           3700.0000
>> CPU min MHz:           1200.0000
>> BogoMIPS:              5387.58
>> Virtualization:        VT-x
>> L1d cache:             32K
>> L1i cache:             32K
>> L2 cache:              256K
>> L3 cache:              6144K
>> NUMA node0 CPU(s):     0-7
>>
>>
>> GSequencer uses many threads but doesn't stay in realtime. What am I
>> doing wrong? Or how to gain more Performance out of the system?
>
> How do you define performance? If you want more throughput then try a
> generic kernel. If you want shorter response times (lower latencies) =
for
> selected RT threads than use a RT kernel and tweak the thread priorit=
ies of
> the respective user and kernel threads in the processing chain. Make =
sure
> that you don't get priority inversion by using improper RT prio assig=
nment,
> e.g. participating IRQ threads from kernel should have higher or same=
 RT
> prio than threads processing data delivered by those IRQ threads. A g=
ood
> example for audio applications is
> http://subversion.ffado.org/wiki/IrqPriorities which shows priority s=
ettings
> for JACK audio applications.
>>
>> I could imagine on my code side that vary frequency segmentation wou=
ld
>> bring better throughput. By modeifing AGS_THREAD_DEFAULT_JIFFIE,
>> AGS_THREAD_MAX_PRECISION and related.
>>
>> But for now I search for documentation about linux kernel performanc=
e
>> counters.
>>
>> Best regards,
>> Jo=C3=ABl Kr=C3=A4hemann
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
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
