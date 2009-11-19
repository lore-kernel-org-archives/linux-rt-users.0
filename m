From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rt-tests: pi_stress: Remove racy state variables that cause watchdog to trigger
Date: Thu, 19 Nov 2009 17:35:15 +0100
Message-ID: <1258648515-7566-4-git-send-email-jkacur@redhat.com>
References: <1258648515-7566-1-git-send-email-jkacur@redhat.com>
 <1258648515-7566-2-git-send-email-jkacur@redhat.com>
 <1258648515-7566-3-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53174 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757392AbZKSQfP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Nov 2009 11:35:15 -0500
Received: by bwz27 with SMTP id 27so2536549bwz.21
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Nov 2009 08:35:20 -0800 (PST)
In-Reply-To: <1258648515-7566-3-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When using pthread_barrier_wait, it is important that barriers are called
the correct number of times. That is - the same number given as the count
when initializing the barrier.

There was a do-while loop around elevate_barrier in the med priority thread.
On most machines, it actually never looped.

On threads with enough processors (nehalem for example), there was a racy
situation in which the high priority thread could come out of the finish
barrier, and before it could set high_has_run = 0, the medium priority
thread would test the value and call the elevate barrier an extra time.

This patch removes the bogus loop and related state variables and fixes
the hang.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |   22 +++++++---------------
 1 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index f4b43ed..6f1a309 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -201,8 +201,6 @@ struct group_parameters {
 	int loop;	/* boolean, loop or not, connected to shutdown */
 
 	/* state variables */
-	volatile int high_has_run;
-	volatile int low_unlocked;
 	volatile int watchdog;
 
 	/* total number of inversions performed */
@@ -703,7 +701,6 @@ void *low_priority(void *arg)
 		}
 		/* wait for priority boost */
 		debug("low_priority[%d]: entering elevated wait\n", p->id);
-		p->low_unlocked = 0;	/* prevent race with med_priority */
 		status = pthread_barrier_wait(&p->elevate_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
 			error
@@ -711,7 +708,6 @@ void *low_priority(void *arg)
 			     p->id, status);
 			return NULL;
 		}
-		p->low_unlocked = 1;
 
 		/* release the mutex */
 		debug("low_priority[%d]: unlocking mutex\n", p->id);
@@ -812,15 +808,12 @@ void *med_priority(void *arg)
 			return NULL;
 		}
 		debug("med_priority[%d]: entering elevate state\n", p->id);
-		do {
-			status = pthread_barrier_wait(&p->elevate_barrier);
-			if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
-				error
-				    ("med_priority[%d]: pthread_barrier_wait(elevate): %x",
-				     p->id, status);
-				return NULL;
-			}
-		} while (!p->high_has_run && !p->low_unlocked);
+		status = pthread_barrier_wait(&p->elevate_barrier);
+		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
+			error ("med_priority[%d]: pthread_barrier_wait(elevate): %x", p->id, status);
+			return NULL;
+		}
+
 		debug("med_priority[%d]: entering finish state\n", p->id);
 		status = pthread_barrier_wait(&p->finish_barrier);
 		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
@@ -906,7 +899,6 @@ void *high_priority(void *arg)
 			}
 			pthread_mutex_unlock(&shutdown_mtx);
 		}
-		p->high_has_run = 0;
 		debug("high_priority[%d]: entering start state (%d)\n", p->id,
 		      count++);
 		status = pthread_barrier_wait(&p->start_barrier);
@@ -928,7 +920,7 @@ void *high_priority(void *arg)
 		debug("high_priority[%d]: locking mutex\n", p->id);
 		pthread_mutex_lock(&p->mutex);
 		debug("high_priority[%d]: got mutex\n", p->id);
-		p->high_has_run = 1;
+
 		debug("high_priority[%d]: unlocking mutex\n", p->id);
 		pthread_mutex_unlock(&p->mutex);
 		debug("high_priority[%d]: entering finish state\n", p->id);
-- 
1.6.2.5

