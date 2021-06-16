Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA64C49361
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 23:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BFAF61040
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Jun 2021 23:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhFPXU2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 19:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbhFPXU1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Jun 2021 19:20:27 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15CC06175F
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 16:18:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c9so1331243qkm.0
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Jun 2021 16:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXyOziI12E+otdM+iBT/WktnE0kZFZ+zOh/DPlYnCI8=;
        b=WdwXgIGgGwfCp8ArXVzHS0lIo6CEq01qcFrC4TINTzkknuy8ByAukZ2SfkK7ZAzIGE
         zHE0uF742Ec09YYiHaaqkzsRFs8SLav4Q6WOz2FKmWywYwKM1U5Mv5vfsMvTllrbCkLU
         i9rRt1UhhKthtMtpHcTKq/CMHNDepAsrEvhQrCcYszxrwTIq/L9BRRKLYaZ+0lmAN+Qu
         HbWVq4t4Jh3f06JeP7IAgJKghxDecKdcKMAscudBwaBgQrpTMppN3VOu3Pb+WBCraMb7
         FOrMsearE8N+Ru9CnO26SnW7yk0cryJst8Rdlzdwag6hejN7jbPhyGXQcafo/F65N+yf
         DnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BXyOziI12E+otdM+iBT/WktnE0kZFZ+zOh/DPlYnCI8=;
        b=snl5C5eA9iZHy27Kx8g3xmN2YHvI0MJNMsW07hwi4T7oN3GQjEGMBC+hFAEQFbN958
         JwehEdB15KvGmA9qlCYJormfE8jg4PpmKxzxJor/RAXD1TLs/hgdtR80OOXHe3i+HTM8
         UjgSKp5vsqZ170X1gdDE3/f4R0hBNoU/zpnsFl/arbPYcwx3ZJ4l3dQSS/7ipWiOqDy2
         v8Iq1Nk+F7l41FILuL+cHmQnxqj0y998f7bio+11TeS6wMk6b5GLVnrEozB8wP92DJe5
         HqBkJR7D631yqKMDWfVrIETQqZavwO5LamOVFj3k/AGiUa3RMYT8w+hPRObT+FqTH04D
         080A==
X-Gm-Message-State: AOAM530Pu2oddnn19j33NED5Dgqrthz3IHNuL+yLrYmNUkX4/wxXKG+4
        vWDGchpoeentGMD709tM5RQ6furiar5QIQ==
X-Google-Smtp-Source: ABdhPJz9tabNqSDoWK41DpNw5mdRQiEtt15BBeS2tcK+ArItff/CzwVxN0mpx6Slo1kIsNi1NBxKtg==
X-Received: by 2002:ae9:eb91:: with SMTP id b139mr827791qkg.135.1623885499054;
        Wed, 16 Jun 2021 16:18:19 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id bj39sm296588qkb.78.2021.06.16.16.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 16:18:18 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Jonathan Schwender <schwenderjonathan@gmail.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] Subject: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
Date:   Wed, 16 Jun 2021 19:17:59 -0400
Message-Id: <20210616231800.19228-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210616231800.19228-1-jkacur@redhat.com>
References: <20210616231800.19228-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Jonathan Schwender <schwenderjonathan@gmail.com>

This allows the user to specify a separate cpuset for the main pid,
e.g. on a housekeeping CPU.
If --mainaffinity is not specified, but --affinity is, then the
current behaviour is preserved and the main thread is bound
to the cpuset specified by --affinity

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
- Little fix-up applying patch
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index edb0c707d35c..3477cd137c15 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -837,6 +837,8 @@ static void display_help(int error)
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
 
@@ -944,8 +947,8 @@ enum option_values {
 	OPT_AFFINITY=1, OPT_BREAKTRACE, OPT_CLOCK,
 	OPT_DISTANCE, OPT_DURATION, OPT_LATENCY,
 	OPT_FIFO, OPT_HISTOGRAM, OPT_HISTOFALL, OPT_HISTFILE,
-	OPT_INTERVAL, OPT_JSON, OPT_LOOPS, OPT_MLOCKALL, OPT_REFRESH,
-	OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
+	OPT_INTERVAL, OPT_JSON, OPT_MAINAFFINITY, OPT_LOOPS, OPT_MLOCKALL,
+	OPT_REFRESH, OPT_NANOSLEEP, OPT_NSECS, OPT_OSCOPE, OPT_PRIORITY,
 	OPT_QUIET, OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION,
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRIGGER,
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
@@ -982,6 +985,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			{"json",             required_argument, NULL, OPT_JSON },
 			{"laptop",	     no_argument,	NULL, OPT_LAPTOP },
 			{"loops",            required_argument, NULL, OPT_LOOPS },
+			{"mainaffinity",     required_argument, NULL, OPT_MAINAFFINITY},
 			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
 			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
 			{"nsecs",            no_argument,       NULL, OPT_NSECS },
@@ -1086,6 +1090,16 @@ static void process_options(int argc, char *argv[], int max_cpus)
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
@@ -1802,7 +1816,9 @@ int main(int argc, char **argv)
 	}
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask != NULL) {
+	if (main_affinity_mask != NULL) {
+		set_main_thread_affinity(main_affinity_mask);
+	} else if (affinity_mask != NULL) {
 		set_main_thread_affinity(affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
-- 
2.31.1

