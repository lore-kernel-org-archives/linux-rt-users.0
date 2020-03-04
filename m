Return-Path: <SRS0=qI7K=4V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2600C3F2D8
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABAC20716
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYSPuFbJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388440AbgCDV4E (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:56:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35114 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDV4D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Mar 2020 16:56:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id v15so2638873qto.2
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Mar 2020 13:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YvNUnxeez6v2XKBQb75FCk1D6hj07Yfy/QQuzuSUQTQ=;
        b=UYSPuFbJrXX6zPxb8y/0HMq8iTPInMa1Wcv+g7UAPYOyecAMBC8b7Az1gxwxRd5e0E
         irOKNE+Pptxuk6vX99jkUmT7lEKF1qRA6WGMzs8fAhGDMgnVnF9EPfk3WL39YeVHXOlv
         woUQJlaBP1cuYYiOYNIMf2Q6HaJrTrKT5Dq6cbtARZ1yRB+4l2iSNHc8jw+MvvgfdFP3
         fhYRtMCBxtgdujgVR4hJXPDcYpyK3P3h2A5IESwRXuUQwlsr+oUQGqMa2m4MsrSxb26e
         sG9xkP5eeaK7ojO1psojG1XasNvG80JzNIf+aoIWdduNucNksIS8XBU1Z0/FavWr3k0u
         HlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YvNUnxeez6v2XKBQb75FCk1D6hj07Yfy/QQuzuSUQTQ=;
        b=oJ4tC24Jg4VatLwTQ7rNaxJXgN16GOJvHomn1a7WXpE+YZWLmiwUrcg3T2yX+/YiwB
         kSUr2xG704755kaZLvgNjpz/+rRp7O8gJxoEWauhMeEzl61c66G5eVKMIL8HlZfmpodp
         2eaodUN1lLHN30OIf3hAtgxvJJPdJLzcnyslLUWTcafW4sCDQ/LO8KqkmPyvskTVeAKa
         bF71E700Ke/ibP/8Br4BZq6fSHXstqb0XQ19PgmS79/reyOoQzUPBEM2oCvj9K8U+IHO
         MepfJ/6/oqWIyvd1CcfEggSpSfB2RQlfWURKv6oi0J2NWA/0R6aevTNnnCJqx460XCHu
         mPzg==
X-Gm-Message-State: ANhLgQ0zjrrKfsSGFl7OhYCWy5qlha7EUsV4cS9Za7JwEJ+m4laBEBTO
        DzVFRNu3u8ksFwT3TB0japrVky/opgA=
X-Google-Smtp-Source: ADFU+vu2v0UL81vf9+X50UqaSNsSIihDY/3QXF/8u9nKQDrhUjaJUZcQQyRJWJQdZHYDGZjZTMfyQQ==
X-Received: by 2002:ac8:ac1:: with SMTP id g1mr4418943qti.287.1583358961126;
        Wed, 04 Mar 2020 13:56:01 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id f5sm4899164qtq.72.2020.03.04.13.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:56:00 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/4] rt-tests: cyclictest: Fix -t without a user specified [NUM]
Date:   Wed,  4 Mar 2020 16:55:48 -0500
Message-Id: <20200304215548.13079-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304215548.13079-1-jkacur@redhat.com>
References: <20200304215548.13079-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix -t without a specified [NUM] to run the same number of threads as
available processors.

Currently it runs the same number of threads as cpus on a system.
However, if cyclictest is contrained to run on a smaller set of cpus
either because of a container or a user specified affinity or a
combination of the two, then the actual number of available cpus is
smaller. -t should reflect that.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f8df4c6954ad..c5f1fd46567a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1040,6 +1040,35 @@ static unsigned int is_cpumask_zero(const struct bitmask *mask)
 	return (rt_numa_bitmask_count(mask) == 0);
 }
 
+/* Get available cpus according to getaffinity or according to the
+ * intersection of getaffinity and the user specified affinity
+ * in the case of AFFINITY_SPECIFIED, the function has to be called
+ * after the call to parse_cpumask made in process_options()
+ */
+static int get_available_cpus(void)
+{
+	int num_cpus = 0;
+	int res;
+	pthread_t thread;
+	cpu_set_t cpuset;
+
+
+	if (affinity_mask != NULL) {
+		num_cpus = rt_numa_bitmask_count(affinity_mask);
+	} else {
+		CPU_ZERO(&cpuset);
+		thread = pthread_self();
+		res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
+		if (res != 0) {
+			fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
+		}
+		num_cpus = CPU_COUNT(&cpuset);
+	}
+
+	return num_cpus;
+
+}
+
 /* cpu_for_thread AFFINITY_SPECIFIED */
 static int cpu_for_thread_sp(int thread_num, int max_cpus)
 {
@@ -1358,7 +1387,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			if (numa)
 				fatal("numa and smp options are mutually exclusive\n");
 			smp = 1;
-			num_threads = max_cpus;
+			num_threads = -1; /* update after parsing */
 			setaffinity = AFFINITY_USEALL;
 			break;
 		case 't':
@@ -1372,7 +1401,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else if (optind<argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
-				num_threads = max_cpus;
+				num_threads = -1; /* update after parsing */
 			break;
 		case OPT_TRIGGER:
 			trigger = atoi(optarg);
@@ -1485,6 +1514,9 @@ static void process_options (int argc, char *argv[], int max_cpus)
 	if (priority < 0 || priority > 99)
 		error = 1;
 
+	if (num_threads == -1)
+		num_threads = get_available_cpus();
+
 	if (priospread && priority == 0) {
 		fprintf(stderr, "defaulting realtime priority to %d\n",
 			num_threads+1);
-- 
2.20.1

