From: =?ISO-8859-1?Q?Max_M=FCller?= <mxmr@gmx.net>
Subject: Re: Tweak Latency on Intel ATOM
Date: Mon, 15 Feb 2010 10:32:54 +0100
Message-ID: <4B7914C6.8080005@gmx.net>
References: <loom.20100209T081421-234@post.gmane.org>	<20100210163818.7f54ec3a@torg>	<4B73B7B5.4070509@gmx.net> <20100211093447.3c0a97cd@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:18197 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614Ab0BOJc5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Feb 2010 04:32:57 -0500
In-Reply-To: <20100211093447.3c0a97cd@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Clark Williams schrieb:
> On Thu, 11 Feb 2010 08:54:29 +0100
> Max M=FCller <mxmr@gmx.net> wrote:
>
>  =20
>> Clark Williams schrieb:
>>    =20
>>> On Tue, 9 Feb 2010 07:41:58 +0000 (UTC)
>>> Max Miller <mxmr@gmx.net> wrote:
>>>
>>>  =20
>>>      =20
>>>> Hello,
>>>>
>>>> im am using the PREEMPT-RT patch on linux 2.6.29.6. It runs on a M=
SI965GSE
>>>> industial board with Intel ATOM CPU (N270, 1,6GHz) and i945GSE Nor=
thbridge.=20
>>>>
>>>> I got about 45=B5s as maximum and 13=B5s as average latency when h=
yperthreading is
>>>> disabled. With enabled Hyperthreading the maximum latency increses=
 to about
>>>> 100=B5s. I measured the latency with cyclictest.=20
>>>>
>>>> What can i do to get better maximum latency? Can I do somthing in =
the kernel
>>>> configuration or are there some kernel bootoptions? Or is it still=
 impossible
>>>> with this CPU to get better results?
>>>>
>>>> Thanks in advance,
>>>> Max Miller=20
>>>>
>>>>
>>>>    =20
>>>>        =20
>>> Make sure you turn off any power management settings in the BIOS an=
d
>>> turn off the irqbalance and cpuspeed services on the Linux side.
>>>
>>> What cyclictest command are you using to measure latency?
>>>
>>> Clark
>>>  =20
>>>      =20
>> I run cyclictest as follows:
>>
>> cyclictest -n -t3 -p99
>>    =20
>
> You might want to try the new cyclictest option --smp (which is reall=
y
> the options -t, -a -n) and I'd back the priority down to -p95 just to
> keep out of the way of watchdog and migration threads. In general, wh=
en
> I run it on a multi-core box I use:
>
> 	$ cyclictest --smp -m -p95 -d0
>
> Lately on AMD boxes I use --numa, which makes calls into libnuma to
> allocated memory on local nodes for the measurement threads.
>
> If you want to get fancy and look at at the history of the run, you c=
an
> use the -h <n> option to keep a histogram of <n> buckets (1 bucket =3D=
=3D 1
> microsecond).=20
>
>  =20
>> For generating additional system load i run (one to several instance=
s):
>>
>> while true; do echo "blah" > /dev/null; done &
>>
>> Then i watch the max. latency from the thread with the highest prior=
ity.
>> Sometimes i add the parameter '-h' to generate a history. In this=20
>> history i can
>> see that the most latency times are under 20=B5s, only  about 5ppm a=
re=20
>> worse than 30=B5s.
>> Am i doing this correctly?
>>    =20
>
> You're seeing some nice numbers there (any max latency under 100us is
> pretty good).=20
>
> I have a python program I've been developing named 'rteval' which kic=
ks
> off a kernel compile and a scheduler benchmark called 'hackbench', th=
en
> runs cyclictest with the histogram option. After the run it generates=
 a
> report on how well cyclictest did with the loads in place. If you're
> interested, you can get rteval from my kernel.org git repo:
>
> $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/r=
teval.git
>
> It's not 100% complete, but it's getting there.=20
>
>  =20
>> The only powersave setting in the BIOS is "Intel speedstep" which i=20
>> disabled.
>>
>>
>> I will check with disabled "irqbalance and cpuspeed services" disabl=
ed=20
>> and will report later.
>>
>>
>> What should the adequate max. latency on this system?
>>
>>
>>    =20
>
> I'd say you're doing pretty good keeping under 50us. You might want t=
o
> try it under a heavier load than the shell script you've been running=
=2E
> If you don't want to fool with rteval, try kicking off a kernel compi=
le
> in another window like this:
>
> $ while true; do make -j4 clean bzImage modules; done
>
> and then run cyclictest. A kernel compile with parallel jobs (-j) is =
a
> good overall load of computation and I/O.
>
>  =20

I tested now like you told me with irqbalance and cpuspeed services=20
disabled. I hope i made the right for disabling irqbalance, i used the=20
kernel parameter acpi_no_irqbalance. Is this correct? Unfortunately the=
=20
results were nearly equal as before.

=46or measureing latency i did now the following:
-compile kernel (for high system load)
-running cyclictest -n -m -t3 -p94 (for having some running high=20
priority threads)
-running cyclictest -n -m -h80 -p95 -l6000000 (for latency measurement)

I will also test your python program the next days.

I have now about 50=B5s worst case latency and about 15=B5s average lat=
ency.

Greetings,
Max
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
