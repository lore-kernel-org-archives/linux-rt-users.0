Return-Path: <SRS0=nn6j=3M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78766C33CB8
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 486C920684
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Jan 2020 20:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVuGFDLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbgAWUup (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Jan 2020 15:50:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43948 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729327AbgAWUuo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Jan 2020 15:50:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id j20so4873119qka.10
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jan 2020 12:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bgpDKLQpWTiMfc6oaiwgz5xzOsjriaH7vbdkmXLcbHs=;
        b=bVuGFDLpfssJu9MRMJ2EFVPWN5ErIRHLcX9lhyVHNQD+HCapRzcyirD4/J22fXDafQ
         fHLUY+OnBK7s1OvTubAxhAOI9qrj/Fwh7+V4i9cfRop7FIyPbwp72NqhR0Ul0fQs1c2E
         WHLj4tWGXGqubt8oZW2k55Qoq1s4bcVhqBI4UHGEoxw2WLp14WC6OJbGbprjHBWcmYBi
         rzW16G4ymM9HpnKv7Kh74foGL0b9y2FDKNzQPiQIEIjyzGWHJ2rHAVnUTdM5kw/hoLPN
         6UtZYMxMJJqsHuv+adeOHg0S0XKf93tIDg7eqGkItXtf5S+DN5mgD4OWKzbbUfh6HCfu
         Yx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bgpDKLQpWTiMfc6oaiwgz5xzOsjriaH7vbdkmXLcbHs=;
        b=qLhrBTOKd+Pvwhx6G9vpkhhFh19F3iyEAwsDy1bqHB2erfAosHuRJ9CBXL1bdm+TqJ
         CpAMA2U7AHDfcYWxSUXzIMXXJWf7MTaHt6mDeb8EJX3b9AugJUgMYP9fWPBqxFuFTC0u
         2nT/9azzkwfS2fi+XoYCxG3DUTi0nyR6gv8O7oLCrGDBemKIa41w4cKRoxjTyqDDZtFs
         qr59xFXH7zZAauGSDUhbPt+78FEyuG5i/lz4E0OUJsCvYn76j9+uHl0JvpnE5+KjfSuI
         /fM73yiV/YhmcaE72yXk4YVLpvNmV7L3tfatn25Pv7+HYrxdtvaCNzwiYal2Z2iVzhPq
         DJVw==
X-Gm-Message-State: APjAAAVuGRPGp5kozodA6cBxeiZY9I9I2wl/MlZtkNdOi2kRE4NFm4gR
        4Sr3RbhFa8cuolK25IV6hsrZTWGkVGc=
X-Google-Smtp-Source: APXvYqxEu2wX9u6TrFwEkMEwUpsqoawmOZ9yb23ZSdiT1ruAcW7A8oygGULQv5KpKc7W54bzK8gyZw==
X-Received: by 2002:a37:27cc:: with SMTP id n195mr30955qkn.428.1579812643604;
        Thu, 23 Jan 2020 12:50:43 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id j185sm1518346qkc.96.2020.01.23.12.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 12:50:43 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/9] rt-tests: pi_stress: Add short options to usage message
Date:   Thu, 23 Jan 2020 21:50:23 +0100
Message-Id: <20200123205029.20176-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add short options to usage message. Note, the options all ready exist,
they simply were not documented in the usage message.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 7fa98dfb9ad4..0ed844c636cd 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1008,29 +1008,25 @@ void *high_priority(void *arg)
 
 void usage(void)
 {
-	printf("usage: pi_stress <options>\n");
-	printf("    options:\n");
-	printf("\t--verbose\t- lots of output\n");
-	printf("\t--quiet\t\t- suppress running output\n");
-	printf
-	    ("\t--duration=<n>\t- length of the test run in seconds [infinite]\n");
-	printf("\t\t\t  Append 'm', 'h', or 'd' to specify minutes, hours or days.\n");
-	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
+	printf("usage: pi_stress <options>\n\n");
+	printf("-v\t--verbose\t- lots of output\n");
+	printf("-q\t--quiet\t\t- suppress running output\n");
+	printf ("-D TIME\t--duration=TIME\n\t\t\t- length of test run in seconds (default is infinite)\n");
+	printf("\t\t\t  Append 'm', 'h', or 'd'\n\t\t\t  to specify minutes, hours or days.\n");
+	printf("-g\t--groups=<n>\t- set the number of inversion groups [%d]\n",
 	       ngroups);
-	printf
-	    ("\t--inversions=<n>- number of inversions per group [infinite]\n");
-	printf("\t--rr\t\t- use SCHED_RR for test threads [SCHED_FIFO]\n");
-	printf("\t--sched\t\t- scheduling options per thread type:\n");
+	printf ("-i INVERSIONS\t\t--inversions=INVERSIONS\n\t\t\t  number of inversions per group (default is infinite)\n");
+	printf("-r\t--rr\t\t- use SCHED_RR for test threads [SCHED_FIFO]\n");
+	printf("-s SCHED_OPTS\t--sched\t\t- scheduling options per thread type:\n");
 	printf("\t\tid=[high|med|low]\t\t\t- select thread\n");
 	printf("\t\t,policy=[fifo,rr],priority=<n>\t\t- SCHED_FIFO or SCHED_RR\n");
 	printf("\t\t,policy=deadline,runtime=<n>,deadline=<n>,period=<n>\t- SCHED_DEADLINE\n");
-	printf("\t--prompt\t- prompt before starting the test\n");
-	printf
-	    ("\t--uniprocessor\t- force all threads to run on one processor\n");
-	printf("\t--mlockall\t- lock current and future memory\n");
-	printf("\t--debug\t\t- turn on debug prints\n");
-	printf("\t--version\t- print version number on output\n");
-	printf("\t--help\t\t- print this message\n");
+	printf("-p\t--prompt\t- prompt before starting the test\n");
+	printf ("-u\t--uniprocessor\t- force all threads to run on one processor\n");
+	printf("-m\t--mlockall\t- lock current and future memory\n");
+	printf("-d\t--debug\t\t- turn on debug prints\n");
+	printf("-V\t--version\t- print version number on output\n");
+	printf("-h\t--help\t\t- print this message\n");
 }
 
 /* block all signals (called from main) */
-- 
2.20.1

