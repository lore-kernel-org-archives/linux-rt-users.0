From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rt-tests: Update rt-migrate-test to use ftrace
 infrastructure
Date: Wed, 21 Mar 2012 13:06:43 -0400
Message-ID: <1332349603.23924.47.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <clark@redhat.com>,
	Darren Hart <dvhart@linux.intel.com>,
	John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:11385 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533Ab2CURGq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Mar 2012 13:06:46 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The rt-migrate-test in the rt-tests is still using the old logdev
interface that requires the logdev patch. Ftrace has been introduced
into mainline Linux since 2.6.27 and has many more features than logdev.
The rt-migrate-test should interact with ftrace instead of logdev.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 1963641..e3c7a09 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -44,39 +44,55 @@
 #include <errno.h>
 #include <sched.h>
 #include <pthread.h>
-#ifdef LOGDEV
-# include <dump_log.h>
-# define do_logdev_open() open("/debug/logdev/write", O_WRONLY)
-# define do_logdev_close(ld) close(ld)
-__thread char buff[BUFSIZ];
-static lgprint(int fd, const char *fmt, ...)
+
+#define gettid() syscall(__NR_gettid)
+
+#ifndef VERSION_STRING
+#define VERSION_STRING 0.3
+#endif
+
+int nr_tasks;
+int lfd;
+
+static int mark_fd = -1;
+static __thread char buff[BUFSIZ+1];
+
+static void setup_ftrace_marker(void)
+{
+	struct stat st;
+	char *files[] = {
+		"/sys/kernel/debug/tracing/trace_marker",
+		"/debug/tracing/trace_marker",
+		"/debugfs/tracing/trace_marker",
+	};
+	int ret;
+	int i;
+
+	for (i = 0; i < (sizeof(files) / sizeof(char *)); i++) {
+		ret = stat(files[i], &st);
+		if (ret >= 0)
+			goto found;
+	}
+	/* todo, check mounts system */
+	return;
+found:
+	mark_fd = open(files[i], O_WRONLY);
+}
+
+static void ftrace_write(const char *fmt, ...)
 {
 	va_list ap;
 	int n;
 
+	if (mark_fd < 0)
+		return;
+
 	va_start(ap, fmt);
 	n = vsnprintf(buff, BUFSIZ, fmt, ap);
 	va_end(ap);
 
-	write(fd, buff, n);
+	write(mark_fd, buff, n);
 }
-#else
-# define do_logdev_open() (0)
-# define do_logdev_close(lfd) do { } while(0)
-# define logdev_print_set(x)  do { } while(0)
-# define logdev_switch_set(x)  do { } while(0)
-# define lgprint(x...) do { } while(0)
-#endif
-
-
-#define gettid() syscall(__NR_gettid)
-
-#ifndef VERSION_STRING
-#define VERSION_STRING "V 0.3"
-#endif
-
-int nr_tasks;
-int lfd;
 
 #define nano2sec(nan) (nan / 1000000000ULL)
 #define nano2ms(nan) (nan / 1000000ULL)
@@ -360,8 +376,8 @@ void *start_task(void *data)
 		}
 		pthread_barrier_wait(&start_barrier);
 		start_time = get_time();
-		lgprint(lfd, "Thread %d: started %lld diff %lld\n",
-			pid, start_time, start_time - now);
+		ftrace_write("Thread %d: started %lld diff %lld\n",
+			     pid, start_time, start_time - now);
 		l = busy_loop(start_time);
 		record_time(id, start_time, l);
 		pthread_barrier_wait(&end_barrier);
@@ -403,8 +419,6 @@ static int check_times(int l)
 
 static void stop_log(int sig)
 {
-	logdev_print_set(0);
-	logdev_switch_set(0);
 	stop = 1;
 }
 
@@ -527,27 +541,25 @@ int main (int argc, char **argv)
 
 	print_progress_bar(0);
 
-	lfd = do_logdev_open();
-	logdev_print_set(1);
-	logdev_switch_set(1);
+	setup_ftrace_marker();
 
 	for (loop=0; loop < nr_runs; loop++) {
 		unsigned long long end;
 
 		now = get_time();
 
-		lgprint(lfd, "Loop %d now=%lld\n", loop, now);
+		ftrace_write("Loop %d now=%lld\n", loop, now);
 
 		pthread_barrier_wait(&start_barrier);
 
-		lgprint(lfd, "All running!!!\n");
+		ftrace_write("All running!!!\n");
 
 		nanosleep(&intv, NULL);
 
 		print_progress_bar((loop * 100)/ nr_runs);
 
 		end = get_time();
-		lgprint(lfd, "Loop %d end now=%lld diff=%lld\n", loop, end, end - now);
+		ftrace_write("Loop %d end now=%lld diff=%lld\n", loop, end, end - now);
 
 		pthread_barrier_wait(&end_barrier);
 
@@ -557,8 +569,6 @@ int main (int argc, char **argv)
 			break;
 		}
 	}
-	do_logdev_close(lfd);
-
 	putc('\n', stderr);
 
 	pthread_barrier_wait(&start_barrier);
@@ -568,9 +578,6 @@ int main (int argc, char **argv)
 	for (i=0; i < nr_tasks; i++)
 		pthread_join(threads[i], (void*)&thread_pids[i]);
 
-	logdev_print_set(0);
-	logdev_switch_set(0);
