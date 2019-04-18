Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE98DC10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD01A217FA
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389831AbfDRR01 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:26:27 -0400
Received: from foss.arm.com ([217.140.101.70]:38064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389826AbfDRR00 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 13:26:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19C9E169E;
        Thu, 18 Apr 2019 10:26:26 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D61FA3F557;
        Thu, 18 Apr 2019 10:26:23 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two parts
Date:   Thu, 18 Apr 2019 18:26:06 +0100
Message-Id: <20190418172611.21561-3-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On RT, the function iommu_dma_map_msi_msg may be called from
non-preemptible context. This will lead to a splat with
CONFIG_DEBUG_ATOMIC_SLEEP as the function is using spin_lock
(they can sleep on RT).

The function iommu_dma_map_msi_msg is used to map the MSI page in the
IOMMU PT and update the MSI message with the IOVA.

Only the part to lookup for the MSI page requires to be called in
preemptible context. As the MSI page cannot change over the lifecycle
of the MSI interrupt, the lookup can be cached and re-used later on.

This patch split the function iommu_dma_map_msi_msg in two new
functions:
    - iommu_dma_prepare_msi: This function will prepare the mapping in
    the IOMMU and store the cookie in the structure msi_desc. This
    function should be called in preemptible context.
    - iommu_dma_compose_msi_msg: This function will update the MSI
    message with the IOVA when the device is behind an IOMMU.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/iommu/dma-iommu.c | 43 ++++++++++++++++++++++++++++++++-----------
 include/linux/dma-iommu.h | 21 +++++++++++++++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 77aabe637a60..f5c1f1685095 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -888,17 +888,17 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
-	struct device *dev = msi_desc_to_dev(irq_get_msi_desc(irq));
+	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
 	struct iommu_dma_cookie *cookie;
-	struct iommu_dma_msi_page *msi_page;
-	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
 	unsigned long flags;
 
-	if (!domain || !domain->iova_cookie)
-		return;
+	if (!domain || !domain->iova_cookie) {
+		desc->iommu_cookie = NULL;
+		return 0;
+	}
 
 	cookie = domain->iova_cookie;
 
@@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 	 * of an MSI from within an IPI handler.
 	 */
 	spin_lock_irqsave(&cookie->msi_lock, flags);
-	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
+	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
 	spin_unlock_irqrestore(&cookie->msi_lock, flags);
 
-	if (WARN_ON(!msi_page)) {
+	return (desc->iommu_cookie) ? 0 : -ENOMEM;
+}
+
+void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	struct device *dev = msi_desc_to_dev(desc);
+	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_dma_msi_page *msi_page = desc->iommu_cookie;
+
+	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
+		return;
+
+	msg->address_hi = upper_32_bits(msi_page->iova);
+	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
+	msg->address_lo += lower_32_bits(msi_page->iova);
+}
+
+void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
+{
+	struct msi_desc *desc = irq_get_msi_desc(irq);
+	phys_addr_t msi_addr = (u64)msg->address_hi << 32 | msg->address_lo;
+
+	if (WARN_ON(iommu_dma_prepare_msi(desc, msi_addr))) {
 		/*
 		 * We're called from a void callback, so the best we can do is
 		 * 'fail' by filling the message with obviously bogus values.
@@ -922,8 +945,6 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 		msg->address_lo = ~0U;
 		msg->data = ~0U;
 	} else {
-		msg->address_hi = upper_32_bits(msi_page->iova);
-		msg->address_lo &= cookie_msi_granule(cookie) - 1;
-		msg->address_lo += lower_32_bits(msi_page->iova);
+		iommu_dma_compose_msi_msg(irq, msg);
 	}
 }
diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
index e760dc5d1fa8..2f4b2c2cc859 100644
--- a/include/linux/dma-iommu.h
+++ b/include/linux/dma-iommu.h
@@ -71,12 +71,23 @@ void iommu_dma_unmap_resource(struct device *dev, dma_addr_t handle,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 /* The DMA API isn't _quite_ the whole story, though... */
+/*
+ * Map the MSI page in the IOMMU device and store it in @desc
+ *
+ * Return 0 if succeeded other an error if the preparation has failed.
+ */
+int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
+
+/* Update the MSI message if required. */
+void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg);
+
 void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg);
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
 #else
 
 struct iommu_domain;
+struct msi_desc;
 struct msi_msg;
 struct device;
 
@@ -99,6 +110,16 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
+					phys_addr_t msi_addr)
+{
+	return 0;
+}
+
+static inline void iommu_dma_compose_msi_msg(int irq, struct msi_msg *msg)
+{
+}
+
 static inline void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
 {
 }
-- 
2.11.0

