From: Victor henri <nadaeck@hotmail.com>
Subject: complete system freeze with nvidia RT-kernel
Date: Thu, 3 Feb 2011 21:48:31 +0100
Message-ID: <SNT110-W637498A73782580C72DC19A8E70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from snt0-omc1-s26.snt0.hotmail.com ([65.55.90.37]:28629 "EHLO
	snt0-omc1-s26.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752067Ab1BCUsc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 Feb 2011 15:48:32 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



Hello

I have big trouble with RT kernel greater than 2.6.31.12 (i started seeing it on
gentoo), i have total system freeze... after a few minutes.... to the
point that i have to force shut down the system without proper shutdown
(i hate doing that); i have installed "das-watchdog" and see the pop-up
window saying that das watchdog has disabled real-time for 8 seconds...
and this pop-up appears every 8 sec... (forever)... everything happen
before i have time to play a single note....

I have Ubuntu Maverick 10.10 and Gentoo, both 64 bits. So this doesn't happen at all with the linux-rt package of Ubuntu Lucid (2.6.31-11-rt then) and with 2.6.31.12-rt21 from pro-audio overlay on Gentoo. But it happens with every 2.6.33 flavor of rt kernel (2.6.33.7 kernel form kernel.org patched with the 2.6.33.7.2-rt patch; 2.6.33.7-rt29 from pro-audio overlay of Gentoo; 2.6.33-29-realtime from Abogani's ppa)...

I'm using the rtirq script.

And tis happens on 2 laptops; both Asus core I 7, both with Nvidia graphic card; i didn't install any patch for the nvidia, but i use the generic nouveau driver (in Ubuntu) or nv (in Gentoo), but no the proprietary drivers. Actually, since the upgrade, i am unable to run a RT kernel and those machines; i've been posting on several forums without finding a solution (although people were willing to help). I make a compromise now : i compile the latest kernel with the "preemptible kernel (low latency desktop)" and "timer frequency 1000 Hz"; it works ok but as soon as i use several application at the same time, Xruns appear....

Thank you fro some help/clue

Victor
 		 	   		  