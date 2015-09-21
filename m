From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 4/6] Fix compile-warnings
Date: Mon, 21 Sep 2015 17:27:26 +0200
Message-ID: <1442849248-573-5-git-send-email-haustad@cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-5.cisco.com ([173.37.142.92]:5762 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbbIUP3h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:37 -0400
In-Reply-To: <1442849248-573-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Check return-value from read/write/ftruncate and remove unused variables.

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/backfire/sendme.c                 |  8 ++++++--
 src/cyclictest/cyclictest.c           | 10 +++++++---
 src/pmqtest/pmqtest.c                 |  3 ++-
 src/ptsematest/ptsematest.c           |  3 ++-
 src/rt-migrate-test/rt-migrate-test.c |  5 +++--
 src/signaltest/signaltest.c           | 25 +++++++++++++++----------
 src/sigwaittest/sigwaittest.c         |  8 ++++++--
 src/svsematest/svsematest.c           |  9 +++++++--
 8 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index c1854d9..e524fbf 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -256,9 +256,13 @@ int main(int argc, char *argv[])
 			ts.tv_nsec = (interval % USEC_PER_SEC) * 1000;
 
 			gettimeofday(&before, NULL);
-			write(path, sigtest, strlen(sigtest));
+			if (write(path, sigtest, strlen(sigtest)) < 0) {
+				fprintf(stderr, "Could not write sigtest to backfire-path\n");
+			}
 			while (after.tv_sec == 0);
-			read(path, timestamp, sizeof(timestamp));
+			if (read(path, timestamp, sizeof(timestamp)) <= 0) {
+				fprintf(stderr, "Trouble reading file backfire-path\n");
+			}
 			if (sscanf(timestamp, "%lu,%lu\n", &sendtime.tv_sec,
 			    &sendtime.tv_usec) != 2)
 				break;
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2be72fa..42cd964 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -439,7 +439,9 @@ static void tracemark(char *fmt, ...)
 	va_start(ap, fmt);
 	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
 	va_end(ap);
-	write(tracemark_fd, tracebuf, len);
+	if (write(tracemark_fd, tracebuf, len) < 0) {
+		err_msg_n(errno, "WARN: could not write to tracebuf");
+	}
 }
 
 
@@ -452,7 +454,8 @@ static void tracing(int on)
 		case KV_26_LT24: prctl(0, 1); break;
 		case KV_26_33:
 		case KV_30:
-			write(trace_fd, "1", 1);
+			if (write(trace_fd, "1", 1) < 0)
+				err_msg_n(errno, "Could not set trace_fd");
 			break;
 		default:	 break;
 		}
@@ -462,7 +465,8 @@ static void tracing(int on)
 		case KV_26_LT24: prctl(0, 0); break;
 		case KV_26_33:
 		case KV_30:
-			write(trace_fd, "0", 1);
+			if (write(trace_fd, "0", 1) < 0)
+				err_msg_n(errno, "Could not set trace_fd");
 			break;
 		default:	break;
 		}
diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 75d5ee8..78eaa9c 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -210,7 +210,8 @@ void *pmqthread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					if (write(tracing_enabled, "0", 1) < 0)
+						err_msg_n(errno, "WARN: could write to tracing_enabled");
 					close(tracing_enabled);
 				} else
 					snprintf(par->error, sizeof(par->error),
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index a31c745..f777b38 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -137,7 +137,8 @@ void *semathread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					if (write(tracing_enabled, "0", 1) < 0)
+						err_msg_n(errno, "WARN: Could not enable tracing.");
 					close(tracing_enabled);
 				} else
 					snprintf(par->error, sizeof(par->error),
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 85a78da..1501432 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -44,7 +44,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
-
+#include "error.h"
 #define gettid() syscall(__NR_gettid)
 
 int nr_tasks;
@@ -87,7 +87,8 @@ static void ftrace_write(const char *fmt, ...)
 	n = vsnprintf(buff, BUFSIZ, fmt, ap);
 	va_end(ap);
 
-	write(mark_fd, buff, n);
+	if (write(mark_fd, buff, n) < 0)
+		err_msg_n(errno, "WARN: Could not write to trace_marker.");
 }
 
 #define nano2sec(nan) (nan / 1000000000ULL)
diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 61259a0..8c780b9 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -64,6 +64,11 @@ struct thread_stat {
 	int threadstarted;
 	int tid;
 };
+#define SYSTEM_W(x)				\
+	if (system((x)) < 0) {			\
+		fprintf(stderr, "Trouble running %s\n", (x));	\
+		return NULL;					\
+	}							\
 
 static int shutdown;
 static int tracelimit = 0;
@@ -101,16 +106,16 @@ void *signalthread(void *param)
 	int first = 1;
 
 	if (tracelimit) {
-		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
-		system("echo 1 > /proc/sys/kernel/trace_enabled");
-		system("echo 1 > /proc/sys/kernel/trace_freerunning");
-		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
-		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
-		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
-		system("echo 0 > /proc/sys/kernel/trace_verbose");
-		system("echo 0 > /proc/sys/kernel/preempt_thresh");
-		system("echo 0 > /proc/sys/kernel/wakeup_timing");
-		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_all_cpus");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_enabled");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_freerunning");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/trace_print_at_crash");
+		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_user_triggered");
+		SYSTEM_W("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/trace_verbose");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/preempt_thresh");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/wakeup_timing");
+		SYSTEM_W("echo 0 > /proc/sys/kernel/preempt_max_latency");
 	}
 
 	stat->tid = gettid();
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index 91fcdaa..abeaa35 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -36,6 +36,7 @@
 #include <sys/time.h>
 #include <linux/unistd.h>
 #include <utmpx.h>
+#include "error.h"
 #include "rt-utils.h"
 #include "rt-get_cpu.h"
 
@@ -185,7 +186,8 @@ void *semathread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					if (write(tracing_enabled, "0", 1) < 0)
+						err_msg_n(errno, "WARN: Could not disable tracing.");
 					close(tracing_enabled);
 				} else
 					snprintf(par->error, sizeof(par->error),
@@ -378,7 +380,9 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Could not create shared memory\n");
 			return 1;
 		}
-		ftruncate(shmem, totalsize);
+		if (ftruncate(shmem, totalsize) < 0)
+			err_msg_n(errno, "WARN: Could not truncate file to %d bytes.", totalsize);
+
 		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
 		    shmem, 0);
 		if (param == MAP_FAILED) {
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index eeb8285..9d4d2b9 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -191,7 +191,8 @@ void *semathread(void *param)
 				int tracing_enabled =
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >= 0) {
-					write(tracing_enabled, "0", 1);
+					if (write(tracing_enabled, "0", 1))
+						err_msg_n(errno, "WARN: Could not write to tracing_enabled!");
 					close(tracing_enabled);
 				} else
 					snprintf(par->error, sizeof(par->error),
@@ -431,7 +432,11 @@ int main(int argc, char *argv[])
 			fprintf(stderr, "Could not create shared memory\n");
 			return 1;
 		}
-		ftruncate(shmem, totalsize);
+		if (ftruncate(shmem, totalsize) < 0) {
+			fprintf(stderr, "Could not truncate file to specified size (%d)\n", totalsize);
+			return 1;
+
+		}
 		param = mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
 		    shmem, 0);
 		if (param == MAP_FAILED) {
-- 
1.9.1

