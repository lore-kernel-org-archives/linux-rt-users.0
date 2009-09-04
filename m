From: OB <obconseil@gmail.com>
Subject: Patch to add the TimerFD API to "cyclictest"
Date: Fri, 04 Sep 2009 09:18:06 +0200
Message-ID: <4AA0BF2E.5060607@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000406030506090703070909"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:59466 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756547AbZIDHSF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Sep 2009 03:18:05 -0400
Received: by fxm17 with SMTP id 17so469402fxm.37
        for <linux-rt-users@vger.kernel.org>; Fri, 04 Sep 2009 00:18:06 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000406030506090703070909
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Please find below a patch to enable the use of the TimerFD API
to the cyclictest program.

It add the -F option for this, and can be used on either MONOTONIC and REALTIME
clock, in absolute or relative time.

It has been tested on CentOS4 with a custom , 2.6.19-rt15 kernel and on a
Debian Lenny with a -wireless-testing kernel (non-preempt-rt), so far.
(The latest shown a strange behavior : in MONOTONIC / RELATIVE clocking,
sometimes it happen that the minimum delay become negative. In my opinion, it
would mean that the read() syscall returned *before* the required expiration
delay - but it might just be a bug in my code. It does not appear on the
preempt-rt kernel)

Please let me know if you see any obvious mistake. You may include this patch
in the repository at will.

Bye,

obconseil
-- 
People in the embedded space don't do prototypes. They hack something until it
works, then it's done.
---
Always code as if the person who will maintain your code is a maniac serial
killer that knows where you live


--------------000406030506090703070909
Content-Type: text/x-patch;
 name="cyclictest_timerfd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cyclictest_timerfd.patch"

diff --git a/Makefile b/Makefile
index 911b05e..e9491dd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION_STRING = 0.50
 
 TARGETS	= cyclictest signaltest classic_pi pi_stress hwlatdetect
-FLAGS	= -Wall -Wno-nonnull -O2
+FLAGS	= -Wall -Wno-nonnull -O2 -DWITH_TIMERFD
 LIBS 	= -lpthread -lrt
 DESTDIR	?=
 prefix  ?= /usr/local
diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 2b4dc50..580f140 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -46,6 +46,43 @@
 #define gettid() syscall(__NR_gettid)
 #define sigev_notify_thread_id _sigev_un._tid
 
+#ifdef WITH_TIMERFD
+/*
+ * This were good at the time of 2.6.23-rc7 ...
+ */
+#ifndef __NR_timerfd
+
+#if defined(__x86_64__)
+#define __NR_timerfd_create 283
+#define __NR_timerfd_settime 286
+#define __NR_timerfd_gettime 287
+
+#elif defined(__i386__)
+#define __NR_timerfd_create 322
+#define __NR_timerfd_settime 325
+#define __NR_timerfd_gettime 326
+
+#else
+#error Cannot detect your architecture!
+#endif
+
+#define TFD_TIMER_ABSTIME (1 << 0)
+inline int timerfd_create(int clockid, int flags) {
+	return syscall(__NR_timerfd_create, clockid, flags);
+}
+
+inline int timerfd_settime(int ufc, int flags, const struct itimerspec *utmr,
+		    struct itimerspec *otmr) {
+	return syscall(__NR_timerfd_settime, ufc, flags, utmr, otmr);
+}
+
+inline int timerfd_gettime(int ufc, struct itimerspec *otmr) {
+	return syscall(__NR_timerfd_gettime, ufc, otmr);
+}
+#endif
+#endif // timerfd
+
+
 #ifdef __UCLIBC__
 #define MAKE_PROCESS_CPUCLOCK(pid, clock) \
 	((~(clockid_t) (pid) << 3) | (clockid_t) (clock))
@@ -74,7 +111,7 @@ static void CPU_ZERO(cpu_set_t *set) { }
 extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 			   __const struct timespec *__req,
 			   struct timespec *__rem);
-#endif
+#endif // uclibc
 
 #define USEC_PER_SEC		1000000
 #define NSEC_PER_SEC		1000000000
@@ -86,6 +123,7 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 #define MODE_SYS_ITIMER		2
 #define MODE_SYS_NANOSLEEP	3
 #define MODE_SYS_OFFSET		2
+#define MODE_TIMERFD	        4
 
 #define TIMER_RELTIME		0
 
@@ -553,6 +591,7 @@ parse_time_string(char *val)
  * Modes:
  * - clock_nanosleep based
  * - cyclic timer based
+ * - timerfd based 
  *
  * Clock:
  * - CLOCK_MONOTONIC
@@ -574,6 +613,10 @@ void *timerthread(void *param)
 	struct thread_stat *stat = par->stats;
 	int stopped = 0;
 	cpu_set_t mask;
+#ifdef WITH_TIMERFD
+	int timerfd_id = 0;
+	unsigned long long timerfd_data=0;
+#endif
 
 	if (par->cpu != -1) {
 		CPU_ZERO(&mask);
@@ -599,7 +642,13 @@ void *timerthread(void *param)
 		timer_create(par->clock, &sigev, &timer);
 		tspec.it_interval = interval;
 	}
-
+#ifdef WITH_TIMERFD
+	if (par->mode == MODE_TIMERFD) {
+		timerfd_id =  timerfd_create(par->clock, 0);
+		if (timerfd_id == -1)
+			fprintf(stderr,"Error : Cannot create the timerfd\n");
+	}
+#endif
 	memset(&schedp, 0, sizeof(schedp));
 	schedp.sched_priority = par->prio;
 	sched_setscheduler(0, par->policy, &schedp);
@@ -615,6 +664,7 @@ void *timerthread(void *param)
 		stop.tv_sec += duration;
 		tsnorm(&stop);
 	}
