From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] dma: ipu: convert back_lock to a raw spinlock
Date: Fri, 29 Jul 2011 16:27:07 +0200
Message-ID: <1311949627-13260-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kernel@pengutronix.de,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Dan Williams <dan.j.williams@intel.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42213 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab1G2O1R (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2011 10:27:17 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It's used in irq handling, so needs to be hardirq safe.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/dma/ipu/ipu_irq.c |   48 ++++++++++++++++++++++---------------=
-------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/ipu/ipu_irq.c b/drivers/dma/ipu/ipu_irq.c
index ab8a4ef..a71f55e 100644
--- a/drivers/dma/ipu/ipu_irq.c
+++ b/drivers/dma/ipu/ipu_irq.c
@@ -81,7 +81,7 @@ static struct ipu_irq_map irq_map[CONFIG_MX3_IPU_IRQS=
];
 /* Protects allocations from the above array of maps */
 static DEFINE_MUTEX(map_lock);
 /* Protects register accesses and individual mappings */
-static DEFINE_SPINLOCK(bank_lock);
+static DEFINE_RAW_SPINLOCK(bank_lock);
=20
 static struct ipu_irq_map *src2map(unsigned int src)
 {
@@ -101,11 +101,11 @@ static void ipu_irq_unmask(struct irq_data *d)
 	uint32_t reg;
 	unsigned long lock_flags;
=20
-	spin_lock_irqsave(&bank_lock, lock_flags);
+	raw_spin_lock_irqsave(&bank_lock, lock_flags);
=20
 	bank =3D map->bank;
 	if (!bank) {
-		spin_unlock_irqrestore(&bank_lock, lock_flags);
+		raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
 		pr_err("IPU: %s(%u) - unmapped!\n", __func__, d->irq);
 		return;
 	}
@@ -114,7 +114,7 @@ static void ipu_irq_unmask(struct irq_data *d)
 	reg |=3D (1UL << (map->source & 31));
 	ipu_write_reg(bank->ipu, reg, bank->control);
=20
-	spin_unlock_irqrestore(&bank_lock, lock_flags);
+	raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
 }
=20
 static void ipu_irq_mask(struct irq_data *d)
@@ -124,11 +124,11 @@ static void ipu_irq_mask(struct irq_data *d)
 	uint32_t reg;
 	unsigned long lock_flags;
=20
-	spin_lock_irqsave(&bank_lock, lock_flags);
+	raw_spin_lock_irqsave(&bank_lock, lock_flags);
=20
 	bank =3D map->bank;
 	if (!bank) {
-		spin_unlock_irqrestore(&bank_lock, lock_flags);
+		raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
 		pr_err("IPU: %s(%u) - unmapped!\n", __func__, d->irq);
 		return;
 	}
@@ -137,7 +137,7 @@ static void ipu_irq_mask(struct irq_data *d)
 	reg &=3D ~(1UL << (map->source & 31));
 	ipu_write_reg(bank->ipu, reg, bank->control);
=20
-	spin_unlock_irqrestore(&bank_lock, lock_flags);
+	raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
 }
=20
 static void ipu_irq_ack(struct irq_data *d)
@@ -146,17 +146,17 @@ static void ipu_irq_ack(struct irq_data *d)
 	struct ipu_irq_bank *bank;
 	unsigned long lock_flags;
=20
-	spin_lock_irqsave(&bank_lock, lock_flags);
+	raw_spin_lock_irqsave(&bank_lock, lock_flags);
=20
 	bank =3D map->bank;
 	if (!bank) {
-		spin_unlock_irqrestore(&bank_lock, lock_flags);
+		raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
 		pr_err("IPU: %s(%u) - unmapped!\n", __func__, d->irq);
 		return;
 	}
=20
 	ipu_write_reg(bank->ipu, 1UL << (map->source & 31), bank->status);
-	spin_unlock_irqrestore(&bank_lock, lock_flags);
+	raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
 }
