Return-Path: <SRS0=4qQz=SU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51160C10F0E
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EAB2171F
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Apr 2019 17:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389818AbfDRR0Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:26:25 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRR0Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Apr 2019 13:26:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97BA71688;
        Thu, 18 Apr 2019 10:26:23 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 604463F557;
        Thu, 18 Apr 2019 10:26:21 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     logang@deltatee.com, douliyangs@gmail.com,
        miquel.raynal@bootlin.com, marc.zyngier@arm.com,
        jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org,
        robin.murphy@arm.com, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, Julien Grall <julien.grall@arm.com>
Subject: [PATCH 1/7] genirq/msi: Add a new field in msi_desc to store an IOMMU cookie
Date:   Thu, 18 Apr 2019 18:26:05 +0100
Message-Id: <20190418172611.21561-2-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190418172611.21561-1-julien.grall@arm.com>
References: <20190418172611.21561-1-julien.grall@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When an MSI doorbell is located downstream of an IOMMU, it is required
to swizzle the physical address with an appropriately-mapped IOVA for any
device attached to one of our DMA ops domain.

At the moment, the allocation of the mapping may be done when composing
the message. However, the composing may be done in non-preemtible
context while the allocation requires to be called from preemptible
context.

A follow-up patch will split the current logic in two functions
requiring to keep an IOMMU cookie per MSI.

This patch introduces a new field in msi_desc to store an IOMMU cookie
when CONFIG_IOMMU_DMA is selected.

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 include/linux/msi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 7e9b81c3b50d..d7907feef1bb 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,9 @@ struct msi_desc {
 	struct device			*dev;
 	struct msi_msg			msg;
 	struct irq_affinity_desc	*affinity;
+#ifdef CONFIG_IOMMU_DMA
+	const void			*iommu_cookie;
+#endif
 
 	union {
 		/* PCI MSI/X specific data */
-- 
2.11.0

