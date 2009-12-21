From: Carsten Emde <Carsten.Emde@osadl.org>
Subject: Re: More RT Test Programs
Date: Mon, 21 Dec 2009 03:10:36 +0100
Message-ID: <4B2ED91C.9030305@osadl.org>
References: <388070393.1730301260825543554.JavaMail.root@zmail07.collab.prod.int.phx2.redhat.com>	 <4B26B838.1080303@osadl.org>	 <alpine.LFD.2.00.0912150053010.6441@localhost.localdomain>	 <4B2E8C51.3040302@osadl.org>	 <520f0cf10912201451q55c823cbia07c23f4a3bbe98c@mail.gmail.com>	 <4B2EB806.301@osadl.org> <520f0cf10912201605y4019b940p346c73b927a52b39@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050704060901030306030808"
Cc: Clark Williams <williams@redhat.com>,
	RT-Users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:43337 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbZLUCUh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Dec 2009 21:20:37 -0500
In-Reply-To: <520f0cf10912201605y4019b940p346c73b927a52b39@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050704060901030306030808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

John,

>> I have found an issue with all source files of the new tests. At some
>> stage between the original files and Clark's tree, the line delimiters
>> changed from NL to CR/NL. Would be great, if you could move this back to NL.
> Weird - I'll remove them.
> It's not coming from you is it? The patch that you attached here has
> ^M at the end of each line.
Yes, this is because of the ^Ms in the original file. I had to use
diff's -w option.

> I can run that through a script to remove it - but you
> should look into where that is coming from on your end.
Okay. Here comes another patch. Let's see in what shape it arrives at
your side. I converted the files and did not use diff's -w option this
time. You need to remove the ^Ms from the patched files; otherwise, the
patch will not apply.

>> A second issue is related to the removal of the getcpu() definition.
>> There is a leftover in svsematest.c which should also be removed for
>> consistency. However, this and the other tests no longer compile in EL5
>> without this definition - should we better revert this and provide a
>> working recognition through "grep sched_getcpu
>> /usr/include/bits/sched.h"? Or is EL5 irrelevant in this context? I
>> still have an EL5 test machine where all RT kernels are tested.
> Yup - I've been struggling with a resolution for this issue, I have something
> to post tomorrow after my testing is complete. EL5 is not irrelevant to us.
Below comes a proposal of a patch that works here on EL5.

> Do you test 32-bit as well as 64-bit?
No - currently, I have only an F11 machine that runs 64-bit. Is there an
issue with EL5 64-bit?

	Carsten.


-=-------------------------------------------------------------------=-
Generate getcpu.h to use getcpu() instead of sched_getcpu(), if needed.

Signed-off-by: Carsten Emde <C.Emde@osadl.org>


--------------050704060901030306030808
Content-Type: text/x-patch;
 name="use-getcpu-if-sched_getcpu-not-available.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="use-getcpu-if-sched_getcpu-not-available.patch"

Index: rt-tests/Makefile
===================================================================
--- rt-tests.orig/Makefile
+++ rt-tests/Makefile
@@ -20,7 +20,11 @@ endif
 UTILS	= src/lib/rt-utils.o
 
 .PHONY: all
-all: $(TARGETS)
+all:  src/lib/getcpu.h $(TARGETS)
+
+src/lib/getcpu.h:
+	@touch $@
+	@grep -q sched_getcpu /usr/include/bits/sched.h && echo "#define HAS_SCHED_GETCPU" >$@; true
 
 cyclictest: src/cyclictest/cyclictest.c $(UTILS)
 	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
