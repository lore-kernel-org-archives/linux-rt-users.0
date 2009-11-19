From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rt-tests: pi_stress: Use a pthread_mutex_t for the global variable shutdown
Date: Thu, 19 Nov 2009 17:35:13 +0100
Message-ID: <1258648515-7566-2-git-send-email-jkacur@redhat.com>
References: <1258648515-7566-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:53501 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318AbZKSQfN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Nov 2009 11:35:13 -0500
Received: by fxm21 with SMTP id 21so2597614fxm.21
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Nov 2009 08:35:18 -0800 (PST)
In-Reply-To: <1258648515-7566-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Use a pthread_mutex_t for the global variable shutdown.
- Remove the volatile qualifier from shutdown. (Since the original author
probably simply meant the variable should be atomic which we effectively
get through the mutex.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 76f466d..44c8f69 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -118,8 +118,8 @@ int prompt = 0;
 /* report interval */
 unsigned long report_interval = (unsigned long)SEC_TO_USEC(0.75);
 
-/* global that indicates we should shut down */
-volatile int shutdown = 0;
+int shutdown = 0;		/* global indicating we should shut down */
+pthread_mutex_t shutdown_mtx;	/* associated mutex */
 
 /* indicate if errors have occured */
 int have_errors = 0;
@@ -550,14 +550,23 @@ void *reporter(void *arg)
 	debug("reporter: starting report loop\n");
 	info("Press Control-C to stop test\nCurrent Inversions: \n");
 
-	while (shutdown == 0) {
+	for (;;) {
+		pthread_mutex_lock(&shutdown_mtx);
+		if (shutdown) {
+			pthread_mutex_unlock(&shutdown_mtx);
+			break;
+		}
+		pthread_mutex_unlock(&shutdown_mtx);
+
 		/* wait for our reporting interval */
 		status = clock_nanosleep(CLOCK_MONOTONIC, 0, &ts, NULL);
 		if (status) {
 			error("from clock_nanosleep: %s\n", strerror(status));
 			break;
 		}
+
 		/* check for signaled shutdown */
+		pthread_mutex_lock(&shutdown_mtx);
 		if (shutdown == 0) {
 			if (!quiet) {
 				fputs(UP_ONE, stdout);
@@ -565,6 +574,8 @@ void *reporter(void *arg)
 				       total_inversions());
 			}
 		}
+		pthread_mutex_unlock(&shutdown_mtx);
+
 		/* if we specified a duration, see if it has expired */
 		if (end && time(NULL) > end) {
 			info("duration reached (%d seconds)\n", duration);
@@ -660,11 +671,13 @@ void *low_priority(void *arg)
 
 		/* Only one Thread needs to check the shutdown status */
 		if (status == PTHREAD_BARRIER_SERIAL_THREAD) {
+			pthread_mutex_lock(&shutdown_mtx);
 			if (shutdown) {
 				pthread_mutex_lock(loop_mtx);
 				*loop = 0;
 				pthread_mutex_unlock(loop_mtx);
 			}
+			pthread_mutex_unlock(&shutdown_mtx);
 		}
 
 		/* initial state */
@@ -781,11 +794,13 @@ void *med_priority(void *arg)
 
 		/* Only one Thread needs to check the shutdown status */
 		if (status == PTHREAD_BARRIER_SERIAL_THREAD) {
+			pthread_mutex_lock(&shutdown_mtx);
 			if (shutdown) {
 				pthread_mutex_lock(loop_mtx);
 				*loop = 0;
 				pthread_mutex_unlock(loop_mtx);
 			}
+			pthread_mutex_unlock(&shutdown_mtx);
 		}
 
 		/* start state */
@@ -885,11 +900,13 @@ void *high_priority(void *arg)
 
 		/* Only one Thread needs to check the shutdown status */
 		if (status == PTHREAD_BARRIER_SERIAL_THREAD) {
+			pthread_mutex_lock(&shutdown_mtx);
 			if (shutdown) {
 				pthread_mutex_lock(loop_mtx);
 				*loop = 0;
 				pthread_mutex_unlock(loop_mtx);
 			}
+			pthread_mutex_unlock(&shutdown_mtx);
 		}
 		p->high_has_run = 0;
 		debug("high_priority[%d]: entering start state (%d)\n", p->id,
@@ -1051,11 +1068,13 @@ int allow_sigterm(void)
 /* clean up before exiting */
 void set_shutdown_flag(void)
 {
+	pthread_mutex_lock(&shutdown_mtx);
 	if (shutdown == 0) {
 		/* tell anyone that's looking that we're done */
 		info("setting shutdown flag\n");
 		shutdown = 1;
 	}
+	pthread_mutex_unlock(&shutdown_mtx);
 }
 
 /* set up a test group */
-- 
1.6.2.5

