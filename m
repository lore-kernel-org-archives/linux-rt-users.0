Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F738C10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1208920879
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750910;
	bh=XP8f6UkErQBti+a6Kf6jSIfBEuoaOPaxDWYr0P9+J8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=0PE5jK5vlixcDIChBknXoDpsFKPSE8kMv1i97DwwMpyLdex/kaZA/88rNPz57kQ2k
	 TjvA5F6x3NbMQWWvzg+jf2e06LlIpIqqpeXVInWGQvAK9P5Xj6tV6+gEck5qFRk4Oy
	 jzhEZMyOaSae++sbRYKTD7wuttEzYG5d1yaFOTF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfDHTPE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbfDHTOj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:14:39 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E08F21906;
        Mon,  8 Apr 2019 19:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750878;
        bh=XP8f6UkErQBti+a6Kf6jSIfBEuoaOPaxDWYr0P9+J8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=iY/XJHTTsl4atbrhZB7NMhWahIxIphYE0ccmVNDfOditqsQn5JiAgSonGlQShDiS0
         paFDkE/ea0pSK22N5geIYzy+1m5bOOHfwwL+07i9ABXr8mJrVSrQGOKw9oKJ4wzhCX
         BaV/H9Qmy58ntVo0AxfDBr4S/pthXK/VtoaisYiE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com, amartin@nvidia.com
Subject: [PATCH 12/13] powerpc/pseries/iommu: Use a locallock instead local_irq_save()
Date:   Mon,  8 Apr 2019 14:14:14 -0500
Message-Id: <d7bed9f2ba9b6eef76cdcf106d3fc6bd82fddf58.1554737688.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1554737688.git.tom.zanussi@linux.intel.com>
References: <cover.1554737688.git.tom.zanussi@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14.109-rt58-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 5c1b4cd70e2ca0c81038b65babe6dc66086322e0 ]

The locallock protects the per-CPU variable tce_page. The function
attempts to allocate memory while tce_page is protected (by disabling
interrupts).

Use local_irq_save() instead of local_irq_disable().

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 7c181467d0ad..4bd046492c60 100644
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
@@ -213,6 +214,7 @@ static int tce_build_pSeriesLP(struct iommu_table *tbl, long tcenum,
 }
 
 static DEFINE_PER_CPU(__be64 *, tce_page);
+static DEFINE_LOCAL_IRQ_LOCK(tcp_page_lock);
 
 static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 				     long npages, unsigned long uaddr,
@@ -233,7 +235,8 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		                           direction, attrs);
 	}
 
-	local_irq_save(flags);	/* to protect tcep and the page behind it */
+	/* to protect tcep and the page behind it */
+	local_lock_irqsave(tcp_page_lock, flags);
 
 	tcep = __this_cpu_read(tce_page);
 
@@ -244,7 +247,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcep = (__be64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
 		if (!tcep) {
-			local_irq_restore(flags);
+			local_unlock_irqrestore(tcp_page_lock, flags);
 			return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
 					    direction, attrs);
 		}
@@ -278,7 +281,7 @@ static int tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 		tcenum += limit;
 	} while (npages > 0 && !rc);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(tcp_page_lock, flags);
 
 	if (unlikely(rc == H_NOT_ENOUGH_RESOURCES)) {
 		ret = (int)rc;
@@ -436,13 +439,14 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
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
@@ -488,7 +492,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 
 	/* error cleanup: caller will clear whole range */
 
-	local_irq_enable();
+	local_unlock_irq(tcp_page_lock);
 	return rc;
 }
 
-- 
2.14.1

