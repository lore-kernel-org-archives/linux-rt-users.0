Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D14C10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11FCA206B6
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbfDRR0n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:26:43 -0400
Received: from foss.arm.com ([217.140.101.70]:38158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389775AbfDRR0i (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 13:26:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 812D080D;
        Thu, 18 Apr 2019 10:26:38 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49BEC3F557;
        Thu, 18 Apr 2019 10:26:36 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 7/7] iommu/dma-iommu: Remove iommu_dma_map_msi_msg()
Date:   Thu, 18 Apr 2019 18:26:11 +0100
Message-Id: <20190418172611.21561-8-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A recent patch introduced two new functions to replace
iommu_dma_map_msi_msg() to avoid executing preemptible code in
non-preemptible context.

All the existings callers are now using the two new functions, so
iommu_dma_map_msi_msg() can be removed.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/iommu/dma-iommu.c | 20 --------------------
 include/linux/dma-iommu.h |  5 -----
 2 files changed, 25 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f5c1f1685095..fdc8ded62e87 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -928,23 +928,3 @@ void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)
 	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
 	msg->address_lo += lower_32_bits(msi_page->iova);
 }
-
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-	struct msi_desc *desc = irq_get_msi_desc(irq);
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
-
-	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
-		/*
-		 * We're called from a void callback, so the best we can do is
-		 * 'fail' by filling the message with obviously bogus values.
-		 * Since we got this far due to an IOMMU being present, it's
-		 * not like the existing address would have worked anyway...
-		 */
-		msg->address_hi = ~0U;
-		msg->address_lo = ~0U;
-		msg->data = ~0U;
-	} else {
-		iommu_dma_compose_msi_msg(irq, msg);
-	}
-}
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index 2f4b2c2cc859..4fe2b2fb19bf 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -81,7 +81,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
 /* Update the MSI message if required. */
 void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg);
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
@@ -120,10 +119,6 @@ static inline void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)
 {
 }
 
-static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
-{
-}
-
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
-- 
2.11.0

