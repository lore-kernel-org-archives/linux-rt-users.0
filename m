Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7541C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 00:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF3B60FBF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 00:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243440AbhI2Ai6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 20:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242626AbhI2Ai6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 20:38:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4DAC06161C
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 17:37:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b22so323766pls.1
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 17:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cc32xea/oLt2809F1jdc8aP6vOeuZaKDSplV8wUmg9I=;
        b=WETh/+qT71WZ8LFfHBSEQlVNqZPt7xfX2Y4xwFB7B39UAYGDdvp4OWZREB6nRVFbCg
         s7WFiTQsIljEOcIMcrACcLV0irLDH1PBU5oazndYkEhr4SomzT+ZFYsJXafSPTwRYWNP
         QcKTtKOgpoAF1gTkRVhAcx60eLN+Cy1JMWPc0HQmHMlo1trdtUVyynlkWM/Vl+JRg2ht
         4cMhiFCP5APJfVHka2Y3Cb9lklA7UB4erBgLPHjwkFlmI1e7SzDfVECd0WwAxYxKVdOt
         tUmtzwCtfzSHkeKa8qLv+Oe1dOu2X44Di2riDhSWLtiFrbf68UsjmuJx7CDqzB5o3j19
         q6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cc32xea/oLt2809F1jdc8aP6vOeuZaKDSplV8wUmg9I=;
        b=uzgpnV16F7KA1/xL9rkf7X+tkFePwln3GCEJsKWzm1YOVkDdIGbPPLcilEvPRJxD1R
         rK3LWjlFm2XiBPwAiKiR6nx+KWMvhyLCJR+AalPgYp7U54ig+KyTUPTYeUWAIaNsP+wx
         7/FG4eXPezZsr+YLZstsk6YpEqHfgmLoKnS25kV6+/feygPrHCTMAPmDN+9XSBRh6RcD
         LVM1wdnuCvIPv9vr1y6KJsbJQFITpOK50wceNyE8hfETDuhQNBuunEYXShdoDW3DomNj
         Sdw2S6TEhBfYdsZeQlqfZYpOlpjgXCNepqLg2Rta390YK9npDJyfH6jbZWy4IpcIrRnq
         J3jg==
X-Gm-Message-State: AOAM531PM2+8j/ocMVRSsYeC4AmG0+hXNc9aXJRhJ2hynuaku7Qrt5J7
        o4L6N4oKc7L34aKmi+6QA9c=
X-Google-Smtp-Source: ABdhPJyJa6KdlCZfyfmKYMW1S5DI2E0nUHwmi/WKESj9CSLLpKRXteBJx/qd4/MkP6Bd0iZbLx8L3g==
X-Received: by 2002:a17:90a:191c:: with SMTP id 28mr3065779pjg.121.1632875837760;
        Tue, 28 Sep 2021 17:37:17 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id d24sm319852pgv.52.2021.09.28.17.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 17:37:17 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: [PATCH v3] rt-tests: hwlatdetect: Gracefully handle lack of /dev/cpu_dma_latency
Date:   Wed, 29 Sep 2021 09:37:09 +0900
Message-Id: <20210929003709.3423639-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

On systems where cpu idle is disabled to reduce latencies,
"/dev/cpu_dma_latency" does not exist and leads to the following
exception report from python when using hwlatdetect.py -

    FileNotFoundError: [Errno 2] No such file or directory: '/dev/cpu_dma_latency

Update hwlatdetect to check whether the file exists before attemping
to write values to it. Also, make the related debug output conditional
to c-states support being enabled in the kernel.

While we are touching this part of the code, also address a couple of
minor issues in the code such as -
* correct typos
* reflow comment to fit 80-char column limit

Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
v2 -> v3:
* Address issues in comment
* Initialise self.dma_latency_handle in init()
* Make debug() statements conditional to /dev/cpu_dma_latency
---
 src/hwlatdetect/hwlatdetect.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 12228f45f852..56fd2af8641d 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -200,6 +200,7 @@ class Detector(object):
         if os.path.exists('/usr/sbin/rdmsr'):
             self.have_msr = True
             self.initsmi = self.getsmicounts()
+        self.dma_latency_handle = None
 
     def getsmicounts(self):
         counts = []
@@ -210,20 +211,23 @@ class Detector(object):
         return counts
 
     # methods for preventing/enabling c-state transitions
-    # openinging /dev/cpu_dma_latency and writeing a 32-bit zero to that file will prevent
-    # c-state transitions while the file descriptor is open.
+    #
+    # opening /dev/cpu_dma_latency and writing a 32-bit zero to that file will
+    # prevent c-state transitions while the file descriptor is open.
+    #
     # use c_states_off() to disable c-state transitions
     # use c_states_on() to close the file descriptor and re-enable c-states
     #
     def c_states_off(self):
-        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
-        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
-        debug("c-states disabled")
+        if os.path.exists("/dev/cpu_dma_latency"):
+            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
+            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
+            debug("c-states disabled")
 
     def c_states_on(self):
         if self.dma_latency_handle:
             os.close(self.dma_latency_handle)
-        debug("c-states enabled")
+            debug("c-states enabled")
 
     def cleanup(self):
         raise RuntimeError("must override base method 'cleanup'!")
-- 
2.32.0

