From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 4/6] pi_stress clean-ups, fix hang.
Date: Mon, 14 Sep 2009 16:36:40 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909141635410.4675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755572AbZINOgk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 10:36:40 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8EEaibH016676
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2009 10:36:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From bc78698cc7db99ede25b81b18c6770b83f984df9 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 3 Sep 2009 17:09:54 +0200
Subject: [PATCH] Add barrier_init function

Adding a barrier_init function to make the code more readable, by
encapsulating all of the common code used for calling
pthread_barrier_init.
---
 src/pi_tests/pi_stress.c |   68 +++++++++++++++++++++++++--------------------
 1 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 2a409cc..5a5c35a 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -237,6 +237,8 @@ unsigned long total_inversions(void);
 void banner(void);
 void summary(void);
 void wait_for_termination(void);
+int barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
+		unsigned count, const char *name);
 
 int
 main (int argc, char **argv)
@@ -246,6 +248,7 @@ main (int argc, char **argv)
 	int i;
 	int retval = FAILURE;
 	int core;
+	int nthreads;
 
 	/* Make sure we see all message, even those on stdout.  */
 	setvbuf (stdout, NULL, _IONBF, 0);
@@ -289,21 +292,16 @@ main (int argc, char **argv)
 	if (set_cpu_affinity(&test_cpu_mask, &admin_cpu_mask))
 		return FAILURE;
 		
-	// set up our ready barrier
-	status = pthread_barrier_init(&all_threads_ready, NULL, 
-				      (ngroups * NUM_TEST_THREADS) + NUM_ADMIN_THREADS);
-	if (status) {
-		error("initialize_barriers: failed to initialize all_threads_ready\n");
+	nthreads = ngroups * NUM_TEST_THREADS + NUM_ADMIN_THREADS;
+
+	/* set up our ready barrier */
+	if (barrier_init(&all_threads_ready, NULL, nthreads,
+				"all_threads_ready"))
 		return FAILURE;
-	}
 
-	// set up our done barrier
-	status = pthread_barrier_init(&all_threads_done, NULL, 
-				      (ngroups * NUM_TEST_THREADS) + NUM_ADMIN_THREADS);
-	if (status) {
-		error("initialize_barriers: failed to initialize all_threads_done\n");
+	/* set up our done barrier */
+	if (barrier_init(&all_threads_done, NULL, nthreads, "all_threads_done"))
 		return FAILURE;
-	}
 
 	// create the groups
 	info("Creating %d test groups\n", ngroups);
@@ -974,27 +972,21 @@ initialize_group(struct group_parameters *group)
 		return FAILURE;
 	}
 
-	// initialize the group barriers
-	status = pthread_barrier_init(&group->start_barrier, NULL, NUM_TEST_THREADS);
-	if (status) {
-		error("failed to initialize start_barrier\n");
-		return FAILURE;
-	}
-	status = pthread_barrier_init(&group->locked_barrier, NULL, 2);
-	if (status) {
-		error("failed to intialize locked_barrier: %s\n", strerror(status));
+	/* initialize the group barriers */
+	if (barrier_init(&group->start_barrier, NULL, NUM_TEST_THREADS,
+				"start_barrier"))
+			return FAILURE;
+
+	if (barrier_init(&group->locked_barrier, NULL, 2, "locked_barrier"))
 		return FAILURE;
-	}
-	status = pthread_barrier_init(&group->elevate_barrier, NULL, 2);
-	if (status) {
-		error("failed to initialize elevate_barrier: %s\n", strerror(status));
+
+
+	if (barrier_init(&group->elevate_barrier, NULL, 2, "elevate_barrier"))
 		return FAILURE;
-	}
-	status = pthread_barrier_init(&group->finish_barrier, NULL, NUM_TEST_THREADS);
-	if (status) {
-		error("failed to initialize finish_barrier: %s\n", strerror(status));
+
+	if (barrier_init(&group->finish_barrier, NULL, NUM_TEST_THREADS, "finish_barrier"))
 		return FAILURE;
-	}
+
 	return SUCCESS;
 }	
 // setup and create a groups threads
@@ -1156,3 +1148,19 @@ void summary(void)
 	printf("Test Duration: %d days, %d hours, %d minutes, %d seconds\n",
 		   t->tm_yday, t->tm_hour, t->tm_min, t->tm_sec);
 }
+
+int
+barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
+		unsigned count, const char *name)
+{
+	int status;
+
+	if ((status = pthread_barrier_init(b, attr, count)) != 0) {
+		error("barrier_init: failed to initialize: %s\n", name);
+		error("status = %d\n", status);
+		return FAILURE;
+	}
+
+	return SUCCESS;
+}
+
-- 
1.6.0.6

