From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/6] pi_stress clean-ups, fix hang.
Date: Mon, 14 Sep 2009 16:45:41 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909141644090.4675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44791 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbZINOpm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 10:45:42 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8EEjje7023745
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2009 10:45:45 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

My apologies for this resend, only the "Subject" is different - but it is
important that the patches are applied in order. (so I had to add the 
"6/6" part.

>From a8774c1f30a2cd91954fb10f3d748cf9a926f778 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Fri, 11 Sep 2009 15:22:10 +0200
Subject: [PATCH] The shutdown flag can be set asynchronously. Thus it is possible that one
 thread will fine the value set, and leave it's mainloop before reaching
 a particular pthread barrier. However, another thread will not see this value
 before reaching the barrier, and thus the program is left with the thread
 blocked on the barrier.

Either all the threads have to go through the loop - or none of them.
Thus we introduce a new pthread barrier - the loop barrier.
There is one loop boolean per thread group. If it is set we go through the
loop, else we break through it.

The decision to go through the loop or not is made before the loop barrier.
The only place that the loop boolean can be set is after the barrier. It will
set by exactly one thread - to reduce contention on the mutex.

The loop boolean will be set if either the shutdown flag is set, or if
the loop condition indicates it should be. The loop condition is whether
the preset number of iterations has been reached.
---
 src/pi_tests/pi_stress.c |  140 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 127 insertions(+), 13 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 38ddbd6..ae5571a 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -196,6 +196,11 @@ struct group_parameters {
 	pthread_barrier_t elevate_barrier;
 	pthread_barrier_t finish_barrier;
 
+	/* Either everyone goes through the loop, or else no-ones does */
+	pthread_barrier_t loop_barr;
+	pthread_mutex_t loop_mtx;	/* Protect access to int loop */
+	int loop;	/* boolean, loop or not, connected to shutdown */
+
 	// state variables
 	volatile int high_has_run;
 	volatile int low_unlocked;
@@ -606,6 +611,9 @@ low_priority(void *arg)
 	int unbounded;
 	unsigned long count = 0;
 	struct group_parameters *p = (struct group_parameters *)arg;
+	pthread_barrier_t *loop_barr = &p->loop_barr;
+	pthread_mutex_t *loop_mtx = &p->loop_mtx;
+	int *loop = &p->loop;
 
 	allow_sigterm();
 
@@ -626,7 +634,38 @@ low_priority(void *arg)
 
 	debug("low_priority[%d]: starting inversion loop\n", p->id);
 
-	while (!shutdown && (unbounded || (p->total < p->inversions))) {
+	for(;;) {
+		/* We can't set the 'loop' boolean here, because some flags
+		 * may have already reached the loop_barr
+		 */
+		if (!unbounded && (p->total >= p->inversions)) {
+			set_shutdown_flag();
+		}
+
+		/* Either all threads go through the loop_barr, or none do */
+		pthread_mutex_lock(loop_mtx);
+		if (*loop == 0) {
+			pthread_mutex_unlock(loop_mtx);
+			break;
+		}
+		pthread_mutex_unlock(loop_mtx);
+
+		status = pthread_barrier_wait(loop_barr);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
+			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
+					__func__, p->id, status);
+			return NULL;
+		}
+
+		/* Only one Thread needs to check the shutdown status */
+		if (status == PTHREAD_BARRIER_SERIAL_THREAD) {
+			if (shutdown) {
+				pthread_mutex_lock(loop_mtx);
+				*loop = 0;
+				pthread_mutex_unlock(loop_mtx);
+			}
+		}
+
 		/* initial state */
 		debug("low_priority[%d]: entering start wait (%d)\n", p->id, count++);
 		status = pthread_barrier_wait(&p->start_barrier);
@@ -634,12 +673,11 @@ low_priority(void *arg)
 			error("low_priority[%d]: pthread_barrier_wait(start): %x\n", p->id, status);
 			return NULL;
 		}
-		if (shutdown) continue;
+
 		debug("low_priority[%d]: claiming mutex\n", p->id);
 		pthread_mutex_lock(&p->mutex);
 		debug("low_priority[%d]: mutex locked\n", p->id);
 
-		if (shutdown) continue;
 		debug("low_priority[%d]: entering locked wait\n", p->id);
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -647,7 +685,6 @@ low_priority(void *arg)
 			return NULL;
 		}
 
-		if (shutdown) continue;
 		// wait for priority boost
 		debug("low_priority[%d]: entering elevated wait\n", p->id);
 		p->low_unlocked = 0; /* prevent race with med_priority */
@@ -663,7 +700,6 @@ low_priority(void *arg)
 		pthread_mutex_unlock(&p->mutex);
 
 		// finish state 
