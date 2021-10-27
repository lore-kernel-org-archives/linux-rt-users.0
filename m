Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13B0C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46354604E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242747AbhJ0PRp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:17:45 -0400
Received: from foss.arm.com ([217.140.110.172]:44418 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233978AbhJ0PRl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 11:17:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87B41113E;
        Wed, 27 Oct 2021 08:15:15 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 36C6A3F70D;
        Wed, 27 Oct 2021 08:15:14 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 2/3] irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
Date:   Wed, 27 Oct 2021 16:15:05 +0100
Message-Id: <20211027151506.2085066-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027151506.2085066-1-valentin.schneider@arm.com>
References: <20211027151506.2085066-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Memory used by the LPI tables have to be made persistent for kexec to have
a chance to work, as explained in [1]. If they have been made persistent
and we are booting into a kexec'd kernel, we also need to free the pages
that were preemptively allocated by the new kernel for those tables.

Both of those operations currently happen during its_cpu_init(), which
happens in a _STARTING (IOW atomic) cpuhp callback for secondary
CPUs. efi_mem_reserve_iomem() issues a GFP_ATOMIC allocation, which
unfortunately doesn't work under PREEMPT_RT (this ends up grabbing a
non-raw spinlock, which can sleep under PREEMPT_RT). Similarly, freeing the
pages ends up grabbing a sleepable spinlock.

Since the memreserve is only required by kexec, it doesn't have to be done
so early in the secondary boot process. Issue the reservation in a new
CPUHP_AP_ONLINE_DYN cpuhp callback, and piggy-back the page freeing on top
of it. A CPU gets to run the body of this new callback exactly once.

As kexec issues a machine_shutdown() prior to machine_kexec(), it will be
serialized vs a CPU being plugged to life by the hotplug machinery - either
the CPU will have been brought up and have had its redistributor's pending
table memreserved, or it never went online and will have its table
allocated by the new kernel.

[1]: https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com/
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 58 +++++++++++++++++++++++++++---
 drivers/irqchip/irq-gic-v3.c       |  1 +
 include/linux/irqchip/arm-gic-v3.h |  1 +
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 74c22741f3ce..f860733d3e4e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -47,6 +47,8 @@
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
 #define RD_LOCAL_LPI_ENABLED                    BIT(0)
+#define RD_LOCAL_PENDTABLE_PREALLOCATED         BIT(1)
+#define RD_LOCAL_MEMRESERVE_DONE                BIT(2)
 
 static u32 lpi_id_bits;
 
@@ -3065,15 +3067,13 @@ static void its_cpu_init_lpis(void)
 		paddr &= GENMASK_ULL(51, 16);
 
 		WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
-		its_free_pending_table(gic_data_rdist()->pend_page);
-		gic_data_rdist()->pend_page = NULL;
+		gic_data_rdist()->flags |= RD_LOCAL_PENDTABLE_PREALLOCATED;
 
 		goto out;
 	}
 
 	pend_page = gic_data_rdist()->pend_page;
 	paddr = page_to_phys(pend_page);
-	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
 
 	/* set PROPBASE */
 	val = (gic_rdists->prop_table_pa |
@@ -3163,7 +3163,8 @@ static void its_cpu_init_lpis(void)
 	gic_data_rdist()->flags |= RD_LOCAL_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
-		gic_data_rdist()->pend_page ? "allocated" : "reserved",
+		gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED ?
+		"reserved" : "allocated",
 		&paddr);
 }
 
@@ -5202,6 +5203,38 @@ int its_cpu_init(void)
 	return 0;
 }
 
+static int its_cpu_memreserve_lpi(unsigned int cpu)
+{
+	struct page *pend_page;
+	int ret = 0;
+
+	/* This gets to run exactly once per CPU */
+	if (gic_data_rdist()->flags & RD_LOCAL_MEMRESERVE_DONE)
+		return 0;
+
+	pend_page = gic_data_rdist()->pend_page;
+	if (WARN_ON(!pend_page)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	/*
+	 * If the pending table was pre-programmed, free the memory we
+	 * preemptively allocated. Otherwise, reserve that memory for
+	 * later kexecs.
+	 */
+	if (gic_data_rdist()->flags & RD_LOCAL_PENDTABLE_PREALLOCATED) {
+		its_free_pending_table(pend_page);
+		gic_data_rdist()->pend_page = NULL;
+	} else {
+		phys_addr_t paddr = page_to_phys(pend_page);
+		WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
+	}
+
+out:
+	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
+	return ret;
+}
+
 static const struct of_device_id its_device_id[] = {
 	{	.compatible	= "arm,gic-v3-its",	},
 	{},
@@ -5385,6 +5418,23 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
+int __init its_lpi_memreserve_init(void)
+{
+	int state;
+
+	if (!efi_enabled(EFI_CONFIG_TABLES))
+		return 0;
+
+	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				  "irqchip/arm/gicv3/memreserve:online",
+				  its_cpu_memreserve_lpi,
+				  NULL);
+	if (state < 0)
+		return state;
+
+	return 0;
+}
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index fd4e9a37fea6..7a962767d835 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1802,6 +1802,7 @@ static int __init gic_init_bases(void __iomem *dist_base,
 	if (gic_dist_supports_lpis()) {
 		its_init(handle, &gic_data.rdists, gic_data.domain);
 		its_cpu_init();
+		its_lpi_memreserve_init();
 	} else {
 		if (IS_ENABLED(CONFIG_ARM_GIC_V2M))
 			gicv2m_init(handle, gic_data.domain);
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 0dc34d7d735a..51b85506ae90 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -632,6 +632,7 @@ struct rdists {
 
 struct irq_domain;
 struct fwnode_handle;
+int __init its_lpi_memreserve_init(void);
 int its_cpu_init(void);
 int its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	     struct irq_domain *domain);
-- 
2.25.1

