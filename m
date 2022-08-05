Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B563C00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240693AbiHENmy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 09:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbiHENmu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 09:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9329459B5
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 06:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659706967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=M4b6mKkSCEKMGV/3JHQ1qLooWOTIVizhwmu1OmpkZk0=;
        b=LmW2hq1XxApVotfPzq22CwP9f8Bp7q1J2NPwJ0nqfK+5UMGk7nxlVdPVlfX6Oteor1kyIr
        407CUKDyS/dd1D8RiRsgS63yPzzW4H39DidFTZZPwqgvfov1Nb7cxN/mFhyilIDDhXHs0Y
        wrWTcTM9hhGK8sLGjmW8mHicpQ6Vbxs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-LEuBaAOQM42bh2GRZVCQBw-1; Fri, 05 Aug 2022 09:42:46 -0400
X-MC-Unique: LEuBaAOQM42bh2GRZVCQBw-1
Received: by mail-wm1-f72.google.com with SMTP id j22-20020a05600c485600b003a50fa6981bso2386113wmo.9
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Aug 2022 06:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=M4b6mKkSCEKMGV/3JHQ1qLooWOTIVizhwmu1OmpkZk0=;
        b=7h3+BeUwMCMIzzF7YSwkTJpNbb4wBN9rTs2+4kRajRhzkeP+RffSlTBL49ZKvNrhDc
         RgRoyhwrOlOxKVfJ1V8/8p1+BXWNmUJFQd3R7oLfVnBBSC+MyPpVmnTEn3k0YPxzfXhs
         b63dcFpfT4gj5tMgZCks8jgjahEb2OUQLZWl2zQPCixeQHaYNRRQt49hHK5DpW5HRanO
         46h7Vo3Om7zjg/SWLqmrwPOUWbhQHwAGBu2CrXJTFuv9b6R/Tr/qxDMg6ayX5nH3D/kK
         wRdRVeEHyraxpwi3IDKWYRJxBgbaw4P86dYqu6bBwjAI3g2TwNvdzEZBqh4/qkjwe3hm
         32WQ==
X-Gm-Message-State: ACgBeo1hVP07t1/ELsbor1Sqp8SrFiFIe9Bqy0OlwIBLebqCz7A62/9A
        TJ809pHDD6Adg0k4xsDVZtd5c3P9DxEWnmY/4oyRAr6qLem6DAQRl8k8hNZ9CDmlggVLm0lI4ff
        XOZ6o/5iy9h7Vv0KCp/FS27dKKOQScfhMkm4MiO21rA6a252g8v5P5OgLKtkj9d094VQnmPWYxV
        YbhNg=
X-Received: by 2002:a05:600c:3b16:b0:3a5:17f1:297a with SMTP id m22-20020a05600c3b1600b003a517f1297amr2655099wms.21.1659706964950;
        Fri, 05 Aug 2022 06:42:44 -0700 (PDT)
X-Google-Smtp-Source: AA6agR742ItdqyY5UrnF/7+3oejNVbSA2gTlqQZBEnGG2GE9pv8phXnnTwYQYsFPg4hQmX0Bn/WiMg==
X-Received: by 2002:a05:600c:3b16:b0:3a5:17f1:297a with SMTP id m22-20020a05600c3b1600b003a517f1297amr2655085wms.21.1659706964690;
        Fri, 05 Aug 2022 06:42:44 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id n1-20020a5d6b81000000b002207a5d8db3sm3829528wrx.73.2022.08.05.06.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 06:42:44 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com
Subject: [PATCH] rteval: Fix loads cpulist restriction
Date:   Fri,  5 Aug 2022 14:42:39 +0100
Message-Id: <20220805134239.1257029-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A recent batch of commits, one of them being:

  39115f0a826d ("rteval: Make use of systopology instead of misc in hackbench")

has made the loads modules use CpuList.expand_cpulist() (which produces a
list(int)) instead of misc.expand_cpulist() (which produces a list(str)).
However, the bits handling restricting CPU affinity based on a user
argument still expects to handle a list(str), which results in:

  [DEBUG] [kcompile] node 0 has no available cpus, removing
  [...]
  [DEBUG] [hackbench] node 0 has no available cpus, removing

Remove the leftover string casts.
Cyclictest is unaffected.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
Staring at this made me think that we might be better served by a single
Cpumask type backed by a set() and armed with string-returning methods - I
find it difficult to figure for a given CPU container if it's supposed to
be int or str-backed.

This opens up simplifying shrinking operations into e.g.:

  self.cpus[n] = self.cpus & self.cpulist

How much hate would I get for following up with something like that?
---
 rteval/modules/loads/hackbench.py | 2 +-
 rteval/modules/loads/kcompile.py  | 2 +-
 rteval/modules/loads/stressng.py  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
index 538f60f..14e60d1 100644
--- a/rteval/modules/loads/hackbench.py
+++ b/rteval/modules/loads/hackbench.py
@@ -76,7 +76,7 @@ class Hackbench(CommandLineLoad):
             self.cpus[n] = sysTop.getcpus(int(n))
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                self.cpus[n] = [c for c in self.cpus[n] if str(c) in expand_cpulist(self.cpulist)]
+                self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
 
             # track largest number of cpus used on a node
             node_biggest = len(sysTop.getcpus(int(n)))
diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index a544fd9..8de00cf 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -235,7 +235,7 @@ class Kcompile(CommandLineLoad):
 
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                self.cpus[n] = [c for c in self.cpus[n] if str(c) in expand_cpulist(self.cpulist)]
+                self.cpus[n] = [c for c in self.cpus[n] if c in expand_cpulist(self.cpulist)]
 
         # remove nodes with no cpus available for running
         for node, cpus in self.cpus.items():
diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 287f4e2..85cb473 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -68,7 +68,7 @@ class Stressng(CommandLineLoad):
             cpus[n] = systop.getcpus(int(n))
             # if a cpulist was specified, only allow cpus in that list on the node
             if self.cpulist:
-                cpus[n] = [c for c in cpus[n] if str(c) in expand_cpulist(self.cpulist)]
+                cpus[n] = [c for c in cpus[n] if c in expand_cpulist(self.cpulist)]
 
         # remove nodes with no cpus available for running
         for node, cpu in cpus.items():
-- 
2.31.1

