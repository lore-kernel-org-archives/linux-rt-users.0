Return-Path: <SRS0=oduH=TC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E7CC43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76EA214DA
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 May 2019 19:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556824586;
	bh=ztapzPlmSiYCt4nMj4OICaKQS1K1FzkfxA+tbrWwVwI=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=E1GwaafJYnOmQgZEnGD56+mnfDxPmLHeGib3yMONPKU0U8A2B6/TlsGT4Yw2u+7u3
	 MrGvDzy9D/BZ5EFI/QDgLPUnatJmjIfw4/T7qDm9daGpvrCf8PUnA2hV0DOBHb9GKj
	 zPHZngaQxVLG41sqD3+tHx9Tk2Ad2PgbiN5M4saY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfEBTQV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 May 2019 15:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfEBTQE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 May 2019 15:16:04 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0FAC2087F;
        Thu,  2 May 2019 19:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556824563;
        bh=ztapzPlmSiYCt4nMj4OICaKQS1K1FzkfxA+tbrWwVwI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=eMrYT3UX28W25Euer93AaJnulBqVmpc32cms0MggPiO5wp9eeSwrNlLdQwCngEQ5n
         givX2m0+SIAdnN1iM0gLD5kqaSjuZ/pb4b0W117KuU49NQJaPpzqZqNGowqzM5LADL
         tFtBjW9BlWA9KTuh4yeZ5YcdQN+r54vyM3L62dlM=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Subject: [PATCH RT 2/4] powerpc/pseries/iommu: Use a locallock instead local_irq_save()
Date:   Thu,  2 May 2019 14:15:37 -0500
Message-Id: <abec789dc411b74f8033fb340c792e94cd2372ba.1556824516.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1556824516.git.tom.zanussi@linux.intel.com>
References: <cover.1556824516.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

v3.18.138-rt116-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 5c1b4cd70e2ca0c81038b65babe6dc66086322e0 ]

The locallock protects the per-CPU variable tce_page. The function
attempts to allocate memory while tce_page is protected (by disabling
interrupts).

Use local_irq_save() instead of local_irq_disable().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	arch/powerpc/platforms/pseries/iommu.c
---
 arch/powerpc/platforms/pseries/iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 05a2c9eefc08..acc6f64f0cb8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -36,6 +36,7 @@
 #include <linux/crash_dump.h>
 #include <linux/memory.h>
 #include <linux/of.h>
+#include <linux/locallock.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -177,6 +178,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
+static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -197,7 +199,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		                           direction, attrs);
 	}
 
-	local_irq_save(flags);	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irqsave(tcp_page_lock, flags);
 
 	tcep = __get_cpu_var(tce_page);
 
@@ -208,7 +211,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(tcp_page_lock, flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -242,7 +245,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(tcp_page_lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -397,13 +400,14 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	u64 rc = 0;
 	long l, limit;
 
-	local_irq_disable();	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irq(tcp_page_lock);
 	tcep = __get_cpu_var(tce_page);
 
 	if (!tcep) {
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		if (!tcep) {
-			local_irq_enable();
+			local_unlock_irq(tcp_page_lock);
 			return -ENOMEM;
 		}
 		__get_cpu_var(tce_page) = tcep;
@@ -449,7 +453,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_irq_enable();
+	local_unlock_irq(tcp_page_lock);
 	return rc;
 }
 
-- 
2.14.1

