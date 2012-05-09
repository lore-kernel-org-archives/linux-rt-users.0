From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Using patch-2.6.33.7.2-rt30 increases latency and CPU usage?
Date: Wed, 9 May 2012 21:18:10 +0000 (UTC)
Message-ID: <joemui$6v0$1@dough.gmane.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50815 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756355Ab2EIVUE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 17:20:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1SSEIl-0001o6-Em
	for linux-rt-users@vger.kernel.org; Wed, 09 May 2012 23:20:03 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 09 May 2012 23:20:03 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 09 May 2012 23:20:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


I've been doing some interrupt latency testing using a board running a
400MHz ARM9 (an Atmel at19sam9g20).  I'm measuring interrupt latency
of an ISR attached to external interrupt pin IRQ0.

I built three kernels from scratch and ran the same test on all three:

 2.6.30          
 2.6.33.7        
 2.6.33.7-rt30  

All kernels are built using the standard AT91 patches from
http://maxim.org.za/at91_26.html.  The 2.6.30 kernel also has a set of
patches distributed by Atmel.

The 2.6.33.7-rt30 kernel is built from the same sources as the 2.6.33.7
kernel with the addition of the 2.6.33.6-rt30 patch.

I don't have enough data to say much about worst-case latency, but
after looking a few thousand samples I can say that...

 * 2.6.30 and 2.6.33.7 are pretty much the same: there is as much
   variation between test runs as there is between kernels.

 * Typical latency with RT patch is 3X the latency without it.

 * CPU idle time during test is 10% with RT patch and 30% without.

IOW: the real-time patch for 2.6.33.7 makes both the typical interrupt
latency and the CPU usage significantly worse.

Typical latency without the RT patch is 5-15us.

Typical latency with is 15-50us (I've never seen latency below 15us
with the RT patch).

Is this the expected behavior?

I don't have enough data to state conclusively what the worst-case
latencies are, but it looks like in all cases they're 200-250us.

In all cases the kernel was configured to be the most preemptible it
could be.  In the 2.6.33.7-rt30 kernel I don't have any of the tracers
enabled.

The kernel configurations are as identical as I could make them.  In
the 2.6.33.7-rt30 case, I started with the .config file used to build
the other 2.6.33.7 kernel and ran old-config making sure to select the
"fully preemptible" option when it asked.

Why would a "vanilla" 2.6.33.7 AT91 kernel perform so much better than
one with the RT patch?

-- 
Grant Edwards               grant.b.edwards        Yow! RHAPSODY in Glue!
                                  at
                               gmail.com

