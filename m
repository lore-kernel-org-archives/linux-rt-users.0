From: Allen Martin <amartin@nvidia.com>
Subject: [PATCH 3/3] cyclictest: Handle non sequential online CPU numbering
Date: Wed, 21 Jun 2017 15:25:34 -0700
Message-ID: <20170621222534.24125-4-amartin@nvidia.com>
References: <20170621222534.24125-1-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Allen Martin <amartin@nvidia.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13277 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdFUWZu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jun 2017 18:25:50 -0400
In-Reply-To: <20170621222534.24125-1-amartin@nvidia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Cyclictest assumes online CPUs are numbered 0-N with no "holes".  This
causes it to silently set CPU affinity incorrectly if a CPU is offline
that isn't at the end of the CPU numbering.  Read the online status of
a CPU through sysfs before attempting to run a thread on that CPU to
prevent this problem.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 src/cyclictest/cyclictest.c | 52 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 568e52f4b328..80013a91962e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -958,6 +958,27 @@ static int has_smi_counter(void)
 }
 #endif
 
+/* Check if a CPU is online by reading from sysfs */
+static int cpu_is_online(int cpunum)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+	int online = 1;
+
+	snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/online",
+		 cpunum);
+	/* if CPU has no online toggle it must always be online */
+	if (access(path, F_OK) != 0)
+		return 1;
+	fp = fopen(path, "r");
+	if (!fp)
+		return 1;
+	fscanf(fp, "%d", &online);
+	fclose(fp);
+
+	return online;
+}
+
 /*
  * timer thread
  *
@@ -1515,7 +1536,8 @@ enum option_values {
 };
 
 /* Process commandline options */
-static void process_options (int argc, char *argv[], int max_cpus)
+static void process_options (int argc, char *argv[], int max_cpus,
+			     int online_cpus)
 {
 	int error = 0;
 	int option_affinity = 0;
@@ -1721,7 +1743,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			if (numa)
 				fatal("numa and smp options are mutually exclusive\n");
 			smp = 1;
-			num_threads = max_cpus;
+			num_threads = online_cpus;
 			setaffinity = AFFINITY_USEALL;
 			break;
 		case 't':
@@ -1735,7 +1757,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			else if (optind<argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
-				num_threads = max_cpus;
+				num_threads = online_cpus;
 			break;
 		case OPT_TRIGGER:
 			trigger = atoi(optarg);
@@ -1759,7 +1781,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 				fatal("numa and smp options are mutually exclusive\n");
 			numa_on_and_available();
 #ifdef NUMA
-			num_threads = max_cpus;
+			num_threads = online_cpus;
 			setaffinity = AFFINITY_USEALL;
 #else
 			warn("cyclictest was not built with the numa option\n");
@@ -2206,17 +2228,20 @@ int main(int argc, char **argv)
 	sigset_t sigset;
 	int signum = SIGALRM;
 	int mode;
-	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
+	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int online_cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	int i, ret = -1;
 	int status;
 
-	process_options(argc, argv, max_cpus);
+	process_options(argc, argv, max_cpus, online_cpus);
 
 	if (check_privs())
 		exit(EXIT_FAILURE);
 
-	if (verbose)
+	if (verbose) {
 		printf("Max CPUs = %d\n", max_cpus);
+		printf("Online CPUs = %d\n", online_cpus);
+	}
 
 	if (trigger) {
 		int retval;
@@ -2368,6 +2393,10 @@ int main(int argc, char **argv)
 		int node;
 		struct thread_param *par;
 		struct thread_stat *stat;
+		static int cpu_num = 0;
+
+		while (!cpu_is_online(cpu_num))
+			cpu_num++;
 
 		status = pthread_attr_init(&attr);
 		if (status != 0)
@@ -2468,12 +2497,17 @@ int main(int argc, char **argv)
 		switch (setaffinity) {
 		case AFFINITY_UNSPECIFIED: par->cpu = -1; break;
 		case AFFINITY_SPECIFIED:
-			par->cpu = cpu_for_thread(i, max_cpus);
+			par->cpu = cpu_for_thread(cpu_num++, max_cpus);
+			if (verbose)
+				printf("Thread %d using cpu %d.\n", i,
+					par->cpu);
+			break;
+		case AFFINITY_USEALL:
+			par->cpu = cpu_num++ % max_cpus;
 			if (verbose)
 				printf("Thread %d using cpu %d.\n", i,
 					par->cpu);
 			break;
-		case AFFINITY_USEALL: par->cpu = i % max_cpus; break;
 		}
 		stat->min = 1000000;
 		stat->max = 0;
-- 
2.11.0

