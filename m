From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Re: sched_clock for arm
Date: Tue, 03 May 2011 09:13:01 +0200 (CEST)
Message-ID: <1304406781.4dbfaafd47710@webmail.aon.at>
References: <1303296464.4daeb9d04a026@webmail.aon.at> <4DAECAEE.4020503@enseirb-matmeca.fr> <1304003318.4db982f68a671@webmail.aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout06.highway.telekom.at ([195.3.96.89]:37836 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750740Ab1ECHNF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 May 2011 03:13:05 -0400
Received: from warsbl114-nfs.highway.telekom.at (HELO WARSBL114.highway.telekom.at) ([172.18.96.91])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub98.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 3 May 2011 07:13:02 -0000
Received: from webmail.aon.at (localhost.localdomain [127.0.0.1])
	by WARSBL114.highway.telekom.at (8.13.1/8.13.1) with SMTP id p437D1la025136
	for <linux-rt-users@vger.kernel.org>; Tue, 3 May 2011 09:13:01 +0200
In-Reply-To: <1304003318.4db982f68a671@webmail.aon.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Does nobody have any idea about that topic?

At the moment im using that implementation and it seems to work unless i am using cyclcitest with -i < 1000.
However when i \"cat /proc/timer_list\" i sometimes get \"active timers\" that expire before \"next_event\", which seems somhow odd to me. The difference in that values is about 1 ms which should be easily be able to handle by the highres timer...

> Hello everybody!

Again i am a little bit confused - sorry!

For the lpc2478 board (arm7tdmi-s), with Patrice Kadionik\\\'s help, I implemented a clocksource and clock event source to achieve hrtimer resolution. I realised i have to implement a sched_clock function too, in order to achieve better scheduling resolution. I took some examples from the arch/arm directory, where totally different solution exist. Very few using a cnt32_to_63() functions, others only clocksource_cyc2ns().
Is it ok to implement a sched_clock with only clocksource_cyc2ns() with a 72MHz 32bit counter, since it wraps somehow often?
It seems the newest preempt-release announced by Thomas Gleixner a few weeks ago has a new arm sched_clock support provided by Russel King, but I am using 2.6.33.7.2-rt30, where those features are not built in and i cannot update the kernel yet
I found a conversation initiated by Johannes Stezenbach (http://ns.spinics.net/lists/arm-kernel/msg86383.html) having the same toopic, but actually no specific answer to that question was posted.

So is it enough to use clocksource_cyc2ns(), or do I have use something else, and if yould you please point out some code that does exactly what needs to be done for arm architecture.

At the moment my implemetations looks as following:

   unsigned long long notrace sched_clock(void)
   {
   return clocksource_cyc2ns(pit_clk.read(&pit_clk),pit_clk.mult,pit_clk.shift);
   }

I would post the code as example here in order to give people a better 

Thank you again and kind regards
Johannes Bauer
--
To unsubscribe from this list: send the line \"unsubscribe linux-rt-users\" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


