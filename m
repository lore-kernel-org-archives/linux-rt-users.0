From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [4.14.66-rt TEST PATCH 3/3] irqchip/gic-v3-its: Move pending table allocation to init time
Date: Fri, 31 Aug 2018 14:20:09 -0500
Message-ID: <20180831192009.17257-3-grygorii.strashko@ti.com>
References: <20180830091456.mz73o26ohrc3rq2f@linutronix.de>
 <20180831192009.17257-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sekhar Nori <nsekhar@ti.com>, Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
To: <bigeasy@linutronix.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831192009.17257-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[bigeasy: backport commit effe377d415 ("irqchip/gic-v3-its: Move pending
          table allocation to init time")]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/irqchip/irq-gic-v3-its.c   | 79 +++++++++++++++++---------------------
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 36 insertions(+), 44 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 23c5818..1aaa757 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1446,7 +1446,7 @@ static void its_free_prop_table(struct page *prop_page)
 		   get_order(LPI_PROPBASE_SZ));
 }
 
-static int __init its_alloc_lpi_tables(void)
+static int __init its_alloc_lpi_prop_table(void)
 {
 	phys_addr_t paddr;
 
@@ -1739,17 +1739,15 @@ static int its_alloc_collections(struct its_node *its)
 	return 0;
 }
 
-static struct page *its_allocate_pending_table(unsigned int cpu)
+static struct page *its_allocate_pending_table(gfp_t gfp_flags)
 {
 	struct page *pend_page;
-	unsigned int order;
 	/*
 	 * The pending pages have to be at least 64kB aligned,
 	 * hence the 'max(LPI_PENDBASE_SZ, SZ_64K)' below.
 	 */
-	order = get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K));
-	pend_page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
-				     order);
+	pend_page = alloc_pages(gfp_flags | __GFP_ZERO,
+				get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 	if (!pend_page)
 		return NULL;
 
@@ -1765,25 +1763,31 @@ static void its_free_pending_table(struct page *pt)
 		   get_order(max_t(u32, LPI_PENDBASE_SZ, SZ_64K)));
 }
 
-static int its_alloc_pend_page(unsigned int cpu)
+static int __init allocate_lpi_tables(void)
 {
-	struct page *pend_page;
-	phys_addr_t paddr;
+	int err, cpu;
 
-	pend_page = gic_data_rdist_cpu(cpu)->pend_page;
-	if (pend_page)
-		return 0;
+	err = its_alloc_lpi_prop_table();
+	if (err)
+		return err;
 
-	pend_page = its_allocate_pending_table(cpu);
-	if (!pend_page) {
-		pr_err("Failed to allocate PENDBASE for CPU%d\n",
-		       smp_processor_id());
-		return -ENOMEM;
+	/*
+	 * We allocate all the pending tables anyway, as we may have a
+	 * mix of RDs that have had LPIs enabled, and some that
+	 * don't. We'll free the unused ones as each CPU comes online.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct page *pend_page;
+
+		pend_page = its_allocate_pending_table(GFP_NOWAIT);
+		if (!pend_page) {
+			pr_err("Failed to allocate PENDBASE for CPU%d\n", cpu);
+			return -ENOMEM;
+		}
+
+		gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	}
 
-	paddr = page_to_phys(pend_page);
-	pr_info("CPU%d: using LPI pending table @%pa\n", cpu, &paddr);
-	gic_data_rdist_cpu(cpu)->pend_page = pend_page;
 	return 0;
 }
 
@@ -1791,22 +1795,14 @@ static void its_cpu_init_lpis(void)
 {
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
+	phys_addr_t paddr;
 	u64 val, tmp;
 
-	/* If we didn't allocate the pending table yet, do it now */
-	pend_page = gic_data_rdist()->pend_page;
-	if (!pend_page)
+	if (gic_data_rdist()->lpi_enabled)
 		return;
 
-	/* Disable LPIs */
-	val = readl_relaxed(rbase + GICR_CTLR);
-	val &= ~GICR_CTLR_ENABLE_LPIS;
-	writel_relaxed(val, rbase + GICR_CTLR);
-
-	/*
-	 * Make sure any change to the table is observable by the GIC.
-	 */
-	dsb(sy);
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
 
 	/* set PROPBASE */
 	val = (page_to_phys(gic_rdists->prop_page) |
@@ -1859,6 +1855,10 @@ static void its_cpu_init_lpis(void)
 
 	/* Make sure the GIC has seen the above */
 	dsb(sy);
+	gic_data_rdist()->lpi_enabled = true;
+	pr_info("GICv3: CPU%d: using LPI pending table @%pa\n",
+		smp_processor_id(),
+		&paddr);
 }
 
 static void its_cpu_init_collection(void)
@@ -2615,7 +2615,7 @@ static int its_vpe_init(struct its_vpe *vpe)
 		return vpe_id;
 
 	/* Allocate VPT */
-	vpt_page = its_allocate_pending_table(raw_smp_processor_id());
+	vpt_page = its_allocate_pending_table(GFP_KERNEL);
 	if (!vpt_page) {
 		its_vpe_id_free(vpe_id);
 		return -ENOMEM;
@@ -3358,18 +3358,9 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	}
 
 	gic_rdists = rdists;
-	err = its_alloc_lpi_tables();
-	if (err)
-		return err;
 
-	err = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "irqchip/arm/gicv3:prepare",
-				its_alloc_pend_page, NULL);
-	if (err < 0) {
-		pr_warn("ITS: Can't register CPU-hoplug callback.\n");
-		return err;
-	}
-	err = its_alloc_pend_page(smp_processor_id());
-	if (err < 0)
+	err = allocate_lpi_tables();
+	if (err)
 		return err;
 
 	list_for_each_entry(its, &its_nodes, entry)
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index bacb499..688f256 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -568,6 +568,7 @@ struct rdists {
 		void __iomem	*rd_base;
 		struct page	*pend_page;
 		phys_addr_t	phys_base;
+		bool		lpi_enabled;
 	} __percpu		*rdist;
 	struct page		*prop_page;
 	int			id_bits;
-- 
2.10.5
