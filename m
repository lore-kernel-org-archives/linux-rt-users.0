From: Matthias Meier <matthias.j.meier@gmx.net>
Subject: Re: Long max latencies on Wandbaord / Freescale i.MX6
Date: Thu, 1 Oct 2015 10:08:18 +0200
Message-ID: <560CE9F2.4010401@gmx.net>
References: <5606677A.1020705@gmx.net>
 <alpine.DEB.2.11.1509271346160.4500@nanos> <560A3020.5090909@gmx.net>
 <alpine.DEB.2.11.1509300909240.4500@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:65146 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755246AbbJAIIV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Oct 2015 04:08:21 -0400
Received: from localhost.localdomain ([213.188.224.136]) by mail.gmx.com
 (mrgmx003) with ESMTPSA (Nemesis) id 0M9JYE-1ZnZiX1eIw-00ChJ4 for
 <linux-rt-users@vger.kernel.org>; Thu, 01 Oct 2015 10:08:19 +0200
In-Reply-To: <alpine.DEB.2.11.1509300909240.4500@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

PROVE_LOCKING is not so bad I thought

finally I guess my latency problem is caused by a spurious interrupt on 
a unused mmc slot causing heavy load when using PROVE_LOCKING ...


Here a little more in detail what I did:

Disabling CONFIG_PROVE_LOCKING together with a lot other debug options 
as Thomas proposed indeed gave max latencies in the range of 100us - at 
least most of the time...

After adding besides 'hackbench' additional heavy network load via the 
on-board WiFi interface, the max latency raised further and finally I 
the kernel fired a backtrace which ended in a "Disabling IRQ #284"

/proc/interrupts indeed shows a hugh amout of interrupts on mmc1 
although I don't use mmc1 at all (the Wandboard boots via mmc0)

(possible a pullup config is missing at the mmc interfaces?)

After reboot I tried to stop the spurious interrupts by inserting a 
sd-card on mmc1 but this does not work - still high interrupts.

Now I'm trying to disable mmc1 and mmc2 completely which is not as easy 
as I thought: via sysfs it seems not to be possible and via DT I think I 
would have to modify all imx6* DTS files of all imx6 boards - otherwise 
the dtbs does not compile...


Is there a simple solution to disable either a single interrupt or a 
individual mmc interface from userspace?

Thanks,
	Matthias

