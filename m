Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B9C4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD665610C7
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242750AbhJ0PRq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:17:46 -0400
Received: from foss.arm.com ([217.140.110.172]:44434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242727AbhJ0PRm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 11:17:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A47713A1;
        Wed, 27 Oct 2021 08:15:17 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BBCD93F70D;
        Wed, 27 Oct 2021 08:15:15 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 3/3] irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime
Date:   Wed, 27 Oct 2021 16:15:06 +0100
Message-Id: <20211027151506.2085066-4-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211027151506.2085066-1-valentin.schneider@arm.com>
References: <20211027151506.2085066-1-valentin.schneider@arm.com>
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
 drivers/irqchip/irq-gic-v3-its.c   | 16 ++++++++++++++++
 include/linux/irqchip/arm-gic-v3.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index f860733d3e4e..ee83eb377d7e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5203,6 +5203,15 @@ int its_cpu_init(void)
 	return 0;
 }
 
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
 	struct page *pend_page;
@@ -5231,6 +5240,10 @@ static int its_cpu_memreserve_lpi(unsigned int cpu)
 	}
 
 out:
+	/* Last CPU being brought up gets to issue the cleanup */
+	if (cpumask_equal(&cpus_booted_once_mask, cpu_possible_mask))
+		schedule_work(&rdist_memreserve_cpuhp_cleanup_work);
+
 	gic_data_rdist()->flags |= RD_LOCAL_MEMRESERVE_DONE;
 	return ret;
 }
@@ -5425,6 +5438,7 @@ int __init its_lpi_memreserve_init(void)
 	if (!efi_enabled(EFI_CONFIG_TABLES))
 		return 0;
 
+	gic_rdists->cpuhp_memreserve_state = CPUHP_INVALID;
 	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
 				  "irqchip/arm/gicv3/memreserve:online",
 				  its_cpu_memreserve_lpi,
@@ -5432,6 +5446,8 @@ int __init its_lpi_memreserve_init(void)
 	if (state < 0)
 		return state;
 
+	gic_rdists->cpuhp_memreserve_state = state;
+
 	return 0;
 }
 
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 51b85506ae90..12d91f0dedf9 100644
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

