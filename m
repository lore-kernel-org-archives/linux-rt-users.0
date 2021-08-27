Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290F4C432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F8860F91
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhH0WDy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbhH0WDx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:53 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42052C06179A
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 14so8804948qkc.4
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jWD/iLRg8IOsuY/XgnJcGRTA86lMIig+tN/mK0ghb3c=;
        b=P6J4SsMUHcn6CcfuvBj51Zgkz4yPHc3aPTpzIAnUL3ElmcDniz+81jN0LOcEDi0pp5
         ZWjXBifFeVVujLuUF/tlqu3xRcWw4/1ArqKK1mw2mg2UzH60DC1erZ3xNYgHsFCOxu3G
         7Vnhc9LwltDwULga+Ez+vHHQeu9Lky2G1Wkex09YIxx4p16giOgMQW4OBKy858NB51c0
         3diT9F9nOzXaGJdxzj9ZR7YwOXTyp7eg26JDxG8iSzF5Vk236NdRgL0891rMQm2c1+sG
         7oWFzYjJQiTZ+T/2g2bp8ddmqFTk/lq2rlUsfqg6DOKk8iVHdNtQdyRxnAWxqAAb8k2r
         iIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=jWD/iLRg8IOsuY/XgnJcGRTA86lMIig+tN/mK0ghb3c=;
        b=VkIvRUMnq3jnBaRlSQDk2c1gBJPt58YVbvmStBT1pYOFmdJJjKn7N6hq6mLc52roq7
         1adFydFKYdysLrR0xSszsciWxQ/RWFbYLaWt6aCisyWkjq5qxa9twTKGHLOx99krbNlZ
         W51HAUfxrkpbCGTUDaaBKnltnDkSYA+VMPVVVnYeKMhXva9PVQJV4gcoD/LmkUfeSTnC
         NjwUQVIUrFQvEilybkPEeoRN8YH/1rAeK3q9BYAPZ2y4iG5L+9zWfFzqERquwDdGbU6d
         MUlwROaHljSORJRAKJwPqVnxQcdso/BDllbdPj44pmQW9sl1WP+xee/SC4uaJNRnKk2B
         PeYQ==
X-Gm-Message-State: AOAM533nTjppctSG6yGGNbrVwOqwVVOAvBdfcsrqHkf9fuumV98v0Cux
        sstDnvEUDCjmS9VKfVOmRUjk7uYidEfmKw==
X-Google-Smtp-Source: ABdhPJy6BYGQFNpq3oJW34Tshnz2gWJIwSb4dnKJfnB5G8dN+08jhyMgfH3io0s7g19gfiOpFNNoag==
X-Received: by 2002:a05:620a:941:: with SMTP id w1mr10919106qkw.434.1630101783337;
        Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:03 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/8] rt-tests: ptsematest: Remove deadcode
Date:   Fri, 27 Aug 2021 18:02:39 -0400
Message-Id: <20210827220244.24210-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove deadcode from ptsematest.c

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 821e58428e6d..e000c3017081 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -58,7 +58,6 @@ struct params {
 void *semathread(void *param)
 {
 	int mustgetcpu = 0;
-	int first = 1;
 	struct params *par = param;
 	cpu_set_t mask;
 	int policy = SCHED_FIFO;
@@ -92,11 +91,6 @@ void *semathread(void *param)
 			if (mustgetcpu)
 				par->cpu = get_cpu();
 		} else {
-			/* Receiver */
-			if (!first) {
-				pthread_mutex_lock(&syncmutex[par->num]);
-				first = 1;
-			}
 			pthread_mutex_lock(&testmutex[par->num]);
 
 			/* ... Got the lock: End of latency measurement */
-- 
2.31.1

