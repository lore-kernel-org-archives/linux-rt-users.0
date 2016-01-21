From: Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH 1/2] cyclictest: SMI count/detection via MSR/SMI counter
Date: Thu, 21 Jan 2016 16:08:29 -0200
Message-ID: <484277bc674d29eba2f4585416a58db443fba682.1453397401.git.bristot@redhat.com>
References: <cover.1453397401.git.bristot@redhat.com>
Cc: Len Brown <len.brown@intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965568AbcAUSIx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jan 2016 13:08:53 -0500
In-Reply-To: <cover.1453397401.git.bristot@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Use the MSR/SMI counter on Intel's processor to detect/count SMIs. It is
based on turbostat's implementation.

SMI counting is enabled via --smi argument. When enabled, and additional
field is added on both regular and verbose ouput.

On the regular output, a SMI column shows how many SMIs occurred on
each CPU during cyclictest's execution. For example:

policy: fifo: loadavg: 0.09 0.05 0.02 1/194 2288

T: 0 ( 2285) P:80 I:1000 C:   9975 Min:      2 Act:    3 Avg:    4 Max:   20831 SMI:       2
T: 1 ( 2286) P:80 I:1500 C:   6650 Min:      2 Act:    2 Avg:    5 Max:   19910 SMI:       2
T: 2 ( 2287) P:80 I:2000 C:   4987 Min:      2 Act:    2 Avg:    6 Max:   20811 SMI:       2
T: 3 ( 2288) P:80 I:2500 C:   3990 Min:      2 Act:    3 Avg:    7 Max:   20322 SMI:       2

On verbose output, the last column shows how many SMIs occurred
on each loop. For example:

