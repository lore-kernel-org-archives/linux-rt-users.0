Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC7C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 06:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8E1613A1
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 Oct 2021 06:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbhJDGq5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 Oct 2021 02:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhJDGq5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Oct 2021 02:46:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EF5C061745
        for <linux-rt-users@vger.kernel.org>; Sun,  3 Oct 2021 23:45:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q201so2963021pgq.12
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Oct 2021 23:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FuGonMxig3cxD0KDogYs/m0ZxS5ZZICUzoxwTYPlxkw=;
        b=H0544lkhdV1h5zUTlxThZNpWaAsbENUF2H/fmg669yTKMHYNJE7Df2q2b8zrhLlgjg
         RBh7L1DdmH0bfSPU623j0ai7vBjyHksj6dt/FGPE6zxrQ1irP6RIforAp4Veoz6O7b9X
         bSZUvrDw+5qhZ494PsGKXtV92NF7Ef1e8HAUflU59QUp1SOry9KG3/mWjHz1RT1e4Oq4
         AewYHYO8bdvcI+nnA+/j4j5fm/ETNsiITeZR9DEYg2DcAwvd1ycIz1tWDO4KJXkY5DTY
         tOf+ozAncLaibidVGisjrLyG8yK9FA7/+JdkZz//ZMmLCRFXGJEZ3BfpzI53/sMjp7Fp
         Th3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FuGonMxig3cxD0KDogYs/m0ZxS5ZZICUzoxwTYPlxkw=;
        b=XRTgfRecCtGW8ZCw18VeAJ6aL38OIszAGNu4A+bOfkK8W1LdMiWUV3dTDbcs5SNdcN
         EZjdMIoRDPXdVmK8PZjffrqRrW/gJA5MWrgCgzOrj20tL9XA399pzpTJcEuPQJ3H8F3+
         kCWiuOH8ZHb14UdPqBJKok+JduBBH0c0iDtHDOBYguqaEWYzVbxMjIwjfcJpTIeDscmw
         aPgOfgM0VFhiQFGz91lCiH+6iI8TYZdlGja05z5lYvV/LcOsgwB78jCr3s9nA1k1rR4m
         QMv6jZDn3HdNR3gKL3+fAA6/1q9o96FiWyi9v1ilBQfQDVSonoUj0wgrey9NeWU5yASq
         oxHQ==
X-Gm-Message-State: AOAM530SqkQBOVGuHztLohTqhLC2xDwPhxMwhOMRoaLUdbEGZFIzC7yA
        rBBjPZYISS31c/geb5VUCBw=
X-Google-Smtp-Source: ABdhPJz9dhpnlzgYJI/54x0rYfl41bE/+rYn5lAuxZ322kT/wGNYAFEQGTCOn/F7wv7C9LVRvCCnPA==
X-Received: by 2002:a62:3606:0:b0:445:38d5:98bf with SMTP id d6-20020a623606000000b0044538d598bfmr24152243pfa.4.1633329908154;
        Sun, 03 Oct 2021 23:45:08 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id x10sm4348183pfu.177.2021.10.03.23.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 23:45:07 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [RFC PATCH] rteval: cyclictest.py: Skip statistics reporting in case of an overflow
Date:   Mon,  4 Oct 2021 15:44:58 +0900
Message-Id: <20211004064458.3488990-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The cyclictest.py module recently gained the capability to parse max
latency values as reported by cyclictest.

When the max latency exceeds the range of the latency histogram (or in
other words, the number of configured buckets), statistics such as
mean and standard deviation can not be calculated correctly due to
lost samples during measurement.

In the case of lost samples, skip statistics generation and report the
max latency warning the user to rerun the measurement.

Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
---

Hi,

The patch depends on the improvements to cyclictest[0] posted sometime
ago.

In certain environments such as virtualized systems, latencies can be
quite high - such that the samples exceed the range of the histogram
and rteval reports incorrect statistics such as mean and standard
deviation due to missing data.

Now that it is possible to parse the real max latency, it would be
good to use this to detect situations where max latency exceeds
histogram range and take appropriate action.

There are a few different response (or combination thereof) to the
error condition -

* log a message warning the user
* skip statistics reporting in the report
* add an error message in the generated report.

This patch implements the first two points.

I am posting the patch as an RFC to get feedback on the appropriate
action to take in such a situation.

Thoughts?

Thanks,
Punit

[0] https://lore.kernel.org/all/20210917085343.2775300-1-punitagrawal@gmail.com/

 rteval/modules/measurement/cyclictest.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index 50a734c75047..7a619dd1c852 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -67,6 +67,9 @@ class RunData:
         retval += "mean:       %f\n" % self.__mean
         return retval
 
+    def get_max(self):
+        return self.__max
+
     def update_max(self, value):
         if value > self.__max:
             self.__max = value
@@ -423,6 +426,13 @@ class Cyclictest(rtevalModulePrototype):
         if abrt:
             rep_n.addChild(abrt_n)
 
+        # Let the user know if max latency overshot the number of buckets
+        if self.__cyclicdata["system"].get_max() > self.__buckets:
+            self._log(Log.ERR, "Max latency(%dus) exceeded histogram range(%dus). Skipping statistics" %
+                      (self.__cyclicdata["system"].get_max(), self.__buckets))
+            self._log(Log.ERR, "Increase number of buckets to avoid lost samples")
+            return rep_n
+
         rep_n.addChild(self.__cyclicdata["system"].MakeReport())
         for thr in self.__cpus:
             if str(thr) not in self.__cyclicdata:
-- 
2.32.0