=20
 /**
@@ -172,11 +172,11 @@ bool ipu_irq_status(unsigned int irq)
 	unsigned long lock_flags;
 	bool ret;
=20
-	spin_lock_irqsave(&bank_lock, lock_flags);
+	raw_spin_lock_irqsave(&bank_lock, lock_flags);
 	bank =3D map->bank;
 	ret =3D bank && ipu_read_reg(bank->ipu, bank->status) &
 		(1UL << (map->source & 31));
-	spin_unlock_irqrestore(&bank_lock, lock_flags);
+	raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
=20
 	return ret;
 }
@@ -213,10 +213,10 @@ int ipu_irq_map(unsigned int source)
 		if (irq_map[i].source < 0) {
 			unsigned long lock_flags;
=20
-			spin_lock_irqsave(&bank_lock, lock_flags);
+			raw_spin_lock_irqsave(&bank_lock, lock_flags);
 			irq_map[i].source =3D source;
 			irq_map[i].bank =3D irq_bank + source / 32;
-			spin_unlock_irqrestore(&bank_lock, lock_flags);
+			raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
=20
 			ret =3D irq_map[i].irq;
 			pr_debug("IPU: mapped source %u to IRQ %u\n",
@@ -252,10 +252,10 @@ int ipu_irq_unmap(unsigned int source)
 			pr_debug("IPU: unmapped source %u from IRQ %u\n",
 				 source, irq_map[i].irq);
=20
-			spin_lock_irqsave(&bank_lock, lock_flags);
+			raw_spin_lock_irqsave(&bank_lock, lock_flags);
 			irq_map[i].source =3D -EINVAL;
 			irq_map[i].bank =3D NULL;
-			spin_unlock_irqrestore(&bank_lock, lock_flags);
+			raw_spin_unlock_irqrestore(&bank_lock, lock_flags);
=20
 			ret =3D 0;
 			break;
@@ -276,7 +276,7 @@ static void ipu_irq_err(unsigned int irq, struct ir=
q_desc *desc)
 	for (i =3D IPU_IRQ_NR_FN_BANKS; i < IPU_IRQ_NR_BANKS; i++) {
 		struct ipu_irq_bank *bank =3D irq_bank + i;
=20
-		spin_lock(&bank_lock);
+		raw_spin_lock(&bank_lock);
 		status =3D ipu_read_reg(ipu, bank->status);
 		/*
 		 * Don't think we have to clear all interrupts here, they will
@@ -284,18 +284,18 @@ static void ipu_irq_err(unsigned int irq, struct =
irq_desc *desc)
 		 * might want to clear unhandled interrupts after the loop...
 		 */
 		status &=3D ipu_read_reg(ipu, bank->control);
-		spin_unlock(&bank_lock);
+		raw_spin_unlock(&bank_lock);
 		while ((line =3D ffs(status))) {
 			struct ipu_irq_map *map;
=20
 			line--;
 			status &=3D ~(1UL << line);
=20
-			spin_lock(&bank_lock);
+			raw_spin_lock(&bank_lock);
 			map =3D src2map(32 * i + line);
 			if (map)
 				irq =3D map->irq;
-			spin_unlock(&bank_lock);
+			raw_spin_unlock(&bank_lock);
=20
 			if (!map) {
 				pr_err("IPU: Interrupt on unmapped source %u bank %d\n",
@@ -317,22 +317,22 @@ static void ipu_irq_fn(unsigned int irq, struct i=
rq_desc *desc)
 	for (i =3D 0; i < IPU_IRQ_NR_FN_BANKS; i++) {
 		struct ipu_irq_bank *bank =3D irq_bank + i;
=20
-		spin_lock(&bank_lock);
+		raw_spin_lock(&bank_lock);
 		status =3D ipu_read_reg(ipu, bank->status);
 		/* Not clearing all interrupts, see above */
 		status &=3D ipu_read_reg(ipu, bank->control);
-		spin_unlock(&bank_lock);
+		raw_spin_unlock(&bank_lock);
 		while ((line =3D ffs(status))) {
 			struct ipu_irq_map *map;
=20
 			line--;
 			status &=3D ~(1UL << line);
=20
-			spin_lock(&bank_lock);
+			raw_spin_lock(&bank_lock);
 			map =3D src2map(32 * i + line);
 			if (map)
 				irq =3D map->irq;
-			spin_unlock(&bank_lock);
+			raw_spin_unlock(&bank_lock);
=20
 			if (!map) {
 				pr_err("IPU: Interrupt on unmapped source %u bank %d\n",
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
