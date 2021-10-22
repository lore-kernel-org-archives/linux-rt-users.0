Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009AAC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD976112F
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Oct 2021 10:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhJVKft (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:35:49 -0400
Received: from foss.arm.com ([217.140.110.172]:52574 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232721AbhJVKfs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Oct 2021 06:35:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96BC13A1;
        Fri, 22 Oct 2021 03:33:30 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 673CC3F70D;
        Fri, 22 Oct 2021 03:33:29 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 3/3] irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime
Date:   Fri, 22 Oct 2021 11:33:07 +0100
Message-Id: <20211022103307.1711619-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022103307.1711619-1-valentin.schneider@arm.com>
References: <20211022103307.1711619-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The new memreserve cpuhp callback only needs to survive up until a point
where every CPU in the system has booted once. Beyond that, it becomes a
no-op and can be put in the bin.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c   | 23 ++++++++++++++++++++---
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a6a4af59205e..4ae9ae6b90fe 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5206,6 +5206,15 @@ int its_cpu_init(void)
 }
 
 #ifdef CONFIG_EFI
+static void rdist_memreserve_cpuhp_cleanup_workfn(struct work_struct *work)
+{
+	cpuhp_remove_state_nocalls(gic_rdists->cpuhp_memreserve_state);
+	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
+}
+
+static DECLARE_WORK(rdist_memreserve_cpuhp_cleanup_work,
+		    rdist_memreserve_cpuhp_cleanup_workfn);
+
 static int its_cpu_memreserve_lpi(unsigned int cpu)
 {
 	struct page *pend_page = gic_data_rdist()->pend_page;
@@ -5226,7 +5235,7 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 	 * invocation of this callback, or in a previous life before kexec.
 	 */
 	if (gic_data_rdist()->flags & RDIST_FLAGS_PENDTABLE_RESERVED)
-		return 0;
+		goto out;
 
 	gic_data_rdist()->flags |= RDIST_FLAGS_PENDTABLE_RESERVED;
 
@@ -5234,6 +5243,11 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 	paddr = page_to_phys(pend_page);
 	WARN_ON(gic_reserve_range(paddr, LPI_PENDBASE_SZ));
 
+out:
+	/* This only needs to run once per CPU */
+	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
+
 	return 0;
 }
 #endif
@@ -5421,13 +5435,14 @@ static void __init its_acpi_probe(void)
 static void __init its_acpi_probe(void) { }
 #endif
 
-static int __init its_lpi_memreserve_init(void)
+static int __init its_lpi_memreserve_init(struct rdists *rdists)
 {
 	int state;
 
 	if (!efi_enabled(EFI_CONFIG_TABLES))
 		return 0;
 
+	rdists->cpuhp_memreserve_state = CPUHP_INVALID;
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				"irqchip/arm/gicv3/memreserve:online",
 				its_cpu_memreserve_lpi,
@@ -5435,6 +5450,8 @@ static int __init its_lpi_memreserve_init(void)
 	if (state < 0)
 		return state;
 
+	rdists->cpuhp_memreserve_state = state;
+
 	return 0;
 }
 
@@ -5465,7 +5482,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 	if (err)
 		return err;
 
-	err = its_lpi_memreserve_init();
+	err = its_lpi_memreserve_init(rdists);
 	if (err)
 		return err;
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 0dc34d7d735a..95479b315918 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -624,6 +624,7 @@ struct rdists {
 	u64			flags;
 	u32			gicd_typer;
 	u32			gicd_typer2;
+	int                     cpuhp_memreserve_state;
 	bool			has_vlpis;
 	bool			has_rvpeid;
 	bool			has_direct_lpi;
-- 
2.25.1

