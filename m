From: Patrice Kadionik <kadionik@enseirb-matmeca.fr>
Subject: Re: clocksource and clockevent confusion
Date: Mon, 04 Apr 2011 21:35:18 +0200
Message-ID: <4D9A1D76.2060807@enseirb-matmeca.fr>
References: <4458795.11336.1301677125869.JavaMail.root@WARSBL213.highway.telekom.at> <1301943081.4d9a1329799cf@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org, hannes_bauer@aon.at
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:43485 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053Ab1DDTf2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Apr 2011 15:35:28 -0400
In-Reply-To: <1301943081.4d9a1329799cf@webmail.aon.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Le 04/04/2011 20:51, Johannes Bauer a =E9crit :

Hi Johannes,

Same problem than you one year before:=20
http://www.spinics.net/lists/linux-rt-users/msg05299.html

Please find below some pointers on high resolution timers:

Thomas Gleixner's & Douglas Niehaus's presentation:
http://www.linuxsymposium.org/2006/linuxsymposium_procv1.pdf from page =
333
http://userweb.kernel.org/~tglx/ols2006/ols2006-hrtimers.pdf

This good report on PREEMPT-RT port on AVR32 and on hrtimer port on=20
AVR32: http://ntnu.diva-portal.org/smash/get/diva2:350562/FULLTEXT01

http://lwn.net/Articles/167897/
http://public.dhe.ibm.com/software/dw/linux/l-timers-list/l-timers-list=
-pdf.pdf
https://rt.wiki.kernel.org/index.php/High_resolution_timer_design_notes
http://elinux.org/High_Resolution_Timers

I have implemented high resolution timer support for NIOS II softcore=20
processor. You may find the source code here as example:=20
http://sopc.et.ntust.edu.tw/pipermail/nios2-dev/2011-January/004543.htm=
l
=46or the high resolution timer port, you must have 2 timers:
- a timer that you program in one shot mode with the next event of the=20
hrtimer subsystem known as a clock event.
- a timer that acts as a free running counter that gives time stamping =
=20
generally multiple of the CPU frequency known as a clock source. A=20
64-bit timer is preferable.
My work was derived from the high resolution timer port for MicroBlaze=20
which is now in the arch/ directory in the vanilla Linux kernel. The=20
code is easy to understand.

May this help you...

Cheers;

Pat.

> Can anybody help me to sort this out plz, since I cannot find any exa=
mple I can \"copy\" it for my implementation and i urgently need it to =
get my testscope running. I forgot to mention that i already read the h=
ighrest.txt, but it doesnt help me since there is no detailed informati=
on on what exactly mult and shift is. \"nanoseconds to cycles multiplie=
r\" and divisor dont make click for me either and the mask member seems=
 to have to do something with the timeroverrun, but is it the mask for =
the counter register, when it throw the interrupts and starts from BOTT=
OM again. What if i don use a power of two number as a compare match as=
 interrupt source (for example 0x47), can i do that or is it restricted=
? Im somehow in the dark here...
> Any help would be highly appreciated.
>
> Kind regards Johannes Bauer
>
> ----- Original von:  Johannes Bauer
>
>   Hi RT Mailing List!
>
>
> Im trying to implement a clocksource driver for my board, which is a
> mach-lpc22xx board. I downloaded linux2-6.33 and patched it with the
> latest RT patch in order to get a RT kernel. Then I realized that i h=
ad
> to enable the hrtimer support in order to gain the benefit of
> preempt-rt.
>   However, to use hrt it seems i need to use the
> GENERIC_CLOCKEVENT timer instead of the old one using timer_tick(). I
> do not find a detailed documentation on this clockevent subsystem, an=
d
> i dont grasp the aspect of clocksource and clockevent, what is the
> difference? I also dont know what exactly the shift and mult struct
> entities are in specific. I have a PIT running at 72MHz, and providin=
g
> a 32bit prescaler counter and a 32 bit counter register, I want to us=
e
> as the tick counter.
>   So if i set the prescaler counter to 71
> (0x47) my timer counter runs with 1Mhz (increments every us). I can
> configure any number in 32bit compare register in order to throw an
> interrupt and reseting the counter and prescaler counter. My cpu
> (lpc2478) runs with 288MHz.
>   So in thsi example, what would be the
> ideal configuration for my timer to achieve highest resultion for hrt
> and what would be the corresponding settings for shift and mult?
>   I hope you can help me to run the system with the PIT as jiffy tick=
 and for hrt usage.
>
>   Thank you very much in advance
>   Jhannes Bauer
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
