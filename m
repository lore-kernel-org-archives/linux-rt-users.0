Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C73AC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 09:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6608C60F6C
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 09:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245186AbhIBJ0X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbhIBJ0V (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Sep 2021 05:26:21 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B5CC061575
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Sep 2021 02:25:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gp20-20020a17090adf1400b00196b761920aso1001697pjb.3
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Sep 2021 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uVoehRNkv/18chcPBo9FlEyAYm/NAyui+88NpwxoGzk=;
        b=RNrghy4FzDm7pl29ObV8zYD1qnkWD2L15WwkhGaropfUaoAER4s9szZUJOXRI1fE3L
         Dn0Ctoejg3XA7Y5TSVVEVKkBDqN73M/gMmETb4z56eJSTIdhPezWl6yfS5KKwWQY59gw
         X/WWKGbe0RNrNjWoFmWDUpB7g60zpEjjQyoVpnojen6bhJEjrziDxQ7PHEspkgG8UDr5
         23wfasjCL9DI7Tt6d4EwKtD+21gyyKdnEYhxuw+Vp7P87qsLK+bzb8W9PkosFNypwU8J
         hVYWfJTcDXKV1A+hI2Vtr+u2IDjpeoVTZOxyzSQSUs+79rDWVjXVH4KfSs3QzpTzvWUj
         xk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uVoehRNkv/18chcPBo9FlEyAYm/NAyui+88NpwxoGzk=;
        b=mgur7MoH8MPiav2N+gNDeWWkOerFG0k+I12wTuDSioGQ6azYp7QmXF45LnmHipKBVj
         NhOo+94exczXgNhQ4Fv7yJR0FRbGVA3nLc1yGRtzvpYUXPCYzLFPFZ4YKliY2+kymHok
         YHb2urGI/pvw5meqF5+ImIstZhBHznL0Mk2n8LvXYLl/SYNHvQ+jLWMEm/rhxyy2kiBr
         VHyQAC+v+yB4Njbksg31bIfRou4tgaLKtxHSK008wuJr7ibmy9sDOepvibJLWRZktYfM
         rWeouzXxhEoVRqyJOOXt9vsoxqz22jmLlVv8bAOcuVW1vamGXsh13Ym+SQWbUjJHBvX1
         8INg==
X-Gm-Message-State: AOAM53053lgl/p3OUVElOXolWJnynRmO01KF4FcZ4tCdQR85G7IIEfPl
        OblsuUcugZatoEQzgoHCaZA=
X-Google-Smtp-Source: ABdhPJxS+ggPbW2iHWHc2KxFJIhzZSOXXJcr3ErhU0Thv3TcKKoNDBF9LbLosQlUQYALhAA4bbm+nA==
X-Received: by 2002:a17:90b:4d12:: with SMTP id mw18mr2718973pjb.223.1630574723433;
        Thu, 02 Sep 2021 02:25:23 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 77sm1666803pfz.118.2021.09.02.02.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:25:23 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Venkata.Pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com
Subject: [PATCH 2/3] rteval: cyclictest.py Parse max latencies from cyclictest ouput
Date:   Thu,  2 Sep 2021 18:24:51 +0900
Message-Id: <20210902092452.726905-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210902092452.726905-1-punitagrawal@gmail.com>
References: <20210902092452.726905-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

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
index 0037c3ad07bd..67a2eab21d7c 100644
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
@@ -328,6 +333,18 @@ class Cyclictest(rtevalModulePrototype):
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
@@ -344,6 +361,8 @@ class Cyclictest(rtevalModulePrototype):
                 # Catch if cyclictest stopped due to a breaktrace
                 if line.startswith('# Break value: '):
                     self.__breaktraceval = int(line.split(':')[1])
+                elif line.startswith('# Max Latencies: '):
+                    self._parse_max_latencies(line)
                 continue
 
             # Skipping blank lines
-- 
2.32.0

