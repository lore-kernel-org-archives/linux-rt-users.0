Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D7C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D6461167
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhJNHP3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbhJNHP0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:26 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A5C061746
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:22 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m21so4646476pgu.13
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiEwsQR9AF+jK2H8L2EYFHHab2TxPWPZYe1RQi9T0ns=;
        b=RpecsZlGSX1lGAQ5utabv8DdGdH2G6rv+O7QiWoFDiWg9Yevdwo1hq/kBuFj9XA5V2
         VSQB/ikTgRIMlqTxZXcTSOpbWIiAaQIeB9Rp1NqLX2vodlF3Cgm0pYskeaVFFgOmX3H0
         Sqcj+vK/VCkLCTs6I/18UdnMkRl4zTr17KvQuRsKqQMo9F+XIlEft4yiuGwKyfKebIKD
         csDQ+QV7XKIA40VlYDDE0GIcqtabsI7ziXjrSiR+qJ8+qgXqOk1bjb12qWN6I8SZdE8g
         Qrl4aOYC9N3IPotMXcS48dd1jI6lL8djnl4PYYlf0xjQxH+riFzcJe46KmFqxIAqEdmy
         HsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiEwsQR9AF+jK2H8L2EYFHHab2TxPWPZYe1RQi9T0ns=;
        b=4qo+q0PiHAGsqPtunHgQxI94upSCEdWAOySdULYS3wUhkwyEBXjos/63/8gZ/n+EOa
         FXrN1QCCLi5F0JufITnyefbH5xJcGnwq3Qpt3VsWT9RraG2OK4U6l4LvtJZw3PLS/cDO
         aBqz1CgnWY8RpNa7LQEpCI4SNRzHeJldjzki/Yr9sSQwnQxI6vn8++0YYZkkTIwE0Hj/
         o9AV5jk4/HW4SBpJZu9kLToDZGPLclDMNhikJIggtnLMs+I1/MXVmCkQG68/A6V+4X3h
         88uhXuukHHDEHIfDrYippMvza4dlJFH4qB4inTk/PicELlrO7s1WpSuzUh2qh408x2m8
         fpeQ==
X-Gm-Message-State: AOAM531tv8pqJBpIYMUbnhPS4336TGsqmBTfhzsfYrTetYtmnYGevaXq
        QH2Dd716SQr2GGXrCyjP5KQ=
X-Google-Smtp-Source: ABdhPJy2nPV6jALXtvt8kVU+s/fh8AYCCDEmvpdsG6OP4Ys8lKhR2EJsttPtYgw0mOrkLGEgFEt0bA==
X-Received: by 2002:a63:ea44:: with SMTP id l4mr3014347pgk.210.1634195601772;
        Thu, 14 Oct 2021 00:13:21 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id om5sm1453956pjb.36.2021.10.14.00.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:21 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 2/7] rt-tests: cyclictest: Simplify duplicate initialization of "stop"
Date:   Thu, 14 Oct 2021 16:12:42 +0900
Message-Id: <20211014071247.4165329-3-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

The timespec structure "stop" is initialised whether it is used or not
as the compiler is not smart enough to figure out that it's use is
always guarded by the "duration" variable. As a result, "stop" needs
to be initialised whether it's used or not to avoid a compiler
warning.

Replace the duplicate memset statements by initializing "stop" using
structure initialiser.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/cyclictest/cyclictest.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0c1e6617e0e1..d06ed01c58f4 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -507,7 +507,7 @@ static void *timerthread(void *param)
 	struct sigevent sigev;
 	sigset_t sigset;
 	timer_t timer;
-	struct timespec now, next, interval, stop;
+	struct timespec now, next, interval, stop = { 0 };
 	struct itimerval itimer;
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
@@ -516,8 +516,6 @@ static void *timerthread(void *param)
 	pthread_t thread;
 	unsigned long smi_now, smi_old = 0;
 
-	memset(&stop, 0, sizeof(stop));
-
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
 		rt_numa_set_numa_run_on_node(par->node, par->cpu);
@@ -598,7 +596,6 @@ static void *timerthread(void *param)
 	tsnorm(&next);
 
 	if (duration) {
-		memset(&stop, 0, sizeof(stop)); /* grrr */
 		stop = now;
 		stop.tv_sec += duration;
 	}
-- 
2.32.0

