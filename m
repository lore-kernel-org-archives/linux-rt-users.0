Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FA0C07E9A
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Jul 2021 11:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E45661374
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Jul 2021 11:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhGNLKQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229899AbhGNLKQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Jul 2021 07:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626260844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6t3MTZglyfbWuuV2hRErJ55E+KllXM6hRCOM2cmVH0g=;
        b=dB5nVNN6tUItn93V/8SJbjEmHTT9Ic30gLQVQaooxFgl89WA9l15pOZK6gC53IxoYn095J
        ziWEgWSAqanosEbfTRvC4Yx9plWabhXcqItq3d828UzYEmd3vkXl/lbLDqqBqhuNkJ5L3B
        9Zdnhy6msjjkYj4DqT1hdULLr/Nv+m4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-mVfW0ERSOQSCCrO-LiYMIQ-1; Wed, 14 Jul 2021 07:07:23 -0400
X-MC-Unique: mVfW0ERSOQSCCrO-LiYMIQ-1
Received: by mail-wr1-f69.google.com with SMTP id p4-20020a5d63840000b0290126f2836a61so1341613wru.6
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Jul 2021 04:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6t3MTZglyfbWuuV2hRErJ55E+KllXM6hRCOM2cmVH0g=;
        b=hYT9kpBZnkM4BwvYSG0CGOdoNFb9Ur+jR2+7uun6KG9C/SIyROccR4/gB8O7xMg9uc
         fpbhxMjjN0ZcM9O6CZdOZAyplILaVYZpyRFJNWG/vjjf5XTLzppjyq2VjFctmBLekqVY
         R/V7NJ7YfnVkNARQ05dJ05TE/JgQJmtyYvNYuq/OgjhMHbLSso7Vw14tS+dIPF/0Wou2
         cJ4gOCWS0nHu2jNREqtH9E0SnDJDkr3bVoK1BVBNytFmC3jqFdGIqJPFpSD2jQeE+OgR
         RkfYTDafeSVr/HV0ZLo54kslBR8V/85dNu4eGpkNiZOaZu8w3gl9ftiw68euPUJV48i1
         zY9g==
X-Gm-Message-State: AOAM531G/DCD2NAfYR0PAIYztov3+L3KT9tx93N0+gG9YmBCbpYqivEE
        pu2twG1pIPa8hMaUgQIhOz1m70akP2j10+2iEG0IKbo3LQlot+95WhoajB9Xxz9tk4q5qxin8ye
        UvTpODtrMkZKAHccy5y4eER4fTs62xCFCQrCgp/uMVKlgNdoykRtugbem0zrnvyCRrSas+UvUME
        +LH0Q=
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr10590638wms.50.1626260841848;
        Wed, 14 Jul 2021 04:07:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz45tKOpIB7mU2uKAXv0M/GYKYE1aVZGi0pDKz8zvke9F+DSS70YG8Okrv+CF9zSD8yTtzhZQ==
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr10590610wms.50.1626260841670;
        Wed, 14 Jul 2021 04:07:21 -0700 (PDT)
Received: from vian.redhat.com ([79.116.5.179])
        by smtp.gmail.com with ESMTPSA id d18sm2343690wrw.7.2021.07.14.04.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:07:21 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH v2 2/2] oslat: Add trace maker prior starting main thread
Date:   Wed, 14 Jul 2021 13:07:18 +0200
Message-Id: <20210714110718.68292-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714110718.68292-1-nsaenzju@redhat.com>
References: <20210714110718.68292-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

After a long tracing session it's sometimes hard to find the moment
oslat started. So leave a message in the trace buffer just before the
main thread starts.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
---

Changes since v1:
 - none

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

