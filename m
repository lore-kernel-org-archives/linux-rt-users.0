From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/5] mmci: Remove bogus local_irq_save()
Date: Wed, 06 Feb 2013 17:06:10 -0500
Message-ID: <20130206220632.477444278@goodmis.org>
References: <20130206220608.862416001@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9048 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932190Ab3BFWGd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Feb 2013 17:06:33 -0500
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
index 9394d0b..8d0bf36 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -741,15 +741,12 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
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
@@ -789,8 +786,6 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 
 	sg_miter_stop(sg_miter);
 
-	local_irq_restore(flags);
