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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B9C43381
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CA764E76
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 15:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhBVPbE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhBVPaY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 10:30:24 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B06C06178B
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:41 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jt13so30126654ejb.0
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 07:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3ddTj6CDwWCKK2+WXm7UsicHVTh123Pf0UUIsUfUSo=;
        b=m6VgYC9/NeDt31+cBGkTqGVf9YbRaqEqewNxRKeCcYUrGX4utZE+uEAqbmeXo3ZXGE
         asn5svnILgK1mJq8NeTfNOSXVSTmKtmZJQEUbwlhwG2hUmttbRQDpLwgrSZg5w7nRDTw
         qvwoA5w51ZokAm+BlV55fruG+YGyb7bGbNLQc5P8U4Qm+Wntkh2E0RnWusGaibYYuwcf
         a+wA04fZHKwPeQqqVAO3ND7JHsbuTMgL6HUIMnWai0zd1jMu8Pm98XOr7UtbjSwrxibS
         vAvaIqmPYwFNAF+Lpg0EyJn6EBQ7MgqAtuvYjAl8cauMCF3z9Vh54JUH1/m1f6LV8Bj2
         92QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3ddTj6CDwWCKK2+WXm7UsicHVTh123Pf0UUIsUfUSo=;
        b=AKp+BmGr3cw6+iLsXU8LXCt1QQka0m33XVBnhvgfdQWEgjkiL2D63gG/tMu+Lg185D
         w1pjien8s+zhWkyXXw+ZIPJlUaIPfvfUwxjDm8maHudVtkUOTeQbEO9BiJ9foefiMcpT
         Zv02kHH/X65IyMJI3aWcMKpVTDgg2PJbtQiZ/gtl9aIPDdUoSTJ6M3Djf8t08E2qrLMZ
         DKtAJ2owABpuw/2YAE17Fb98G3WZd2pZuTTqeYftPyFCt5GuL+XNaxBDVeL+Ixu/FJ6C
         ky+ktsqp0H4z9J8o5gyDcL5Fw1pZMuH73L54UkCz2A1qQwkusUttBFiPKLxbEQ4yzn0t
         9bLw==
X-Gm-Message-State: AOAM533DRJmAS/J0DbLv0PXfPb9SQAh7GAm3iUP8i97dN6ZVi+RPMu4O
        tL/MKLfWdd0uyU9aS2P1QGc=
X-Google-Smtp-Source: ABdhPJx2tW/5t+xSNMs97hOD9cQbMcxzBJg8Uz5LyTq735H24Esx3/HGhzJf3Op64dHEQoOaoLldgA==
X-Received: by 2002:a17:906:3850:: with SMTP id w16mr21885830ejc.286.1614007780238;
        Mon, 22 Feb 2021 07:29:40 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-6c04-5000-dab0-26a8-91ef-23f9.c23.pool.telefonica.de. [2a01:c23:6c04:5000:dab0:26a8:91ef:23f9])
        by smtp.gmail.com with ESMTPSA id bw22sm10657116ejb.78.2021.02.22.07.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:29:39 -0800 (PST)
From:   Jonathan Schwender <schwenderjonathan@gmail.com>
To:     jkacur@redhat.com, williams@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: [PATCH 2/2] cyclictest: Add --mainaffinity=[CPUSET] option.
Date:   Mon, 22 Feb 2021 16:28:33 +0100
Message-Id: <20210222152833.8758-4-schwenderjonathan@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210222152833.8758-1-schwenderjonathan@gmail.com>
References: <20210222152833.8758-1-schwenderjonathan@gmail.com>
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
 src/cyclictest/cyclictest.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3cd592d..803d19a 100644
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
@@ -1787,7 +1801,10 @@ int main(int argc, char **argv)
 	}
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask) {
+	if (main_affinity_mask){
+		set_main_thread_affinity(main_affinity_mask);
+	}
+	else if (affinity_mask) {
 		set_main_thread_affinity(affinity_mask);
 		if (verbose)
 			printf("Using %u cpus.\n",
-- 
2.29.2

