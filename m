Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD03C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327456117A
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJNHPc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJNHPc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE02DC061570
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id v8so518308pfu.11
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sBL6kPCfg7nm8PIn7S+4KUAX6c7SNh/cUOh+Qmeucc8=;
        b=Ow9zpbzf9E7bCRyBZevSuu/1Dc+rK4H2ZaQKE2dWWDQG9XjsghNXi+JZ6UcwHlExAF
         FKIUiCYf3tVktMrnLrJb6bup5u1gb4rOJHuhe7HhRbA2kINDyquQuQ4Hs5z4rk5qRHsV
         jBcMtDR5h34x2TbfeJ4TxHqhFZjla+NKuTp/OCyqBOvcGnxlSqtDsZ+XszrQSSWRGQRJ
         +5e8JVV8fTKKk7ds4fLJtyGnGudqVfJ+pWZRWi/Sc5hcoXgPvDYd+jGnWUFurba8nix9
         Dr2QjCdv6wvDJmXqko4YIwuy/M7iJCrE5hVfTONSAIsUxgCzEClgMT64eZGzld4tyEj9
         /qvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sBL6kPCfg7nm8PIn7S+4KUAX6c7SNh/cUOh+Qmeucc8=;
        b=2dYDTlI3M5JzzVxFExiCjCIkA+5525DhQd7mQ95l/1ijDoHtHQYBmR+KcMe4CtfkTI
         3zV0qao557vRJI2bgc+2Ez3IjVMsFdwCDF2xWyn/1gN6f4rHh5wQSlaTX1XUDZWSCGZZ
         lcCk06G89iQ/OT6UpAMLEdYOOyj2dz1CuUYNN1MBInLOR/RShCu9e1iRClg6kDkKp0nW
         +4/pu/VR/qNjv2t4BuSB2qZo2BB2nNS5/mQ+rSxqLBooMSWKFOZv0ZLWk4/X1oT3vH79
         8fL2vsu+RaGgFZvHE73VTqe7fwZ6olkARlSreUMIvvqjKZN3Tsl8XestAX+c++mn3yBy
         UGNw==
X-Gm-Message-State: AOAM532uuRZIos8g54zcIZmiMt7oNNdbTZPnOqCZmiWq0V1zmBMIG97E
        0E7T3pwqaFraOyXBt0FIqjM=
X-Google-Smtp-Source: ABdhPJybAqjBoHkCDUiY97Ua3/eSEnSPbdG7Wgc1dTrS+JhiRKdXWge4vd6Id1R/R19CLqDFrS5WFQ==
X-Received: by 2002:a63:7444:: with SMTP id e4mr3004627pgn.87.1634195607343;
        Thu, 14 Oct 2021 00:13:27 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id z23sm1562159pgv.45.2021.10.14.00.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:26 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 3/7] rt-tests: cyclictest: Drop unnecessary variable "stopped"
Date:   Thu, 14 Oct 2021 16:12:43 +0900
Message-Id: <20211014071247.4165329-4-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

In timerthread(), "stopped" is used to track when the tracelimit has
been breached. It prevents additional updates of break_thread_id.

But the timerthread functionality is already guarded by "shutdown"
which is also updated then latency crosses tracelimit. Remove the
redundant variable "stopped" to simplify the logic.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/cyclictest/cyclictest.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index d06ed01c58f4..721d242a1da0 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -511,7 +511,6 @@ static void *timerthread(void *param)
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
-	int stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
 	unsigned long smi_now, smi_old = 0;
@@ -715,8 +714,7 @@ static void *timerthread(void *param)
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
 
-		if (!stopped && tracelimit && (diff > tracelimit)) {
-			stopped++;
+		if (tracelimit && (diff > tracelimit)) {
 			shutdown++;
 			pthread_mutex_lock(&break_thread_id_lock);
 			if (break_thread_id == 0) {
-- 
2.32.0

