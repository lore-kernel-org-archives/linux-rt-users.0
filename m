Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68018C433DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A30661A3C
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 20:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhCYUSr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 16:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbhCYUSn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 16:18:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C24C06174A
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 13:18:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k10so5079325ejg.0
        for <linux-rt-users@vger.kernel.org>; Thu, 25 Mar 2021 13:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=361cTzTlXGtqwtD9HEXGlyvaBQSMBaGJIBz68d1QHCk=;
        b=SCF8EppTIjUvO7Eru/WmW9KoiBJnDt/YvUdzz8q75rBUnXlPq3wWlVgWkP2RLAol0g
         6/1Wi+xq1h5wX9ylGryNKJWk2Akqj9Cf2TiU5F49e8X3qHcK09lhYZJGmdGfZZZ870Zq
         T4i5P6zXQVhDoxvUPzDdO4A4TwT/uf7uTvHVreMtjrdLy8ro3vYDW/c9elN/hsZSLvo6
         fyglzR8lKYvtBq0FECYx8TBVbk11XhGShxhgxD6L7gh8KQUQoAxUlQbGBCQytdWzeM2+
         h2QmXeya6lA+Y9jOlq+n3zsZmG9SuYljARs10hLE6nUOHBzHVuPAplDNtMeJA7URsyx+
         UXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=361cTzTlXGtqwtD9HEXGlyvaBQSMBaGJIBz68d1QHCk=;
        b=RNkcp/4xdR7UqZIyXO0ovRRzXnIdLDlMTSMSLA51yUSVW2lBwSMcvOUxovuE9nKPTK
         AOUs3lz1f6BdqxmEPVS5E7UuxnVi0rM5E1GfUlCIltdhvmWD8z1LZraxXxJBmiE+kgXB
         Fa+/uu4vRnhsi8hiiyM2cx/f+ZvvzaE6oL7pEkcGzX0nxIDZ4eO4BUsequXqGfNW6NKz
         Wwon3c7K897q+UL/Iywr9MvyYX6gzPBhfUFuOCI/GEfidL9vtBhvfSJFOrUFsqFcQDU8
         JnSylK75cIteJxLQseroWB694nTEue3USph/5XFgkdCZLIlIsB25KiCrrAW4E10nfA7N
         NRQQ==
X-Gm-Message-State: AOAM530mnSNyTfSiMF7/qSIVlZs/SKBr4JDsoY7KXxN2qqEJPmh/9mVw
        /O1HO55esOZbBP8HWjrqQDo=
X-Google-Smtp-Source: ABdhPJwBrX/k0pOQKJhRN9NBrcakSFkCQ0lZfu/DRXQXIUhmspG1UZabSysVPiXfvcNs9gV1Fx8Rog==
X-Received: by 2002:a17:907:1692:: with SMTP id hc18mr11407323ejc.265.1616703521372;
        Thu, 25 Mar 2021 13:18:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c47-0000-17ef-d1e1-78a0-d19c.c23.pool.telefonica.de. [2a01:c23:6c47:0:17ef:d1e1:78a0:d19c])
        by smtp.gmail.com with ESMTPSA id a22sm3135406edu.14.2021.03.25.13.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 13:18:40 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v3 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
Date:   Thu, 25 Mar 2021 21:18:37 +0100
Message-Id: <effbc35dba96b6c59b30ad9d629038ee325adf04.1616702706.git.schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616702706.git.schwenderjonathan@gmail.com>
References: <cover.1616702706.git.schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This allows the user to specify a separate cpuset for the main pid,
e.g. on a housekeeping CPU.
If --mainaffinity is not specified, but --affinity is, then the
current behaviour is preserved and the main pid is bound
to the cpuset specified by --affinity

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 src/cyclictest/cyclictest.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 460f6ae..b7ca8de 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -836,6 +836,8 @@ static void display_help(int error)
 	       "	 --laptop	   Save battery when running cyclictest\n"
 	       "			   This will give you poorer realtime results\n"
 	       "			   but will not drain your battery so quickly\n"
+	       "         --mainaffinity=[CPUSET]  Run the main thread on CPU #N. This only affects\n"
+	       "                           the main thread and not the measurement threads\n"
 	       "-m       --mlockall        lock current and future memory allocations\n"
 	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
 	       "			   latency is hit. Useful for low bandwidth.\n"
@@ -891,6 +893,7 @@ static int quiet;
 static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
 static struct bitmask *affinity_mask = NULL;
+static struct bitmask *main_affinity_mask = NULL;
 static int smp = 0;
 static int setaffinity = AFFINITY_UNSPECIFIED;
 
@@ -944,7 +947,7 @@ enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
 	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
+	OPT_INTERVAL, OPT_LOOPS, OPT_MAINAFFINITY, OPT_MLOCKALL, OPT_REFRESH,
 	OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
@@ -981,6 +984,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"interval",         required_argument, NULL, OPT_INTERVAL },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
 			{"loops",            required_argument, NULL, OPT_LOOPS },
+			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
 			{"nsecs",            no_argument,       NULL, OPT_NSECS },
@@ -1083,6 +1087,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case 'l':
 		case OPT_LOOPS:
 			max_cycles = atoi(optarg); break;
+		case OPT_MAINAFFINITY:
+			if (optarg) {
+				parse_cpumask(optarg, max_cpus, &main_affinity_mask);
+			} else if (optind < argc &&
+			           (atoi(argv[optind]) ||
+			            argv[optind][0] == '0' ||
+			            argv[optind][0] == '!')) {
+				parse_cpumask(argv[optind], max_cpus, &main_affinity_mask);
+			}
+			break;
 		case 'm':
 		case OPT_MLOCKALL:
 			lockall = 1; break;
@@ -1790,7 +1804,9 @@ int main(int argc, char **argv)
 	}
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask != NULL) {
+	if (main_affinity_mask != NULL) {
+		try_numa_sched_setaffinity(getpid(), main_affinity_mask);
+	} else if (affinity_mask != NULL) {
 		try_numa_sched_setaffinity(getpid(), affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
-- 
2.30.2

