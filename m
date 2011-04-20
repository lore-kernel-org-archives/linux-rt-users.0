From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: Fwd: Re: preempt-rt amd uClibc
Date: Wed, 20 Apr 2011 14:00:46 +0200
Message-ID: <4DAECAEE.4020503@enseirb-matmeca.fr>
References: <1303296464.4daeb9d04a026@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:44169 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508Ab1DTMA4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Apr 2011 08:00:56 -0400
Received: from [192.168.0.1] (unknown [82.249.57.233])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 45C584C818A
	for <linux-rt-users@vger.kernel.org>; Wed, 20 Apr 2011 14:00:48 +0200 (CEST)
In-Reply-To: <1303296464.4daeb9d04a026@webmail.aon.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 20/04/2011 12:47, Johannes Bauer a =C3=A9crit :
> Thats good news, thank you Remy!
Hi Johannes,

> I was able to run cyclictest
Great news!
Can you post your latest hrtimer port for your HW? It could be useful=20
for anyone who will want to do the same thing in the future...
> \\\"cyclictest -t1 -p 80 -n -i 10000 -l 1000\\\" an thw maximum laten=
cies were about
> 650us. However the intervall timers \\\"cyclictest -t1 -p 80 -i 10000=
 -l 1000\\\"
> result in abou 3000us maximum latencies.
> Is it common that interval timers have higher latencies and could thi=
s values be
> reasonable for a 72MHz arm7tdmi (ARMv4T).
You may read this paper (page 2) from OSADL:=20
https://www.osadl.org/fileadmin/dam/press/Industrial-Ethernet-Book-2009=
-05.pdf
It gives an empirical law for max latency under PREEMPT-RT:
"A number of commercially available Linux distributions (e.g. Red Hat=E2=
=80=99s=20
MRG) already contain the PREEMPT_RT patches in production quality. The=20
worst-case rule-of-thumb latency is in the range of 10^5 multiplied by=20
the CPU cycle duration with these systems without special optimisation.=
=20
=46or example, a 1GHz processor has a cycle duration of one nanosecond=20
which results in a worst-case latency of about 100=CE=BCs. This is cons=
idered=20
sufficient for the vast majority of real-time projects. Using latency=20
optimisation, however, the worst-case latency can be reduced by up to=20
three times."

=46or a 72 MHz CPU clock, it gives: 1388 =C2=B5s
I've done a PREEMPT-RT port for NIOS 2 with MMU (with hrtimer port too)=
=2E=20
With cyclictest, I've measured for a low performance design with 50 MHz=
=20
NIOS 2 HW a latency up to 1400 =C2=B5s and for another more powerful de=
sign=20
with 125 MHz NIOS 2 HW a latency up to 650 =C2=B5s.

Your 650 =C2=B5s value sounds reasonable.

Cheers;

Pat.
> Anyone has any values to compare or can tell me if those values are r=
easonable?
>
> Kind Regards
> Johannes Bauer
>
> ----- Original von:  Remy Bohmer
>
>> Hi,
> 2011/4/15 Johannes Bauer<hannes_bauer@aon.at>:
>> Hi everybody!
>>
>> I downloaded the newest uClinux dist a while ago and compiled it wit=
h 2.6.33
> kernel and the 2.6.33.7.2-rt30 patch applied.
>> Then i by hand implemeted an old patch for arm lpc22xx machine (ARMv=
4T), since
> i am running a lpc2478 board from embedded artists.
>> I had to implement a clockevent/source timer to add hrtimer support.=
 I
> compiled it all with uClibc since it as a NOMMU system.
>> Now i have some questions:
>> Is it possible to run the preempt-rt patch with the uClinux distribu=
tion and
> uClibc?
>
> The preempt-RT patch runs just fine with a uClibc userspace, I have n=
o
> idea what it will do in a NOMMU system (never tried it)
>
>> I read a few times that if doesnt support PI mutexes, but arent thos=
e RT
> mutexes part of the kernel?
>
> The kernel itself has PI-mutexes support, _internally_within_ the
> kernel; regardless what type of userspace C-library is being used.
> However, for _userspace_ PI-mutexes, you will need a C-library that
> supports it (search for example for PTHREAD_PRIO_INHERIT in the
> library code). 2 options:
> * Glibc since version 2.5 (actually 2.4.90 and higher)
> * uClibc master. You might have some luck since there is now NPTL
> support in uClibc master. So, get the master tree of uClibc and see i=
f
> it works for you.
> (http://git.uclibc.org/uClibc/snapshot/uClibc-master.tar.gz)
> I have not tested it myself though, but if it works, please share the
> good news.
>
> Have Fun!
>
> Remy
> --
> To unsubscribe from this list: send the line \\\"unsubscribe linux-rt=
-users\\\" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> ----- Ende der weitergeleiteten Nachricht -----
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Patrice Kadionik. F6KQH / F4CUQ
-----------

+----------------------------------------------------------------------=
+
+"Tout doit etre aussi simple que possible, pas seulement plus simple" =
+
+----------------------------------------------------------------------=
+
+ Patrice Kadionik             http://www.enseirb-matmeca.fr/~kadionik =
+
+ IMS Laboratory               http://www.ims-bordeaux.fr/             =
+
+ ENSEIRB-MATMECA              http://www.enseirb-matmeca.fr           =
+
+ PO BOX 99                    fax   : +33 5.56.37.20.23               =
+
+ 33402 TALENCE Cedex          voice : +33 5.56.84.23.47               =
+
+ FRANCE                       mailto:patrice.kadionik@ims-bordeaux.fr =
+
+----------------------------------------------------------------------=
+

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
