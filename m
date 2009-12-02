From: Hector Perez Tijero <perezh@unican.es>
Subject: Re: Posix Execution time clock
Date: Wed, 02 Dec 2009 01:01:05 -0800
Message-ID: <4B162CD1.9030309@unican.es>
References: <4B1508B5.7030202@unican.es> <20091201123228.GM3864@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver1.unican.es ([130.206.5.100]:37292 "EHLO
	ccserver1.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894AbZLBJBM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Dec 2009 04:01:12 -0500
Received: from ccserver1.unican.es (ccserver1.unican.es [127.0.0.1])
	by ccserver1.unican.es (Postfix) with ESMTP id 2762F40A2C
	for <linux-rt-users@vger.kernel.org>; Wed,  2 Dec 2009 10:01:11 +0100 (CET)
Received: from correo.unican.es (ccserver18.unican.es [130.206.5.18])by
	ccserver1.unican.es (Postfix) with ESMTP id 1BCDF409DDfor
	<linux-rt-users@vger.kernel.org>; Wed,  2 Dec 2009 10:01:11 +0100 (CET)
In-Reply-To: <20091201123228.GM3864@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi again,

Thanks for your really quick replies and your contributions!  I have=20
found some interesting info:


Luis Claudio R. Goncalves escribi=F3:
> On Tue, Dec 01, 2009 at 07:14:45AM -0500, Hector Perez Tijero wrote:
>  =20
>> Hi,
>>
>> My question might be a little basic for this list... Maybe someone c=
ould =20
>> point me out to another forum :)
>>
>> I'm trying to get some measures using the execution time clock in my=
 =20
>> system and I found some slight differences in the use of the =20
>> CLOCK_THREAD_CPUTIME_ID and CLOCK_MONOTONIC clocks. The measures are=
 =20
>> between the same points of code. My concern is that, sometimes, the =
=20
>> measure obtained with CLOCK_MONOTONIC is lower than using =20
>> CLOCK_THREAD_CPUTIME_ID. Find below a dummy example to test this str=
ange =20
>> behavior.
>>
>> It doesn't happen very often but the error could be around hundreds =
of =20
>> microseconds.
>>
>> So my question is: are both POSIX clocks based on different physical=
 =20
>> clocks? I always though they use the TSC...
>>    =20
>
> Check the dmesg logs for hints on TSC. There are some TSCs that are n=
ot
> used as clocksources because they are out-of-sync between CPUs, becau=
se
> they halt on idle, because they halt on inner C-states and so on...
>
>  =20
My dmesg output:
    [    8.333748] checking TSC synchronization [CPU#0 -> CPU#1]:
    [    8.353732] Measured 3359526540 cycles TSC warp between CPUs,=20
turning off TSC clock.
    [    8.353737] Marking TSC unstable due to: check_tsc_sync_source=20
failed.

So my system is not using the TSC...

>  =20
>> My previous guess was that such behavior could be caused by the CPU =
=20
>> frequency scaling but the same happened when I disabled it.
>>    =20
>
> How many CPUs?
>  =20
A DualCore.

> >From http://www.tin.org/bin/man.cgi?section=3D3&topic=3Dclock_gettim=
e :
>
>   NOTE for SMP systems
>        The CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID clock=
s are
>        realized on many platforms using timers from the CPUs (TSC on =
i386,
>        AR.ITC on Itanium). These registers may differ between CPUs an=
d as a
>        consequence these clocks may return bogus results if a process=
 is
>        migrated to another CPU.
>  =20
Yeah, I have check the available clocks in=20
/sys/devices/system/clocksource/clocksource0/available_clocksource
    >>hpet acpi_pm jiffies tsc

and the clock used according to cat=20
/sys/devices/system/clocksource/clocksource0/current_clocksource
    >>hpet

I have switched to acpi_pm but the same issue exists. I have also=20
disabled one CPU in the BIOS to use the TSC... I though it could be goo=
d=20
try but... useless

> By definition, CLOCK_MONOTONIC seems to be what you want.
>
>  =20
No, I actually need the CLOCK_THREAD_CPUTIME_ID. Basically I have to ge=
t=20
some execution times measures to perform the schedulability analysis.=20
But I have found this strange behavior and I just wonder why.
> Another interesting detail is that you have to check what is the valu=
e of
> /proc/sys/kernel/vsyscall64 for it constrols the behavior and resolut=
ion of
> clock reads (enabling or disabling VDSO clock enhancements). Try sett=
ing it
> to zero and repeating your tests.
>
>  =20
That functionality is only for 64bits, isn't it? My computer is still 3=
2=20
bits... :)

Please let me know any new suggestion...

Regards,

Hector

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
