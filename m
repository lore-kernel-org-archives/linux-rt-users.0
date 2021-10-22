Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F50BC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0945261059
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhJVKfs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:35:48 -0400
Received: from foss.arm.com ([217.140.110.172]:52564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232719AbhJVKfr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Oct 2021 06:35:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 349AD1474;
        Fri, 22 Oct 2021 03:33:29 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D68793F70D;
        Fri, 22 Oct 2021 03:33:27 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/3] irqchip/gic-v3-its: Postpone LPI pending table freeing and memreserve
Date:   Fri, 22 Oct 2021 11:33:06 +0100
Message-Id: <20211022103307.1711619-3-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022103307.1711619-1-valentin.schneider@arm.com>
References: <20211022103307.1711619-1-valentin.schneider@arm.com>
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

Since the memreserve is only required by kexec, it doesn't have to be
done so early in the secondary boot process. Issue the reservation in a new
CPUHP_AP_ONLINE_DYN cpuhp callback, and piggy-back the page freeing on top
of it. As kexec issues a machine_shutdown() prior to machine_kexec(), it
will be serialized vs a CPU being plugged to life by the hotplug machinery -
either the CPU will have been brought up and have had its redistributor's
pending table memreserved, or it never went online and will have its table
allocated by the new kernel.

[1]: https://lore.kernel.org/lkml/20180921195954.21574-1-marc.zyngier@arm.com/
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 65 ++++++++++++++++++++++++++++++--
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a688ed5c21e8..a6a4af59205e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -47,6 +47,8 @@
 #define RDISTS_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
 
 #define RDIST_FLAGS_LPI_ENABLED                 BIT(0)
+#define RDIST_FLAGS_PENDTABLE_RESERVED          BIT(1)
+#define RDIST_FLAGS_PENDTABLE_PREALLOCATED      BIT(2)
 
 static u32 lpi_id_bits;
 
@@ -3065,15 +3067,15 @@ static void its_cpu_init_lpis(void)
 		paddr &= GENMASK_ULL(51, 16);
 
 		WARN_ON(!gic_check_reserved_range(paddr, LPI_PENDBASE_SZ));
-		its_free_pending_table(gic_data_rdist()->pend_page);
-		gic_data_rdist()->pend_page = NULL;
+		gic_data_rdist()->flags |=
+			RDIST_FLAGS_PENDTABLE_RESERVED |
+			RDIST_FLAGS_PENDTABLE_PREALLOCATED;
 
 		goto out;
 	}
 
 	pend_page = gic_data_rdist()->pend_page;
 	paddr = page_to_phys(pend_page);
-	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
 
 	/* set PROPBASE */
 	val = (gic_rdists->prop_table_pa |
@@ -3163,7 +3165,8 @@ static void its_cpu_init_lpis(void)
 	gic_data_rdist()->flags |= RDIST_FLAGS_LPI_ENABLED;
 	pr_info("GICv3: CPU%d: using %s LPI pending table @%pa\n",
 		smp_processor_id(),
-		gic_data_rdist()->pend_page ? "allocated" : "reserved",
+		gic_data_rdist()->flags & RDIST_FLAGS_PENDTABLE_PREALLOCATED ?
+		"reserved" : "allocated",
 		&paddr);
 }
 
@@ -5202,6 +5205,39 @@ int its_cpu_init(void)
 	return 0;
 }
 
+#ifdef CONFIG_EFI
+static int its_cpu_memreserve_lpi(unsigned int cpu)
+{
+	struct page *pend_page = gic_data_rdist()->pend_page;
+	phys_addr_t paddr;
+
+	/*
+	 * If the pending table was pre-programmed, free the memory we
+	 * preemptively allocated.
+	 */
+	if (pend_page &&
+	    (gic_data_rdist()->flags & RDIST_FLAGS_PENDTABLE_PREALLOCATED)) {
+		its_free_pending_table(gic_data_rdist()->pend_page);
+		gic_data_rdist()->pend_page = NULL;
+	}
+
+	/*
+	 * Did we already issue a memreserve? This could be via a previous
+	 * invocation of this callback, or in a previous life before kexec.
+	 */
+	if (gic_data_rdist()->flags & RDIST_FLAGS_PENDTABLE_RESERVED)
+		return 0;
+
+	gic_data_rdist()->flags |= RDIST_FLAGS_PENDTABLE_RESERVED;
+
+	pend_page = gic_data_rdist()->pend_page;
+	paddr = page_to_phys(pend_page);
+	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
+
+	return 0;
+}
+#endif
+
 static const struct of_device_id its_device_id[] = {
 	{	.compatible	= "arm,gic-v3-its",	},
 	{},
@@ -5385,6 +5421,23 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
+static int __init its_lpi_memreserve_init(void)
+{
+	int state;
+
+	if (!efi_enabled(EFI_CONFIG_TABLES))
+		return 0;
+
+	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"irqchip/arm/gicv3/memreserve:online",
+				its_cpu_memreserve_lpi,
+				NULL);
+	if (state < 0)
+		return state;
+
+	return 0;
+}
+
 int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		    struct irq_domain *parent_domain)
 {
@@ -5412,6 +5465,10 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (err)
 		return err;
 
+	err = its_lpi_memreserve_init();
+	if (err)
+		return err;
+
 	list_for_each_entry(its, &its_nodes, entry) {
 		has_v4 |= is_v4(its);
 		has_v4_1 |= is_v4_1(its);
-- 
2.25.1

