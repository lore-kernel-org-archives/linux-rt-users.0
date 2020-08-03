Return-Path: <SRS0=buBN=BN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47030C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Aug 2020 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4DB22B45
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Aug 2020 20:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpgQNO5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgHCUKr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCUKq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Aug 2020 16:10:46 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B292C06174A;
        Mon,  3 Aug 2020 13:10:46 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a14so11187007edx.7;
        Mon, 03 Aug 2020 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3ptvbwyL3eMkXzCvwkUGi6lWLScZbjIY72Givg73RM=;
        b=bpgQNO5SZsC9FJeljzAfeFLqU1kFreasmyaomW+z8/ZEwxp+kS3EbIsO3w5wf3dRFm
         coTRDy1n7tCz9j3Jmj6wCnvZ4oLrU3ecEFR7kDd2vRWOEzyXSAsd3IQb0n/XnShDW9i1
         3lcAljxFHY9DgHSO3PNVtIrkzDhRI08rk6DHZwW2gRfhTGqZyW8qE6HghZBd8G8Apd0b
         RAY8zOcl6HyGr02KQ3kjw2jXd0zes4JjUK9yCz4iJvDSLH1fd1ODFsMdTN1M1HTZH2OO
         zFv0rLc5LBWXAKwMAxoKbxiz/Z6fpd6rIv8Fop7BWP2PNmyb1MMkTplcqynSm5iBkaON
         plDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3ptvbwyL3eMkXzCvwkUGi6lWLScZbjIY72Givg73RM=;
        b=W+CfZF6TuHYt/+VsLOe4tQjYIzVyKkItJEKMmva5TMSjEdp7eULeQWHbrNewv/uNeg
         ZYPUoonjC7P4Q3ZhsbQTPCNjGRUh4e8RUTujG1OfeSqNHtQA9cYsWYA5D+GYP89yLMHJ
         BS90bSTUCtmoMbgJSKOGuPaXxL2w4pD0JNf+R0BGAHes24+DOkTEjhX8BLOhf81XSFot
         TGLMxo2Ze3YO3XxunBF2DT6cacnzWyT42epNCHx2EOH/lz+VtgKPrGq5aJGxpZVmMcWj
         C2QJC2YKyRAtapp0+PW8jNHKCQZ6VWpSCOOVeHTWOuMmuyofKn+eqnwMOEvlww9HOA4b
         u5+g==
X-Gm-Message-State: AOAM530TqXfO+83+h6z+/ohzyPePOxaFcWvI8TVppthMA8mriXY/Yuro
        dcJfRJ/8f7KbPUe2P/BmyS0=
X-Google-Smtp-Source: ABdhPJxiRlfNZldXm0QMgXVFE46y/hXLG0ie71qyg1SpfhOjaBsGZH3mlc0L84oI0zxroOOFKELhsw==
X-Received: by 2002:a50:d655:: with SMTP id c21mr16881305edj.49.1596485445220;
        Mon, 03 Aug 2020 13:10:45 -0700 (PDT)
Received: from localhost.localdomain ([188.26.57.97])
        by smtp.gmail.com with ESMTPSA id u8sm16664049ejm.65.2020.08.03.13.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:10:44 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org
Cc:     claudiu.manoil@nxp.com, ioana.ciornei@nxp.com, Jiafei.Pan@nxp.com,
        yangbo.lu@nxp.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: [PATCH net-next 1/2] dpaa2-eth: use napi_schedule to be compatible with PREEMPT_RT
Date:   Mon,  3 Aug 2020 23:10:08 +0300
Message-Id: <20200803201009.613147-1-olteanv@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Jiafei Pan <Jiafei.Pan@nxp.com>

The driver calls napi_schedule_irqoff() from a context where, in RT,
hardirqs are not disabled, since the IRQ handler is force-threaded.

In the call path of this function, __raise_softirq_irqoff() is modifying
its per-CPU mask of pending softirqs that must be processed, using
or_softirq_pending(). The or_softirq_pending() function is not atomic,
but since interrupts are supposed to be disabled, nobody should be
preempting it, and the operation should be safe.

Nonetheless, when running with hardirqs on, as in the PREEMPT_RT case,
it isn't safe, and the pending softirqs mask can get corrupted,
resulting in softirqs being lost and never processed.

To have common code that works with PREEMPT_RT and with mainline Linux,
we can use plain napi_schedule() instead. The difference is that
napi_schedule() (via __napi_schedule) also calls local_irq_save, which
disables hardirqs if they aren't already. But, since they already are
disabled in non-RT, this means that in practice we don't see any
measurable difference in throughput or latency with this patch.

Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 9b4028c0e34c..50f52fe2012f 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -2330,7 +2330,7 @@ static void cdan_cb(struct dpaa2_io_notification_ctx *ctx)
 	/* Update NAPI statistics */
 	ch->stats.cdan++;
 
-	napi_schedule_irqoff(&ch->napi);
+	napi_schedule(&ch->napi);
 }
 
 /* Allocate and configure a DPCON object */
-- 
2.25.1

