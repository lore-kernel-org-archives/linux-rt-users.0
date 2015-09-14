From: =?UTF-8?B?Sm/Dq2wgS3LDpGhlbWFubg==?= <jkraehemann@gmail.com>
Subject: Re: 1 of 23 peformance problems at 30 to 40 percent system load
Date: Mon, 14 Sep 2015 16:47:46 +0200
Message-ID: <CA+Owze4S-eLRB90-B25V1=HYH6-Z2ay-vACmeOJsERAcvxh-4A@mail.gmail.com>
References: <CA+Owze7RC95-OD+bQi_M0zAJRke+WVf1t4nL+PF-k5iPg0gS7g@mail.gmail.com>
	<55ACED0C.4030403@gmail.com>
	<CA+Owze7Z244hAi7KH4SvP_XQoexmYvRsZDZLUx0oeUmD4-=45A@mail.gmail.com>
Reply-To: jkraehemann-guest@users.alioth.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: jkraehemann-guest@users.alioth.debian.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:36338 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbbINOrr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2015 10:47:47 -0400
Received: by ykdt18 with SMTP id t18so134541533ykd.3
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2015 07:47:46 -0700 (PDT)
In-Reply-To: <CA+Owze7Z244hAi7KH4SvP_XQoexmYvRsZDZLUx0oeUmD4-=45A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi

Today I was thinking about performance. Every system has its
properties e.g. acoustics has it's range within a bandwidth, light has
it's own oscillation range as well. These are all basically
mathematical systems whereby the
rule of performance can be applied. You might underload a system to
make certain properties visible like the amplitude of a wave. Within
finite computation with recursive precision you have to use the
harmonic oscillation
within the system.

Underload as a term would be defined as followig: An optimal system on
highest load shall slow down as underloading. In contrast as it
doesn't run at highest load it would be over-clocked.

In view of threads and the kernel, Linux would preferably be able to
handle more computation capacity on different loads. So concurrency
safety will be handled on compiler level.

About me, I don't code the kernel and don't have to deal with bits or
frequencies. Or at least in a more abstract manner, bits are the
things I switch on and off. Frequency is the synchronization rate I do
=2E..
How ever I really like maths. I hope you enjoy the show:

http://gsequencer.org

By the way electrons are able to tunnel what isn't handled by the
specifications above.

Bests,
Jo=C3=ABl Kr=C3=A4hemann




On Tue, Jul 21, 2015 at 3:47 AM, Jo=C3=ABl Kr=C3=A4hemann <jkraehemann@=
gmail.com> wrote:
> Hi
>
> The problem was more related to a memory leak what slowed the down th=
e computer.
> This is fixed for now. For me performance means you can do your work
> during a period in time.
> So good performance means stay in realtime.
>
> cheers,
> Jo=C3=ABl
>
> On Mon, Jul 20, 2015 at 2:43 PM, linuxball <linuxball@gmail.com> wrot=
e:
>> Hi Jo=C3=ABl,
>>
>> see remarks in the context below.
>>
>> Best regards,
>>
>> Wolfgang
>>
>> On 17.07.2015 22:05, Jo=C3=ABl Kr=C3=A4hemann wrote:
>>>
>>> Hi all,
>>>
>>> My name is Jo=C3=ABl Kr=C3=A4hemann, I'm developing:
>>>
>>> http://gsequencer.org
>>>
>>> and I'm using:
>>>
>>> Linux debian 4.0.5 #1 SMP PREEMPT Sat Jul 11 16:32:49 CEST 2015 x86=
_64
>>> GNU/Linux
>>
>> From the output it seems that the kernel you are using is NOT a RT k=
ernel
>> (otherwise "uname -v" should say "#1 SMP PREEMPT RT ..."). If you wa=
nt to
>> use a RT kernel you should build the kernel with PREEMPT_RT_FULL def=
ined.
>>>
>>> For now I encounter on my system performance problems at a load of =
30
>>> to 40 % system load, all 8 virtual cpu's have same average load.
>>
>> What do you mean when you talk about "performance problems"? How do =
they
>> manifest?
>>
>>> * `chrt` to higher priority doesn't give wished throughput.
>>
>> As you certainly know in general a RT kernel has worse throughput (b=
ut
>> better response times / lower latencies for time critical threads) t=
han a
>> generic kernel.
>>
>>> * `taskset` has ff as default.
>>> * `cpufreq-set -g performance` brings a little improvement for firs=
t
>>> seconds
>>>
>>> This is my CPU:
>>>
>>> Architecture:          x86_64
>>> CPU op-mode(s):        32-bit, 64-bit
>>> Byte Order:            Little Endian
>>> CPU(s):                8
>>> On-line CPU(s) list:   0-7
>>> Thread(s) per core:    2
>>> Core(s) per socket:    4
>>> Socket(s):             1
>>> NUMA node(s):          1
>>> Vendor ID:             GenuineIntel
>>> CPU family:            6
>>> Model:                 58
>>> Model name:            Intel(R) Core(TM) i7-3740QM CPU @ 2.70GHz
>>> Stepping:              9
>>> CPU MHz:               3275.648
>>> CPU max MHz:           3700.0000
>>> CPU min MHz:           1200.0000
>>> BogoMIPS:              5387.58
>>> Virtualization:        VT-x
>>> L1d cache:             32K
>>> L1i cache:             32K
>>> L2 cache:              256K
>>> L3 cache:              6144K
>>> NUMA node0 CPU(s):     0-7
>>>
>>>
>>> GSequencer uses many threads but doesn't stay in realtime. What am =
I
>>> doing wrong? Or how to gain more Performance out of the system?
>>
>> How do you define performance? If you want more throughput then try =
a
>> generic kernel. If you want shorter response times (lower latencies)=
 for
>> selected RT threads than use a RT kernel and tweak the thread priori=
ties of
>> the respective user and kernel threads in the processing chain. Make=
 sure
>> that you don't get priority inversion by using improper RT prio assi=
gnment,
>> e.g. participating IRQ threads from kernel should have higher or sam=
e RT
>> prio than threads processing data delivered by those IRQ threads. A =
good
>> example for audio applications is
>> http://subversion.ffado.org/wiki/IrqPriorities which shows priority =
settings
>> for JACK audio applications.
>>>
>>> I could imagine on my code side that vary frequency segmentation wo=
uld
>>> bring better throughput. By modeifing AGS_THREAD_DEFAULT_JIFFIE,
>>> AGS_THREAD_MAX_PRECISION and related.
>>>
>>> But for now I search for documentation about linux kernel performan=
ce
>>> counters.
>>>
>>> Best regards,
>>> Jo=C3=ABl Kr=C3=A4hemann
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-rt-=
users"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-rt-u=
sers" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
