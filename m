From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/4] rt-tests: Add a get_cpu() function to the library.
Date: Mon, 21 Dec 2009 22:45:48 +0100
Message-ID: <1261431950-28500-3-git-send-email-jkacur@redhat.com>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
 <1261431950-28500-2-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:41653 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757318AbZLUVqI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 16:46:08 -0500
Received: by mail-bw0-f227.google.com with SMTP id 27so3775817bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2009 13:46:08 -0800 (PST)
In-Reply-To: <1261431950-28500-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a get_cpu() function to the library.
Most platforms will simply use sched_getcpu()
However, if you have a glibc < 2.6 then
64-bits will use vsyscall for getcpu (if available).
32-bits will use getcpu() (if available)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                      |   17 ++++++++-------
 src/backfire/sendme.c         |    7 ++++-
 src/lib/rt-get_cpu.c          |   25 ++++++++++++++++++++++
 src/lib/rt-get_cpu.h          |   46 +++++++++++++++++++++++++++++++++++++++++
 src/ptsematest/ptsematest.c   |   11 ++++-----
 src/sigwaittest/sigwaittest.c |    7 ++++-
 src/svsematest/svsematest.c   |   30 ++++++--------------------
 7 files changed, 102 insertions(+), 41 deletions(-)
 create mode 100644 src/lib/rt-get_cpu.c
 create mode 100644 src/lib/rt-get_cpu.h

diff --git a/Makefile b/Makefile
index 4ca4470..aa95e78 100644
--- a/Makefile
+++ b/Makefile
@@ -4,6 +4,7 @@ TARGETS	= cyclictest signaltest classic_pi pi_stress \
 	  hwlatdetect rt-migrate-test ptsematest sigwaittest svsematest \
 	  sendme
 LIBS 	= -lpthread -lrt
+EXTRA_LIBS ?= -ldl	# for get_cpu
 DESTDIR	?=
 prefix  ?= /usr/local
 bindir  ?= $(prefix)/bin
@@ -53,17 +54,17 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 rt-migrate-test: rt-migrate-test.o
 	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-ptsematest: ptsematest.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+ptsematest: ptsematest.o rt-utils.o rt-get_cpu.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-sigwaittest: sigwaittest.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+sigwaittest: sigwaittest.o rt-utils.o rt-get_cpu.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-svsematest: svsematest.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+svsematest: svsematest.o rt-utils.o rt-get_cpu.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
-sendme: sendme.o rt-utils.o
-	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
+sendme: sendme.o rt-utils.o rt-get_cpu.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS) $(EXTRA_LIBS)
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
 CLEANUP += $(if $(wildcard .git), ChangeLog)
diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index 8621a9e..fdc1056 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <time.h>
 #include "rt-utils.h"
+#include "rt-get_cpu.h"
 
 #include <utmpx.h>
 #include <sys/types.h>
