From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Re: clocksource and clockevent confusion
Date: Mon, 04 Apr 2011 20:51:21 +0200 (CEST)
Message-ID: <1301943081.4d9a1329799cf@webmail.aon.at>
References: <4458795.11336.1301677125869.JavaMail.root@WARSBL213.highway.telekom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout02.highway.telekom.at ([195.3.96.113]:23332 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753796Ab1DDSvZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Apr 2011 14:51:25 -0400
Received: from warsbl113-nfs.highway.telekom.at (HELO WARSBL113.highway.telekom.at) ([172.18.96.90])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub95.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 4 Apr 2011 18:51:22 -0000
Received: from webmail.aon.at (localhost.localdomain [127.0.0.1])
	by WARSBL113.highway.telekom.at (8.13.1/8.13.1) with SMTP id p34IpLkK024929
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Apr 2011 20:51:21 +0200
In-Reply-To: <4458795.11336.1301677125869.JavaMail.root@WARSBL213.highway.telekom.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Can anybody help me to sort this out plz, since I cannot find any example I can \"copy\" it for my implementation and i urgently need it to get my testscope running. I forgot to mention that i already read the highrest.txt, but it doesnt help me since there is no detailed information on what exactly mult and shift is. \"nanoseconds to cycles multiplier\" and divisor dont make click for me either and the mask member seems to have to do something with the timeroverrun, but is it the mask for the counter register, when it throw the interrupts and starts from BOTTOM again. What if i don use a power of two number as a compare match as interrupt source (for example 0x47), can i do that or is it restricted? Im somehow in the dark here...
Any help would be highly appreciated.

Kind regards Johannes Bauer

----- Original von:  Johannes Bauer

> 
 Hi RT Mailing List!


Im trying to implement a clocksource driver for my board, which is a
mach-lpc22xx board. I downloaded linux2-6.33 and patched it with the
latest RT patch in order to get a RT kernel. Then I realized that i had
to enable the hrtimer support in order to gain the benefit of
preempt-rt.
 However, to use hrt it seems i need to use the
GENERIC_CLOCKEVENT timer instead of the old one using timer_tick(). I
do not find a detailed documentation on this clockevent subsystem, and
i dont grasp the aspect of clocksource and clockevent, what is the
difference? I also dont know what exactly the shift and mult struct
entities are in specific. I have a PIT running at 72MHz, and providing
a 32bit prescaler counter and a 32 bit counter register, I want to use
as the tick counter. 
 So if i set the prescaler counter to 71
(0x47) my timer counter runs with 1Mhz (increments every us). I can
configure any number in 32bit compare register in order to throw an
interrupt and reseting the counter and prescaler counter. My cpu
(lpc2478) runs with 288MHz.
 So in thsi example, what would be the
ideal configuration for my timer to achieve highest resultion for hrt
and what would be the corresponding settings for shift and mult?
 I hope you can help me to run the system with the PIT as jiffy tick and for hrt usage.

 Thank you very much in advance
 Jhannes Bauer

