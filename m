From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/7] Use sched_getcpu - sched_getcpu is available since glibc 2.6 - the current tests were broken in anycase.
Date: Mon, 14 Dec 2009 16:58:54 +0100
Message-ID: <1260806336-4691-6-git-send-email-jkacur@redhat.com>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
 <1260806336-4691-2-git-send-email-jkacur@redhat.com>
 <1260806336-4691-3-git-send-email-jkacur@redhat.com>
 <1260806336-4691-4-git-send-email-jkacur@redhat.com>
 <1260806336-4691-5-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:40002 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757557AbZLNP7b (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Dec 2009 10:59:31 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so2113580bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Dec 2009 07:59:30 -0800 (PST)
In-Reply-To: <1260806336-4691-5-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/ptsematest/ptsematest.c   |   18 +-----------------
 src/sigwaittest/sigwaittest.c |   18 +-----------------
 2 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index e040417..c4426f3 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -33,17 +33,13 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 #include <linux/unistd.h>
+#include <utmpx.h>
 #include "rt-utils.h"
 
 #define __USE_GNU
 #include <pthread.h>
 
-#undef HAS_SCHED_GETCPU
-
 #define gettid() syscall(__NR_gettid)
-#ifndef HAS_SCHED_GETCPU
-#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
-#endif
 
 #define USEC_PER_SEC 1000000
 
@@ -112,13 +108,7 @@ void *semathread(void *param)
 			if(par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 			if (mustgetcpu) {
-#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
-#else
-				int c, s;
-	                        s = getcpu(&c, NULL, NULL);
-			        par->cpu = (s == -1) ? s : c;
-#endif
 			}
 		} else {
 			/* Receiver */
@@ -160,13 +150,7 @@ void *semathread(void *param)
 			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 			if (mustgetcpu) {
-#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
-#else
-				int c, s;
-	                        s = getcpu(&c, NULL, NULL);
-			        par->cpu = (s == -1) ? s : c;
-#endif
 		        }
 			nanosleep(&par->delay, NULL);
 			pthread_mutex_unlock(&syncmutex[par->num]);
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index a3bbebc..740e13d 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -35,17 +35,13 @@
 #include <sys/types.h>
 #include <sys/time.h>
 #include <linux/unistd.h>
+#include <utmpx.h>
 #include "rt-utils.h"
 
 #define __USE_GNU
 #include <pthread.h>
 
-#undef HAS_SCHED_GETCPU
-
 #define gettid() syscall(__NR_gettid)
-#ifndef HAS_SCHED_GETCPU
-#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
-#endif
 
 #define USEC_PER_SEC 1000000
 
@@ -143,13 +139,7 @@ void *semathread(void *param)
 				par->shutdown = 1;
 
 			if (mustgetcpu) {
-#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
-#else
-				int c, s;
-	                        s = getcpu(&c, NULL, NULL);
-			        par->cpu = (s == -1) ? s : c;
-#endif
 			}
 			sigwait(&sigset, &sig);
 		} else {
@@ -173,13 +163,7 @@ void *semathread(void *param)
 				par->shutdown = 1;
 
 			if (mustgetcpu) {
-#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
-#else
-				int c, s;
-	                        s = getcpu(&c, NULL, NULL);
-			        par->cpu = (s == -1) ? s : c;
-#endif
 		        }
 			/*
 			 * Latency is the time spent between sending and
-- 
1.6.5.2

