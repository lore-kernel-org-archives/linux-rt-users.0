From: Johannes Bauer <hannes_bauer@aon.at>
Subject: clocksource and clockevent confusion
Date: Fri, 01 Apr 2011 19:25:38 +0200 (CEST)
Message-ID: <1301678738.4d960a9229368@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout04.highway.telekom.at ([195.3.96.117]:13319 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757852Ab1DARZm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2011 13:25:42 -0400
Received: from warsbl213-nfs.highway.telekom.at (HELO WARSBL213.highway.telekom.at) ([172.18.96.92])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub92.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 1 Apr 2011 17:25:39 -0000
Received: from webmail.aon.at (localhost.localdomain [127.0.0.1])
	by WARSBL213.highway.telekom.at (8.13.1/8.13.1) with SMTP id p31HPcbZ013232
	for <linux-rt-users@vger.kernel.org>; Fri, 1 Apr 2011 19:25:38 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hi RT Mailing List!

Im trying to implement a clocksource driver for my board, which is a mach-lpc22xx board. I downloaded linux2-6.33 and patched it with the latest RT patch in order to get a RT kernel. Then I realized that i had to enable the hrtimer support in order to gain the benefit of preempt-rt.
However, to use hrt it seems i need to use the GENERIC_CLOCKEVENT timer instead of the old one using timer_tick(). I do not find a detailed documentation on this clockevent subsystem, and i dont grasp the aspect of clocksource and clockevent, what is the difference? I also dont know what exactly the shift and mult struct entities are in specific. I have a PIT running at 72MHz, and providing a 32bit prescaler counter and a 32 bit counter register, I want to use as the tick counter.
So if i set the prescaler counter to 71 (0x47) my timer counter runs with 1Mhz (increments every us). I can configure any number in 32bit compare register in order to throw an interrupt and reseting the counter and prescaler counter. My cpu (lpc2478) runs with 288MHz.
So in thsi example, what would be the ideal configuration for my timer to achieve highest resultion for hrt and what would be the corresponding settings for shift and mult?
I hope you can help me to run the system with the PIT as jiffy tick and for hrt usage.

Thank you very much in advance
Johannes Bauer 
