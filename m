Return-Path: <SRS0=dorw=TZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E06C282E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AC921871
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEYDdS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 May 2019 23:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfEYDdR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 May 2019 23:33:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CE4A2177E;
        Sat, 25 May 2019 03:33:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNQp-0002FL-EG; Fri, 24 May 2019 23:33:15 -0400
Message-Id: <20190525033315.333596820@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:32:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org
Subject: [PATCH RT 1/6] powerpc/pseries/iommu: Use a locallock instead local_irq_save()
References: <20190525033232.795741612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.37-rt20-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The locallock protects the per-CPU variable tce_page. The function
attempts to allocate memory while tce_page is protected (by disabling
interrupts).

Use local_irq_save() instead of local_irq_disable().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/platforms/pseries/iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 06f02960b439..d80d919c78d3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -38,6 +38,7 @@
 #include <linux/of.h>
 #include <linux/iommu.h>
 #include <linux/rculist.h>
+#include <linux/locallock.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -212,6 +213,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
+static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -232,7 +234,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		                           direction, attrs);
 	}
 
-	local_irq_save(flags);	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irqsave(tcp_page_lock, flags);
 
 	tcep = __this_cpu_read(tce_page);
 
@@ -243,7 +246,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(tcp_page_lock, flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -277,7 +280,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(tcp_page_lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -435,13 +438,14 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 	u64 rc = 0;
 	long l, limit;
 
-	local_irq_disable();	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irq(tcp_page_lock);
 	tcep = __this_cpu_read(tce_page);
 
 	if (!tcep) {
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		if (!tcep) {
-			local_irq_enable();
+			local_unlock_irq(tcp_page_lock);
 			return -ENOMEM;
 		}
 		__this_cpu_write(tce_page, tcep);
@@ -487,7 +491,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_irq_enable();
+	local_unlock_irq(tcp_page_lock);
 	return rc;
 }
 
-- 
2.20.1


