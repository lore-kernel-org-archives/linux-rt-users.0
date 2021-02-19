Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26911C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBAB964E92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 18:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBSSs6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 13:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSSs5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 13:48:57 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3FBC061756
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:17 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id m144so6484743qke.10
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 10:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgnhYIQMPQxwiAAU1IQs8Oj0PgY8gIQvuDFaFx9DTuc=;
        b=o8QzdDGGR/qBv5aqw9JvjNoG6FZcHKAarbwIekKfnS3mg9GCfxfZFIpw3M8Req/G8L
         ZWcQIlnCUc+92/NZCHit5Abw0wTW5/7bFqhXPU/clJ7MkzRTuAa3R6WN2M/Srv42ob12
         xSRUNv+rRMQBfpUQv/FaJRLHTGbipH9AlQqUalpwk2xK3VFxkpt118fADygXqtoqzCcE
         eoiHuFd5CDjj6cKvOYqIYhoHMeklMFu9bAsIPe4X8SCx4521GHfVl/RtE0KXKfJgKXoX
         yLjodarFXYsGvD5O0D9kdalT42Q+FOtT2GGLRX0A74g/arwRURqtfTtfqL/8ebMur8MW
         hdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RgnhYIQMPQxwiAAU1IQs8Oj0PgY8gIQvuDFaFx9DTuc=;
        b=AyUVkfhw/Gz9OMalyqiDo8qPNKIMiIBRQV8+bwohmy8Zpf8mSes01E4tmLahz7tIrl
         +PmQKx3L+fopy3BgEyESZjht+kCwCgne+FRW08/VhgggBG+b07dlWfJHyERWWAOH6A7Q
         iCpKzoEXVhf3L+vPx1O80SEgp7JFHJkIwn+PaLlfgVH5rQDrCQ9eG5uAx651wCWPGmoh
         szPvxcxq2n3Mlur1CqtpitXwouQdmRMug6Kph1uWEzhPnSAPvRAAE9Q7c3orf62W/seg
         9HsFo35eP+dcWcM28laK6a1WrhP6Rnh8ihfrTQJ4na3JyvZj/EhXlRH3yCAxDeZwXJjT
         /KRA==
X-Gm-Message-State: AOAM531Lhsy1CBU8iG/u/hMoJ3frDDYiztcJ9QFkGZ3bnVwzOOb1dAaS
        2btvmUPbA8ayJxKLlKZvg1Ovv/zvq1vtFBgN
X-Google-Smtp-Source: ABdhPJwxNxA9X5YnepSWz4IUdi2fkPUpNZGw2hVmIelOgb0CHcmN87OdXzWoQKo2L9KPkuX3QB3z1Q==
X-Received: by 2002:a37:9a84:: with SMTP id c126mr10533515qke.399.1613760496274;
        Fri, 19 Feb 2021 10:48:16 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id s136sm6831647qka.106.2021.02.19.10.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 10:48:15 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Christian Eggers <ceggers@arri.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] Revert "cyclictest: Use affinity_mask for steering thread placement"
Date:   Fri, 19 Feb 2021 13:47:59 -0500
Message-Id: <20210219184801.13905-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210219184801.13905-1-jkacur@redhat.com>
References: <20210219184801.13905-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This reverts commit 8305e65092deeaf900366c6250d4b319f6c274b6.

Reverting to put back the code that allows us to run on machines
without libnuma.

However, there were some ideas in this patch that were not directly
related to that and could be revisited.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 38 ++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c3d45f3ae31b..e2753db39c02 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -892,6 +892,7 @@ static int interval = DEFAULT_INTERVAL;
 static int distance = -1;
 static struct bitmask *affinity_mask = NULL;
 static int smp = 0;
+static int setaffinity = AFFINITY_UNSPECIFIED;
 
 static int clocksources[] = {
 	CLOCK_MONOTONIC,
@@ -1019,12 +1020,22 @@ static void process_options(int argc, char *argv[], int max_cpus)
 				break;
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
+				setaffinity = AFFINITY_SPECIFIED;
 			} else if (optind < argc &&
 				   (atoi(argv[optind]) ||
 				    argv[optind][0] == '0' ||
 				    argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus, &affinity_mask);
+				setaffinity = AFFINITY_SPECIFIED;
+			} else {
+				setaffinity = AFFINITY_USEALL;
 			}
+
+			if (setaffinity == AFFINITY_SPECIFIED && !affinity_mask)
+				display_help(1);
+			if (verbose)
+				printf("Using %u cpus.\n",
+					numa_bitmask_weight(affinity_mask));
 			break;
 		case 'A':
 		case OPT_ALIGNED:
@@ -1117,6 +1128,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		case OPT_SMP: /* SMP testing */
 			smp = 1;
 			num_threads = -1; /* update after parsing */
+			setaffinity = AFFINITY_USEALL;
 			break;
 		case 't':
 		case OPT_THREADS:
@@ -1185,16 +1197,23 @@ static void process_options(int argc, char *argv[], int max_cpus)
 		use_nanosleep = MODE_CLOCK_NANOSLEEP;
 	}
 
+	/* if smp wasn't requested, test for numa automatically */
+	if (!smp) {
+		if (setaffinity == AFFINITY_UNSPECIFIED)
+			setaffinity = AFFINITY_USEALL;
+	}
+
 	if (option_affinity && smp) {
 		warn("-a ignored due to smp mode\n");
 		if (affinity_mask) {
 			numa_bitmask_free(affinity_mask);
 			affinity_mask = NULL;
 		}
+		setaffinity = AFFINITY_USEALL;
 	}
 
 	if (smi) {
-		if (affinity_mask)
+		if (setaffinity == AFFINITY_UNSPECIFIED)
 			fatal("SMI counter relies on thread affinity\n");
 
 		if (!has_smi_counter())
@@ -1777,7 +1796,7 @@ int main(int argc, char **argv)
 	}
 
 	/* Restrict the main pid to the affinity specified by the user */
-	if (affinity_mask) {
+	if (affinity_mask != NULL) {
 		int res;
 
 		errno = 0;
@@ -1940,13 +1959,18 @@ int main(int argc, char **argv)
 		if (status != 0)
 			fatal("error from pthread_attr_init for thread %d: %s\n", i, strerror(status));
 
-		if (affinity_mask)
+		switch (setaffinity) {
+		case AFFINITY_UNSPECIFIED: cpu = -1; break;
+		case AFFINITY_SPECIFIED:
 			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
-		else
+			if (verbose)
+				printf("Thread %d using cpu %d.\n", i, cpu);
+			break;
+		case AFFINITY_USEALL:
 			cpu = cpu_for_thread_ua(i, max_cpus);
-
-		if (verbose)
-			printf("Thread %d using cpu %d.\n", i, cpu);
+			break;
+		default: cpu = -1;
+		}
 
 		/* find the memory node associated with the cpu i */
 		node = rt_numa_numa_node_of_cpu(cpu);
-- 
2.26.2

