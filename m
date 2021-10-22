Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1F7C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CE561208
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhJVKfq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:35:46 -0400
Received: from foss.arm.com ([217.140.110.172]:52554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232651AbhJVKfp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Oct 2021 06:35:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A11BC1396;
        Fri, 22 Oct 2021 03:33:27 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 517CD3F70D;
        Fri, 22 Oct 2021 03:33:26 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 1/3] irqchip/gic-v3-its: Give the percpu rdist struct its own flags field
Date:   Fri, 22 Oct 2021 11:33:05 +0100
Message-Id: <20211022103307.1711619-2-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022103307.1711619-1-valentin.schneider@arm.com>
References: <20211022103307.1711619-1-valentin.schneider@arm.com>
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
 drivers/irqchip/irq-gic-v3-its.c   | 26 ++++++++++++++------------
 include/linux/irqchip/arm-gic-v3.h |  2 +-
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index eb0882d15366..a688ed5c21e8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -43,8 +43,10 @@
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
 
-#define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
-#define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
+#define RDISTS_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
+#define RDISTS_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
+
+#define RDIST_FLAGS_LPI_ENABLED                 BIT(0)
 
 static u32 lpi_id_bits;
 
@@ -1415,7 +1417,7 @@ static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 	 * And yes, we're flushing exactly: One. Single. Byte.
 	 * Humpf...
 	 */
-	if (gic_rdists->flags & RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING)
+	if (gic_rdists->flags & RDISTS_FLAGS_PROPBASE_NEEDS_FLUSHING)
 		gic_flush_dcache_to_poc(cfg, sizeof(*cfg));
 	else
 		dsb(ishst);
@@ -2224,7 +2226,7 @@ static int gic_reserve_range(phys_addr_t addr, unsigned long size)
 
 static int __init its_setup_lpi_prop_table(void)
 {
-	if (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) {
+	if (gic_rdists->flags & RDISTS_FLAGS_RD_TABLES_PREALLOCATED) {
 		u64 val;
 
 		val = gicr_read_propbaser(gic_data_rdist_rd_base() + GICR_PROPBASER);
@@ -2978,8 +2980,8 @@ static int __init allocate_lpi_tables(void)
 	 */
 	val = readl_relaxed(gic_data_rdist_rd_base() + GICR_CTLR);
 	if ((val & GICR_CTLR_ENABLE_LPIS) && enabled_lpis_allowed()) {
-		gic_rdists->flags |= (RDIST_FLAGS_RD_TABLES_PREALLOCATED |
-				      RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING);
+		gic_rdists->flags |= (RDISTS_FLAGS_RD_TABLES_PREALLOCATED |
+				      RDISTS_FLAGS_PROPBASE_NEEDS_FLUSHING);
 		pr_info("GICv3: Using preallocated redistributor tables\n");
 	}
 
@@ -3044,11 +3046,11 @@ static void its_cpu_init_lpis(void)
 	phys_addr_t paddr;
 	u64 val, tmp;
 
-	if (gic_data_rdist()->lpi_enabled)
+	if (gic_data_rdist()->flags & RDIST_FLAGS_LPI_ENABLED)
 		return;
 
 	val = readl_relaxed(rbase + GICR_CTLR);
-	if ((gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED) &&
+	if ((gic_rdists->flags & RDISTS_FLAGS_RD_TABLES_PREALLOCATED) &&
 	    (val & GICR_CTLR_ENABLE_LPIS)) {
 		/*
 		 * Check that we get the same property table on all
@@ -3095,7 +3097,7 @@ static void its_cpu_init_lpis(void)
 			gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 		}
 		pr_info_once("GIC: using cache flushing for LPI property table\n");
-		gic_rdists->flags |= RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING;
+		gic_rdists->flags |= RDISTS_FLAGS_PROPBASE_NEEDS_FLUSHING;
 	}
 
 	/* set PENDBASE */
@@ -3158,7 +3160,7 @@ static void its_cpu_init_lpis(void)
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
 out:
-	gic_data_rdist()->lpi_enabled = true;
+	gic_data_rdist()->flags |= RDIST_FLAGS_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
 		gic_data_rdist()->pend_page ? "allocated" : "reserved",
@@ -5138,8 +5140,8 @@ static int redist_disable_lpis(void)
 	 *
 	 * If running with preallocated tables, there is nothing to do.
 	 */
-	if (gic_data_rdist()->lpi_enabled ||
-	    (gic_rdists->flags & RDIST_FLAGS_RD_TABLES_PREALLOCATED))
+	if ((gic_data_rdist()->flags & RDIST_FLAGS_LPI_ENABLED) ||
+	    (gic_rdists->flags & RDISTS_FLAGS_RD_TABLES_PREALLOCATED))
 		return 0;
 
 	/*
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

