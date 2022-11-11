Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED246C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKKTxv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiKKTxs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:48 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6907020F6D
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:48 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g10so3593104qkl.6
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kS4LT3r+baucYCk9MJKod0wvesZNb9jMBFqLw552ISQ=;
        b=FjAWhDJ+iPOPSABqwi3ZIegNphnnT7KW8RHGfF5nQYGMOdyH6MG7F2jXyg8ch1DFFX
         ON2VYFvW6xhGwYVC6K5MtG2MerPhsfVlxNSKGN+VahuNLGDK/gnqB+xvYC9gw0ReWV0C
         fppQ1/sMXMXK5Hx6TenL2t+LrgKmgyfzl5SK9AyfBZZBi6Qu9ubBArWIe7bs7VC8QgGk
         lA1crmmpg6cm4pt7AweZH/pto9TKM3F452oXqTgZLZw6FoSLs3orYSQ+kcL8pQy7+atT
         P5hAAhg02wGgZToTMPnu4ae0hpIseT7VSt+VL/D2lHueck6bYAn2wxCRe83AflZGxuXy
         1lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kS4LT3r+baucYCk9MJKod0wvesZNb9jMBFqLw552ISQ=;
        b=Zpb02Qx/hZOpjE31b2HOhRDIbZTazjKEvGpqWu18mWbf0SM4sf9P6DB7LyQVE0f69w
         J80hqHnSjOV/L3JSuhzDSPvz/QgHJjaKjc4rOHuzbI4PkO8pNQ61+jB0j9F3DGXJ5hNv
         MW+nFyQJzJL3bIdEdIA7VgQYGCza34KeUIRmUj18fkr6P7U7WA9Zm3+O3jmmHorRRgca
         NJ5GcGxdkkaD1z7IGxaDaccT8jakysX6btAAaO08WxGoCzDLNHwTUxaC6q7o7/kMg4n4
         dhkjF0KyM6qrLA+MdWAGE8lK9ZfxFEMiE7+s3xwyrpkGZNwUfeIzv/lIJqXi72RreT5g
         /JuQ==
X-Gm-Message-State: ANoB5pkSOYHA1mEspFUjBwBik+Gxpg63ZLOVq8GD0K0coK1i6QaR6aeS
        L7GbUvqoo521pZ6ohphB7pz1tNIcdeE=
X-Google-Smtp-Source: AA0mqf4ILtSWma1ISoE7eH4hIMCDTdY5M2ES1g7v4KnS1tYnwn9pMqLLnoP3yITwUCPN0EvTHQHKXw==
X-Received: by 2002:a37:8785:0:b0:6f9:25e5:8398 with SMTP id j127-20020a378785000000b006f925e58398mr2465915qkd.231.1668196426796;
        Fri, 11 Nov 2022 11:53:46 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:46 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 8/8] rt-tests: hwlatdetect: Fix incorrect comment about testduration
Date:   Fri, 11 Nov 2022 14:53:23 -0500
Message-Id: <20221111195323.27402-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

At some point
self.testduration = 10
was changed to
self.testduration = 30

but retained the comment, "ten seconds"

Just change the comment to say, "in seconds" so it's clear what unit
we are talking about.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index c5b3a689dcd1..68df58f7e2d0 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -130,7 +130,7 @@ class Detector:
         if not self.debugfs.mount():
             raise RuntimeError("failed to mount debugfs")
         self.samples = []
-        self.testduration = 30  # ten seconds
+        self.testduration = 30  # in seconds
         self.have_msr = False
         self.initsmi = []
         if os.path.exists('/usr/sbin/rdmsr'):
-- 
2.38.1