@@ -59,7 +63,7 @@ CLEANUP += $(if $(wildcard .git), Change
 .PHONY: clean
 clean:
 	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
-	rm -f hwlatdetect
+	rm -f hwlatdetect src/lib/getcpu.h
 
 .PHONY: distclean
 distclean: clean
Index: rt-tests/src/backfire/sendme.c
===================================================================
--- rt-tests.orig/src/backfire/sendme.c
+++ rt-tests/src/backfire/sendme.c
@@ -30,6 +30,7 @@
 #include <string.h>
 #include <time.h>
 #include "rt-utils.h"
+#include "getcpu.h"
 
 #define _GNU_SOURCE
 #include <utmpx.h>
@@ -38,11 +39,17 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 
+#include <linux/unistd.h>
+
 #define USEC_PER_SEC		1000000
 #define NSEC_PER_SEC		1000000000
 
 #define SIGTEST SIGHUP
 
+#ifndef HAS_SCHED_GETCPU
+#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
+#endif
+
 enum {
 	AFFINITY_UNSPECIFIED,
 	AFFINITY_SPECIFIED,
@@ -197,8 +204,15 @@ int main(int argc, char *argv[])
 
 	if (setaffinity != AFFINITY_UNSPECIFIED) {
 		CPU_ZERO(&mask);
-		if (setaffinity == AFFINITY_USECURRENT)
+		if (setaffinity == AFFINITY_USECURRENT) {
+#ifdef HAS_SCHED_GETCPU
 			affinity = sched_getcpu();
+#else
+			int c, s;
+                        s = getcpu(&c, NULL, NULL);
+		        affinity = (s == -1) ? s : c;
+#endif
+                }
 		CPU_SET(affinity, &mask);
 		if (sched_setaffinity(0, sizeof(mask), &mask) == -1)
 			fprintf(stderr,	"WARNING: Could not set CPU affinity "
Index: rt-tests/src/ptsematest/ptsematest.c
===================================================================
--- rt-tests.orig/src/ptsematest/ptsematest.c
+++ rt-tests/src/ptsematest/ptsematest.c
@@ -35,11 +35,15 @@
 #include <linux/unistd.h>
 #include <utmpx.h>
 #include "rt-utils.h"
+#include "getcpu.h"
 
 #define __USE_GNU
 #include <pthread.h>
 
 #define gettid() syscall(__NR_gettid)
+#ifndef HAS_SCHED_GETCPU
+#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
+#endif
 
 #define USEC_PER_SEC 1000000
 
@@ -108,7 +112,13 @@ void *semathread(void *param)
 			if(par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
 			}
 		} else {
 			/* Receiver */
@@ -150,7 +160,13 @@ void *semathread(void *param)
 			if (par->max_cycles && par->samples >= par->max_cycles)
 				par->shutdown = 1;
 			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
 		        }
 			nanosleep(&par->delay, NULL);
 			pthread_mutex_unlock(&syncmutex[par->num]);
Index: rt-tests/src/sigwaittest/sigwaittest.c
===================================================================
--- rt-tests.orig/src/sigwaittest/sigwaittest.c
+++ rt-tests/src/sigwaittest/sigwaittest.c
@@ -37,11 +37,15 @@
 #include <linux/unistd.h>
 #include <utmpx.h>
 #include "rt-utils.h"
+#include "getcpu.h"
 
 #define __USE_GNU
 #include <pthread.h>
 
 #define gettid() syscall(__NR_gettid)
+#ifndef HAS_SCHED_GETCPU
+#define getcpu(cpu, node, cache) syscall(__NR_getcpu, cpu, node, cache)
+#endif
 
 #define USEC_PER_SEC 1000000
 
@@ -139,7 +143,13 @@ void *semathread(void *param)
 				par->shutdown = 1;
 
 			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
 			}
 			sigwait(&sigset, &sig);
 		} else {
@@ -163,7 +173,13 @@ void *semathread(void *param)
 				par->shutdown = 1;
 
 			if (mustgetcpu) {
+#ifdef HAS_SCHED_GETCPU
 				par->cpu = sched_getcpu();
+#else
+				int c, s;
+	                        s = getcpu(&c, NULL, NULL);
+			        par->cpu = (s == -1) ? s : c;
+#endif
 		        }
 			/*
 			 * Latency is the time spent between sending and
Index: rt-tests/src/svsematest/svsematest.c
===================================================================
--- rt-tests.orig/src/svsematest/svsematest.c
+++ rt-tests/src/svsematest/svsematest.c
@@ -42,8 +42,7 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 #include "rt-utils.h"
--------------050704060901030306030808--
