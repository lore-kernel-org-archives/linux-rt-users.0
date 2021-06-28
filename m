Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E01C11F66
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D1061CC7
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Jun 2021 20:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhF1UOj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Jun 2021 16:14:39 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49592 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbhF1UOe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Jun 2021 16:14:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1213320327;
        Mon, 28 Jun 2021 20:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624911128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evGWANbTDq7C0YbS8lkJ2EmR2mMuHanAz7rasjAKnpQ=;
        b=O5O8DIrRPiYeOUuHqo+xeQ3kzzGYAGAmdemB1PErkKkvSAlD6qBZWefwYRIhD3XuFoYjVk
        CFwaiBPZceXVYiAylgYMCZ/b0epEoBQxxrSaPDviGz5LUA2Bla/hXXiGvNHatrnimc9P3n
        aF4K2570dTKXJWiA2+DiFasHobk5ZVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624911128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evGWANbTDq7C0YbS8lkJ2EmR2mMuHanAz7rasjAKnpQ=;
        b=znCG9pcavOILXFYLRqtVH665OC/YjdWG5i/a8Rx3ylYO0INInkZe9HYH5vuTSpT6iFqA+d
        twIcF5SC7XQUcYDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EB19E11906;
        Mon, 28 Jun 2021 20:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624911128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evGWANbTDq7C0YbS8lkJ2EmR2mMuHanAz7rasjAKnpQ=;
        b=O5O8DIrRPiYeOUuHqo+xeQ3kzzGYAGAmdemB1PErkKkvSAlD6qBZWefwYRIhD3XuFoYjVk
        CFwaiBPZceXVYiAylgYMCZ/b0epEoBQxxrSaPDviGz5LUA2Bla/hXXiGvNHatrnimc9P3n
        aF4K2570dTKXJWiA2+DiFasHobk5ZVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624911128;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evGWANbTDq7C0YbS8lkJ2EmR2mMuHanAz7rasjAKnpQ=;
        b=znCG9pcavOILXFYLRqtVH665OC/YjdWG5i/a8Rx3ylYO0INInkZe9HYH5vuTSpT6iFqA+d
        twIcF5SC7XQUcYDw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id rm5pOBct2mALLwAALh3uQQ
        (envelope-from <dwagner@suse.de>); Mon, 28 Jun 2021 20:12:07 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH rt-tests v1 2/2] rt-utils: Remove empty rt_test_start()
Date:   Mon, 28 Jun 2021 22:12:03 +0200
Message-Id: <20210628201203.30974-3-dwagner@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628201203.30974-1-dwagner@suse.de>
References: <20210628201203.30974-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

rt_test_start() is unused, remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/cyclictest/cyclictest.c           | 1 -
 src/include/rt-utils.h                | 2 --
 src/lib/rt-utils.c                    | 4 ----
 src/oslat/oslat.c                     | 1 -
 src/pi_tests/pi_stress.c              | 1 -
 src/pmqtest/pmqtest.c                 | 1 -
 src/ptsematest/ptsematest.c           | 1 -
 src/rt-migrate-test/rt-migrate-test.c | 1 -
 src/sched_deadline/cyclicdeadline.c   | 1 -
 src/signaltest/signaltest.c           | 1 -
 src/sigwaittest/sigwaittest.c         | 1 -
 src/ssdd/ssdd.c                       | 1 -
 src/svsematest/svsematest.c           | 1 -
 13 files changed, 17 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index be8285a072b4..a08c91d9f4ca 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -615,7 +615,6 @@ static void *timerthread(void *param)
 		setitimer(ITIMER_REAL, &itimer, NULL);
 	}
 
-	rt_test_start();
 	stat->threadstarted++;
 
 	while (!shutdown) {
diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index f07b57d5f7c1..f6b3fede06f7 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -82,8 +82,6 @@ static inline int64_t calctime(struct timespec t)
 
 void rt_init(int argc, char *argv[]);
 
-void rt_test_start(void);
-
 void rt_write_json(const char *filename, int return_code,
 		   void (*cb)(FILE *, void *),
 		   void *data);
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index 11f386098867..6c0235d0d2e0 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -531,10 +531,6 @@ void rt_init(int argc, char *argv[])
 	get_timestamp(ts_start);
 }
 
-void rt_test_start(void)
-{
-}
-
 void rt_write_json(const char *filename, int return_code,
 		  void (*cb)(FILE *, void *),
 		  void *data)
diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index 32de951f27c0..6108fede039c 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -854,7 +854,6 @@ int main(int argc, char *argv[])
 		printf("Test starts...\n");
 	/* Reset n_threads to always run on all the cores */
 	g.n_threads = g.n_threads_total;
-	rt_test_start();
 	run_expt(threads, g.runtime);
 
 	if (!g.quiet)
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 7782ea717c55..53c6af15afac 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -304,7 +304,6 @@ int main(int argc, char **argv)
 	}
 	/* report */
 	banner();
-	rt_test_start();
 	start = time(NULL);
 
 	/* turn loose the threads */
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index edda7c69652e..6ad0a92ffb5c 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -582,7 +582,6 @@ int main(int argc, char *argv[])
 	sigemptyset(&sigset);
 	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
 
-	rt_test_start();
 	do {
 		int newsamples = 0, newtimeoutcount = 0;
 		int minsamples = INT_MAX;
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 5822164386de..821e58428e6d 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -468,7 +468,6 @@ int main(int argc, char *argv[])
 	maindelay.tv_sec = 0;
 	maindelay.tv_nsec = 50000000; /* 50 ms */
 
-	rt_test_start();
 	while (!shutdown) {
 		for (i = 0; i < num_threads; i++)
 			shutdown |= receiver[i].shutdown | sender[i].shutdown;
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 0c4dabeee249..62cc603c983b 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -621,7 +621,6 @@ int main (int argc, char **argv)
 
 	setup_ftrace_marker();
 
-	rt_test_start();
 	for (loop=0; loop < nr_runs; loop++) {
 		unsigned long long end;
 
diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index 4c81891bbe63..ffefa9e6fecb 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1213,7 +1213,6 @@ int main(int argc, char **argv)
 	if (duration)
 		alarm(duration);
 
-	rt_test_start();
 	loop(sched_data, nr_threads);
 
 	for (i = 0; i < nr_threads; i++) {
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 2dd22070cb5d..6e8f6b51b003 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -500,7 +500,6 @@ int main(int argc, char **argv)
 			      strerror(status));
 	}
 
-	rt_test_start();
 	while (!shutdown) {
 		int allstarted = 1;
 
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 98a740d2cce2..d0d79df940de 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -652,7 +652,6 @@ int main(int argc, char *argv[])
 			    &sender[i]);
 	}
 
-	rt_test_start();
 	while (!mustshutdown) {
 		for (i = 0; i < num_threads; i++)
 			mustshutdown |= receiver[i].shutdown |
diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
index 421688c7f47c..c5307648a82d 100644
--- a/src/ssdd/ssdd.c
+++ b/src/ssdd/ssdd.c
@@ -357,7 +357,6 @@ int main(int argc, char **argv)
 			forktests(i);
 	}
 
-	rt_test_start();
 	for (i = 0; i < nforks; i++) {
 		status = do_wait(&wait_pid, &ret_sig);
 		if (status != STATE_EXITED) {
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 8c55b6b7c48d..22ea7bcb7374 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -724,7 +724,6 @@ int main(int argc, char *argv[])
 			    &sender[i]);
 	}
 
-	rt_test_start();
 	while (!mustshutdown) {
 		for (i = 0; i < num_threads; i++)
 			mustshutdown |= receiver[i].shutdown |
-- 
2.32.0

