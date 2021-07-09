Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A05CFC07E99
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 15:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8456B61182
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jul 2021 15:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhGIP5G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232248AbhGIP5E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Jul 2021 11:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625846061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHSAHonJE4deSZXB4H3BRySsjgmOYM99K6OJla0dYoM=;
        b=E04QWZFhHqHPTRisSGxOfEpxHtIOlpe5HOnORrERVS8zojELfdnkcYvmMLFeY0Q9D1Z0h0
        gRSRmpEdh6HeRHfPOVOINPf5kJNK3Yy6S6Ya0MjEXkObUFlNvn4ITdXs3CRGD1zbYPFGck
        9UGkNm4t5IdCMNGISmvTvN6O4VcG/t4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-NvQztxXYNSyC-yYs9e08cA-1; Fri, 09 Jul 2021 11:54:19 -0400
X-MC-Unique: NvQztxXYNSyC-yYs9e08cA-1
Received: by mail-wm1-f70.google.com with SMTP id p6-20020a05600c3586b029020b46124c2eso2334749wmq.1
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Jul 2021 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FHSAHonJE4deSZXB4H3BRySsjgmOYM99K6OJla0dYoM=;
        b=bHHhKF67Tu/gML862kgu6QJG1Y3EnVXKd1sOVGrg5+u00D2zxgiOpmYJbtOCvTjkP9
         pjGPA/GYH/s+h5NI7B+U0qF5nbEhnHNVPhQ5scr4tXJdfU5/dtpK0UAuoIlFqhnS2rlK
         7hFeZq+iJeP7WoM3+RXVuhI0+9lSe6Ws7ShNxx9LgoLbaVh9RKC7+fQ7PJdT6YIwPxPE
         Uw05YyFhaM6VPnb+SEOHqSFR0ITTEW/CB5S2gMCJjOzYKUmK8Ntk0EMofFfsD6FWGgfD
         dpu+AiEJE5cmIdGTzKTXZnqEYcVJD0eTiNeRHAbM+ws5dykHCrN9mOja4B/CLP7jwhAv
         aR3g==
X-Gm-Message-State: AOAM532y4ydtb2f/LVJWpJXesFsbXoL1IIg5T9yfd3Bva4EaZ+T2KAyw
        5J2FhIFWq9S43HW0UA/0Cd0kSoAaag09vWa8oNz2+lBxBNN7367PXpAMexLid1F3QcwuGByn0IS
        85KvZ8mnVvhcFLI4/LXJHPKnfifci55AhwZgIxNa8CVmoU+Ac/Zf/1TGfyH6HZOPnoudB6MbQjj
        dbGp8=
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr12635211wmh.8.1625846058631;
        Fri, 09 Jul 2021 08:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykNJ+raj9b37J7ColChA8QDhGboTlfGlTHnnQ589WPe8iMVqTglnr+KSe9Tx/WXmrkG1REaA==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr12635190wmh.8.1625846058438;
        Fri, 09 Jul 2021 08:54:18 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id n13sm5094305wms.4.2021.07.09.08.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 08:54:18 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 2/2] oslat: Add trace maker prior starting main thread
Date:   Fri,  9 Jul 2021 17:54:14 +0200
Message-Id: <20210709155414.610308-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210709155414.610308-1-nsaenzju@redhat.com>
References: <20210709155414.610308-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

After a long tracing session it's sometimes hard to find the moment
oslat started. So leave a message in the trace buffer just before the
main thread starts.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index d35be57..20bf02b 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -400,6 +400,10 @@ static void *thread_main(void *arg)
 	while (g.n_threads_running != g.n_threads)
 		relax();
 
+	if (!g.preheat)
+		tracemark(false, "%s: Starting thread on CPU %d.\n",
+			  g.app_name, t->core_i);
+
 	frc(&t->frc_start);
 	doit(t);
 	frc(&t->frc_stop);
-- 
2.31.1

