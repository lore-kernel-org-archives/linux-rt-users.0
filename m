Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C9BC433E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 13:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D727064D9A
	for <linux-rt-users@archiver.kernel.org>; Tue, 23 Feb 2021 13:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhBWNzv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 23 Feb 2021 08:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhBWNzi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 23 Feb 2021 08:55:38 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895E2C061786
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2021 05:54:58 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id k13so32829835ejs.10
        for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2021 05:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cNs41YSSK/W5h6wt2jd73rmLp1dPJSMHUNlRfjJpemI=;
        b=hHArW20MR3cnJ6/REVxN4XN7Ki4Yr/M6PE5iYnCCsUaa8peQrarS0Usw/eYTZ2m969
         s4KWv/JbzvmXdjMucYn+6HyjKGX1W639RqpLhGlb9AwVEXzhO/1H285eGVr4yV4OxoFF
         2Ez65Y1nG1tqjZDtLOvE8X5liZzXs/2LKxWpBYFgR1lX55p0+ISqkNlDekiWNhEkyHWY
         LwtHvDbKHZNuq4RLWnqf/3NPtynhPkR5U8icoBueQ0O+9r0m2TqszLYnmPjhgSqGe752
         0GlL1rPbp1Q7xLHjLqiWJa4cSlfhCYoIG3l7jgO8MtgsRALxMO2BP5mDWwfsZ8MKd5Oy
         +o5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNs41YSSK/W5h6wt2jd73rmLp1dPJSMHUNlRfjJpemI=;
        b=pYsIjiaKQWOzcoyqSKJLYojJc76tBxx3s1BhPTHptonUls36rOzt29gL7qf4ypGave
         FV4qx0QL5Rw/XhNmKfDgL7dNX6N1L5jbIJoH1ttjqWoEsZ5zKN04QAzkOI9By/fqGPFF
         3gUFIE35sw0uuASpM/zR02smvYDSZ+vXzQm7tkput0Wbd/uI51muDODND3La261DQ660
         q0TfeRyzzysjSENhEQXFBJ/Gi9ajbUBj8jNi6UylZro8l+ozP4SDQTePrlypYbHAy07r
         c39kots+hgnGRoR3RRF/j/h1JjB4aN8oImLI+J/sGQMc+QLqvlNhS98j1ua8C2lks3GG
         d2ng==
X-Gm-Message-State: AOAM533K8a8vt9l93hWLOg0IQhahBdmQZXCPEoMhNYMUlQLzkwpx49ZH
        7FupkNDdcKfQYN2Dtp3gWFk=
X-Google-Smtp-Source: ABdhPJzhdzAJnajPr6WnQXdEhSOG6XIU/nSJqs/z2kE7PIqtER4J090UGTm7PPtUiBI/G6fHR6QW5w==
X-Received: by 2002:a17:906:4045:: with SMTP id y5mr26518622ejj.529.1614088497242;
        Tue, 23 Feb 2021 05:54:57 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6883-f900-4d8f-ff61-45e1-6480.c23.pool.telefonica.de. [2a01:c23:6883:f900:4d8f:ff61:45e1:6480])
        by smtp.gmail.com with ESMTPSA id z13sm14447509edc.73.2021.02.23.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 05:54:56 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v2 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
Date:   Tue, 23 Feb 2021 14:54:46 +0100
Message-Id: <20210223135446.7201-3-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223135446.7201-1-schwenderjonathan@gmail.com>
References: <20210223135446.7201-1-schwenderjonathan@gmail.com>
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
index 9d8eca8..3ce934d 100644
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
 
 static int clocksources[] = {
@@ -943,7 +946,7 @@ enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
 	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
+	OPT_INTERVAL, OPT_LOOPS, OPT_MAINAFFINITY, OPT_MLOCKALL, OPT_REFRESH,
 	OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
@@ -980,6 +983,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"interval",         required_argument, NULL, OPT_INTERVAL },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
 			{"loops",            required_argument, NULL, OPT_LOOPS },
+			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
 			{"nsecs",            no_argument,       NULL, OPT_NSECS },
@@ -1071,6 +1075,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
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
@@ -1777,7 +1791,9 @@ int main(int argc, char **argv)
 	}
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask) {
+	if (main_affinity_mask) {
+		try_numa_sched_setaffinity(getpid(), main_affinity_mask);
+	} else if (affinity_mask) {
 		try_numa_sched_setaffinity(getpid(), affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
-- 
2.29.2

