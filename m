From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: [Fwd: Re: sdhci can turn off irq up to 200 ms]
Date: Thu, 13 Aug 2009 18:02:51 +0200
Message-ID: <4A84392B.90802@parrot.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------050600070003080503060300"
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:53227 "EHLO co203.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752032AbZHMQWJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 Aug 2009 12:22:09 -0400
Received: from ONYX.xi-lite.lan (unknown [193.34.35.244])
	by co203.xi-lite.net (Postfix) with ESMTP id 8ACA2658452
	for <linux-rt-users@vger.kernel.org>; Thu, 13 Aug 2009 16:02:52 +0000 (GMT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--------------050600070003080503060300
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit

Hi,

I foward this here because it could interest some people caring about
low latency. I have got no reply from upstream.
It may or not affect preempt-rt kernel.

For info the issue was found with ltt.


Matthieu

PS :
the sdhci driver contains others mdelay that should be killed.

-------- Message original --------
Sujet : Re: sdhci can turn off irq up to 200 ms
Date : Thu, 09 Jul 2009 12:28:01 +0200
De : Matthieu CASTET <matthieu.castet@parrot.com>
Pour : pierre@ossman.eu
Copie à : sdhci-devel@lists.ossman.eu,  "linux-kernel@vger.kernel.org"
<linux-kernel@vger.kernel.org>
Références : <4A4B6184.7000903@parrot.com>

Matthieu CASTET a écrit :
> Hi,
> 
> sdhci code got tasklets (sdhci_tasklet_card and sdhci_tasklet_finish),
> that does :
> {
> spin_lock_irqsave
> 
> if (cond) {
> sdhci_reset
> sdhci_reset
> }
> 
> spin_unlock_irqrestore
> }
> 
> The problem is that sdhci_reset [1] does busy pooling on a register up
> to a timeout of 100 ms.
> That's not low latency friendly.
> 
> On our system, we saw that sdhci_reset take 1 ms. That should be because
> we enter in mdelay, even if the hardware clears the bit faster.
> I wonder why there is an mdelay(1). Using cpu_relax and
> time_is_after_jiffies should make sdhci_reset faster.
> 
In case somebody cares, here a patch that reduce on our hardware
sdhci_reset from 1 ms to 30 us.


Matthieu

--------------050600070003080503060300
Content-Type: text/x-diff; name="sdhci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="sdhci.diff"

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6779b4e..3e199b6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -156,18 +156,17 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
 		host->clock = 0;
 
 	/* Wait max 100 ms */
-	timeout = 100;
+	timeout = jiffies + msecs_to_jiffies(100);
 
 	/* hw clears the bit when it's done */
 	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
-		if (timeout == 0) {
+		if (time_is_before_jiffies(timeout)) {
 			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
 				mmc_hostname(host->mmc), (int)mask);
 			sdhci_dumpregs(host);
 			return;
 		}
-		timeout--;
-		mdelay(1);
+		cpu_relax();
 	}
 
 	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)


--------------050600070003080503060300--
