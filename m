From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/6] Change VERSION_STRING to VERSION
Date: Fri, 10 Jul 2015 14:25:30 +0200
Message-ID: <1436531131-9186-6-git-send-email-jkacur@redhat.com>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:33304 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbbGJMZu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:50 -0400
Received: by wgck11 with SMTP id k11so248247327wgc.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:48 -0700 (PDT)
In-Reply-To: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Adding _STRING doesn't add any extra meaning, but the extra length makes
the Makefile more unreadable than is necessary, so shorten this up

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                      | 20 ++++++++++----------
 src/backfire/sendme.c         |  2 +-
 src/cyclictest/cyclictest.c   |  2 +-
 src/pi_tests/pi_stress.c      |  2 +-
 src/pmqtest/pmqtest.c         |  2 +-
 src/ptsematest/ptsematest.c   |  2 +-
 src/signaltest/signaltest.c   |  2 +-
 src/sigwaittest/sigwaittest.c |  2 +-
 src/svsematest/svsematest.c   |  2 +-
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Makefile b/Makefile
index a48e7597b908..1f7640b82fa6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,4 @@
-VERSION_STRING = 0.92
+VERSION = 0.92
 
 HAVE_NPTL ?= yes
 
@@ -60,7 +60,7 @@ VPATH	+= src/lib
 VPATH	+= src/hackbench
 
 %.o: %.c
-	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS) $(CPPFLAGS)
+	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS)
 
 # Pattern rule to generate dependency files from .c files
 %.d: %.c
@@ -158,23 +158,23 @@ release: distclean changelog
 	mkdir -p releases
 	mkdir -p tmp/rt-tests
 	cp -r Makefile COPYING ChangeLog MAINTAINERS doc README.markdown src tmp/rt-tests
-	rm -f rt-tests-$(VERSION_STRING).tar rt-tests-$(VERSION_STRING).tar.asc
-	tar -C tmp -cf rt-tests-$(VERSION_STRING).tar rt-tests
-	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tests-$(VERSION_STRING).tar
-	gzip rt-tests-$(VERSION_STRING).tar
+	rm -f rt-tests-$(VERSION).tar rt-tests-$(VERSION).tar.asc
+	tar -C tmp -cf rt-tests-$(VERSION).tar rt-tests
+	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tests-$(VERSION).tar
+	gzip rt-tests-$(VERSION).tar
 	rm -f ChangeLog
-	cp rt-tests-$(VERSION_STRING).tar.gz rt-tests-$(VERSION_STRING).tar.asc releases
+	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
 
 .PHONY: push
 push:	release
-	scripts/do-git-push $(VERSION_STRING)
+	scripts/do-git-push $(VERSION)
 
 .PHONY: pushtest
 pushtest: release
-	scripts/do-git-push --test $(VERSION_STRING)
+	scripts/do-git-push --test $(VERSION)
 
 rt-tests.spec: Makefile rt-tests.spec-in
-	sed s/__VERSION__/$(VERSION_STRING)/ <$@-in >$@
+	sed s/__VERSION__/$(VERSION)/ <$@-in >$@
 ifeq ($(NUMA),1)
 	sed -i -e 's/__MAKE_NUMA__/NUMA=1/' $@
 	sed -i -e 's/__BUILDREQUIRES_NUMA__/numactl-devel/' $@
diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index 8c169dda5857..c1854d9660cb 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -108,7 +108,7 @@ void stop_tracing(void)
 
 static void display_help(void)
 {
-	printf("sendme V %1.2f\n", VERSION_STRING);
+	printf("sendme V %1.2f\n", VERSION);
 	puts("Usage: sendme <options>");
 	puts("Function: send a signal from driver to userspace");
 	puts(
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 34053c5d42b0..94e383f8fde1 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1016,7 +1016,7 @@ static void display_help(int error)
 			strcpy(tracers, "none");
 	}
 
-	printf("cyclictest V %1.2f\n", VERSION_STRING);
+	printf("cyclictest V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "cyclictest <options>\n\n"
 #if LIBNUMA_API_VERSION >= 2
diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 1d1cc58fae54..a4e6e3df1a3d 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -1362,7 +1362,7 @@ void process_command_line(int argc, char **argv)
 			debugging = 1;
 			break;
 		case 'V':
-			printf("pi_stress v%1.2f ", VERSION_STRING);
+			printf("pi_stress v%1.2f ", VERSION);
 			exit(0);
 		case 'u':
 			uniprocessor = 1;
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 336a8eb23626..75d5ee8185a0 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -240,7 +240,7 @@ void *pmqthread(void *param)
 
 static void display_help(void)
 {
-	printf("pmqtest V %1.2f\n", VERSION_STRING);
+	printf("pmqtest V %1.2f\n", VERSION);
 	puts("Usage: pmqtest <options>");
 	puts("Function: test POSIX message queue latency");
 	puts(
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index 7558a41d1917..a31c745ec928 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -162,7 +162,7 @@ void *semathread(void *param)
 
 static void display_help(void)
 {
-	printf("ptsematest V %1.2f\n", VERSION_STRING);
+	printf("ptsematest V %1.2f\n", VERSION);
 	puts("Usage: ptsematest <options>");
 	puts("Function: test POSIX threads mutex latency");
 	puts(
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 9454a2642342..61259a0a8913 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -202,7 +202,7 @@ out:
 /* Print usage information */
 static void display_help(void)
 {
-	printf("signaltest V %1.2f\n", VERSION_STRING);
+	printf("signaltest V %1.2f\n", VERSION);
 	printf("Usage:\n"
 	       "signaltest <options>\n\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 428f5cecadd7..91fcdaa5f185 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -210,7 +210,7 @@ void *semathread(void *param)
 
 static void display_help(void)
 {
-	printf("sigwaittest V %1.2f\n", VERSION_STRING);
+	printf("sigwaittest V %1.2f\n", VERSION);
 	puts("Usage: sigwaittest <options>");
 	puts("Function: test sigwait() latency");
 	puts(
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index c1128cc375b1..eeb82858720a 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -236,7 +236,7 @@ union semun {
 
 static void display_help(void)
 {
-	printf("svsematest V %1.2f\n", VERSION_STRING);
+	printf("svsematest V %1.2f\n", VERSION);
 	puts("Usage: svsematest <options>");
 	puts("Function: test SYSV semaphore latency");
 	puts(
-- 
1.8.3.1

