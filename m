From: =?ISO-8859-1?Q?Matthias_S=F6llner?= <m.soellner@haw-aw.de>
Subject: Problem with Realtime Kernel and Ethernet Card
Date: Mon, 16 Jan 2012 15:56:50 +0100
Message-ID: <4F143AB2.6070404@haw-aw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp.haw-aw.de ([195.37.42.4]:47001 "EHLO smtp.haw-aw.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754067Ab2APPHj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Jan 2012 10:07:39 -0500
Received: from [10.10.132.78] ([10.10.132.78])
	(authenticated bits=0)
	by smtp.haw-aw.de  with ESMTP id q0GEupRe008650-q0GEupRf008650
	for <linux-rt-users@vger.kernel.org>; Mon, 16 Jan 2012 15:56:51 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,
I installed a RT-Preempt Kernel in Debian 6
as shown on
http://pengutronix.de/software/linux-rt/debian_en.html

I have a DELL Precision T1600 with onboard network card and additional
PCI network-card.

The onboard card is a Intel=AE 82579LM Gigabit-LAN.

I used linux-image-2.6-rt-686 from Pengutronix APT repository.

Installation worked fine, I can boot my debian with both kernels.

If I boot normal debian kernel i have eth0 and eth1. both cards work fi=
ne.

But if I boot RT-Preempt-Kernel the  internal network card is not shown
and I only have eth0.

With normal debian kernel intel e1000e driver is loaded.

What can I do to make my internal network card function properly with
realtime kernel ?


I tried to compile the intel network driver myself. But where to I get
the right kernel-headers for my RT-Preempt-Kernel?

Any hints?
Thanks a lot
Matthias
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
