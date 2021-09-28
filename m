Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9882AC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7616E611C3
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 08:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbhI1ITG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 04:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhI1ITG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 04:19:06 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D42C061575
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 01:17:27 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n18so20338889pgm.12
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCfRIbzKM5B6w8nVb45ohKOpkTn4INQfBvXyLmVvB60=;
        b=DeJwISpAbKhtiE4uMgVEeDHHWYW6dDONrioYrkoLjsD7OUYf3yPmXO1c7ftNq1eo8n
         txEx1fkJfap3l8nm+voSZn+LKmhi/1FCr6Pu2HrojHnWcCTwuIgMQVE1N26klmjskPaB
         HMKTaW0f+XmQlRYlU5TnO3pyBy0DNUgYJc0+NAQeFSwj4OTGuJk39bY4Ils9Tq9yEp6E
         zSbVBXsZ9f7NNut+VwujERSFVGUih26ylo/ToHT5vWaKjGoz9f7rfFJ27dqKbOkjtzfv
         ZEhamBsH8GLD2N0ulztQA8XCeqVa2WZMyVpmPwXJpbJ7yHKhxxYaFsN3ObIbMpbH5lhi
         evXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCfRIbzKM5B6w8nVb45ohKOpkTn4INQfBvXyLmVvB60=;
        b=WeUDIk6Y7XJD+tHfIkpFcNYCBXg/5Z1K8CSqg4h8tTGa2R3AeWEo29HfbwTQFgpKC4
         PZRIhW324AfNfIo16tJx/2x6TSwpUg9qArU3mTj5HenrxMt5J0m9LQf8PBtHM5ujgb1X
         xZnJjwq0PbSeb0eZe+Df6xfXMWWsAEImTjFAd0nYUD3V0H9D6z5UNKBQ5+KZBev43d7e
         m3l8xyUe+pflpfVTtxy01sYA6E26B+rydHWi2poivTg1PXPFjc/aaZeox+dSlSI8YHXL
         vjNZM1FVmNaCGBeInyWKecKk2EVn+c2JpoQBNyTZwFNvqnQydZAH7j3u6vMElv/57Iqz
         ldPQ==
X-Gm-Message-State: AOAM532O6GkbS4EVdTHORRUSmh54+6c3GCZamYC/n7Np6d0FtCYRjofT
        l3vAeaGlbMSss0moQ48ZxCmacl70U7c=
X-Google-Smtp-Source: ABdhPJy2EJQaFLy0m0dMxmaEAB+4B8P4rJKdyfCG2M5S3kLkKmFrj/dx5FpSDURSPWDPlhAMu3N1cA==
X-Received: by 2002:a63:dc42:: with SMTP id f2mr3470470pgj.152.1632817046394;
        Tue, 28 Sep 2021 01:17:26 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id s2sm1627874pjo.24.2021.09.28.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:17:25 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh1.hegde@toshiba.co.jp>
Subject: [PATCH] rt-tests: hwlatdetect: Gracefully handle lack of /dev/cpu_dma_latency
Date:   Tue, 28 Sep 2021 17:17:16 +0900
Message-Id: <20210928081716.3421463-1-punitagrawal@gmail.com>
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
to write values to it.

Reported-by: Suresh Hegde <suresh1.hegde@toshiba.co.jp>
Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/hwlatdetect/hwlatdetect.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 12228f45f852..89537a6e371f 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -216,8 +216,11 @@ class Detector(object):
     # use c_states_on() to close the file descriptor and re-enable c-states
     #
     def c_states_off(self):
-        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
-        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
+        if os.path.exists("/dev/cpu_dma_latency"):
+            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
+            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
+        else:
+            self.dma_latency_handle = None
         debug("c-states disabled")
 
     def c_states_on(self):
-- 
2.32.0

