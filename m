Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F6C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Jan 2022 16:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbiALQNT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Jan 2022 11:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355018AbiALQMA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jan 2022 11:12:00 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D6C061201
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jan 2022 08:11:59 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id g2so3035797qkp.1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jan 2022 08:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hZiTHKGO/jEdMgXg6vt8KZrV7oNcC9XatccD66djYYQ=;
        b=nC8hLCTXJHu0LDUEaLeBCgxJ9NB7mztlNOnrw00sFnY8MFUhCUnEgDdkCGPidG2MsA
         fDKbUNrgNtJB4NtYOdazKr0UDmgpwBsB022fvvvIRicppJCBZBL+6BQ3zHpYEujg6qWN
         INUAGy9XcBoD/PSs1h66pQkSe+uBHAsAYiRi3OeZlgHuNq03BwvRLc/PI07Gj7r3suhc
         YjGxaLiUH2uwmePpgFEzpBZXcX2Zst+gJLUYcMG8qonY/IQ2KAvSf8vIN3XtcDeuJF3e
         bgUO2qJyqtyzCvwVX9bxW7JWKyHiFxf2aWl4muTb0cvslXh/V4rUvfaQ5Ae3/0+6/llB
         qdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=hZiTHKGO/jEdMgXg6vt8KZrV7oNcC9XatccD66djYYQ=;
        b=Gx3MNYO3e5slFoTAO43z8O1wLv4Zc4M99yGLKlfH+Ju6sUthMYQ01LQxowmOnEc9BB
         HKAgBkIfrdYmQgJYt1yHBJmNoM3+QgYr81bdYmEMqea3QRFZJNtXK/wN5BtbMjnu1x6t
         MeB6jjDqBjMmODKrX2pdHVJc5QdoCy+WyKlv1xNoRgy5KfrycX7/8uXbgWwxCZ2Mcgb1
         olTe8a/vK1Toxa2C8Hk5KNDeJVkUYGDmc4Si7JWcdis8OtNaWpFt4Jt0DQrfFMzFgKV+
         LDISZaUTwE6xTbidBCQMG/OWEZfInehdYPyK1osU1l1R/tG1g6MVjG6smzboOgtlUJEC
         /CwQ==
X-Gm-Message-State: AOAM532ZWjAa0wB92sm0Sv7eOTWvhBXFMWXsPOLDg7mmoQdELrBWBTcE
        Dy4HZzeejPczVwIAOT5cDmhd4U+OTZs=
X-Google-Smtp-Source: ABdhPJya6wNd+P1zi/rp2VieDWPISCDDpxg8o+3wqs+Vc9GotB8HB3w3dg4vfLE4EEy4SRSyy5UoRw==
X-Received: by 2002:a05:620a:2894:: with SMTP id j20mr311216qkp.307.1642003918469;
        Wed, 12 Jan 2022 08:11:58 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id t9sm143999qtw.48.2022.01.12.08.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 08:11:58 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Add --cyclictest-threshold=USEC
Date:   Wed, 12 Jan 2022 11:11:37 -0500
Message-Id: <20220112161137.7909-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add --cyclictest-threshold=USEC
This option causes rteval to exit if latency is greater than USEC

This is similar to --cyclictest-breaktrace=USEC
and uses the --breaktrace option to cyclictest

The difference is that --cyclictest-threshold does NOT write a tracemark
when the latency is exceeded

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/measurement/cyclictest.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index c094df499403..cc74b467913d 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -295,9 +295,12 @@ class Cyclictest(rtevalModulePrototype):
         if 'threads' in self.__cfg and self.__cfg.threads:
             self.__cmd.append("-t%d" % int(self.__cfg.threads))
 
+        # Should have either breaktrace or threshold, not both
         if 'breaktrace' in self.__cfg and self.__cfg.breaktrace:
             self.__cmd.append("-b%d" % int(self.__cfg.breaktrace))
             self.__cmd.append("--tracemark")
+        elif 'threshold' in self.__cfg and self.__cfg.threshold:
+            self.__cmd.append("-b%d" % int(self.__cfg.threshold))
 
         # Buffer for cyclictest data written to stdout
         self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
@@ -411,7 +414,7 @@ class Cyclictest(rtevalModulePrototype):
         if self.__breaktraceval:
             abrt_n.newProp('reason', 'breaktrace')
             btv_n = abrt_n.newChild(None, 'breaktrace', None)
-            btv_n.newProp('latency_threshold', str(self.__cfg.breaktrace))
+            btv_n.newProp('latency_threshold', str(self.__cfg.breaktrace) if self.__cfg.breaktrace else str(self.__cfg.threshold))
             btv_n.newProp('measured_latency', str(self.__breaktraceval))
             abrt = True
 
@@ -454,7 +457,10 @@ def ModuleParameters():
                          "metavar": "PRIO"},
             "breaktrace": {"descr": "Send a break trace command when latency > USEC",
                            "default": None,
-                           "metavar": "USEC"}
+                           "metavar": "USEC"},
+            "threshold": {"descr": "Exit rteval if latency > USEC",
+                          "default": None,
+                          "metavar": "USEC"}
             }
 
 
-- 
2.31.1

