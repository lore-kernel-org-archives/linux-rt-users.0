Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D91C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 15:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiF2Pbv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 11:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiF2Pbu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 11:31:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1362CCA6
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 08:31:50 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id u7so2894875qvm.4
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 08:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CMur6mcREyCUZZK8xg2rr6JM3dZqFnZWR0xFwsOJD24=;
        b=ZEwnfNtO3wTSdTCt0ECaACwefRuUWEwTx4zchpcpPM9beaEMGHSfLaMqbGNUhokuHd
         OZV2dKsM4Pn7Fw/aZIK9VKJm6d5lnOolUMuwUDnmHqe+uCGRplNZz4EXqeNHVVZSkrjt
         d1zpZGmKbVaSel4YBWhISuDxF2zHNzCAcGzM9/mDM+zcGSdt3gE2HAGSmmNwnRMMDudo
         Tt0bhWN5/QJIWAIX6YRke6H77CGPNMhEtlE5ISWLPLn/eS8Eo99fRZNfiVrVCN2Z16gk
         80kHcN97fgCDw9wYcCGs3y/xRBVvZrrkB7kfIcqOuvd/WdQ/Pzn6xpxhPmTUZJe2eea3
         ll9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=CMur6mcREyCUZZK8xg2rr6JM3dZqFnZWR0xFwsOJD24=;
        b=7pLAFn9OQ+jWlPv6zIT9eeEcCkWqad0L1cudJAVrDhwOHwT4ue5Pvzc8DWepsJV3Ja
         WHJFxDtY+enQNwnGroGxfIjp71wxgg348HEOIBv60z0jsv5p9bHIivp3ezxLzowOIibU
         HOJyVBCtMkJRdiobhT5UZpkkMrf9PIkf0ocoPDbJCk2ilF5HOHvj2zL78gm0DnzY85HM
         b62tU8SzW2sx1pFhDh7Smisi6pnThvMVO+sWuVDC8TOywnvcvMrjTXYaW8vCHTKJl83J
         LMCvEZWoZhKLCfVF8iz7htri/iZ4qMhsGM+E8Z1dTnOXUs5DPE883hVjmu4p8sliW5Zy
         wDKQ==
X-Gm-Message-State: AJIora9wOsQmLweoVdyhFb9SvYLh1JTRZpmjrKVQOvy+SbFQteARCilE
        SnYnvOaPvfMc8WLszFYSOI4dO0UxnIo=
X-Google-Smtp-Source: AGRyM1su/n3IFrBAG0DNc+MMtZ0wLaZBivLfPIdwFgaXaFDihkgG4ZOKJ1x8lZJyo8DkdEKmHy+0Sw==
X-Received: by 2002:a05:622a:d6:b0:31a:7ed9:9146 with SMTP id p22-20020a05622a00d600b0031a7ed99146mr3008983qtw.211.1656516708828;
        Wed, 29 Jun 2022 08:31:48 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id g19-20020ac87d13000000b00307aed25fc7sm11468225qtb.31.2022.06.29.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 08:31:48 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: [PATCH] rt-tests: cyclictest: Fix seg fault for verbose with no affinity maxk
Date:   Wed, 29 Jun 2022 11:31:40 -0400
Message-Id: <20220629153140.15073-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Using verbose with affinity and no affinity mask causes a
segmentation mask. Fix this by checking if the affinity mask is NULL
before printing the verbose message.

Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index d90228a7ebec..decea786268a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1088,7 +1088,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 
 			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
 				display_help(1);
-			if (verbose)
+			if (verbose && affinity_mask)
 				printf("Using %u cpus.\n",
 					numa_bitmask_weight(affinity_mask));
 			break;
-- 
2.36.1

