From: Jens Wirth <jewirth@gmail.com>
Subject: Re: cyclictest - trouble explaning results
Date: Fri, 13 Jun 2008 12:31:33 +0000 (UTC)
Message-ID: <loom.20080613T114833-789@post.gmane.org>
References: <20080611151437.234900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:56992 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755270AbYFMMfF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 Jun 2008 08:35:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K78Ug-00084M-Vr
	for linux-rt-users@vger.kernel.org; Fri, 13 Jun 2008 12:35:03 +0000
Received: from port-212-202-126-147.static.qsc.de ([212.202.126.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jun 2008 12:35:02 +0000
Received: from jewirth by port-212-202-126-147.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jun 2008 12:35:02 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Oleg Galimov <Galimov <at> gmx.de> writes:

> I have a dual-core cpu. When I run cyclictest on both cores and then start a
time hog (like cp /dev/zero
> /dev/null), then the average latency on the core where it runs goes down
significantly (on my machine it is
> like 30us before and 10us after, when using rt-patch). It returns to the
original values, when I kill the cp process.

I made a similar observation while measuring the jitter in
the time of execution of usleep(). The more load the machine
has the less becomes the average jitter. Of course, there is
a point of inflection when the system is fully stretched.

I observed this behavior on a ppc405 based embedded system
(no SMP) with and without CONFIG_PREEMPT_RT. Interestingly
enough, I was unable to reproduce your observation with the
cyclictest tool on this system.

Regards,
Jens Wirth

