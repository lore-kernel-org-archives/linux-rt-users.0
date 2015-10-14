From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/7] cyclictest: Clean-ups in timerthread before working on it
Date: Wed, 14 Oct 2015 15:32:12 +0200
Message-ID: <1444829538-18465-2-git-send-email-jkacur@redhat.com>
References: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:36853 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228AbbJNNdG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 Oct 2015 09:33:06 -0400
Received: by wicgb1 with SMTP id gb1so231213742wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Oct 2015 06:33:04 -0700 (PDT)
In-Reply-To: <1444829538-18465-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Clean this function up a bit before modifying it
	- Don't use assignment in if statements
	- Put spaces before open braces and parentheses
	- Break lines up where possible that go over 80 chars

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 50 ++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b1f99ab22c57..00168e22fc7f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -785,8 +785,9 @@ static void *timerthread(void *param)
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
 		thread = pthread_self();
-		if(pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
-			warn("Could not set CPU affinity to CPU #%d\n", par->cpu);
+		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
+			warn("Could not set CPU affinity to CPU #%d\n",
+			     par->cpu);
 	}
 
 	interval.tv_sec = par->interval / USEC_PER_SEC;
@@ -809,11 +810,12 @@ static void *timerthread(void *param)
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
 	if (setscheduler(0, par->policy, &schedp))
-		fatal("timerthread%d: failed to set priority to %d\n", par->cpu, par->prio);
+		fatal("timerthread%d: failed to set priority to %d\n",
+		      par->cpu, par->prio);
 
 	/* Get current time */
 #ifndef NO_PTHREAD_BARRIER
-	if(aligned || secaligned){
+	if (aligned || secaligned) {
 		pthread_barrier_wait(&globalt_barr);
 		if (par->tnum == 0) {
 			clock_gettime(par->clock, &globalt);
@@ -829,15 +831,14 @@ static void *timerthread(void *param)
 		}
 		pthread_barrier_wait(&align_barr);
 		now = globalt;
-		if(offset) {
+		if (offset) {
 			if (aligned)
 				now.tv_nsec += offset * par->tnum;
 			else
 				now.tv_nsec += offset;
 			tsnorm(&now);
 		}
-	}
-	else
+	} else
 #endif
 		clock_gettime(par->clock, &now);
 
@@ -854,9 +855,8 @@ static void *timerthread(void *param)
 	if (par->mode == MODE_CYCLIC) {
 		if (par->timermode == TIMER_ABSTIME)
 			tspec.it_value = next;
-		else {
+		else
 			tspec.it_value = interval;
-		}
 		timer_settime(timer, par->timermode, &tspec, NULL);
 	}
 
@@ -864,7 +864,7 @@ static void *timerthread(void *param)
 		itimer.it_interval.tv_sec = interval.tv_sec;
 		itimer.it_interval.tv_usec = interval.tv_nsec / 1000;
 		itimer.it_value = itimer.it_interval;
-		setitimer (ITIMER_REAL, &itimer, NULL);
+		setitimer(ITIMER_REAL, &itimer, NULL);
 	}
 
 	stat->threadstarted++;
@@ -884,18 +884,23 @@ static void *timerthread(void *param)
 
 		case MODE_CLOCK_NANOSLEEP:
 			if (par->timermode == TIMER_ABSTIME) {
-				if ((ret = clock_nanosleep(par->clock, TIMER_ABSTIME, &next, NULL))) {
+				ret = clock_nanosleep(par->clock, TIMER_ABSTIME,
+						      &next, NULL);
+				if (ret != 0) {
 					if (ret != EINTR)
 						warn("clock_nanosleep failed. errno: %d\n", errno);
 					goto out;
 				}
 			} else {
-				if ((ret = clock_gettime(par->clock, &now))) {
+				ret = clock_gettime(par->clock, &now);
+				if (ret != 0) {
 					if (ret != EINTR)
 						warn("clock_gettime() failed: %s", strerror(errno));
 					goto out;
 				}
-				if ((ret = clock_nanosleep(par->clock, TIMER_RELTIME, &interval, NULL))) {
+				ret = clock_nanosleep(par->clock,
+					TIMER_RELTIME, &interval, NULL);
+				if (ret != 0) {
 					if (ret != EINTR)
 						warn("clock_nanosleep() failed. errno: %d\n", errno);
 					goto out;
@@ -907,14 +912,16 @@ static void *timerthread(void *param)
 			break;
 
 		case MODE_SYS_NANOSLEEP:
-			if ((ret = clock_gettime(par->clock, &now))) {
+			ret = clock_gettime(par->clock, &now);
+			if (ret != 0) {
 				if (ret != EINTR)
 					warn("clock_gettime() failed: errno %d\n", errno);
 				goto out;
 			}
 			if (nanosleep(&interval, NULL)) {
 				if (errno != EINTR)
-					warn("nanosleep failed. errno: %d\n", errno);
+					warn("nanosleep failed. errno: %d\n",
+					     errno);
 				goto out;
 			}
 			next.tv_sec = now.tv_sec + interval.tv_sec;
@@ -922,10 +929,11 @@ static void *timerthread(void *param)
 			tsnorm(&next);
 			break;
 		}
-
-		if ((ret = clock_gettime(par->clock, &now))) {
+		ret = clock_gettime(par->clock, &now);
+		if (ret != 0) {
 			if (ret != EINTR)
-				warn("clock_getttime() failed. errno: %d\n", errno);
+				warn("clock_getttime() failed. errno: %d\n",
+				     errno);
 			goto out;
 		}
 
@@ -968,9 +976,9 @@ static void *timerthread(void *param)
 				stat->hist_overflow++;
 				if (stat->num_outliers < histogram)
 					stat->outliers[stat->num_outliers++] = stat->cycles;
-			}
-			else
+			} else {
 				stat->hist_array[diff]++;
+			}
 		}
 
 		stat->cycles++;
@@ -1003,7 +1011,7 @@ out:
 		itimer.it_value.tv_usec = 0;
 		itimer.it_interval.tv_sec = 0;
 		itimer.it_interval.tv_usec = 0;
-		setitimer (ITIMER_REAL, &itimer, NULL);
+		setitimer(ITIMER_REAL, &itimer, NULL);
 	}
 
 	/* switch to normal */
-- 
2.4.3

