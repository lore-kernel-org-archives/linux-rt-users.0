From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/4] rt-tests: Makefile - Changes to unify and simplify the Makefile
Date: Mon, 21 Dec 2009 22:45:47 +0100
Message-ID: <1261431950-28500-2-git-send-email-jkacur@redhat.com>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	Carsten Emde <carsten.emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64114 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757277AbZLUVqI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 16:46:08 -0500
Received: by bwz27 with SMTP id 27so3775854bwz.21
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Dec 2009 13:46:06 -0800 (PST)
In-Reply-To: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- These changes simplify the Makefile. For example, notice that we no
longer need to specify the full path to the source file
- These changes also unify the Makefile, for example, every program
gets VERSION_STRING as an floating point number.
- Due to the above change I had to make a number of changes in the programs
that expected VERSION_STRING as a string.
- By unifying what we CFLAGS, to include -D_GNU_SOURCE, I had to remove
__USE_GNU which is reduncant in a number of files.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                              |   52 ++++++++++++++++++++------------
 src/backfire/sendme.c                 |    2 -
 src/cyclictest/cyclictest.c           |    1 -
 src/pi_tests/pi_stress.c              |    7 +---
 src/ptsematest/ptsematest.c           |    1 -
 src/rt-migrate-test/rt-migrate-test.c |    2 +-
 src/sigwaittest/sigwaittest.c         |    1 -
 src/svsematest/svsematest.c           |    1 -
 8 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/Makefile b/Makefile
index 9a42532..4ca4470 100644
--- a/Makefile
+++ b/Makefile
@@ -10,48 +10,60 @@ bindir  ?= $(prefix)/bin
 mandir	?= $(prefix)/share/man
 srcdir	?= $(prefix)/src
 
-CFLAGS = -Wall -Wno-nonnull -Isrc/lib
+CFLAGS = -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/lib
+
 ifndef DEBUG
 	CFLAGS	+= -O2
 else
 	CFLAGS	+= -O0 -g
 endif
 
-UTILS	= src/lib/rt-utils.o
+VPATH	= src/cyclictest:
+VPATH	+= src/signaltest:
+VPATH	+= src/pi_tests:
+VPATH	+= src/rt-migrate-test:
+VPATH	+= src/ptsematest:
+VPATH	+= src/sigwaittest:
+VPATH	+= src/svsematest:
+VPATH	+= src/backfire:
+VPATH	+= src/lib
+
+%.o: %.c
+	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS)
 
 .PHONY: all
 all: $(TARGETS)
 
-cyclictest: src/cyclictest/cyclictest.c $(UTILS)
-	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+cyclictest: cyclictest.o rt-utils.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-signaltest: src/signaltest/signaltest.c $(UTILS)
-	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+signaltest: signaltest.o rt-utils.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-classic_pi: src/pi_tests/classic_pi.c
-	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
+classic_pi: classic_pi.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-pi_stress:  src/pi_tests/pi_stress.c
-	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
+pi_stress: pi_stress.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
 hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
-rt-migrate-test: src/rt-migrate-test/rt-migrate-test.c
-	$(CC) $(CFLAGS) -D_GNU_SOURCE -D VERSION_STRING=\"$(VERSION_STRING)\" $^ -o $@ $(LIBS)
+rt-migrate-test: rt-migrate-test.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-ptsematest: src/ptsematest/ptsematest.c $(UTILS)
-	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+ptsematest: ptsematest.o rt-utils.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-sigwaittest: src/sigwaittest/sigwaittest.c $(UTILS)
-	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+sigwaittest: sigwaittest.o rt-utils.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-svsematest: src/svsematest/svsematest.c $(UTILS)
-	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+svsematest: svsematest.o rt-utils.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
-sendme: src/backfire/sendme.c $(UTILS)
-	$(CC) $(CFLAGS) -D VERSION_STRING=$(VERSION_STRING) $^ -o $@ $(LIBS)
+sendme: sendme.o rt-utils.o
+	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
 
 CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec
 CLEANUP += $(if $(wildcard .git), ChangeLog)
diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index 3736ddb..8621a9e 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -22,7 +22,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
-#define __USE_GNU
 #include <fcntl.h>
 #include <getopt.h>
 #include <signal.h>
@@ -31,7 +30,6 @@
 #include <time.h>
 #include "rt-utils.h"
 
-#define _GNU_SOURCE
 #include <utmpx.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 811ce9f..20251a0 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -13,7 +13,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#define __USE_GNU
 #include <fcntl.h>
 #include <getopt.h>
 #include <pthread.h>
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 89a749c..0940567 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -55,10 +55,6 @@
 #include <sys/wait.h>
 #include <termios.h>
 
-/* version */
-const char *version =
-    "pi_stress v" VERSION_STRING " (" __DATE__ " " __TIME__ ")";
-
 /* conversions */
 #define USEC_PER_SEC 	1000000
 #define NSEC_PER_SEC 	1000000000
@@ -1230,7 +1226,8 @@ void process_command_line(int argc, char **argv)
 			debugging = 1;
 			break;
 		case 'V':
-			puts(version);
+			printf("pi_stress v%1.2f ", VERSION_STRING);
+			printf("(%s %s)\n", __DATE__, __TIME__);
 			exit(0);
 		case 'u':
 			uniprocessor = 1;
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index aaae92a..2d19364 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -36,7 +36,6 @@
 #include <utmpx.h>
 #include "rt-utils.h"
 
-#define __USE_GNU
 #include <pthread.h>
 
 #define gettid() syscall(__NR_gettid)
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index e22d188..1963641 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -162,7 +162,7 @@ static void usage(char **argv)
 		p--;
 	p++;
 
-	printf("%s %s\n", p, VERSION_STRING);
+	printf("%s %1.2f\n", p, VERSION_STRING);
 	printf("Usage:\n"
 	       "%s <options> nr_tasks\n\n"
 	       "-p prio --prio  prio        base priority to start RT tasks with (2) \n"
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index adb51cf..3c5aacf 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -38,7 +38,6 @@
 #include <utmpx.h>
 #include "rt-utils.h"
 
-#define __USE_GNU
 #include <pthread.h>
 
 #define gettid() syscall(__NR_gettid)
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 50224de..ead78c7 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -24,7 +24,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
-#define __USE_GNU
 #include <fcntl.h>
 #include <getopt.h>
 #include <pthread.h>
-- 
1.6.5.2

