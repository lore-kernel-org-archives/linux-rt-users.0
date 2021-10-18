Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D4C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A606D60F25
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhJRGA3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 02:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJRGA2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 02:00:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F13C06161C
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:58:17 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m21so14937419pgu.13
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRSNpPjRQbUd60neLv6n1DUrTAqIqO995bqvFmd5u5k=;
        b=iAUWq31NRDO2Gfix0DIuhjJUi66z/dIT4Yzi90jNMa6RSDJi8ukUZc5LK5SUFPMoeR
         OyKiM3DuRoCgApc9Vzz7KK6vCGfjmQlEQvjUTCDYoIIGKdJGh0bDXQPH2YaWgKG0Oh97
         RAU3JTIsGw86gpl9VYaD09FKZOBQPbM2wjUMUrEWKX+X+CdPwcxnwnJ0CxF9gcBlTmSr
         XE4KfKxv+xk/7A079ha1G8OBLphiFwnPqTRuXZR28Rp9QIQ5JFcQxUrFfOoMCSqBUk26
         xP/JGIgloZJxePXPWBkHAJzV8Ywj7uoP4TmZo3DmW70+cLI5AUwgIXNEC8oQxMK49C9Q
         XYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRSNpPjRQbUd60neLv6n1DUrTAqIqO995bqvFmd5u5k=;
        b=haoM6X099k9UeOvvq7KoGK6+f9z2sXlV23NxaajPNzuiEePmzkCa8kkpCyaNu0bG8w
         s0aiHZTciCPfK1R8lDXCNUYcxBreJKiUGFKRpKxijBfX/phyNe97qtYp2a6aibownMdI
         RHIbGnz+7rV3zIMKE+1b+jAFbsP69Rt8CUBazBbAgFrnJwSU43dI/jGbM7DiSeqySbwX
         PZ+eCyHzIrSdLZ37yOj6OfimvENcpxdgit8uCx4HLF/CgI7AwUHm3Vuh8t0m/19R3Ffo
         ht+PDWvQiC27C240ern/VMn0L7/iDrKbnJogQONS55GNqMoc8UvNcfj85g735lX4YgHa
         BM3w==
X-Gm-Message-State: AOAM5336/e2qFi8+K5lwTRG/3c8hZ3jmKJkx91edIsNqy6wW/AuA2FtM
        kCfia39jr7YRf/49NjKFnW0=
X-Google-Smtp-Source: ABdhPJwPviSHBNSh3gxwr2W59Sh/10aY0S521+GNLc18hpevtfMPW4uYSBH7F3Z0CB9x6qPCTG6QNQ==
X-Received: by 2002:a63:4606:: with SMTP id t6mr21392367pga.388.1634536697203;
        Sun, 17 Oct 2021 22:58:17 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id a28sm11680693pfg.33.2021.10.17.22.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 22:58:16 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH v3 4/4] rteval: cyclictest.py: Skip statistics reporting in case of an overflow
Date:   Mon, 18 Oct 2021 14:57:36 +0900
Message-Id: <20211018055736.412576-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018055736.412576-1-punitagrawal@gmail.com>
References: <20211018055736.412576-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

The cyclictest.py module recently gained the capability to parse max
latency values as reported by cyclictest.

When the max latency exceeds the range of the latency histogram (or in
other words, the number of configured buckets), statistics such as
mean and standard deviation can not be calculated correctly due to
lost samples during measurement.

In the case of lost samples, skip statistics generation and report the
max latency warning the user to rerun the measurement.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
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
2.33.0

