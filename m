From: Man Johnson <man.johnson@outlook.com>
Subject: RE: RT Problem on Powermac G5 (more info)
Date: Mon, 18 Mar 2013 11:41:04 +0100
Message-ID: <DUB002-W1021CA504ED4C6331CE1438E1E80@phx.gbl>
References: <DUB002-W1234C65DFF1F08EEE03C9BDE1ED0@phx.gbl>,<CDAB4622-D08F-453E-A23F-1E2544BEDBF3@thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from dub0-omc4-s2.dub0.hotmail.com ([157.55.2.77]:44963 "EHLO
	dub0-omc4-s2.dub0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751813Ab3CRKrT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Mar 2013 06:47:19 -0400
In-Reply-To: <CDAB4622-D08F-453E-A23F-1E2544BEDBF3@thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Subject: Re: RT Problem on Powermac G5 (more info)
> From: sven@thebigcorporation.com
> Date: Fri, 15 Mar 2013 13:54:55 -0700
> CC: linux-rt-users@vger.kernel.org
> To: man.johnson@outlook.com
> 
> 
> Quick general advice, without looking at your specific links:
> 
> Try some other configurations first, e.g. instead of configuring PREEMPT_FULL, 
> configure a more basic PREEMPT mode, and see if you can get something running.

Thank you -- I did that this week-end, trying to produce a minimal config. Now I have a PREEMT_DESKTOP with SOFT_IRQS which works well but as soon as I put PREEMT_HARDIRQS it fails at boot time with : "hda lost interrupt".

I have put the working config here: http://pastebin.com/VJ4GDsHN
and the failing one here: http://pastebin.com/jgZhkhVt

They should only differ with respect to soft and hard irqs threading.

The picture of the error message at boot time is at: http://views.airpost.net/#single:preempt_hardirqs.jpg

> Then turn on features (e.g. IRQ threading, and so on, and see when it breaks)
> 
> BTW what's up with the oddball - - in the SMTP header?

A mistake.

I'd be very glad if you can continue to help me find a way to boot in full realtime. 		 	   		  