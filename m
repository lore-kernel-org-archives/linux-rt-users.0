Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B69BC43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 17:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiF2Rvk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiF2Rvj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 13:51:39 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B51EEC6
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 10:51:37 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id r142-20020a632b94000000b0040c978aef47so8491441pgr.10
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 10:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MoAGJJsXkdtvgenknQ4HOS1oOce8TQbNR+BaxSpMxyY=;
        b=GeLzThxvNikhm87rH5+1ecy9lVg91YtKB1p/h6quczURXHIYTCaQbMlkj2NU3mv/2D
         bgrUxS4ZBaJ3UnaMH5T+0hj4pUWAJOEvX87KuZCwZSl4inK1+0pJX65EtqoUt3f7DOip
         /t8MkyIT2ghxEobF/jmxwnS4SIdB8OqzMGyfGaE4n3/DsmX+ZNfYf7QVk2PBT9FPLQer
         5Ati/soM5TRlyE+rp3sFpQAEXGZY2kpYW3UUthYG5Pu8QWyucj1XIenCaWqb/iT6v16h
         ShkhPQEgtZbzDkpP6Y4E3i+bUwE61Cw0t12Y+39TMeI+y7dE2oTZ05Fulg2/lR4HGUQl
         R2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MoAGJJsXkdtvgenknQ4HOS1oOce8TQbNR+BaxSpMxyY=;
        b=IG0fNl5Lb2l4+xe0em+OQczBUfD6aM/uRjci5Tq5/Mh0VvbrT1Ezm2Hq02JmOBMl0f
         /NkUyomWRMvVGGkl8mjOtGBtqBZfWQ3nhJnqBeLpYdQIpgudw98iY0WZdOkcel2QKdoT
         EEV5oa+eq7V2TsMO5hcsSudyUsfOYqjIdHWeC9MmhgLlfdACfJtajOQydxPx/3/g3PBr
         lGDQ+SHu1fu00Qzj36yjkBaSWqpo1myWr1l4rXWF/fyG+DWqgu5brcNPrW7zewe3Ry4r
         UbVwqd86iKQP7CFUgy69L+ukIAEQDp+GdqnBmL0yMPGomwXzjh1YvOZkb4mOloNoAQc8
         Ilyw==
X-Gm-Message-State: AJIora8fDnewW7d59/ZymSw1fijvIrKJAaovpUeB7JtYBz7x13kAV8nl
        A8c3ACAdxV63o0KeThy7ukCdLXoZW5mOORI=
X-Google-Smtp-Source: AGRyM1v3UJne6FsezgkHqY7hGd309rO260B5fAub+thTXe+vN1mzkZJS0qYbhgDFlqKiiw1gUduqAiI20nRSCAI=
X-Received: from grimace.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:21e])
 (user=icoolidge job=sendgmr) by 2002:a17:90b:4a12:b0:1ed:56ab:b2d5 with SMTP
 id kk18-20020a17090b4a1200b001ed56abb2d5mr5318514pjb.152.1656525097035; Wed,
 29 Jun 2022 10:51:37 -0700 (PDT)
Date:   Wed, 29 Jun 2022 17:51:34 +0000
Message-Id: <20220629175134.162666-1-icoolidge@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH] rt-tests: rt-utils: Fix potential 'debugfileprefix' overflow
From:   "Ian K. Coolidge" <icoolidge@google.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        "Ian K. Coolidge" <icoolidge@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

fscanf on line 73 amounts to
fscanf(fp, "... %256s ...", debugfileprefix)

This can result in 256 characters excluding nul.

Add 1 to buffer size to accomodate a maximum write + a nul.

Signed-off-by: Ian K. Coolidge <icoolidge@google.com>
---
 src/lib/rt-utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 6c0235d..bbc0b82 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -32,7 +32,7 @@
 #define  MAX_COMMAND_LINE 4096
 #define  MAX_TS_SIZE 64
 
-static char debugfileprefix[MAX_PATH];
+static char debugfileprefix[MAX_PATH + 1];
 static char *fileprefix;
 static int trace_fd = -1;
 static int tracemark_fd = -1;
-- 
2.37.0.rc0.161.g10f37bed90-goog

