Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30275C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F57611C3
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245529AbhIQIzi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIQIzh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 04:55:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20623C061574
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 01:54:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f21so5753073plb.4
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 01:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wyDJZf/rqCIT9JNzOExnx8zWrqqyG0KC9OFy7YI3oiM=;
        b=LN1WRcqQqvr+om9kgM1ozsLXdpA0XBO0unzNOc/VIAOIP0ky68ahfB4AebUwcXjiDg
         RQghzgAoMQFMZNuSARm774nmH+JWs+YLxULVUjHC2+1FCfi+2DkQ6/+roE1u59U7hft1
         mVXUAhA6S4S+T9YMIcQhvdYjb4/alBa1zFMbQcJWqNPL++m53SmuVK31tsiIPuDV1A4V
         vRkIG1pNtoO/+xgFm/rLbkcqHhhys+CsAxGPMQC106aLG9QTntc0Xdy5phme6uXWEs+k
         P1zAw1wzUsRoUGdT/nTPyU9Og5TrRO2DUu8L8gf6KthwldcpxPWbGoVEXp1UiAHbjRIr
         71gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wyDJZf/rqCIT9JNzOExnx8zWrqqyG0KC9OFy7YI3oiM=;
        b=fpPAJDDIaYj2/VmidxIXLIKYBPV3XBcJvnacZta0Z8s4lgV7JAFPHJWbPZQAJLmtJr
         eXCqpKVyc2RW2mWbV5Moryu16wL8zMH3MtUev/tUZnrtLAombYi2fxP7/MifxoIo1P5k
         zkG3CajSZB1Fk9VMozVCQJUI6MQnvlUCOuVlBwkK3kaSJg38UqFLeliQtFERxtOgLruy
         Bx46yHQBdYymuGsxmIz6/dnlRhnhjitFG0i7K3RCMEFNbOInFOgCs+LkMXFv5NpMS5Ma
         Zh3RxxCPsC62U6BA+ryJRdRZ+FzbXxdh/eUVFL7GgP7uGxnpEcM90BhNlOLqgLXng5+y
         qdng==
X-Gm-Message-State: AOAM533v61jU7fOV5kBu+BRbu3ZV+cjHGRi6wrXwNyepB50al/T6pZwR
        AKNzUeeNzyqZ1nr1rXLlyUQ=
X-Google-Smtp-Source: ABdhPJxzRWvv1EAdoFWxC7pzYM5N6JTAp+fxYm60YaPZT4eeyA885VOiMoYiJXE2MVf3esGS9q3ePw==
X-Received: by 2002:a17:90a:bb04:: with SMTP id u4mr10988735pjr.221.1631868855662;
        Fri, 17 Sep 2021 01:54:15 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id q15sm5026634pfl.18.2021.09.17.01.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:54:15 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH v2 2/3] rteval: cyclictest.py Parse max latencies from cyclictest output
Date:   Fri, 17 Sep 2021 17:53:42 +0900
Message-Id: <20210917085343.2775300-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210917085343.2775300-1-punitagrawal@gmail.com>
References: <20210917085343.2775300-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

When collecting a histogram of latencies, "cyclictest" reports the
maximum latency encountered on each core even if they fall outside the
configured no. of buckets. This can be useful to understand the worst
case latencies for the run as well as right sizing the number of
buckets for the histogram.

While processing the output of cyclictest, rteval skips the reported
max latencies and calculates them by capping to the no. of buckets.

Fix rteval by parsing the maximum latencies reported by cyclictest.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 rteval/modules/measurement/cyclictest.py | 31 +++++++++++++++++++-----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index ee1de883d844..d3a0b045b9dd 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -67,20 +67,25 @@ class RunData:
         retval += "mean:       %f\n" % self.__mean
         return retval
 
-    def sample(self, value):
-        self.__samples[value] += self.__samples.setdefault(value, 0) + 1
+    def update_max(self, value):
         if value > self.__max:
             self.__max = value
+
+    def update_min(self, value):
         if value < self.__min:
             self.__min = value
+
+    def sample(self, value):
+        self.__samples[value] += self.__samples.setdefault(value, 0) + 1
+        self.update_max(value)
+        self.update_min(value)
         self.__numsamples += 1
 
     def bucket(self, index, value):
         self.__samples[index] = self.__samples.setdefault(index, 0) + value
-        if value and index > self.__max:
-            self.__max = index
-        if value and index < self.__min:
-            self.__min = index
+        if value:
+            self.update_max(index)
+            self.update_min(index)
         self.__numsamples += value
 
     def reduce(self):
@@ -332,6 +337,18 @@ class Cyclictest(rtevalModulePrototype):
         return False
 
 
+    def _parse_max_latencies(self, line):
+        if not line.startswith('# Max Latencies: '):
+            return
+
+        line = line.split(':')[1]
+        vals = [int(x) for x in line.split()]
+
+        for i, core in enumerate(self.__cpus):
+            self.__cyclicdata[core].update_max(vals[i])
+            self.__cyclicdata['system'].update_max(vals[i])
+
+
     def _WorkloadCleanup(self):
         if not self.__started:
             return
@@ -348,6 +365,8 @@ class Cyclictest(rtevalModulePrototype):
                 # Catch if cyclictest stopped due to a breaktrace
                 if line.startswith('# Break value: '):
                     self.__breaktraceval = int(line.split(':')[1])
+                elif line.startswith('# Max Latencies: '):
+                    self._parse_max_latencies(line)
                 continue
 
             # Skipping blank lines
-- 
2.32.0

