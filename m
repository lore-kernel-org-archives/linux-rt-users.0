Return-Path: <SRS0=Byy1=TB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8B4C43219
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 13:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2816A21743
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 May 2019 13:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEAN6s (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 May 2019 09:58:48 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59694 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfEAN6r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 May 2019 09:58:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87553EBD;
        Wed,  1 May 2019 06:58:46 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13B883F5AF;
        Wed,  1 May 2019 06:58:43 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org,
        Julien Grall <julien.grall@arm.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: [PATCH v3 4/7] irqchip/gic-v3-its: Don't map the MSI page in its_irq_compose_msi_msg()
Date:   Wed,  1 May 2019 14:58:21 +0100
Message-Id: <20190501135824.25586-5-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190501135824.25586-1-julien.grall@arm.com>
References: <20190501135824.25586-1-julien.grall@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

its_irq_compose_msi_msg() may be called from non-preemptible context.
However, on RT, iommu_dma_map_msi_msg requires to be called from a
preemptible context.

A recent change split iommu_dma_map_msi_msg() in two new functions:
one that should be called in preemptible context, the other does
not have any requirement.

The GICv3 ITS driver is reworked to avoid executing preemptible code in
non-preemptible context. This can be achieved by preparing the MSI
mapping when allocating the MSI interrupt.

Signed-off-by: Julien Grall <julien.grall@arm.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

---
    Changes in v3:
        - Fix typo in the commit message
        - Check the return of iommu_dma_prepare_msi
        - Add Eric's reviewed-by

    Changes in v2:
        - Rework the commit message to use imperative mood
---
 drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7577755bdcf4..9cddf336c09d 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1179,7 +1179,7 @@ static void its_irq_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 	msg->address_hi		= upper_32_bits(addr);
 	msg->data		= its_get_event_id(d);
 
-	iommu_dma_map_msi_msg(d->irq, msg);
+	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(d), msg);
 }
 
 static int its_irq_set_irqchip_state(struct irq_data *d,
@@ -2566,6 +2566,7 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 {
 	msi_alloc_info_t *info = args;
 	struct its_device *its_dev = info->scratchpad[0].ptr;
+	struct its_node *its = its_dev->its;
 	irq_hw_number_t hwirq;
 	int err;
 	int i;
@@ -2574,6 +2575,10 @@ static int its_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 	if (err)
 		return err;
 
+	err = iommu_dma_prepare_msi(info->desc, its->get_msi_base(its_dev));
+	if (err)
+		return err;
+
 	for (i = 0; i < nr_irqs; i++) {
 		err = its_irq_gic_domain_alloc(domain, virq + i, hwirq + i);
 		if (err)
-- 
2.11.0

