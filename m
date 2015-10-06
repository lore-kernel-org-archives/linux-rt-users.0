From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 1/4] Properly test for return-values from read() and write()
Date: Tue,  6 Oct 2015 11:08:20 +0200
Message-ID: <1444122503-8112-1-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik Austad <haustad@cisco.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-7.cisco.com ([173.37.142.94]:34697 "EHLO
	alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbJFJL3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 05:11:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It is conceivable that read() and write() will fail, and when they do,
it is useful to catch these errors. This also has the benefit of
removing gcc-warnings like :

warning: ignoring return value of =E2=80=98write=E2=80=99, declared wit=
h attribute warn_unused_result [-Wunused-result]
      write(tracing_enabled, "0", 1);
            ^
warning: ignoring return value of =E2=80=98ftruncate=E2=80=99, declared=
 with attribute warn_unused_result [-Wunused-result]
   ftruncate(shmem, totalsize);
            ^
warning: ignoring return value of =E2=80=98read=E2=80=99, declared with=
 attribute warn_unused_result [-Wunused-result]
    read(path, timestamp, sizeof(timestamp));
        ^
Signed-off-by: Henrik Austad <haustad@cisco.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
---
 src/backfire/sendme.c                 | 8 ++++++--
 src/cyclictest/cyclictest.c           | 9 ++++++---
 src/pmqtest/pmqtest.c                 | 3 ++-
 src/ptsematest/ptsematest.c           | 3 ++-
 src/rt-migrate-test/rt-migrate-test.c | 5 +++--
 src/sigwaittest/sigwaittest.c         | 8 ++++++--
 src/svsematest/svsematest.c           | 9 +++++++--
 7 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
index c1854d9..34504b7 100644
--- a/src/backfire/sendme.c
+++ b/src/backfire/sendme.c
@@ -256,9 +256,13 @@ int main(int argc, char *argv[])
 			ts.tv_nsec =3D (interval % USEC_PER_SEC) * 1000;
=20
 			gettimeofday(&before, NULL);
-			write(path, sigtest, strlen(sigtest));
+			if (write(path, sigtest, strlen(sigtest)) < 0)
+				fprintf(stderr, "Could not write sigtest to backfire-path\n");
+
 			while (after.tv_sec =3D=3D 0);
-			read(path, timestamp, sizeof(timestamp));
+			if (read(path, timestamp, sizeof(timestamp)) <=3D 0)
+				fprintf(stderr, "Trouble reading file backfire-path\n");
+
 			if (sscanf(timestamp, "%lu,%lu\n", &sendtime.tv_sec,
 			    &sendtime.tv_usec) !=3D 2)
 				break;
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 58f1983..22932e9 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -450,7 +450,8 @@ static void tracemark(char *fmt, ...)
 	va_start(ap, fmt);
 	len =3D vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
 	va_end(ap);
-	write(tracemark_fd, tracebuf, len);
+	if (write(tracemark_fd, tracebuf, len) < 0)
+		err_msg_n(errno, "WARN: could not write to tracebuf");
 }
=20
=20
@@ -463,7 +464,8 @@ static void tracing(int on)
 		case KV_26_LT24: prctl(0, 1); break;
 		case KV_26_33:
 		case KV_30:
-			write(trace_fd, "1", 1);
+			if (write(trace_fd, "1", 1) < 0)
+				err_msg_n(errno, "Could not set trace_fd");
 			break;
 		default:	 break;
 		}
@@ -473,7 +475,8 @@ static void tracing(int on)
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
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >=3D 0) {
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
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >=3D 0) {
-					write(tracing_enabled, "0", 1);
+					if (write(tracing_enabled, "0", 1) < 0)
+						err_msg_n(errno, "WARN: Could not enable tracing.");
 					close(tracing_enabled);
 				} else
 					snprintf(par->error, sizeof(par->error),
diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-tes=
t/rt-migrate-test.c
index d7b68dd..352a331 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -44,7 +44,7 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
-
+#include "error.h"
 #define gettid() syscall(__NR_gettid)
=20
 int nr_tasks;
@@ -87,7 +87,8 @@ static void ftrace_write(const char *fmt, ...)
 	n =3D vsnprintf(buff, BUFSIZ, fmt, ap);
 	va_end(ap);
=20
-	write(mark_fd, buff, n);
+	if (write(mark_fd, buff, n) < 0)
+		err_msg_n(errno, "WARN: Could not write to trace_marker.");
 }
=20
 #define nano2sec(nan) (nan / 1000000000ULL)
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittes=
t.c
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
=20
@@ -185,7 +186,8 @@ void *semathread(void *param)
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >=3D 0) {
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
+			err_msg_n(errno, "WARN: Could not truncate file to %d bytes.", tota=
lsize);
+
 		param =3D mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
 		    shmem, 0);
 		if (param =3D=3D MAP_FAILED) {
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index eeb8285..9d4d2b9 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -191,7 +191,8 @@ void *semathread(void *param)
 				int tracing_enabled =3D
 				    open(tracing_enabled_file, O_WRONLY);
 				if (tracing_enabled >=3D 0) {
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
+			fprintf(stderr, "Could not truncate file to specified size (%d)\n",=
 totalsize);
+			return 1;
+
+		}
 		param =3D mmap(0, totalsize, PROT_READ|PROT_WRITE, MAP_SHARED,
 		    shmem, 0);
 		if (param =3D=3D MAP_FAILED) {
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
