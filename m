From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/6] mmci: Remove bogus local_irq_save()
Date: Wed, 06 Feb 2013 16:58:20 -0500
Message-ID: <20130206215915.206727520@goodmis.org>
References: <20130206215818.969089606@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:7266 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758667Ab3BFV7S (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 16:59:18 -0500
Content-Disposition: inline; filename=0002-mmci-Remove-bogus-local_irq_save.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

On !RT interrupt runs with interrupts disabled. On RT it's in a
thread, so no need to disable interrupts at all.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/mmc/host/mmci.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 032b847..6f8a1a7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -910,15 +910,12 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 	struct sg_mapping_iter *sg_miter = &host->sg_miter;
 	struct variant_data *variant = host->variant;
 	void __iomem *base = host->base;
-	unsigned long flags;
 	u32 status;
 
 	status = readl(base + MMCISTATUS);
 
 	dev_dbg(mmc_dev(host->mmc), "irq1 (pio) %08x\n", status);
 
-	local_irq_save(flags);
-
 	do {
 		unsigned int remain, len;
 		char *buffer;
@@ -958,8 +955,6 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 
 	sg_miter_stop(sg_miter);
 
-	local_irq_restore(flags);
