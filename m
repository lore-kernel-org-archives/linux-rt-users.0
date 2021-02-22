Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E28DC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1F364E41
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBVWIo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:08:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBVWIl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:41 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D96C06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:08:01 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id v206so14337335qkb.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wO3eIzITUtZp0XrEV67+OA3V1D7jX01HDZtKpv3Vrm4=;
        b=kLFPfGDdYl747KJafysZMEKOF+pIkuBcdFcVBb2trorjy9807QSg5bqqL7fCrzyDuQ
         PuyaKMhonf96zn4eqe8uRV4GR1sbO+kPZtVgbP/MUZfht5RY9iZFpDEh1HgYW++mdHf5
         EvAGgu8Vl9gzcHF4UWKdOckyGa9FgsNvBlXCjSvWT5F0TAO/1RLRH/Se3P/mZCqrnmlB
         BCL83RTbmkMLtwi/hpWeH+pFr0tv4RgWY1F6KEpWOxxiDJ4tu4lbrNVtLggsmJ0PyGGc
         wAGbI+kv/AilOg8ws8vM2jPm8ilDc46ZvVONENpI8edabe49O78ikEF5LlD5dd8Z5k7p
         +8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wO3eIzITUtZp0XrEV67+OA3V1D7jX01HDZtKpv3Vrm4=;
        b=QlDHgYkLGfLuyeugg+o8qmTTp4mB+5Ed6w0+raV7FVkLP/K6Le5vUboGuHCOXlzvtQ
         NpW4jIQJ7VieTObgVvwJ+uoz9UD75UlT7JxgekdADEaK78iPQl9OSJkOJVOHz3iEekvo
         wj1u9XOx57/vGt92PNbndOINVDMxd9L0zP3h+2QGDUUWwe29fUGlywyqqBolA6azvClk
         dJT/Hb/ttoLTO0QavBUn3mxbatGIvIeqqCn4FvuZBw4iiaYQ9hVGb/f6foIv4WTzab/4
         Ubmy2FIiriMkctiAmyL3z/3xbgUySU0jnrhpwogUN5e4YBQ2vmm+6aE3qwlBwMPQflR0
         6Gxg==
X-Gm-Message-State: AOAM532iI01lRoE7zhrEvK3PQ/7J50+YN0MPhv/cwdDaE61lmz0pi8SX
        FC6Lh9x4E/0ZJA9McrxsoIpQ+GNHirFvwbIO
X-Google-Smtp-Source: ABdhPJxMKP13Jn9W7iTBGw/NHAC6r9TqniPpj6TSq+K4mVSXxNlRLOirWMrTBfDmsN2OFTtGieNVlQ==
X-Received: by 2002:a05:620a:21c9:: with SMTP id h9mr3517323qka.481.1614031680198;
        Mon, 22 Feb 2021 14:08:00 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o5sm13278352qkh.59.2021.02.22.14.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 14:07:59 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: Don't assume numa is available at runtime
Date:   Mon, 22 Feb 2021 17:07:49 -0500
Message-Id: <20210222220750.12911-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210222220750.12911-1-jkacur@redhat.com>
References: <20210222220750.12911-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Rework numa_initialize a bit to return the status of numa
- Don't fail if numa is not available after the call to numa_initialize

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c |  8 ++------
 src/lib/rt-numa.c           | 17 +++++++++++------
 src/signaltest/signaltest.c |  8 ++------
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3e31937f7088..157047837259 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1018,9 +1018,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
-			if (numa_initialize())
-				fatal("Couldn't initialize libnuma");
-			numa = 1;
+			numa = numa_initialize();
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -1204,9 +1202,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
-		if (numa_initialize())
-			fatal("Couldn't initialize libnuma");
-		numa = 1;
+		numa = numa_initialize();
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
 	}
diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
index dbeaef696876..babcc634d57e 100644
--- a/src/lib/rt-numa.c
+++ b/src/lib/rt-numa.c
@@ -13,19 +13,24 @@
 #include "rt-error.h"
 #include "rt-numa.h"
 
-/* numa_available() must be called before any other calls to the numa library */
+/*
+ * numa_available() must be called before any other calls to the numa library
+ * returns 0 if numa is available, or 1 if numa is not available
+ */
 int numa_initialize(void)
 {
-	static int is_initialized;
+	static int is_initialized;	// Only call numa_available once
+	static int numa;
 
 	if (is_initialized == 1)
-		return 0;
+		return numa;
 
-	if (numa_available() == -1)
-		return -1;
+	if (numa_available() != -1)
+		numa = 1;
 
 	is_initialized = 1;
-	return 0;
+
+	return numa;
 }
 
 int get_available_cpus(struct bitmask *cpumask)
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 4f8e7caea2c1..b1a7e1db8302 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -253,9 +253,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 			/* smp sets AFFINITY_USEALL in OPT_SMP */
 			if (smp)
 				break;
-			if (numa_initialize())
-				fatal("Couldn't initialize libnuma");
-			numa = 1;
+			numa = numa_initialize();
 			if (optarg) {
 				parse_cpumask(optarg, max_cpus, &affinity_mask);
 				setaffinity = AFFINITY_SPECIFIED;
@@ -339,9 +337,7 @@ static void process_options(int argc, char *argv[], unsigned int max_cpus)
 
 	/* if smp wasn't requested, test for numa automatically */
 	if (!smp) {
-		if (numa_initialize())
-			fatal("Couldn't initialize libnuma");
-		numa = 1;
+		numa = numa_initialize();
 		if (setaffinity == AFFINITY_UNSPECIFIED)
 			setaffinity = AFFINITY_USEALL;
 	}
-- 
2.26.2

