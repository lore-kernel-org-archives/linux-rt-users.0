From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: priority inversion regarding workqueues?
Date: Wed, 18 Jun 2014 13:51:32 +0200
Message-ID: <7780742.4RyhKh5sl9@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:53988 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933954AbaFRLxk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jun 2014 07:53:40 -0400
Received: from imapserver.systec-electronic.com (unknown [212.185.67.148])
	by webbox1416.server-home.net (Postfix) with ESMTPA id 5B10B27A68D
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2014 13:37:54 +0200 (CEST)
Received: from ws-stein.localnet (unknown [192.168.10.109])
	by imapserver.systec-electronic.com (Postfix) with ESMTPA id E28E8DA0C51
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Jun 2014 13:53:38 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

i think I noticed a priority inversion regarding workqueues. I have a high-
prio task (SCHED_FIFO prio 69) that reads a file in sysfs which actually 
starts a SPI transfer (4 Bytes). I already boosted (manually) the IRQ thread 
to SCHED_FIFO prio 96 and also the workqueue (imx35-cspi.0) attached to the 
SPI driver (spi-imx). The execution time of my task is usually about 600us, 
but with that SPI it sometimes (well rather often though) it is of about 2ms 
or even mugh higher.
When I remove the SPI transfer from the driver behing the sysfs file the 
execution time is rather stable, so the problem lies in that SPI transfer. 
After trying some debug output I came to the conclusion i have change the 
priority of [kworker/u:1] to SCHED_FIFO prio 97 in my case. I think this 
should be done automatically. To be held: I do not know what [kworker/u:1] 
actually is. There seem to be a task for that workqueue already, so what is 
this kworker? BTW: This is a v3.4.33-rt47 kernel.

As the some low priority tasks can delay my high-prio task waiting for SPI 
transfer completion this seems like priority inversion to me.
Any opinions?

Best regards,
Alexander

PS: I tried a 3.10.39-rt40 kernel and the problem is still the same, just the 
kworker task names have changed.

