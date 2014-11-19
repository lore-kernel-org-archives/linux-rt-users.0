From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
Subject: Re: Measuring scheduling latency for RT threads
Date: Wed, 19 Nov 2014 14:11:37 +0100
Message-ID: <9785835.e6QRrDJeRk@bs8>
References: <trinity-4b6e4283-c92f-4553-af86-5fb9e1fb1541-1416401016597@3capp-gmx-bs35>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:57507 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736AbaKSNLq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Nov 2014 08:11:46 -0500
In-Reply-To: <trinity-4b6e4283-c92f-4553-af86-5fb9e1fb1541-1416401016597@3capp-gmx-bs35>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Mittwoch, 19. November 2014, 13:43:36 schrieben Sie:
> I have a complex automation project with makes heavy use of real time prio
> threads working with external hardware connected by e.g. TCP/IP. IMHO most
> of my latencies simply come from the fact that there are multiple threads
> running on the same RT prio being scheduled FIFO. (poor design, yes, but
> that's what I want to fix) Expected response time is in low millsecond
> area, so no miroseconds juggling here. The process is running (alone, no
> other processes there) on one CPU of an i5 quad core (using 3.13.0-35
> ubuntu 14.04)

The expected behavior is "in general" only achiveable with patched kernels. 
The RT-patches are available here:
https://www.kernel.org/pub/linux/kernel/projects/rt/
(Notice availability only for even kernel numbers.)

So please get first of all a kernel working suited for "real realtime". This 
step should be quite simple :-)

Good luck!


Bernhard