[  CPU  |   Loop |   Lat |  SMIs  ]
       0:    2156:       2       0
       0:    2157:       2       0
       0:    2158:       2       0
       0:    2159:   20981       2
       1:    1433:       2       0
       1:    1434:       2       0
       1:    1435:       2       0
       1:    1436:       3       0
       1:    1437:       2       0
       1:    1438:       2       0
       1:    1439:   20249       2

Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 src/cyclictest/cyclictest.c | 229 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 219 insertions(+), 10 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f5a67dc..df3db2a 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -111,6 +111,13 @@ extern int clock_nanosleep(clockid_t __clock_id, int __flags,
 #define KVARNAMELEN		32
 #define KVALUELEN		32
 
+#if (defined(__i386__) || defined(__x86_64__))
+#define ARCH_HAS_SMI_COUNTER
+#endif
+
+#define MSR_SMI_COUNT		0x00000034
+#define MSR_SMI_COUNT_MASK	0xFFFFFFFF
+
 int enable_events;
 
 static char *policyname(int policy);
@@ -143,6 +150,7 @@ struct thread_param {
 	int cpu;
 	int node;
 	int tnum;
+	int msr_fd;
 };
 
 /* Struct for statistics */
@@ -154,6 +162,7 @@ struct thread_stat {
 	long act;
 	double avg;
 	long *values;
+	long *smis;
 	long *hist_array;
 	long *outliers;
 	pthread_t thread;
@@ -164,6 +173,7 @@ struct thread_stat {
 	long cycleofmax;
 	long hist_overflow;
 	long num_outliers;
+	unsigned long smi_count;
 };
 
 static pthread_mutex_t trigger_lock = PTHREAD_MUTEX_INITIALIZER;
@@ -212,6 +222,12 @@ static pthread_t fifo_threadid;
 static int laptop = 0;
 static int use_histfile = 0;
 
+#ifdef ARCH_HAS_SMI_COUNTER
+static int smi = 0;
+#else
+#define smi	0
+#endif
+
 static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
 static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
 
@@ -772,6 +788,125 @@ try_again:
 	return err;
 }
 
+#ifdef ARCH_HAS_SMI_COUNTER
+static int open_msr_file(int cpu)
+{
+	int fd;
+	char pathname[32];
+
+	/* SMI needs thread affinity */
+	sprintf(pathname, "/dev/cpu/%d/msr", cpu);
+	fd = open(pathname, O_RDONLY);
+	if (fd < 0)
+		warn("%s open failed, try chown or chmod +r "
+		       "/dev/cpu/*/msr, or run as root\n", pathname);
+
+	return fd;
+}
+
+static int get_msr(int fd, off_t offset, unsigned long long *msr)
+{
+	ssize_t retval;
+
+	retval = pread(fd, msr, sizeof *msr, offset);
+
+	if (retval != sizeof *msr)
+		return 1;
+
+	return 0;
+}
+
+static int get_smi_counter(int fd, unsigned long *counter)
+{
+	int retval;
+	unsigned long long msr;
+
+	retval = get_msr(fd, MSR_SMI_COUNT, &msr);
+	if (retval)
+		return retval;
+
+	*counter = (unsigned long) (msr & MSR_SMI_COUNT_MASK);
+
+	return 0;
+}
+
+#include <cpuid.h>
+
+/* Based on turbostat's check */
+static int has_smi_counter(void)
+{
+	unsigned int ebx, ecx, edx, max_level;
+	unsigned int fms, family, model;
+
+	fms = family = model = ebx = ecx = edx = 0;
+
+	__get_cpuid(0, &max_level, &ebx, &ecx, &edx);
+
+	/* check genuine intel */
+	if (!(ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e))
+		return 0;
+
+	__get_cpuid(1, &fms, &ebx, &ecx, &edx);
+	family = (fms >> 8) & 0xf;
+
+	if (family != 6)
+		return 0;
+
+	/* no MSR */
+	if (!(edx & (1 << 5)))
+		return 0;
+
+	model = (((fms >> 16) & 0xf) << 4) + ((fms >> 4) & 0xf);
+
+	switch (model) {
+	case 0x1A:      /* Core i7, Xeon 5500 series - Bloomfield, Gainstown NHM-EP */
+	case 0x1E:      /* Core i7 and i5 Processor - Clarksfield, Lynnfield, Jasper Forest */
+	case 0x1F:      /* Core i7 and i5 Processor - Nehalem */
+	case 0x25:      /* Westmere Client - Clarkdale, Arrandale */
+	case 0x2C:      /* Westmere EP - Gulftown */
+	case 0x2E:      /* Nehalem-EX Xeon - Beckton */
+	case 0x2F:      /* Westmere-EX Xeon - Eagleton */
+	case 0x2A:      /* SNB */
+	case 0x2D:      /* SNB Xeon */
+	case 0x3A:      /* IVB */
+	case 0x3E:      /* IVB Xeon */
+	case 0x3C:      /* HSW */
+	case 0x3F:      /* HSX */
+	case 0x45:      /* HSW */
+	case 0x46:      /* HSW */
+	case 0x3D:      /* BDW */
+	case 0x47:      /* BDW */
+	case 0x4F:      /* BDX */
+	case 0x56:      /* BDX-DE */
+	case 0x4E:      /* SKL */
+	case 0x5E:      /* SKL */
+	case 0x37:      /* BYT */
+	case 0x4D:      /* AVN */
+	case 0x4C:      /* AMT */
+	case 0x57:      /* PHI */
+		break;
+	default:
+		return 0;
+	}
+
+	return 1;
+}
+#else
+static int open_msr_file(int cpu)
+{
+	return -1;
+}
+
+static int get_smi_counter(int fd, unsigned long *counter)
+{
+	return 1;
+}
+static int has_smi_counter(void)
+{
+	return 0;
+}
+#endif
+
 /*
  * timer thread
  *
@@ -798,6 +933,7 @@ static void *timerthread(void *param)
 	int stopped = 0;
 	cpu_set_t mask;
 	pthread_t thread;
+	unsigned long smi_now, smi_old;
 
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
@@ -835,6 +971,17 @@ static void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n",
 		      par->cpu, par->prio);
 
+	if(smi) {
+		par->msr_fd = open_msr_file(par->cpu);
+		if (par->msr_fd < 0)
+			fatal("Could not open MSR interface, errno: %d\n",
+				errno);
+		/* get current smi count to use as base value */
+		if (get_smi_counter(par->msr_fd, &smi_old))
+			fatal("Could not read SMI counter, errno: %d\n",
+				par->cpu, errno);
+	}
+
 	/* Get current time */
 	if (aligned || secaligned) {
 		pthread_barrier_wait(&globalt_barr);
@@ -892,6 +1039,7 @@ static void *timerthread(void *param)
 	while (!shutdown) {
 
 		uint64_t diff;
+		unsigned long diff_smi = 0;
 		int sigs, ret;
 
 		/* Wait for next period */
@@ -957,6 +1105,17 @@ static void *timerthread(void *param)
 			goto out;
 		}
 
+		if (smi) {
+			if (get_smi_counter(par->msr_fd, &smi_now)) {
+				warn("Could not read SMI counter, errno: %d\n",
+					par->cpu, errno);
+				goto out;
+			}
+			diff_smi = smi_now - smi_old;
+			stat->smi_count += diff_smi;
+			smi_old = smi_now;
+		}
+
 		if (use_nsecs)
 			diff = calcdiff_ns(now, next);
 		else
@@ -974,6 +1133,7 @@ static void *timerthread(void *param)
 			trigger_update(par, diff, calctime(now));
 		}
 
