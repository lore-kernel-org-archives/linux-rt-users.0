Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFA3C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE6864E38
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 04:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhBKEnR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 23:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhBKEnQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 23:43:16 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540F6C061574
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:42:36 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id 2so2035605qvd.0
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 20:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PBORf77O83pT3K2X/3oNiLqGb3lYRHJ+1E8osyJYAaw=;
        b=DmVF9Wad7gXOO8hYfuZ9hHRrilVLBuhEFzyZvbr720cjkRozKG8Z5eTtCdhD1YkcRw
         kBKz+KCsEvvQ30QUWPYlmNvnIHpLW14kGk2fEncm8C2QcDHlSmZEd4Bm0BUhhihiqETE
         sP8IgwjyhNKsA2Xh0IfeDdgHYTDOl4AbZa607pa2dieSRvxX1Lit62rdzVR9IWJ73bpL
         ljv1MtbBpiusNWYF5VzT+WH5AuqU0pV93dtMzRJ3prBQM2qb+1q6gka0xYacOdt58sV6
         4/ht9XbEv7cIsN2zpcbg8AlcCrRXIiSIuGy2eNHIsl0kTUHn8xtJuD7qc/SE2yo+7g5C
         T+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PBORf77O83pT3K2X/3oNiLqGb3lYRHJ+1E8osyJYAaw=;
        b=ZspdZ1kNhT28UXleBgFthY93PszV1Be+LNKoqfDJ9lc0LiFDIPGxy0IAyyWyQ6D0Cx
         X3QbJrnxfSok+Opg02KdTkOKA7RZhnVPxWpX43Ax36OY9gkjH50fVGoT6yAxYYd+b4/j
         o7l9hEPczl8JR00u2xBgdGBYX+kfbR0MMp/yYPCJs7oKdfhYi3q26AbJ1E8lj/p5wji1
         iTl6CU3HsaSWnG6e8Juf/wUfwNjRDlOloSoRlm+6BPjQtOJ8D0ZOFZLqnSPGtNMLAJ37
         7UAX1puFT7sEA1KZtheyziJNBSZC83NbdumiihFl7p6zXy2zVgeC8gWLG0ztTXx7E5bj
         Eccg==
X-Gm-Message-State: AOAM5324g2jP1bG3lQMlY66d42f5qCXUv6K+USQZSsUyv/ynlUIEHIbn
        WklwB+2JL5Zzc5lkVAzhHnJDZOtcp3+v2A==
X-Google-Smtp-Source: ABdhPJx6k8CQ1ZF/o9xMmA+ezPow0+cz/g5zN8Qf16OHBEHOK8GoTFjSb/HVd7YwD4pGioGzk7etYw==
X-Received: by 2002:ad4:48c8:: with SMTP id v8mr5906778qvx.38.1613018555381;
        Wed, 10 Feb 2021 20:42:35 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id v30sm2746178qte.26.2021.02.10.20.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 20:42:35 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        "Reported-by : Peter Xu" <peterx@redhat.com>
Subject: [PATCH] rt-tests: oslat: print version string
Date:   Wed, 10 Feb 2021 23:42:21 -0500
Message-Id: <20210211044221.27851-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

During the streamlining of the command line options something went awry
with the version. The author of oslat wishes to always print the version
string. This allows us to just exit in the case of -v

Fixes e411219d27b1

Reported-by: Pradipta Kumar Sahoo <psahoo@redhat.com>
Reported-by: Reported-by: Peter Xu <peterx@redhat.com>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/oslat/oslat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 5b7e0d5b5d5c..7826c277f26d 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -512,7 +512,6 @@ static void handle_alarm(int code)
 
 static void usage(int error)
 {
-	printf("oslat V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "oslat <options>\n\n"
 	       "This is an OS latency detector by running busy loops on specified cores.\n"
@@ -657,8 +656,8 @@ static void parse_options(int argc, char *argv[])
 			break;
 		case 'v':
 			/*
-			 * Because we always dump the version even before parsing options,
-			 * what we need to do is to quit..
+			 * We always print the version before parsing options
+			 * so just exit
 			 */
 			exit(0);
 			break;
@@ -736,7 +735,7 @@ int main(int argc, char *argv[])
 	g.workload_mem_size = WORKLOAD_MEM_SIZE;
 	/* Run the main thread on cpu0 by default */
 	g.cpu_main_thread = 0;
-
+	printf("oslat V %1.2f\n", VERSION);
 	parse_options(argc, argv);
 
 	TEST(mlockall(MCL_CURRENT | MCL_FUTURE) == 0);
-- 
2.26.2

