From: Stanislav Meduna <stano@meduna.org>
Subject: e1000e 82574L transmit latency?
Date: Tue, 28 May 2013 14:45:43 +0200
Message-ID: <51A4A6F7.5090909@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: e1000-devel@lists.sourceforge.net
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:46350 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759083Ab3E1Mpw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 28 May 2013 08:45:52 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

anyone has experience / knows of bugs (not the ASPM one) causing
high (at least 70 ms) latency on Intel 82574L using the e1000e driver?

We have an instance of a connected device needing to be serviced
each 100 ms reporting a timeout while our internal measurements
show that the packets were given to the kernel max 30 ms apart.

These are raw packets, there is no other traffic on that interface,
no kernel messages, no errors in the /sys/class/net/eth1/statistics/*
and it happened after 5 days of uptime :/

I am using kernel 3.4 with RT PREEMPT - I note that the driver version
there is 1.9.5 while in 3.9 it is 2.2.14. Anyone knows if the network
drivers are back-portable without much hassle that far
or whether this is a complicated task?

e1000-devel: please Cc: me when replying, I am not subscribed
to the list.

Thanks
-- 
                                      Stano
