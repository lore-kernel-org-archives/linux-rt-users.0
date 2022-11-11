Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24DC43217
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiKKTxu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKKTxr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:47 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A6D15A1E
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:46 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id e15so3973982qvo.4
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2y5J8TsLs6NnpkLLECqfh+kMBZ0yK44t2BpYgDC7JM=;
        b=IBTnhAL+PJv39Vjov4fFaYDXVSAcNYYpCQW6s7b1estdrAJPHeEnJkrBYplSrdPIS2
         2Kxu+G0dbz8L8RVh29Phh65etTIvgqLJG89bxl2K46XTg/ZD7ST/0kmYEvmkHnWgLv7g
         nz6HzZUstDv7udqpO2maeRLqOBDdbXftrkcjZvjABbgMu6lMeHTjfKgINMcpB4kPHoFl
         d13E3/1m8tCnmvN6JXfYgQf+fT2g0VYNj/JQDIAvoqfAt+1tVSgzPD/blTnUmb1HukbR
         AGKG9YlO2TK2qviPf5InNzBRH16Q3Ili3K8jRScDoMlPl+Ofj+x1IjJ8RkUlGQ2+Tljv
         KunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i2y5J8TsLs6NnpkLLECqfh+kMBZ0yK44t2BpYgDC7JM=;
        b=DF2YR02IpYf8kp9fF64VYUhwyROOnIgaNtNY/BvKiZDl81SqjjFgNxljE/NOcjym79
         /75yHxbupT0caJFT3eqkP67nTDvIR970++cGrUaNJFfFBCHFQ9X8efkrUEAJ3r1zbs42
         LwDBr0GTR1mjpXv2cGNyNupufoW4SDWWmpr0hl76e7AC+P3jC2rGUIYiQBWFJFSg+AJ8
         svrWYY7p2JrYSdHaOUbYwNqTV2sLYxEuVMtbQjjVvmPRKyx3wchgJLN/B5SVseS8O+zC
         UHSEpOx1IEKUMEkcEd+K0e1dzgm3nfs+lJj8YE8RDP8hKjUfa4asOqgcAuNNMD8rc/Fy
         rYMQ==
X-Gm-Message-State: ANoB5pl/euimVGOZRxrpgu9pQXaiQ9lppGK6eGcCyJ6MlRTaUURM255P
        tAyBRXr4jucomUaEOKAcwHVrM97BiNk=
X-Google-Smtp-Source: AA0mqf6AsMvQBtsLHJdGiq2pJgl415kGEB4jaBE5byQvv3Hjj1sz2HwJ8v9YPvTAmRsehghhSSzXmg==
X-Received: by 2002:a0c:ff07:0:b0:4b1:b025:54e6 with SMTP id w7-20020a0cff07000000b004b1b02554e6mr3351710qvt.53.1668196425132;
        Fri, 11 Nov 2022 11:53:45 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:44 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/8] rt-tests: hwlatdetect: Update to integer division
Date:   Fri, 11 Nov 2022 14:53:22 -0500
Message-Id: <20221111195323.27402-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111195323.27402-1-jkacur@redhat.com>
References: <20221111195323.27402-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Leah Leshchinsky <lleshchi@redhat.com>

In Python 3, "/" is a float division operator, as opposed to Python 2,
which defaults to integer division. This results in an error when
calculating width, which assumes an integer.

Update width division to integer division with the "//" operator.

Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 1efbe7a60059..c5b3a689dcd1 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -454,9 +454,10 @@ if __name__ == '__main__':
 
     if args.window:
         w = microseconds(args.window)
+        width = w//2
         if w < int(detect.get("width")):
-            debug(f"shrinking width to {w//2} for new window of {w}")
-            detect.set("width", w/2)
+            debug(f"shrinking width to {width} for new window of {w}")
+            detect.set("width", width)
         debug(f"window parameter = {w}")
         detect.set("window", w)
         debug(f"window for sampling set to {w}us")
-- 
2.38.1

