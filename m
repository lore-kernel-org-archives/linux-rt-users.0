Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD18C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95666610C8
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbhJ0PRk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:17:40 -0400
Received: from foss.arm.com ([217.140.110.172]:44412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242712AbhJ0PRj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 11:17:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 00FD8106F;
        Wed, 27 Oct 2021 08:15:14 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A53F03F70D;
        Wed, 27 Oct 2021 08:15:12 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 1/3] irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
Date:   Wed, 27 Oct 2021 16:15:04 +0100
Message-Id: <20211027151506.2085066-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027151506.2085066-1-valentin.schneider@arm.com>
References: <20211027151506.2085066-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Later patches will require tracking some per-rdist status. Reuse the bytes
"lost" to padding within the __percpu rdist struct as a flags field, and
re-encode ->lpi_enabled within said flags.

No change in functionality intended.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 8 +++++---
 include/linux/irqchip/arm-gic-v3.h | 2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d15366..74c22741f3ce 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -46,6 +46,8 @@
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
+#define RD_LOCAL_LPI_ENABLED                    BIT(0)
+
 static u32 lpi_id_bits;
 
 /*
@@ -3044,7 +3046,7 @@ static void its_cpu_init_lpis(void)
 	phys_addr_t paddr;
 	u64 val, tmp;
 
-	if (gic_data_rdist()->lpi_enabled)
+	if (gic_data_rdist()->flags & RD_LOCAL_LPI_ENABLED)
 		return;
 
 	val = readl_relaxed(rbase + GICR_CTLR);
@@ -3158,7 +3160,7 @@ static void its_cpu_init_lpis(void)
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
-	gic_data_rdist()->lpi_enabled = true;
+	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
 		gic_data_rdist()->pend_page ? "allocated" : "reserved",
@@ -5138,7 +5140,7 @@ static int redist_disable_lpis(void)
 	 *
 	 * If running with preallocated tables, there is nothing to do.
 	 */
-	if (gic_data_rdist()->lpi_enabled ||
+	if ((gic_data_rdist()->flags & RD_LOCAL_LPI_ENABLED) ||
 	    (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED))
 		return 0;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 81cbf85f73de..0dc34d7d735a 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -615,7 +615,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
-		bool		lpi_enabled;
+		u64             flags;
 		cpumask_t	*vpe_table_mask;
 		void		*vpe_l1_base;
 	} __percpu		*rdist;
-- 
2.25.1