+
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
 
@@ -991,8 +1151,11 @@ static void *timerthread(void *param)
 		}
 		stat->act = diff;
 
-		if (par->bufmsk)
+		if (par->bufmsk) {
 			stat->values[stat->cycles & par->bufmsk] = diff;
+			if (smi)
+				stat->smis[stat->cycles & par->bufmsk] = diff_smi;
+		}
 
 		/* Update the histogram */
 		if (histogram) {
@@ -1038,10 +1201,12 @@ out:
 		setitimer(ITIMER_REAL, &itimer, NULL);
 	}
 
+	/* close msr file */
+	if (smi)
+		close(par->msr_fd);
 	/* switch to normal */
 	schedp.sched_priority = 0;
 	sched_setscheduler(0, SCHED_OTHER, &schedp);
-
 	stat->threadstarted = -1;
 
 	return NULL;
@@ -1126,6 +1291,9 @@ static void display_help(int error)
 	       "	--spike=trigger	   record all spikes > trigger\n"
 	       "	--spike-nodes	   these are the number of spikes we can record\n"
 	       "			   the default is 1024 if not specified\n"
+#ifdef ARCH_HAS_SMI_COUNTER
+               "         --smi             Enable SMI counting\n"
+#endif
 	       "-t       --threads         one thread per available processor\n"
 	       "-t [NUM] --threads=NUM     number of threads:\n"
 	       "                           without NUM, threads = max_cpus\n"
@@ -1220,7 +1388,6 @@ static void parse_cpumask(const char *option, const int max_cpus)
 	}
 }
 
-
 static void handlepolicy(char *polname)
 {
 	if (strncasecmp(polname, "other", 5) == 0)
@@ -1272,7 +1439,7 @@ enum option_values {
 	OPT_SYSTEM, OPT_SMP, OPT_THREADS, OPT_TRACER, OPT_TRIGGER,
 	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
 	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
-	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP,
+	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
 };
 
 /* Process commandline options */
@@ -1322,6 +1489,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
 			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
 			{"system",           no_argument,       NULL, OPT_SYSTEM },
+			{"smi",              no_argument,       NULL, OPT_SMI },
 			{"smp",              no_argument,       NULL, OPT_SMP },
 			{"spike",	     required_argument, NULL, OPT_TRIGGER },
 			{"spike-nodes",	     required_argument, NULL, OPT_TRIGGER_NODES },
@@ -1560,6 +1728,13 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			ct_debug = 1; break;
 		case OPT_LAPTOP:
 			laptop = 1; break;
+		case OPT_SMI:
+#ifdef ARCH_HAS_SMI_COUNTER
+			smi = 1;
+#else
+			fatal("--smi is not available on your arch\n");
+#endif
+			break;
 		}
 	}
 
