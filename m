Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EF6C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99ABD61166
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhJNHPo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhJNHPn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78602C061570
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c29so4674323pfp.2
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQK9XpxHwCvtcoZ1eQtz3fvQKXpIJgtjc24fInhtpnU=;
        b=FoXAF1zEk1WJ8DcdV64s93/MIw2saK7u/9p+xCjTIHl7gybKqYsLdg+xK2NEhGhPCl
         y353BKVZS/ZOTTFsQbe+Q1jbAhqAuDr5Oo4Y9hp/dF62LEh229TFDnjdAzD8cV/c2FBe
         3/0cf95UaOtaGez0CLwMM/orGthp4EU5qp1s1gOmzI0zm5eEOa6qSiaQwSsWfXH0fVAJ
         Fl8TNOtiReTByNbF44NiiEeXce1qSgkVud9KgRYxoPdqe4+2srCc4WApgsGeNtFX7oXU
         h0yI5jlUHmcHFj0RabVDobe4+kSnJdyz0fxVza3EkcvDJQ13QTRpjPs2cyiLtK4+rhhE
         1MRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQK9XpxHwCvtcoZ1eQtz3fvQKXpIJgtjc24fInhtpnU=;
        b=ny//TDla6pttT2BJIXC2Z+Ype+tGTD5Ov0qxpBEax3vPJSNZo2JElsOjVbwvKKbdPI
         c12UkRDOoCmH2mngF8Tim5+zAj5C0t02T+NBx1zD0E6NUp2S7ugF1Hr0nRfs8BsAa6Dy
         to+PDmw4kS30dE2Wtc7CQbAOBLPHQoh2A+ET78Ri73qCNb/7DoMKYAHKdXQ4QVXU7IXt
         E2q6JyxvTp51Z9WPIhsaKSEuX2HrfNAYLCgoF5vPbK1QEu+7xlq+z6xtHaS8juyIxbfo
         Shq72s2HVSvfKsGPSmz2po+2uknEEksgjPfW/TQNHnQteMv0lZYhqZF+EvusLotaEtV7
         k6hA==
X-Gm-Message-State: AOAM533vIHlClHKM0lUNc3UcJ1FuPU9Ie7bhMTRwX+ay8QOrcs9IJ2H2
        iBOrPac5e4NliIG8FJWW2eQ=
X-Google-Smtp-Source: ABdhPJwH6oPGk8diC/SHZmGHB8ztNt7Um4ESp6zhgQ2KnBescOzsLncK4r1asU81l/lUfefXYbNHsA==
X-Received: by 2002:a63:3d8f:: with SMTP id k137mr3059211pga.21.1634195618936;
        Thu, 14 Oct 2021 00:13:38 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id h3sm1651910pfv.166.2021.10.14.00.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:38 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 5/7] rt-tests: cyclictest: Move signal handler to avoid function declaration
Date:   Thu, 14 Oct 2021 16:12:45 +0900
Message-Id: <20211014071247.4165329-6-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/cyclictest/cyclictest.c | 78 ++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 41 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 9c67a3ce3034..48a782fe167d 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -220,10 +220,6 @@ static char jsonfile[MAX_PATH];
 static struct thread_param **parameters;
 static struct thread_stat **statistics;
 
-static void print_stat(FILE *fp, struct thread_param *par, int index, int verbose, int quiet);
-static void rstat_print_stat(struct thread_param *par, int index, int verbose, int quiet);
-static void rstat_setup(void);
-
 static int latency_target_fd = -1;
 static int32_t latency_target_value = 0;
 
@@ -1311,43 +1307,6 @@ static int check_timer(void)
 	return (ts.tv_sec != 0 || ts.tv_nsec != 1);
 }
 
-static void sighand(int sig)
-{
-	if (sig == SIGUSR1) {
-		int i;
-		int oldquiet = quiet;
-
-		quiet = 0;
-		fprintf(stderr, "#---------------------------\n");
-		fprintf(stderr, "# cyclictest current status:\n");
-		for (i = 0; i < num_threads; i++)
-			print_stat(stderr, parameters[i], i, 0, 0);
-		fprintf(stderr, "#---------------------------\n");
-		quiet = oldquiet;
-		return;
-	} else if (sig == SIGUSR2) {
-		int i;
-		int oldquiet = quiet;
-
-		if (rstat_fd == -1) {
-			fprintf(stderr, "ERROR: rstat_fd not valid\n");
-			return;
-		}
-		rstat_ftruncate(rstat_fd, 0);
-		quiet = 0;
-		dprintf(rstat_fd, "#---------------------------\n");
-		dprintf(rstat_fd, "# cyclictest current status:\n");
-		for (i = 0; i < num_threads; i++)
-			rstat_print_stat(parameters[i], i, 0, 0);
-		dprintf(rstat_fd, "#---------------------------\n");
-		quiet = oldquiet;
-		return;
-	}
-	shutdown = 1;
-	if (refresh_on_max)
-		pthread_cond_signal(&refresh_on_max_cond);
-}
-
 static void print_tids(struct thread_param *par[], int nthreads)
 {
 	int i;
@@ -1566,6 +1525,43 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 }
 
 
+static void sighand(int sig)
+{
+	if (sig == SIGUSR1) {
+		int i;
+		int oldquiet = quiet;
+
+		quiet = 0;
+		fprintf(stderr, "#---------------------------\n");
+		fprintf(stderr, "# cyclictest current status:\n");
+		for (i = 0; i < num_threads; i++)
+			print_stat(stderr, parameters[i], i, 0, 0);
+		fprintf(stderr, "#---------------------------\n");
+		quiet = oldquiet;
+		return;
+	} else if (sig == SIGUSR2) {
+		int i;
+		int oldquiet = quiet;
+
+		if (rstat_fd == -1) {
+			fprintf(stderr, "ERROR: rstat_fd not valid\n");
+			return;
+		}
+		rstat_ftruncate(rstat_fd, 0);
+		quiet = 0;
+		dprintf(rstat_fd, "#---------------------------\n");
+		dprintf(rstat_fd, "# cyclictest current status:\n");
+		for (i = 0; i < num_threads; i++)
+			rstat_print_stat(parameters[i], i, 0, 0);
+		dprintf(rstat_fd, "#---------------------------\n");
+		quiet = oldquiet;
+		return;
+	}
+	shutdown = 1;
+	if (refresh_on_max)
+		pthread_cond_signal(&refresh_on_max_cond);
+}
+
 /*
  * thread that creates a named fifo and hands out run stats when someone
  * reads from the fifo.
-- 
2.32.0

