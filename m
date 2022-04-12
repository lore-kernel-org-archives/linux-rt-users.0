Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE878C43217
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Apr 2022 13:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356453AbiDLN6O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356468AbiDLN5o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Apr 2022 09:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 260AFF51
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 06:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649771725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o9KO4BUrUfJXkHq4q3BloAhoMoPs3lORN6KLCN8AuX4=;
        b=KHutDgeAQ9BOE/mwb6pCGBD06S09bC/suAfKTHSf/YdSs9ljfCaJkGaZBISNyWorVJe1Hn
        ZV6lhC650paRjUhqVLXazPAEWodPl9Aw1uyaFAeFhHEXjZRsGBepmYe7ORXNHprw6BphgJ
        b8HvIMI3n7dT/uMRLnFdcFpczYQJPx8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-499-QgW5oKOOP7O6S85xV3W5bw-1; Tue, 12 Apr 2022 09:55:24 -0400
X-MC-Unique: QgW5oKOOP7O6S85xV3W5bw-1
Received: by mail-wm1-f69.google.com with SMTP id k16-20020a7bc310000000b0038e6cf00439so1325533wmj.0
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Apr 2022 06:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9KO4BUrUfJXkHq4q3BloAhoMoPs3lORN6KLCN8AuX4=;
        b=F/psAziiBxOwnkuSvnv4t5/KC6OOU/mK8H3dXBaUMM7BM7BXpI7g0nv1Mk6Tu5dWPC
         Cgjna+YHvGO2H5YVCmgBlF9XAkn2mTbe9SnRwxa2LSccerTkIxg2IGEJFQOyVID0bHxG
         8jz1YQleGQamTw3VIUfANCqNLUHH7PQwCAszhr4xRriV/1axdaW8h/E1ofWhwYpPqXzn
         nvrT7OI/AG7zz2zJ5nBnex5Ln/gUsDNoQYdrflZrS1GBD5Lyo6oFHuI73n8r+ztmkBSG
         XCpB7d4z1oTohPF//Yx+afd1uMFEoyW8G5OWO6Fp0X4UIFsCzzk5MkTayWmGnx+yjKCl
         d7Ug==
X-Gm-Message-State: AOAM533KYyRNHzswFpTBwvAaOWmxs9uS+Lxymai7a4EOTEjFXblZ6YE9
        9K0gLh5bCBy8S3WOiGAez2uzD33tnQiog3wI9tzoCCQhfCOfC5kp6eJ3LQvo0pzNJOtlMZ8hCwj
        T1Uz6fS6o8n/CociZlpIZjsNF47Rb5GOnVU3D7H0khXIJSHcmaCy8yk9zrH2la+1rTJqRCPrsGF
        nkNvc=
X-Received: by 2002:a05:600c:4fce:b0:38d:a58:6d16 with SMTP id o14-20020a05600c4fce00b0038d0a586d16mr4368434wmq.11.1649771722956;
        Tue, 12 Apr 2022 06:55:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyz1eFu15in4wa5JBf8EHB1EOCibhGrMwb22OoyT8nd24fNFYRlr6usO7khAL0IpfmGONiyng==
X-Received: by 2002:a05:600c:4fce:b0:38d:a58:6d16 with SMTP id o14-20020a05600c4fce00b0038d0a586d16mr4368418wmq.11.1649771722738;
        Tue, 12 Apr 2022 06:55:22 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm3030651wmp.13.2022.04.12.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 06:55:22 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH] oslat: Print offending cpu number when above threshold
Date:   Tue, 12 Apr 2022 15:55:18 +0200
Message-Id: <20220412135518.531234-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Knowing which CPU went above the trace threshold is useful information,
even when not tracing. So let's print it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index aa0e9a7..55302f1 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -334,10 +334,10 @@ static void insert_bucket(struct thread *t, stamp_t value)
 	assert(us > 0);
 
 	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
-		char *line = "%s: Trace threshold (%d us) triggered with %u us!\n"
+		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %u us!\n"
 		    "Stopping the test.\n";
-		tracemark(line, g.app_name, g.trace_threshold, us);
-		err_quit(line, g.app_name, g.trace_threshold, us);
+		tracemark(line, g.app_name, g.trace_threshold, t->core_i, us);
+		err_quit(line, g.app_name, g.trace_threshold, t->core_i, us);
 	}
 
 	/* Update max latency */
-- 
2.35.1