@@ -1571,6 +1746,15 @@ static void process_options (int argc, char *argv[], int max_cpus)
 		}
 	}
 
+	if (smi) {
+		if (setaffinity == AFFINITY_UNSPECIFIED)
+			fatal("SMI counter relies on thread affinity\n");
+
+		if (!has_smi_counter())
+			fatal("SMI counter is not supported "
+			      "on this processor\n");
+	}
+
 	if (tracelimit)
 		fileprefix = procfileprefix;
 
@@ -1810,27 +1994,44 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 			char *fmt;
 			if (use_nsecs)
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
-					"Min:%7ld Act:%8ld Avg:%8ld Max:%8ld\n";
+				        "Min:%7ld Act:%8ld Avg:%8ld Max:%8ld";
 			else
 				fmt = "T:%2d (%5d) P:%2d I:%ld C:%7lu "
-					"Min:%7ld Act:%5ld Avg:%5ld Max:%8ld\n";
+				        "Min:%7ld Act:%5ld Avg:%5ld Max:%8ld";
+
 			fprintf(fp, fmt, index, stat->tid, par->prio,
-				par->interval, stat->cycles, stat->min, stat->act,
-				stat->cycles ?
+				par->interval, stat->cycles, stat->min,
+				stat->act, stat->cycles ?
 				(long)(stat->avg/stat->cycles) : 0, stat->max);
+
+			if (smi)
+				fprintf(fp," SMI:%8ld", stat->smi_count);
+
+			fprintf(fp, "\n");
 		}
 	} else {
 		while (stat->cycles != stat->cyclesread) {
+			unsigned long diff_smi;
 			long diff = stat->values
 			    [stat->cyclesread & par->bufmsk];
 
+			if (smi)
+				diff_smi = stat->smis
+				[stat->cyclesread & par->bufmsk];
+
 			if (diff > stat->redmax) {
 				stat->redmax = diff;
 				stat->cycleofmax = stat->cyclesread;
 			}
 			if (++stat->reduce == oscope_reduction) {
-				fprintf(fp, "%8d:%8lu:%8ld\n", index,
-					stat->cycleofmax, stat->redmax);
+				if (!smi)
+					fprintf(fp, "%8d:%8lu:%8ld\n", index,
+						stat->cycleofmax, stat->redmax);
+				else
+					fprintf(fp, "%8d:%8lu:%8ld%8ld\n",
+						index, stat->cycleofmax,
+						stat->redmax, diff_smi);
+
 				stat->reduce = 0;
 				stat->redmax = 0;
 			}
@@ -2154,6 +2355,13 @@ int main(int argc, char **argv)
 				goto outall;
 			memset(stat->values, 0, bufsize);
 			par->bufmsk = VALBUF_SIZE - 1;
+			if (smi) {
+				int bufsize = VALBUF_SIZE * sizeof(long);
+				stat->smis = threadalloc(bufsize, node);
+				if (!stat->smis)
+					goto outall;
+				memset(stat->smis, 0, bufsize);
+			}
 		}
 
 		par->prio = priority;
@@ -2192,6 +2400,7 @@ int main(int argc, char **argv)
 		stat->max = 0;
 		stat->avg = 0.0;
 		stat->threadstarted = 1;
+		stat->smi_count = 0;
 		status = pthread_create(&stat->thread, &attr, timerthread, par);
 		if (status)
 			fatal("failed to create thread %d: %s\n", i, strerror(status));
-- 
2.5.0

