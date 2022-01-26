Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801BCC2BA4C
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jan 2022 15:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbiAZPKw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jan 2022 10:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPKw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jan 2022 10:10:52 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39BEC06161C
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jan 2022 07:10:51 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id c19so27426201qtx.3
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jan 2022 07:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tta/HEJbzMTie1RaVTe7CuW/8Osl8Q6doU3xbsK2fSs=;
        b=EeJS0dY/T6vvmTrH6jDPW44ozfTTNjUqpyQ9rDy8CNYdW/mcsvcwNsIkef2aAquZZO
         WSuYHP6F7/kfTKgxtTGOBpRM+QpED78s3A/dB5HBAgTVi/0MvC7q6Dt171+ruPEpeznl
         AGjP8e7aq2sdWFJCwK7CPmFCszKBPI1jDrxoQ6yTU4oRdBDMqtCQIIJh+KiUQcGVUHDM
         nLfiZPZlvHhxHltNPhFsSXQSRvTCnyqO1+VW2xvAWweHy66pCgvqWl05RuQdfRxVNvIG
         yThfOnwy8lP/N48V/4zc9XMI6UALNy6lhy5TDzfNMcRx9+/LOea4Ah9Q8k5hKWff+T/R
         tlWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=tta/HEJbzMTie1RaVTe7CuW/8Osl8Q6doU3xbsK2fSs=;
        b=A6eW0bT24eprptPMoHLAiOiuczMmvNP3vv4YUQOVdEeu+DPQVZvzdjsRMPw0hNAA9O
         VbU9cGzuxVznw6n4/9mQDN7qcXq5TOxR5Mft5zGbK8iYF8rWiML4h9SshUqurdqTIdU1
         oLGOwuczLNVRpsO7sIu6NjXKOTCxtw6Ahry2fPQzyAHv8RSJKC+L1mavijAD7zWHYT/z
         STZ/NWzzAf7y29Zi9GE/kE+NvRuLrwtYntoSeFyFlf5yw7d3P5550J1iLTeotVOLuQJu
         HtMRRBiNBypr8/ezJblAo+AtNNyFA+g2eD2Gm5zmSZ0W/Q10espFgC46QKuVFQGYy+6J
         lwHg==
X-Gm-Message-State: AOAM530W3deZ2o7pjd5WCZ8dOQ2GbDd7M8hpT+cHgD9JgvCK+xLj6D+F
        Dm6q/zV3qGAgtvtU7dP5ltgtXIrqGH8=
X-Google-Smtp-Source: ABdhPJwMPuS25JraywZKNMX6BegG8+4AfIoSmmdVAmHy+wRoPgxzjqgDv7uulGl5hkbxtvD1BpefIA==
X-Received: by 2002:ac8:5c96:: with SMTP id r22mr7235242qta.541.1643209850673;
        Wed, 26 Jan 2022 07:10:50 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id t22sm11159300qkp.8.2022.01.26.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 07:10:50 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Increase default buckets from 2000 to 3500
Date:   Wed, 26 Jan 2022 10:10:32 -0500
Message-Id: <20220126151032.66449-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Increase the default buckets from 2000 to 3500

With commit 0292c8963611 we skip statistics reporting if we run out of
buckets. Increase the default number of buckets to make this less likely
to occur.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 doc/rteval.8                             | 2 +-
 rteval/modules/measurement/cyclictest.py | 2 +-
 rteval/rteval.conf                       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/rteval.8 b/doc/rteval.8
index fa24509ce7e5..25dcfcc298e7 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -122,7 +122,7 @@ Measurement thread interval in microseconds (default: 100)
 Interval increment in microseconds (default: 0)
 .TP
 .B \-\-cyclictest-buckets=NBUCKETS
-Number of 1 microsecond histogram buckets (default: 2000)
+Number of 1 microsecond histogram buckets (default: 3500)
 .TP
 .B \-\-hackbench-jobspercore=N
 Number of jobs per online-core for hackbench load
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index af8adeeeb402..5330d1466302 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -450,7 +450,7 @@ def ModuleParameters():
                          "default": 100,
                          "metavar": "INTV_US"},
             "buckets":  {"descr": "Histogram width",
-                         "default": 2000,
+                         "default": 3500,
                          "metavar": "NUM"},
             "priority": {"descr": "Run cyclictest with the given priority",
                          "default": 95,
diff --git a/rteval/rteval.conf b/rteval/rteval.conf
index 7ce6ef0b5acc..aa0a53bcfc63 100644
--- a/rteval/rteval.conf
+++ b/rteval/rteval.conf
@@ -6,7 +6,7 @@ duration:  60.0
 report_interval: 600
 
 [cyclictest]
-buckets:	2000
+buckets:	3500
 interval:	100
 distance:	0
 priority:	95
-- 
2.34.1

