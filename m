From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH - cyclictest] handle latest ftrace
Date: Tue, 3 Jun 2008 11:50:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806031147290.22839@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Darren Hart <dvhltc@us.ibm.com>,
	Subrata Modak <subrata@linux.vnet.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:65243 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828AbYFCPum (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jun 2008 11:50:42 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This patch has cyclictest work a bit better with ftrace. Some new options
have been added.

When -b is used:

  -P : use the preemptoff tracer
  -I : use the irqsoff tracer
  -B : use preemptirqsoff tracer

If the above are not set, then it tries to use "events" tracer if it is
available (currently only available in the -rt kernel) and if that is not
set, it defaults to the sched-switch tracer.

-f will enabled the function tracer.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>

---
 src/cyclictest/cyclictest.c |  109 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 94 insertions(+), 15 deletions(-)

Index: rt-tests/src/cyclictest/cyclictest.c
===================================================================
--- rt-tests.orig/src/cyclictest/cyclictest.c	2008-06-02 22:51:55.000000000 -0400
+++ rt-tests/src/cyclictest/cyclictest.c	2008-06-03 11:20:46.000000000 -0400
@@ -85,6 +85,13 @@ extern int clock_nanosleep(clockid_t __c
 #define KVARNAMELEN		32
 #define KVALUELEN		32

+enum {
+	DEFAULTTRACE,
+	IRQSOFF,
+	PREEMPTOFF,
+	IRQPREEMPTOFF,
+};
+
 /* Struct to transfer parameters to the thread */
 struct thread_param {
 	int prio;
@@ -119,6 +126,7 @@ static int ftrace = 0;
 static int kernelversion;
 static int verbose = 0;
 static int oscope_reduction = 1;
+static int tracetype;

 /* Backup of kernel variables that we modify */
 static struct kvars {
@@ -132,6 +140,7 @@ static struct kvars {

 static char *procfileprefix = "/proc/sys/kernel/";
 static char debugfileprefix[MAX_PATH];
+static char *fileprefix;

 enum kernelversion {
 	KV_NOT_26,
@@ -172,25 +181,19 @@ static int set_debugfileprefix(void)
 	size = strlen(debugfileprefix);
 	size = MAX_PATH - size;

-	strncat(debugfileprefix, "/tracing", size);
+	strncat(debugfileprefix, "/tracing/", size);

 	return 0;
 }

-static int kernvar(int mode, char *name, char *value, size_t sizeofvalue)
+static int kernvar(int mode, const char *name, char *value, size_t sizeofvalue)
 {
 	char filename[128];
-	char *prefix;
 	int retval = 1;
 	int path;

-	if (kernelversion == KV_26_CURR)
-		prefix = debugfileprefix;
-	else
-		prefix = procfileprefix;
-
-	strncpy(filename, prefix, sizeof(filename));
-	strncat(filename, name, sizeof(filename) - sizeof(prefix));
+	strncpy(filename, fileprefix, sizeof(filename));
+	strncat(filename, name, sizeof(filename) - strlen(fileprefix));
 	path = open(filename, mode);
 	if (path >= 0) {
 		if (mode == O_RDONLY) {
@@ -208,7 +211,7 @@ static int kernvar(int mode, char *name,
 	return retval;
 }

-static void setkernvar(char *name, char *value)
+static void setkernvar(const char *name, char *value)
 {
 	int i;
 	char oldvalue[KVALUELEN];
@@ -287,6 +290,41 @@ void tracing(int on)
 	}
 }

+static int settracer(char *tracer)
+{
+	char filename[MAX_PATH];
+	char name[100];
+	FILE *fp;
+	int ret;
+	int i;
+
+	/* Make sure tracer is available */
+	strncpy(filename, debugfileprefix, sizeof(filename));
+	strncat(filename, "available_tracers", sizeof(filename) - strlen(debugfileprefix));
+
+	fp = fopen(filename, "r");
+	if (!fp)
+		return -1;
+
+	for (i = 0; i < 10; i++) {
+		ret = fscanf(fp, "%99s", name);
+		if (!ret) {
+			ret = -1;
+			break;
+		}
+		if (strcmp(name, tracer) == 0) {
+			ret = 0;
+			break;
+		}
+	}
+	fclose(fp);
+
+	if (!ret)
+		setkernvar("current_tracer", tracer);
+
+	return ret;
+}
+
 /*
  * timer thread
  *
@@ -330,12 +368,41 @@ void *timerthread(void *param)
 	if (tracelimit) {
 		if (kernelversion == KV_26_CURR) {
 			char buffer[32];
+			int ret;
+
 			sprintf(buffer, "%d", tracelimit);
 			setkernvar("tracing_thresh", buffer);
+
+			/* ftrace_enabled is a sysctl variable */
+			fileprefix = procfileprefix;
 			if (ftrace)
-				setkernvar("current_tracer", "ftrace");
+				setkernvar("ftrace_enabled", "1");
 			else
-				setkernvar("current_tracer", "sched_switch");
+				setkernvar("ftrace_enabled", "0");
+			fileprefix = debugfileprefix;
+
+			switch (tracetype) {
+			case IRQSOFF:
+				ret = settracer("irqsoff");
+				break;
+			case PREEMPTOFF:
+				ret = settracer("preemptoff");
+				break;
+			case IRQPREEMPTOFF:
+				ret = settracer("preemptirqsoff");
+				break;
+			default:
+				if ((ret = settracer("events"))) {
+					if (ftrace)
+						ret = settracer("ftrace");
+					else
+						ret = settracer("sched-switch");
+				}
+			}
+
+			if (ret)
+				fprintf(stderr, "Requested tracer not available\n");
+
 			setkernvar("iter_ctrl", "print-parent");
 			if (verbose) {
 				setkernvar("iter_ctrl", "sym-offset");
@@ -504,16 +571,19 @@ static void display_help(void)
 	       "-a       --affinity        run thread #N on processor #N, if possible\n"
 	       "-a PROC  --affinity=PROC   run all threads on processor #PROC\n"
 	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
+	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
 	       "-c CLOCK --clock=CLOCK     select clock\n"
 	       "                           0 = CLOCK_MONOTONIC (default)\n"
 	       "                           1 = CLOCK_REALTIME\n"
 	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
 	       "-f                         function trace (when -b is active)\n"
 	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
+	       "-I       --irqsoff         Irqsoff tracing (used with -b)\n"
 	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
 	       "-n       --nanosleep       use clock_nanosleep\n"
 	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
 	       "-p PRIO  --prio=PRIO       priority of highest prio thread\n"
+	       "-P       --preemptoff      Preempt off tracing (used with -b)\n"
 	       "-q       --quiet           print only a summary on exit\n"
 	       "-r       --relative        use relative timer instead of absolute\n"
 	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
@@ -560,14 +630,17 @@ static void process_options (int argc, c
 		static struct option long_options[] = {
 			{"affinity", optional_argument, NULL, 'a'},
 			{"breaktrace", required_argument, NULL, 'b'},
+			{"preemptirqs", no_argument, NULL, 'B'},
 			{"clock", required_argument, NULL, 'c'},
 			{"distance", required_argument, NULL, 'd'},
 			{"ftrace", no_argument, NULL, 'f'},
 			{"interval", required_argument, NULL, 'i'},
+			{"irqsoff", no_argument, NULL, 'I'},
 			{"loops", required_argument, NULL, 'l'},
 			{"nanosleep", no_argument, NULL, 'n'},
 			{"oscope", required_argument, NULL, 'o'},
 			{"priority", required_argument, NULL, 'p'},
+			{"preemptoff", no_argument, NULL, 'P'},
 			{"quiet", no_argument, NULL, 'q'},
 			{"relative", no_argument, NULL, 'r'},
 			{"system", no_argument, NULL, 's'},
@@ -576,7 +649,7 @@ static void process_options (int argc, c
 			{"help", no_argument, NULL, '?'},
 			{NULL, 0, NULL, 0}
 		};
-		int c = getopt_long (argc, argv, "a::b:c:d:fi:l:no:p:qrst::v",
+		int c = getopt_long (argc, argv, "a::b:Bc:d:fi:Il:no:p:Pqrst::v",
 			long_options, &option_index);
 		if (c == -1)
 			break;
@@ -589,14 +662,17 @@ static void process_options (int argc, c
 				setaffinity = AFFINITY_USEALL;
 			break;
 		case 'b': tracelimit = atoi(optarg); break;
+		case 'B': tracetype = IRQPREEMPTOFF; break;
 		case 'c': clocksel = atoi(optarg); break;
 		case 'd': distance = atoi(optarg); break;
 		case 'f': ftrace = 1; break;
 		case 'i': interval = atoi(optarg); break;
+		case 'I': tracetype = IRQSOFF; break;
 		case 'l': max_cycles = atoi(optarg); break;
 		case 'n': use_nanosleep = MODE_CLOCK_NANOSLEEP; break;
 		case 'o': oscope_reduction = atoi(optarg); break;
 		case 'p': priority = atoi(optarg); break;
+		case 'P': tracetype = PREEMPTOFF; break;
 		case 'q': quiet = 1; break;
 		case 'r': timermode = TIMER_RELTIME; break;
 		case 's': use_system = MODE_SYS_OFFSET; break;
@@ -746,6 +822,8 @@ int main(int argc, char **argv)
 		char testname[MAX_PATH];

 		set_debugfileprefix();
+		fileprefix = debugfileprefix;
+
 		strcpy(testname, debugfileprefix);
 		strcat(testname, "tracing_enabled");
 		if (access(testname, R_OK)) {
@@ -753,7 +831,8 @@ int main(int argc, char **argv)
 			    "debug fs not mounted, "
 			    "TRACERs not configured?\n", testname);
 		}
-	}
+	} else if (tracelimit)
+		fileprefix = procfileprefix;

 	if (check_timer())
 		fprintf(stderr, "WARNING: High resolution timers not available\n");

