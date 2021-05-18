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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6549DC433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 May 2021 08:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FF50610CB
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 May 2021 08:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242819AbhERIil (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 May 2021 04:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbhERIii (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 May 2021 04:38:38 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503ACC061573
        for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2021 01:37:19 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so992683wmn.2
        for <linux-rt-users@vger.kernel.org>; Tue, 18 May 2021 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ce+QGmNQ39f8GFGfkhA1CUlBrvkvfybR7RY5pq/wL80=;
        b=JKOn4vaJDk8evFXmz2N6Mr9FXTmmEX+kIQ1eDUZUypESnVy9gigLKc4jsrd1k+Z7La
         s+Juf30luEyNDX93/5pec9CwP+1v6wlOQssjAmPR1Nstz4UtNojP3G8S1X08UXBBiUMg
         e7F+n/TH0/VMPk4QIkbeH4bWVB2a2WsV5IWnmXM9Ypr1rgyaxnwO/LKScw9JU2U4yFkT
         Fz8EF9iQJBKHv8ragarp/pQ9V7M9q/nbiLKJ9oPCLpPnqS2OU6x68EMq+Nw4ykqQV15m
         P7hIaibFl/sTh0lGAh/7k9bDPSkVpROaR4k7caWK3Vd7UJ6bUcD+oesSvNxNZrTCK3pF
         9yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ce+QGmNQ39f8GFGfkhA1CUlBrvkvfybR7RY5pq/wL80=;
        b=j4ff8J3ddtmLSbRKbbWRM3P5cX7MpL9bRxu3Jjwqu8K4kQrwxOMs2eHOreaeUJCawP
         IsDgHhqf5YTLx6zMMAiS+o1PFJpEAKE7L7cK8/hqjR9zlj92JxLJCfTs5+pHSGuNNskX
         7aEiYBaMmQto7Dc7LehYcya6zC9hpewzSiPua5SXi7tyUn55GbuS2jcYKXc7crPHuz7S
         lZwpnpKAaTlt8Qnqg4boyexNsG1Io9QzPTqcJunQ5GUUoNqNH69bawToNkLfYECbUgCQ
         pVV+26+62yblDAKgZ2c/0HmKQhjH1II13veeBk8PIjjZFRENPOImG9ot4XTO3yAWhvCE
         dQnw==
X-Gm-Message-State: AOAM531WmDMsx06Gik/h7ij+hT5I6fChQozHDiSWNyq+LSv7E9aJEavZ
        nCXwRqDxvDokteHNHYs7fns=
X-Google-Smtp-Source: ABdhPJzrN6wi3ybzKtaqeMq+sy6UuY7VYdRXbM0JH4JA5mZ+/cSXd7E8Gecu8F+YHjaysCRJHPzVNA==
X-Received: by 2002:a1c:c309:: with SMTP id t9mr3609724wmf.161.1621327038036;
        Tue, 18 May 2021 01:37:18 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c56-8d00-e863-f49d-2f62-8043.c23.pool.telefonica.de. [2a01:c23:6c56:8d00:e863:f49d:2f62:8043])
        by smtp.gmail.com with ESMTPSA id c14sm20439407wrt.77.2021.05.18.01.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 01:37:16 -0700 (PDT)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH v4 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
Date:   Tue, 18 May 2021 10:37:12 +0200
Message-Id: <20210518083712.8237-3-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518083712.8237-1-schwenderjonathan@gmail.com>
References: <20210518083712.8237-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This allows the user to specify a separate cpuset for the main pid,
e.g. on a housekeeping CPU.
If --mainaffinity is not specified, but --affinity is, then the
current behaviour is preserved and the main thread is bound
to the cpuset specified by --affinity

Signed-off-by: Jonathan Schwender <schwenderjonathan@gmail.com>
---
 src/cyclictest/cyclictest.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3bab3b2..a2103c7 100644
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