-		if (shutdown) continue;
 		debug("low_priority[%d]: entering finish wait\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -690,6 +726,9 @@ med_priority(void *arg)
 	int unbounded;
 	unsigned long count = 0;
 	struct group_parameters *p = (struct group_parameters *)arg;
+	pthread_barrier_t *loop_barr = &p->loop_barr;
+	pthread_mutex_t *loop_mtx = &p->loop_mtx;
+	int *loop = &p->loop;
 
 	allow_sigterm();
 
@@ -709,7 +748,34 @@ med_priority(void *arg)
 	unbounded = (p->inversions < 0);
 
 	debug("med_priority[%d]: starting inversion loop\n", p->id);
-	while (!shutdown && (unbounded || (p->total < p->inversions))) {
+	for(;;) {
+		if (!unbounded && (p->total >= p->inversions)) {
+			set_shutdown_flag();
+		}
+				/* Either all threads go through the loop_barr, or none do */
+		pthread_mutex_lock(loop_mtx);
+		if (*loop == 0) {
+			pthread_mutex_unlock(loop_mtx);
+			break;
+		}
+		pthread_mutex_unlock(loop_mtx);
+
+		status = pthread_barrier_wait(loop_barr);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
+			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
+					__func__, p->id, status);
+			return NULL;
+		}
+
+		/* Only one Thread needs to check the shutdown status */
+		if (status == PTHREAD_BARRIER_SERIAL_THREAD) {
+			if (shutdown) {
+				pthread_mutex_lock(loop_mtx);
+				*loop = 0;
+				pthread_mutex_unlock(loop_mtx);
+			}
+		}
+
 		/* start state */
 		debug("med_priority[%d]: entering start state (%d)\n", p->id, count++);
 		status = pthread_barrier_wait(&p->start_barrier);
@@ -719,14 +785,12 @@ med_priority(void *arg)
 		}
 		debug("med_priority[%d]: entering elevate state\n", p->id);
 		do {
-			if (shutdown) break;
 			status = pthread_barrier_wait(&p->elevate_barrier);
 			if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 				error("med_priority[%d]: pthread_barrier_wait(elevate): %x", p->id, status);
 				return NULL;
 			}
 		} while (!p->high_has_run && !p->low_unlocked);
-		if (shutdown) continue;
 		debug("med_priority[%d]: entering finish state\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -758,6 +822,9 @@ high_priority(void *arg)
 	int unbounded;
 	unsigned long count = 0;
 	struct group_parameters *p = (struct group_parameters *)arg;
+	pthread_barrier_t *loop_barr = &p->loop_barr;
+	pthread_mutex_t *loop_mtx = &p->loop_mtx;
+	int *loop = &p->loop;
 
 	allow_sigterm();
 	if (verify_cpu(p->cpu) != SUCCESS) {
@@ -770,13 +837,39 @@ high_priority(void *arg)
 	/* wait for all threads to be ready */
 	status = pthread_barrier_wait(&all_threads_ready);
 	if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-		error("high_priority[%d]: pthread_barrier_wait(all_threads_ready): %x", 
-		      p->id, status);
+		error("high_priority[%d]: pthread_barrier_wait(all_threads_ready): %x", p->id, status);
 		return NULL;
 	}
 	unbounded = (p->inversions < 0);
 	debug("high_priority[%d]: starting inversion loop\n", p->id);
-	while (!shutdown && (unbounded || (p->total < p->inversions))) {
+	for(;;) {
+		if (!unbounded && (p->total >= p->inversions)) {
+			set_shutdown_flag();
+		}
+
+		/* Either all threads go through the loop_barr, or none do */
+		pthread_mutex_lock(loop_mtx);
+		if (*loop == 0) {
+			pthread_mutex_unlock(loop_mtx);
+			break;
+		}
+		pthread_mutex_unlock(loop_mtx);
+
+		status = pthread_barrier_wait(loop_barr);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
+			error("%s[%d]: pthread_barrier_wait(loop): %x\n",
+					__func__, p->id, status);
+			return NULL;
+		}
+
+		/* Only one Thread needs to check the shutdown status */
+		if (status == PTHREAD_BARRIER_SERIAL_THREAD) {
+			if (shutdown) {
+				pthread_mutex_lock(loop_mtx);
+				*loop = 0;
+				pthread_mutex_unlock(loop_mtx);
+			}
+		}
 		p->high_has_run = 0;
 		debug("high_priority[%d]: entering start state (%d)\n", p->id, count++);
 		status = pthread_barrier_wait(&p->start_barrier);
@@ -784,7 +877,7 @@ high_priority(void *arg)
 			error("high_priority[%d]: pthread_barrier_wait(start): %x", p->id, status);
 			return NULL;
 		}
-		if (shutdown) continue;
+
 		debug("high_priority[%d]: entering running state\n", p->id);
 		status = pthread_barrier_wait(&p->locked_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -798,7 +891,7 @@ high_priority(void *arg)
 		debug("high_priority[%d]: unlocking mutex\n", p->id);
 		pthread_mutex_unlock(&p->mutex);
 		debug("high_priority[%d]: entering finish state\n", p->id);
-		if (shutdown) continue;
+
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			error("high_priority[%d]: pthread_barrier_wait(finish): %x", status);
@@ -986,6 +1079,27 @@ initialize_group(struct group_parameters *group)
 	if (barrier_init(&group->finish_barrier, NULL, NUM_TEST_THREADS, "finish_barrier"))
 		return FAILURE;
 
+	if (barrier_init(&group->loop_barr, NULL, NUM_TEST_THREADS,
+				"loop_barrier"))
+		return FAILURE;
+
+	if ((status = pthread_mutex_init(&group->loop_mtx, NULL)) != 0) {
+		error("pthread_mutex_init, status = %d\n", status);
+		return FAILURE;
+	}
+
+	if ((status = pthread_mutex_lock(&group->loop_mtx)) != 0) {
+		error("pthread_mutex_lock, status = %d\n", status);
+		return FAILURE;
+	}
+
+	group->loop = 1;
+
+	if ((status = pthread_mutex_unlock(&group->loop_mtx)) != 0) {
+		error("pthread_mutex_unlock, status = %d\n", status);
+		return FAILURE;
+	}
+
 	return SUCCESS;
 }	
 // setup and create a groups threads
-- 
1.6.0.6