+
 	if (par->mode == MODE_CYCLIC) {
 		if (par->timermode == TIMER_ABSTIME)
 			tspec.it_value = next;
@@ -632,7 +682,20 @@ void *timerthread(void *param)
 		itimer.it_interval.tv_usec = interval.tv_nsec / 1000;
 		setitimer (ITIMER_REAL, &itimer, NULL);
 	}
-
+#ifdef WITH_TIMERFD
+	if (par->mode == MODE_TIMERFD) {
+		tspec.it_interval.tv_sec = interval.tv_sec;
+		tspec.it_interval.tv_nsec = interval.tv_nsec;
+		if (par->timermode == TIMER_ABSTIME) {
+			tspec.it_value = next;
+			timerfd_settime(timerfd_id,TFD_TIMER_ABSTIME,&tspec,NULL);
+		} else {
+			tspec.it_value.tv_nsec = 0;
+			tspec.it_value.tv_sec   = 1;
+			timerfd_settime(timerfd_id,0,&tspec,NULL);
+		}
+	}
+#endif
 	stat->threadstarted++;
 
 	while (!shutdown) {
@@ -656,7 +719,7 @@ void *timerthread(void *param)
 				clock_gettime(par->clock, &now);
 				ret = clock_nanosleep(par->clock, TIMER_RELTIME,
 						&interval, NULL);
-				next.tv_sec = now.tv_sec + interval.tv_sec;
+				next.tv_sec =   now.tv_sec + interval.tv_sec;
 				next.tv_nsec = now.tv_nsec + interval.tv_nsec;
 				tsnorm(&next);
 			}
@@ -676,9 +739,22 @@ void *timerthread(void *param)
 			next.tv_nsec = now.tv_nsec + interval.tv_nsec;
 			tsnorm(&next);
 			break;
+#ifdef WITH_TIMERFD
+		case MODE_TIMERFD:
+			if (par->timermode == TIMER_ABSTIME) {
+				read(timerfd_id,&timerfd_data,8);
+			} else {
+				clock_gettime(par->clock, &now);
+				timerfd_gettime(timerfd_id,&tspec);
+				read(timerfd_id,&timerfd_data,8);
+				next.tv_sec =   now.tv_sec +  tspec.it_value.tv_sec;
+				next.tv_nsec = now.tv_nsec + tspec.it_value.tv_nsec;
+				tsnorm(&next);
+			}
+			break;
+#endif
 		}
 		clock_gettime(par->clock, &now);
-
 		if (use_nsecs)
 			diff = calcdiff_ns(now, next);
 		else
@@ -734,7 +810,11 @@ out:
 		itimer.it_interval.tv_usec = 0;
 		setitimer (ITIMER_REAL, &itimer, NULL);
 	}
-
+#ifdef WITH_TIMERFD
+	if (par->mode == MODE_TIMERFD) {
+		close(timerfd_id);
+	}
+#endif
 	/* switch to normal */
 	schedp.sched_priority = 0;
 	sched_setscheduler(0, SCHED_OTHER, &schedp);
@@ -775,6 +855,9 @@ static void display_help(int error)
 	       "                           to modify value to minutes, hours or days\n"
 	       "-E       --event           event tracing (used with -b)\n"
 	       "-f       --ftrace          function trace (when -b is active)\n"
+#ifdef WITH_TIMERFD
+	       "-F       --timerfd    	   Use TimerFD API\n"
+#endif
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
                "                           (with same priority about many threads)\n"
 	       "                           US is the max time to be be tracked in microseconds\n"
@@ -813,6 +896,7 @@ static void display_help(int error)
 static int use_nanosleep;
 static int timermode = TIMER_ABSTIME;
 static int use_system;
+static int use_timerfd;
 static int priority;
 static int policy = 0;
 static int num_threads = 1;
@@ -899,6 +983,9 @@ static void process_options (int argc, char *argv[])
 			{"distance", required_argument, NULL, 'd'},
 			{"event", no_argument, NULL, 'E'},
 			{"ftrace", no_argument, NULL, 'f'},
+#ifdef WITH_TIMERFD
+			{"timerfd",no_argument,NULL,'F'},
+#endif
 			{"histogram", required_argument, NULL, 'h'},
 			{"interval", required_argument, NULL, 'i'},
 			{"irqsoff", no_argument, NULL, 'I'},
@@ -923,7 +1010,7 @@ static void process_options (int argc, char *argv[])
 			{"traceopt", required_argument, NULL, 'O'},
 			{NULL, 0, NULL, 0}
 		};
-                int c = getopt_long (argc, argv, "a::b:Bc:Cd:Efh:i:Il:nNo:O:p:Pmqrst::vD:wWTy:",
+                int c = getopt_long (argc, argv, "a::b:Bc:Cd:EfFh:i:Il:nNo:O:p:Pmqrst::vD:wWTy:",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -946,6 +1033,9 @@ static void process_options (int argc, char *argv[])
 		case 'd': distance = atoi(optarg); break;
 		case 'E': tracetype = EVENTS; break;
 		case 'f': ftrace = 1; break;
+#ifdef WITH_TIMERFD
+		case 'F': use_timerfd = MODE_TIMERFD; break;
+#endif
 		case 'h': histogram = atoi(optarg); break;
 		case 'i': interval = atoi(optarg); break;
 		case 'I': tracetype = IRQSOFF; break;
@@ -1207,7 +1297,7 @@ int main(int argc, char **argv)
 	if (check_timer())
 		fprintf(stderr, "WARNING: High resolution timers not available\n");
 
-	mode = use_nanosleep + use_system;
+	mode = use_timerfd ? use_timerfd : (use_nanosleep + use_system);
 
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signum);


--------------000406030506090703070909--
