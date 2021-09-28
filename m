Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9C2C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 08:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CC5F61159
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 08:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239792AbhI1JA4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239788AbhI1JAq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 05:00:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F3C061740
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 01:59:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d4-20020a17090ad98400b0019ece228690so1220172pjv.5
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 01:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC4IIbHxt9RBuWgL2+ii5aHPPyl8Se/0jAHhvT335rg=;
        b=Yauu6h6WalZzQaGa0IUm3H2ja+lRJTupCYAJUzgP6rWIAleQmf6NMY6u2UWoDDujVk
         lwny2jsNqsTmm3y0jNR9BIpA1+gqlitRqCaFciHUUPL8VRhNapHELejFwouThQo6bdb5
         /o0YJTddLfJENy8ColcaOxv6EuFUDdiynUy/y8igbH61IxI0Pcz4kxWTLm0moRxCCn5d
         AWUbM99Gqg9aCrTYWRxIfvjpjd/1vnp6NTia+mtKAt+204JVBliKjX4WR6XBrh+3t7ia
         T/OR/q1Sro9AJoh+KOVNy+fS4qrBG3Ki2HLBolCxCYMbA4JVV5LTWRF/D9DO6BwUZenw
         /nDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC4IIbHxt9RBuWgL2+ii5aHPPyl8Se/0jAHhvT335rg=;
        b=SaX3u0nz6CQXWQO7le6ceFcSRjm+ONYDR7l/l/6BoNragGizZy9LSvcEuK4bk9azXN
         CYAnNxvTmH0dfdPLX2bBHsQWUr+QHs4TxyRXRCy5Q/ulXj/9+dbh0XVKaBF+YSI2dkp5
         EoFfFNfPXTmmkJktCYI4lX5aqQHTHJizcuygnHm0gboxkA+bsm6t2NKJdg+TGjjSBMU4
         d6i+YLFDl4o8isPwAHw0L97NsJnFQST9Q0EIrUkJQm31HYSgxylDhRO9ZvBf9euabnRR
         IjO3i0+SBE1R1ryCcAvNW57mYwnQp4z80iYNYZ+zX/Ihem05Jydh183o4jZ6LSE11rFo
         CPJA==
X-Gm-Message-State: AOAM532+X7xACFsQWuhf7et43x7/e5TyDohArx/Jh8iAFd/WVvU6B5Ph
        4NQlNitO2wVfeU4tgyNDlR8=
X-Google-Smtp-Source: ABdhPJwdg42yY6D4Rsb3AYM5Anmx1inf4mZ5ju28nR7FvjzMzmEwcQXcmYFhQ/gbdtmNaSRESzKQYQ==
X-Received: by 2002:a17:902:c204:b0:13d:c6ef:7cf2 with SMTP id 4-20020a170902c20400b0013dc6ef7cf2mr4031440pll.33.1632819546666;
        Tue, 28 Sep 2021 01:59:06 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id a20sm1776221pjh.46.2021.09.28.01.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 01:59:06 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: [PATCH v2] rt-tests: hwlatdetect: Gracefully handle lack of /dev/cpu_dma_latency
Date:   Tue, 28 Sep 2021 17:59:00 +0900
Message-Id: <20210928085900.3422085-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210928081716.3421463-1-punitagrawal@gmail.com>
References: <20210928081716.3421463-1-punitagrawal@gmail.com>
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

Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
v1 -> v2:
* Correct Suresh's email

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

