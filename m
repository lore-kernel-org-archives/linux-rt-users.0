From: Chris Edwards <cedwards@ripples.dyndns.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Sat, 03 Dec 2011 23:42:38 +1300
Message-ID: <4ED9FD1E.3070805@ripples.dyndns.org>
References: <4ECCE979.5080109@cedwards.geek.nz>	 <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:34513 "EHLO kinect.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754468Ab1LCKmz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Dec 2011 05:42:55 -0500
In-Reply-To: <4ED9EEB2.6070401@ripples.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/12/11 22:41, Chris Edwards wrote:
>
> linux-3.0.12-rt30-rc1:
>
>     This looks to have the back-ported changes for 3.0-rt that you 
> sent as a patch already applied.
>
>     This one seems to have fixed things!

Sorry, scratch that - I'd patched the source and built it without 
realising I didn't have CONFIG_PREEMPT_RT_FULL=y!  With that enabled, I 
do still see the spurious interrupts cascading onto the Firewire/IRQ 17 
line from the Ethernet controller on IRQ 26, and the "nobody cared" 
errors.  :^(
--
Chris
