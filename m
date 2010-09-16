From: Agustin Ferrin Pozuelo <agustin.ferrin@cgglobal.com>
Subject: Re: 2.6.33.7-rt29 PREEMPT_RT worse latency than PREEMPT_DESKTOP on
 AT91?
Date: Thu, 16 Sep 2010 15:31:55 +0100
Message-ID: <4C922A5B.1000305@cgglobal.com>
References: <4C72A438.2080301@cgglobal.com>     
    <alpine.LFD.2.00.1008271234300.2768@localhost.localdomain>
    <4C90E959.80306@cgglobal.com>
    <alpine.LFD.2.00.1009151805540.2416@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from edge.cgglobal.com ([202.54.16.167]:39792 "EHLO
	edge.cgglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab0IPO7U (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Sep 2010 10:59:20 -0400
Received: from cgglobal.com ([192.168.1.7]) by edge.cgglobal.com
    (8.14.1/8.14.1) with ESMTP id o8GEpYc1030658 for
    <linux-rt-users@vger.kernel.org>; Thu, 16 Sep 2010 20:21:38 +0530
Received: from mail.microsol.ie by cgglobal.com (MDaemon PRO v9.6.6) with
    ESMTP id md50027317072.msg for <linux-rt-users@vger.kernel.org>; Thu,
    16 Sep 2010 20:01:22 +0530
In-Reply-To: <alpine.LFD.2.00.1009151805540.2416@localhost6.localdomain6>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  On 15/09/10 17:08, Thomas Gleixner wrote:
> On Wed, 15 Sep 2010, Agustin Ferrin Pozuelo wrote:
>>   On 27/08/10 11:35, Thomas Gleixner wrote:
>>> On Mon, 23 Aug 2010, Agustin Ferrin Pozuelo wrote:
>> Sorry, my test setup is not very comprehensive at the moment. I have=
 some
>> overnight/overweekend results at hand with millions of loops:
>>
>>      PREEMPT-DESKTOP:
>>      root@at91sam9263cpc:~# time cyclictest -i 70000 -p 80 -h 700 -r
> Oh, you are running cyclictest with a signal based timer and relative
> time. Any reason for this ?
Not sure about the "signal based timer", is there an alternative to it?=
=20
(clock_nanosleep?)

The relative time setting "-r" I put there to prevent issues with some=20
specific configurations, specially when the interval was smaller than=20
max latency, in which case cyclictest would freeze or give unusable=20
results. That was happening often before using the workaround for the=20
9263 ethernet bug which induced long latencies (non RT at all).

> What happens if you change the command line to
>
>     cyclictest -i 70000 -p 80 -n
>
Interesting, "-n" setting (use clock_nanosleep) brings down the min and=
=20
avg latencies for 35~40 us. (~70 when using "-r") on the PREEMPT-DESKTO=
P=20
configuration:

     root@at91sam9263cpc:~# cyclictest -i 70000 -p 80 -l 1000
     Clock resolution: 0.000000001 (s.ns)
     policy: fifo: loadavg: 0.14 0.13 0.06 1/36 954
     T: 0 (  876) P:80 I:70000 C:   1000 Min:    107 Act:  135 Avg:  16=
4=20
Max:     262

     root@at91sam9263cpc:~# cyclictest -i 70000 -p 80 -l 1000 -n
     Clock resolution: 0.000000001 (s.ns)
     policy: fifo: loadavg: 0.14 0.12 0.05 1/37 874
     T: 0 (  795) P:80 I:70000 C:   1000 Min:     72 Act:  127 Avg:  12=
5=20
Max:     275

     root@at91sam9263cpc:~# cyclictest -i 70000 -p 80 -l 1000 -r
     Clock resolution: 0.000000001 (s.ns)
     policy: fifo: loadavg: 0.04 0.10 0.06 1/36 1035
     T: 0 (  956) P:80 I:70000 C:   1000 Min:    145 Act:  205 Avg:  20=
3=20
Max:     348

     root@at91sam9263cpc:~# cyclictest -i 70000 -p 80 -l 1000 -r -n
     Clock resolution: 0.000000001 (s.ns)
     policy: fifo: loadavg: 0.01 0.07 0.05 2/37 1115
     T: 0 ( 1037) P:80 I:70000 C:   1000 Min:     87 Act:  135 Avg:  15=
0=20
Max:     439

(Longer runs giving similar results)
Note that"-r" seems to lower CPU usage, is loadavg 0.14 =3D=3D 14% or 0=
=2E0014%?
Right now I don't have the PREEMPT-RT version available for this test,=20
should I expect big improvement there?

>> I am assuming context switching is more expensive on PREEMPT-RT unde=
r ARM9,
>> where it seems already a bit expensive.
> No, the context switch is equally expensive, but signal delivery migh=
t
> be a bit more overhead on -RT
Thanks for the clarification and tips!
Regards,
--Agust=EDn.

--=20
[CG logo]

Agust=EDn Ferr=EDn Pozuelo

Embedded Systems Engineer

CG Power Systems Ireland Limited

Automation Systems Division

Herbert House, Harmony Row, Dublin 2, Ireland.

Phone: +353 1 4153700 Web: www.cgglobal.com <http://www.cgglobal.com>

Save the environment. Please print only if essential.



CG DISCLAIMER: This email contains confidential information. It is inte=
nded exclusively for the addressees. If you are not an addressee, you m=
ust not store, transmit or disclose its contents. Instead please notify=
 the sender immediately; and permanently delete this e-mail from your c=
omputer systems. We have taken reasonable precautions to ensure that no=
 viruses are present. However, you must check this email and the attach=
ments, for viruses. We accept no liability whatsoever, for any detrimen=
t caused by any transmitted virus.

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
