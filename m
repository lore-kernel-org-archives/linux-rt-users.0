Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4B2C48BD3
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 11:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F2420B1F
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 11:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOU26oTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfFZLIv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:08:51 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39267 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLIv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 07:08:51 -0400
Received: by mail-wm1-f44.google.com with SMTP id z23so1648658wma.4
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jun 2019 04:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G4G1/H64ARvtvAjoFlk5ueJNImN3hx8MCu8b0K7gDiU=;
        b=lOU26oTNOLbpc1Utyay7nNYXPxDE80Z5EyYUx+t5B3XycZBUcCMVfCNIAXG9cSEkBb
         7kTXtCsIQlx12o+JEHnd7kCjSMWv4XpgPWYRvlbZzbRFJcN3qk6owD7x3wL0e/EiNn+o
         TNsWT3dnfRg4gITHUDLuar1ziA6VkXif76p4qa8DNdPN+5PSXwcCn7vd+Z1OUWiETGzF
         iptiVUK36mowxF5jNv7wtS+Gx3w/P/jdc0xh3FyPNofm9/VevAn/bawjA54gg3Hw5AkR
         YeVm3GxsbirNWaj677JXHdBbY9ruIzPkVmsE+f4bRsetAICxNJo7MxfmeLdnnJEUswgb
         yEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=G4G1/H64ARvtvAjoFlk5ueJNImN3hx8MCu8b0K7gDiU=;
        b=ML/iDXLSmrTxrcLgJpkijVHVkgcrYVVOc7OEhhovGLFV7BB+kCEnq5u037c67YJSWQ
         vh25zD8iKMCl0mXsMFYPJ4q96Bikk8acf4TM4s3pQ4H9Oi//Hw6SxoZ650GvBnmWJitZ
         AKNFDpjoqqtuJn7eGCEyJDxRwmzIhtfwl5ebV8MkuPRPfItZYYPbjT69pJjg/r9OJCYB
         omK/XM735yuiEdah/Cj8KyEJITGnyQnF+X5J/i8HW6UfGvH0T8wQQumMWhdsPFX28ysj
         xu3FtKONEtfPMfWZSNtpHdGmSQSyS9i+kms2HiFhrq4QkgjJ/l2v+ESzLXit1o43kNLA
         Zuww==
X-Gm-Message-State: APjAAAXnjza+UJMyECGY1qJWOkBt3LcOCtVrWM9hk/z2jHX+iI/7NxRn
        gPUPy6h3pm7z4geyiCHJZ/RrVm+EMYo=
X-Google-Smtp-Source: APXvYqwyqQnVnEelZSPa2LFRjz+y1uLqH4tz7pM2x8lqWTnuU6vh45uwZaE0zMTawAW2M/jUN0Wq2Q==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr2473918wmh.16.1561547329384;
        Wed, 26 Jun 2019 04:08:49 -0700 (PDT)
Received: from planxty.fritz.box ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id a81sm2093751wmh.3.2019.06.26.04.08.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 04:08:48 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Use gettid from rt-utils.c everywhere
Date:   Wed, 26 Jun 2019 13:08:38 +0200
Message-Id: <20190626110838.7800-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

gettid is defined in rt-utils, so we should use that everywhere instead
of defining a separate macro in each test for it.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c           | 2 --
 src/pmqtest/pmqtest.c                 | 2 --
 src/ptsematest/ptsematest.c           | 2 --
 src/rt-migrate-test/rt-migrate-test.c | 2 --
 src/signaltest/signaltest.c           | 3 ---
 src/sigwaittest/sigwaittest.c         | 2 --
 src/svsematest/svsematest.c           | 2 --
 7 files changed, 15 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 03d56e4f520c..83f169d381b7 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -54,8 +54,6 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-/* Ugly, but .... */
-#define gettid() syscall(__NR_gettid)
 #define sigev_notify_thread_id _sigev_un._tid
 
 #ifdef __UCLIBC__
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 054768d161a7..2191710961fe 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -41,8 +41,6 @@
 
 #include <pthread.h>
 
-#define gettid() syscall(__NR_gettid)
-
 #define USEC_PER_SEC 1000000
 
 #define SYNCMQ_NAME "/syncmsg%d"
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 6bedbc81b572..e8a3177b63dd 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -40,8 +40,6 @@
 
 #include <pthread.h>
 
-#define gettid() syscall(__NR_gettid)
-
 #define USEC_PER_SEC 1000000
 
 enum {
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 8223d6669a37..f0a285d1d45f 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -43,8 +43,6 @@
 #include <pthread.h>
 #include "rt-utils.h"
 
-#define gettid() syscall(__NR_gettid)
-
 int nr_tasks;
 int lfd;
 
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index a168191b7573..4c952561d7f2 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -32,9 +32,6 @@
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
-/* Ugly, but .... */
-#define gettid() syscall(__NR_gettid)
-
 #define USEC_PER_SEC		1000000
 #define NSEC_PER_SEC		1000000000
 
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 6e3c28330447..4579f903c909 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -41,8 +41,6 @@
 
 #include <pthread.h>
 
-#define gettid() syscall(__NR_gettid)
-
 #define USEC_PER_SEC 1000000
 
 enum {
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index dfa4660c0e43..01083d13dde6 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -44,8 +44,6 @@
 #include "rt-get_cpu.h"
 #include "error.h"
 
-#define gettid() syscall(__NR_gettid)
-
 #define USEC_PER_SEC 1000000
 
 #define SEM_WAIT_FOR_RECEIVER 0
-- 
2.20.1

