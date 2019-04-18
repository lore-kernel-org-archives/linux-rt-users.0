Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36534C10F14
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BCA217FA
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389826AbfDRR03 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:26:29 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38084 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389841AbfDRR03 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 13:26:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FB4516A3;
        Thu, 18 Apr 2019 10:26:28 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57B6C3F557;
        Thu, 18 Apr 2019 10:26:26 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 3/7] irqchip/gicv2m: Don't map the MSI page in gicv2m_compose_msi_msg
Date:   Thu, 18 Apr 2019 18:26:07 +0100
Message-Id: <20190418172611.21561-4-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The function gicv2m_compose_msi_msg may be called from non-preemptible
context. However, on RT, iommu_dma_map_msi_msg requires to be called
from a preemptible context.

A recent patch split the function iommu_dma_map_msi_msg in 2 functions:
one that should be called in preemptible context, the other does
not have any requirement.

This patch reworks the gicv2m driver to avoid executing preemptible code
in non-preemptible context by preparing the MSI mapping when allocating
the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/irqchip/irq-gic-v2m.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index f5fe0100f9ff..e5372acd92c9 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -110,7 +110,7 @@ static void gicv2m_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (v2m->flags & GICV2M_NEEDS_SPI_OFFSET)
 		msg->data -= v2m->spi_offset;
 
-	iommu_dma_map_msi_msg(data->irq, msg);
+	iommu_dma_compose_msi_msg(data->irq, msg);
 }
 
 static struct irq_chip gicv2m_irq_chip = {
@@ -167,6 +167,7 @@ static void gicv2m_unalloc_msi(struct v2m_data *v2m, unsigned int hwirq,
 static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				   unsigned int nr_irqs, void *args)
 {
+	msi_alloc_info_t *info = args;
 	struct v2m_data *v2m = NULL, *tmp;
 	int hwirq, offset, i, err = 0;
 
@@ -186,6 +187,11 @@ static int gicv2m_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	hwirq = v2m->spi_start + offset;
 
+	err = iommu_dma_prepare_msi(info->desc,
+				    v2m->res.start + V2M_MSI_SETSPI_NS);
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = gicv2m_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
-- 
2.11.0

