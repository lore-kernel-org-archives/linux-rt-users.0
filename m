Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABEC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A913164E92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBSStA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbhBSSs7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 13:48:59 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FE7C06178A
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:18 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id q85so6504937qke.8
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcFhlT+fPiCFHLN3NGgRPm6WFJQlwU4WvRTGNRYPLFk=;
        b=f9bXoWYa2S97Zb7IPhsBs9GqgrUA9BG3iW4NQeI0xsetgyXpwu2Z4ylcOPz4XHenKm
         xgY3KCrZl6Rwi+nf26angwCc6vdMbfFP8Bz4YPtBYVe5Nc+iSbsNk8GaerhEOWLB2Cmm
         4ROLJWZtmZFFQQ2rVAwVoQBXa/jzStDIKdc28ByTT6mVYlJJ4DO/DBsIz0+RKV3e/rmL
         DG3q40i3zlwiZfId/MIWFCoCfjfkXcrIDKn/TekbFhG5rLTlMphiEg+Ys0PHuKWUHaCQ
         y21hjrYj0gT2gncRcR51hGwx4BTQbXZMoEjxoY4Mra/FsSAwCXqmsJBDXh6HbS8iOkJx
         O6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YcFhlT+fPiCFHLN3NGgRPm6WFJQlwU4WvRTGNRYPLFk=;
        b=NteC/YKKYEVd8JLQ6C18khhSqlG0/f5X6Cg4JFMifAC+vXZlJCnPWEfg4sIo8VDAyA
         PHHAkfuQSceGQHor6SYDVHwMRPX7o1nwKwrmv6mhF9VlBSAprRXXvze5HUg4gtUBsyxD
         UC943B7IqCGpbokEBQXIb/gG16gCnxMkgVGgCeqkPqSfyOs3vUhJj12h/nuR4ACxiIix
         UeCIeQSOl5G0LsE2NytDjEfpH9k4bBV+VW9ffR4/BFQ8kP/ZY3LZ3Xhx8A8jQLQjeLVY
         rycCc1LTtGMkmDjslgxjrWPej5lq2lN0jhbWaHvov/j0AjwOmSRVxeSpE5MsbeDDBXfd
         zrQQ==
X-Gm-Message-State: AOAM532ciXfpZFefHbs/OYJPY0S3VKJcYTR6wNJs0+aiw5A21EWppMlf
        Bssa4FMvwQ1GDcuCAGhEEm0XEEbcLhla9dyk
X-Google-Smtp-Source: ABdhPJwkNdQTCzitMyYtyetbuxFpJbVmHod4wfedLV9elIcIv87CBO60lGMu9q4ebLKjLIM2LrNHqg==
X-Received: by 2002:a05:620a:98d:: with SMTP id x13mr10826278qkx.432.1613760498072;
        Fri, 19 Feb 2021 10:48:18 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id s136sm6831647qka.106.2021.02.19.10.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:48:17 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Christian Eggers <ceggers@arri.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] Revert "signaltest: Always use libnuma"
Date:   Fri, 19 Feb 2021 13:48:01 -0500
Message-Id: <20210219184801.13905-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210219184801.13905-1-jkacur@redhat.com>
References: <20210219184801.13905-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This reverts commit 3079f1b10d086b878f52607035b328f450b8033e.

libnuma is a build-time requirement but not a runtime requirement

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/signaltest/signaltest.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 1d1b070cf12b..4f8e7caea2c1 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -207,6 +207,7 @@ static int quiet;
 static int lockall;
 static struct bitmask *affinity_mask = NULL;
 static int smp = 0;
+static int numa = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
 static char outfile[MAX_PATH];
 
@@ -222,7 +223,6 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 {
 	int option_affinity = 0;
 	int error = 0;
-	int numa = 0;
 
 	for (;;) {
 		int option_index = 0;
@@ -253,6 +253,8 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
+			if (numa_initialize())
+				fatal("Couldn't initialize libnuma");
 			numa = 1;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
@@ -337,6 +339,9 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
+		if (numa_initialize())
+			fatal("Couldn't initialize libnuma");
+		numa = 1;
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
 	}
@@ -412,9 +417,6 @@ int main(int argc, char **argv)
 	int status, cpu;
 	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 
-	if (numa_initialize())
-		fatal("Couldn't initialize libnuma");
-
 	process_options(argc, argv, max_cpus);
 
 	if (check_privs())
-- 
2.26.2