@@ -195,8 +196,10 @@ int main(int argc, char *argv[])
 
 	if (setaffinity != AFFINITY_UNSPECIFIED) {
 		CPU_ZERO(&mask);
-		if (setaffinity == AFFINITY_USECURRENT)
-			affinity = sched_getcpu();
+		if (setaffinity == AFFINITY_USECURRENT) {
+			get_cpu_setup();
+			affinity = get_cpu();
+		}
 		CPU_SET(affinity, &mask);
 		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
 			fprintf(stderr,	"WARNING: Could not set CPU affinity "
diff --git a/src/lib/rt-get_cpu.c b/src/lib/rt-get_cpu.c
new file mode 100644
index 0000000..6ebda90
--- /dev/null
+++ b/src/lib/rt-get_cpu.c
@@ -0,0 +1,25 @@
+#include "rt-get_cpu.h"
+#ifdef __NR_getcpu
+#elif defined(__GLIBC__) && defined(__GLIBC_MINOR__)	\
+	&& __GLIBC__>=2 && __GLIBC_MINOR__>=6
+#else
+int (*get_cpu)(void);
+int (*get_cpu_vdsop)(unsigned int *, unsigned int *, void *);
+
+int get_cpu_setup(void)
+{
+	void *handle = dlopen("linux-vdso.so.1", RTLD_LAZY);
+	get_cpu_vdsop = NULL;
+	if (handle) {
+		get_cpu_vdsop = dlsym(handle, "getcpu");
+		dlclose(handle);
+		if (get_cpu_vdsop) {
+			get_cpu = getcpu_vdso;
+			return 0;
+		}
+	}
+	return -1;
+}
+
+#endif
+
diff --git a/src/lib/rt-get_cpu.h b/src/lib/rt-get_cpu.h
new file mode 100644
index 0000000..68ac17a
--- /dev/null
+++ b/src/lib/rt-get_cpu.h
@@ -0,0 +1,46 @@
+#ifndef RT_GET_CPU_H
+#define RT_GET_CPU_H
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/syscall.h>   /* For SYS_xxx definitions */
+#include <sched.h>
+#include <dlfcn.h>
+#ifdef __NR_getcpu
+static inline int get_cpu_setup(void) { return 0; }
+static inline int get_cpu(void)
+{
+        int c,s;
+	/* Show the source of get_cpu */
+#ifdef DEBUG
+	fprintf(stderr, "__NR_getcpu\n");
+#endif
+        s = syscall(__NR_getcpu, &c, NULL, NULL);
+        return (s == -1) ? s : c;
+}
+#elif defined(__GLIBC__) && defined(__GLIBC_MINOR__)	\
+	&& __GLIBC__>=2 && __GLIBC_MINOR__>=6
+#include <utmpx.h>
+static inline int get_cpu_setup(void) { return 0; }
+static inline int get_cpu(void) { return sched_getcpu(); }
+#else
+extern int get_cpu_setup(void);
+extern int (*get_cpu)(void);
+extern int (*get_cpu_vdsop)(unsigned int *, unsigned int *, void *);
+
+static inline int getcpu_vdso(void)
+{
+	unsigned int c,s;
+	/* Show the source of get_cpu */
+#ifdef DEBUG
+	fprintf(stderr, "getcpu_vdso\n");
+#endif
+	s = get_cpu_vdsop(&c, NULL, NULL);
+        return (s == -1) ? s : c;
+}
+
+#endif
+
+#endif	/* RT_GET_CPU_H */
+
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 2d19364..2683a2e 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -35,6 +35,7 @@
 #include <linux/unistd.h>
 #include <utmpx.h>
 #include "rt-utils.h"
+#include "rt-get_cpu.h"
 
 #include <pthread.h>
 
@@ -106,9 +107,8 @@ void *semathread(void *param)
 			par->samples++;
 			if(par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
-			if (mustgetcpu) {
-				par->cpu = sched_getcpu();
-			}
+			if (mustgetcpu)
+				par->cpu = get_cpu();
 		} else {
 			/* Receiver */
 			if (!first) {
@@ -148,9 +148,8 @@ void *semathread(void *param)
 
 			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
-			if (mustgetcpu) {
-				par->cpu = sched_getcpu();
-		        }
+			if (mustgetcpu)
+				par->cpu = get_cpu();
 			nanosleep(&par->delay, NULL);
 			pthread_mutex_unlock(&syncmutex[par->num]);
 		}
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 3c5aacf..1948d76 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -37,6 +37,7 @@
 #include <linux/unistd.h>
 #include <utmpx.h>
 #include "rt-utils.h"
+#include "rt-get_cpu.h"
 
 #include <pthread.h>
 
@@ -138,7 +139,7 @@ void *semathread(void *param)
 				par->shutdown = 1;
 
 			if (mustgetcpu) {
-				par->cpu = sched_getcpu();
+				par->cpu = get_cpu();
 			}
 			sigwait(&sigset, &sig);
 		} else {
@@ -162,7 +163,7 @@ void *semathread(void *param)
 				par->shutdown = 1;
 
 			if (mustgetcpu) {
-				par->cpu = sched_getcpu();
+				par->cpu = get_cpu();
 		        }
 			/*
 			 * Latency is the time spent between sending and
@@ -358,6 +359,8 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	get_cpu_setup();	/* init get_cpu() */
+
 	if (mustfork) {
 		int shmem;
 
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index ead78c7..a9f8f53 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -41,13 +41,9 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 #include "rt-utils.h"
-
-#define HAS_SCHED_GETCPU
+#include "rt-get_cpu.h"
 
 #define gettid() syscall(__NR_gettid)
-#ifndef HAS_SCHED_GETCPU
-#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
-#endif
 
 #define USEC_PER_SEC 1000000
 
@@ -143,15 +139,8 @@ void *semathread(void *param)
 			if(par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 
-			if (mustgetcpu) {
-#ifdef HAS_SCHED_GETCPU
-				par->cpu = sched_getcpu();
-#else
-				int c, s;
-	                        s = getcpu(&c, NULL, NULL);
-			        par->cpu = (s == -1) ? s : c;
-#endif
-			}
+			if (mustgetcpu)
+				par->cpu = get_cpu();
 
  			sb.sem_num = SEM_WAIT_FOR_RECEIVER;
  			sb.sem_op = SEM_LOCK;
@@ -182,15 +171,8 @@ void *semathread(void *param)
 			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 
-			if (mustgetcpu) {
-#ifdef HAS_SCHED_GETCPU
-				par->cpu = sched_getcpu();
-#else
-				int c, s;
-	                        s = getcpu(&c, NULL, NULL);
-			        par->cpu = (s == -1) ? s : c;
-#endif
-			}
+			if (mustgetcpu)
+				par->cpu = get_cpu();
 
 			timersub(&par->received, &neighbor->unblocked,
 			    &par->diff);
@@ -408,6 +390,8 @@ int main(int argc, char *argv[])
 		return 1;
 	}
 
+	get_cpu_setup();
+
 	if (mustfork) {
 		int shmem;
 
-- 
1.6.5.2

