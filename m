Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B56BEE49A0
	for <linux-rt-users@archiver.kernel.org>; Sat, 19 Aug 2023 02:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244332AbjHSCqB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 22:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244317AbjHSCpk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 22:45:40 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2793ABC
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Aug 2023 19:45:36 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37J2DdTL010121;
        Sat, 19 Aug 2023 02:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=F6XLMTMDcRbg9dNFL2bcqCk37cA4OkuWdWbb3K74d2U=; b=
        FJr3fJ5iNIBC+IQllsA7S4yytuMCs60+mXqHhpbfwT1px3BKpsgaiESvyGQdbGMc
        80OhJ/5aXja3Q+o8JYv1NEn9V3GVuTmMqzaRic7/sSrfVulPLdG1qidBqceISrFB
        CUa2SyzdTwih0DVpAgwYtrMaUZLRK/IiZ2bKhj3xtP2WtP84Q9BY8YZOQnQY/Pnz
        G5/peXM62Z44RukFtDGrZ82EgF9C3KKpgcXc3iNMzSBfEPD0vU3b7SKKpu5VG77Y
        zTHvYrk+rb3PWyk+H2+nH+N8CmfW5xUc1eI43bYYBvmWT8pIOeM0504ceZuKJkXC
        jkzDTI1BjRxbrUe/kQbaqw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sjmq5g0mc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 19 Aug 2023 02:45:27 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 19:45:27 -0700
Received: from yow-lpggp3.wrs.com (128.224.137.13) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 19:45:26 -0700
From:   <paul.gortmaker@windriver.com>
To:     Clark Williams <williams@redhat.com>,
        Joseph Salisbury <joseph.salisbury@canonical.com>
CC:     <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 1/1] drm/i915: Do not disable preemption for resets
Date:   Fri, 18 Aug 2023 22:45:25 -0400
Message-ID: <20230819024525.2056048-2-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230819024525.2056048-1-paul.gortmaker@windriver.com>
References: <20230819024525.2056048-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: RRopMn830BCK2FPtTRU_WrT-oAFwea1J
X-Proofpoint-ORIG-GUID: RRopMn830BCK2FPtTRU_WrT-oAFwea1J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_29,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308190025
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

[commit 40cd2835ced288789a685aa4aa7bc04b492dcd45 in linux-rt-devel]

Commit ade8a0f59844 ("drm/i915: Make all GPU resets atomic") added a
preempt disable section over the hardware reset callback to prepare the
driver for being able to reset from atomic contexts.

In retrospect I can see that the work item at a time was about removing
the struct mutex from the reset path. Code base also briefly entertained
the idea of doing the reset under stop_machine in order to serialize
userspace mmap and temporary glitch in the fence registers (see
eb8d0f5af4ec ("drm/i915: Remove GPU reset dependence on struct_mutex"),
but that never materialized and was soon removed in 2caffbf11762
("drm/i915: Revoke mmaps and prevent access to fence registers across
reset") and replaced with a SRCU based solution.

As such, as far as I can see, today we still have a requirement that
resets must not sleep (invoked from submission tasklets), but no need to
support invoking them from a truly atomic context.

Given that the preemption section is problematic on RT kernels, since the
uncore lock becomes a sleeping lock and so is invalid in such section,
lets try and remove it. Potential downside is that our short waits on GPU
to complete the reset may get extended if CPU scheduling interferes, but
in practice that probably isn't a deal breaker.

In terms of mechanics, since the preemption disabled block is being
removed we just need to replace a few of the wait_for_atomic macros into
busy looping versions which will work (and not complain) when called from
non-atomic sections.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Chris Wilson <chris.p.wilson@intel.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lore.kernel.org/r/20230705093025.3689748-1-tvrtko.ursulin@linux.intel.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[PG: backport from v6.4-rt ; minor context fixup caused by b7d70b8b06ed]
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/gpu/drm/i915/gt/intel_reset.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index 10b930eaa8cb..6108a449cd19 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -174,13 +174,13 @@ static int i915_do_reset(struct intel_gt *gt,
 	/* Assert reset for at least 20 usec, and wait for acknowledgement. */
 	pci_write_config_byte(pdev, I915_GDRST, GRDOM_RESET_ENABLE);
 	udelay(50);
-	err = wait_for_atomic(i915_in_reset(pdev), 50);
+	err = _wait_for_atomic(i915_in_reset(pdev), 50, 0);
 
 	/* Clear the reset request. */
 	pci_write_config_byte(pdev, I915_GDRST, 0);
 	udelay(50);
 	if (!err)
-		err = wait_for_atomic(!i915_in_reset(pdev), 50);
+		err = _wait_for_atomic(!i915_in_reset(pdev), 50, 0);
 
 	return err;
 }
@@ -200,7 +200,7 @@ static int g33_do_reset(struct intel_gt *gt,
 	struct pci_dev *pdev = to_pci_dev(gt->i915->drm.dev);
 
 	pci_write_config_byte(pdev, I915_GDRST, GRDOM_RESET_ENABLE);
-	return wait_for_atomic(g4x_reset_complete(pdev), 50);
+	return _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 }
 
 static int g4x_do_reset(struct intel_gt *gt,
@@ -217,7 +217,7 @@ static int g4x_do_reset(struct intel_gt *gt,
 
 	pci_write_config_byte(pdev, I915_GDRST,
 			      GRDOM_MEDIA | GRDOM_RESET_ENABLE);
-	ret =  wait_for_atomic(g4x_reset_complete(pdev), 50);
+	ret =  _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 	if (ret) {
 		GT_TRACE(gt, "Wait for media reset failed\n");
 		goto out;
@@ -225,7 +225,7 @@ static int g4x_do_reset(struct intel_gt *gt,
 
 	pci_write_config_byte(pdev, I915_GDRST,
 			      GRDOM_RENDER | GRDOM_RESET_ENABLE);
-	ret =  wait_for_atomic(g4x_reset_complete(pdev), 50);
+	ret =  _wait_for_atomic(g4x_reset_complete(pdev), 50, 0);
 	if (ret) {
 		GT_TRACE(gt, "Wait for render reset failed\n");
 		goto out;
@@ -718,9 +718,7 @@ int __intel_gt_reset(struct intel_gt *gt, intel_engine_mask_t engine_mask)
 	intel_uncore_forcewake_get(gt->uncore, FORCEWAKE_ALL);
 	for (retry = 0; ret == -ETIMEDOUT && retry < retries; retry++) {
 		GT_TRACE(gt, "engine_mask=%x\n", engine_mask);
-		preempt_disable();
 		ret = reset(gt, engine_mask, retry);
-		preempt_enable();
 	}
 	intel_uncore_forcewake_put(gt->uncore, FORCEWAKE_ALL);
 
-- 
2.40.0

