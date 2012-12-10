From: Stanislav Meduna <stano@meduna.org>
Subject: Shared interrupts and RT question
Date: Mon, 10 Dec 2012 12:00:13 +0100
Message-ID: <50C5C0BD.9010600@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:55985 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547Ab2LJLA2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Dec 2012 06:00:28 -0500
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1Ti15u-0003PD-61
	for linux-rt-users@vger.kernel.org; Mon, 10 Dec 2012 12:00:25 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I have a machine that puts several interrupts on one interrupt
line. As these are generally headless embedded machines bought
and installed by the customer, it is a bit problematic to tweak
the BIOS to assign them in an optimal way.

Now I am seeing latencies such as

Wakeup shared prio
385 50 638 (0) irq/15-eth1 <- 28 50 irq/15-ata_piix 5147.373113
#Minimum latency: 1 microseconds
#Average latency: 4 microseconds
#Maximum latency: 638 microseconds

I don't care about the ATA, but eth1 is important. Is it
enough to adjust the priorities of the kernel threads
or are shared interrupts generally a recipe for problems
in the RT_FULL world?

If there is any docs discussing the principles of interrupt
handling in a RT kernel, I'd appreciate a pointer.

Thanks
-- 
                                        Stano
