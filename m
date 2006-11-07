From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.18-rt7 oops at boot
Date: Tue, 7 Nov 2006 13:21:53 -0800
Message-ID: <200611071321.53274.dvhltc@us.ibm.com>
References: <d4209ca0611070519o1539a6f1ye6f6393ec87b37e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:31199 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753375AbWKGVWX
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Nov 2006 16:22:23 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com [9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kA7LMK4B010333
	for <linux-rt-users@vger.kernel.org>; Tue, 7 Nov 2006 16:22:20 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kA7LMJw4543518
	for <linux-rt-users@vger.kernel.org>; Tue, 7 Nov 2006 14:22:20 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kA7LMJji019143
	for <linux-rt-users@vger.kernel.org>; Tue, 7 Nov 2006 14:22:19 -0700
To: "Gerhard Olsson" <gerhard.nospam@gmail.com>
In-Reply-To: <d4209ca0611070519o1539a6f1ye6f6393ec87b37e2@mail.gmail.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 07 November 2006 05:19, Gerhard Olsson wrote:
> 2.6.18-rt7 oops at boot for me when hrtimers are enabled. The kernel
> oops just after grub leaves control to linux, before "normal"
> printouts appear.
> The kernel works fine without high resolution timers and with 2.6.18-rt6
> I have tried with a few different config parameters, but
> CONFIG_HIGH_RES_TIMERS seems to be the only problem.
> (FYI: I also tried 2.6.18.1, with manual merge of conflicts (in sparc
> code). However, hrtimers are not enabled in this combination.)
>
> Using the instructions in the RT wiki in Ubuntu "dapper"
> I am trying to use a realtime kernel with Dapper as defined here:
> https://help.ubuntu.com/community/HowToVanillaKernelWithRealtimePreemption
> (I have tried with and without the Ubuntu bd-claim patch)

I noticed your machine is defaulting to the HPET as a clocksource.  I don't 
know of that being a problem, but it might be worth trying with a different 
clocksource at boot.

To see which clocks are available, see:

	$ cat /sys/devices/system/clocksource/clocksource0/available_clocksource

for available clocksources.  The output will look something like:

	acpi_pm jiffies hpet tsc pit

Then pick another one and boot with "clocksource=newclocksource" appended.  
This isn't a fix, but a temporary workaround until we can figure out why it's 
not booting in the first place.

Regards

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
