Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682BDC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D7860F59
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhJRGAT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 02:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRGAS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 02:00:18 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2683FC06161C
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:58:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n11so10462727plf.4
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7FP8JW57oqCzItTy8go2wIM3cNjDTVvtkbEPwiUoGVY=;
        b=LMWARDpwMVPvQlWTJGyViFIwcdxS65bqN8sJ9CERCLk5H4RRrw2G3HYBvpSkHg8iPH
         KuGVD5f3LSrb3QuwObc8k+xisgA99CZI2L5+nx3USBMKTgFfe2z113bpdapu0+6izn/S
         n/9RqQUc4JLeNAJNtOzuGzUK63vQANymCo6IfZzk4tGBbnWA4+UJVEU1JInVKcVMg4FM
         9Hmo2LJHXzU3SgKK6E2lA8Aj282myBxA9AglYAnrKD7jCh2zbgMLor4hTGox39COH7MW
         SS9mSReJL9Jm4LGK61BwpTGC6/SvJinFtnqSg3UHvxY1EIOpToMJWOA5md92A87x4YUx
         k6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7FP8JW57oqCzItTy8go2wIM3cNjDTVvtkbEPwiUoGVY=;
        b=1vQwbWaFtrHqUi09vMSDY/GQdFxOlj4azYsdOSJl3kNOojzjvxhD6AmAFn+xMsUY+o
         2Q7N+BMTR9IhbChzJxubiuYoLCtkJERMHtRhGdz5TMrI8irCRXOXbyPZmr42sXgqy0vZ
         kKX8x+M7umtXzWszDH/xHUZOvOHpfdenYEza9nTxaLjsj3Sf/P3bk2doLkHgkavh3lP4
         vVasRBGYfMXXB0sbM35alueH2dIlcpfBwAyorvSKYARCtWRpB73EEEfzUOMuwqI0U5gr
         qicm8nUDJhddP8ics6zRuEIGLsGq1G9dht4JopdTOjDG5kpZX2Jdb4xqQzkkN6vSxDbV
         s91A==
X-Gm-Message-State: AOAM5309E3LdrU2BIPqFRa0YqaTvVIRJJJC5UUGrs7YqNvvtN471yrbg
        BmHCWOslwYdYlQTOSytZM08=
X-Google-Smtp-Source: ABdhPJxP8rWDtpGQ6WEkOdDMn8aHcd9QD/Md5OZh+ZVe5dlk864qnMl3eCF0F1CQgVGKkZyCgyAc1Q==
X-Received: by 2002:a17:90b:34a:: with SMTP id fh10mr45477572pjb.51.1634536687508;
        Sun, 17 Oct 2021 22:58:07 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id x17sm11521584pfa.209.2021.10.17.22.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 22:58:07 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH v3 2/4] rteval: cyclictest.py Parse max latencies from cyclictest output
Date:   Mon, 18 Oct 2021 14:57:34 +0900
Message-Id: <20211018055736.412576-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018055736.412576-1-punitagrawal@gmail.com>
References: <20211018055736.412576-1-punitagrawal@gmail.com>
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
2.33.0

