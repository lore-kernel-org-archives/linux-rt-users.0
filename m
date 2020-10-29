Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03386C55179
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8992D2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDAST6Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgJ2RlQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgJ2RlP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026DC0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h19so2375479qtq.4
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uf+FAP3ODLwbLc0p28eQToNS0/OzS2kNZLxQGtomwk=;
        b=IDAST6Kaehkoamf3JZ+F3WmQn5BtM+r2zAoLnaQe2Cen9E4TIHD2ry0nhYyrWfBCKW
         lAjj1HGoaESexuV0CF9v3arEbOKMiwUCH2PqrNQuRh12Wvd/Wh+9Uy25bdBvLhaNgOec
         yneQlbWLp7sU5YG1ZhyqkWswfqjqj+9H6nYVEhpoEga/DEazAkeoUSpT7X/KjIycfAQW
         8YDFHbm/nzYeGXB55No50yyu2LW5E+xZueJhBqoVLNMomCRYrye9FUxOT2bOM+FfSR9d
         NC2EPacgxOIFRA/HKmX5kI2yelWOmw8MCmvr6TDn+BYypWbDXhD7tSrkX7+AS2QZIfbG
         8RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2uf+FAP3ODLwbLc0p28eQToNS0/OzS2kNZLxQGtomwk=;
        b=HcxnEiLHRHug0e0/10zZfVgOt6GWvfCa13rtbApJqTB+BSF28DxZVckI7nfMem8+1b
         Il4cjHtOmLN2EwU4kqqd7nmU/3xayH9LwDkyENjpWC2hkshbpAtFRweCFnlAtuJ+2M/a
         Jqkoaws+Gs5Gj5Stsnmk+Af+SPAfZLdLyjrX9WbwB2hqIPUcGskVlVKJIzRbey82WG0z
         xNQugB6jv8T7a/ZpEOjCUEozFZYeH9NwSCp67voRPys1wPFi3wBJy1Q8OmTs9tc1wo2Y
         hVLb3+CWV31fUzRQ4s8gMp5JOqb8nhml+3IPt0byFDOBfJ2xkTXe2WrSihUYZik5lGxS
         pEFw==
X-Gm-Message-State: AOAM533gPLFJsojgbC3zyPDTUDJu7mTE5JjWbDnzboHrPuVlYq48LXnW
        jgkyK/wS4kTPB+la3lk7Ei9HlNggGnY3/Q==
X-Google-Smtp-Source: ABdhPJygRTAgP5vxf9bpbLC+7vOLgLNAeUxun5u4jK/RbipNtv5M/WZMf8ntJ7mh9vF8oha3kQLVwg==
X-Received: by 2002:aed:2d62:: with SMTP id h89mr4801666qtd.108.1603993274360;
        Thu, 29 Oct 2020 10:41:14 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:13 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 02/16] rt-tests: cyclictest: A few style changes from checkpatch.pl
Date:   Thu, 29 Oct 2020 13:40:43 -0400
Message-Id: <20201029174057.20033-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A few style changes as suggested by checkpatch.pl

Please note not everything that checkpatch reports will be applicable to
rt-tests.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 86 ++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 48 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index fda7b0f4280f..34aa9be583f8 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -62,12 +62,12 @@ static int clock_nanosleep(clockid_t clock_id, int flags, const struct timespec
 	if (clock_id == CLOCK_THREAD_CPUTIME_ID)
 		return -EINVAL;
 	if (clock_id == CLOCK_PROCESS_CPUTIME_ID)
-		clock_id = MAKE_PROCESS_CPUCLOCK (0, CPUCLOCK_SCHED);
+		clock_id = MAKE_PROCESS_CPUCLOCK(0, CPUCLOCK_SCHED);
 
 	return syscall(__NR_clock_nanosleep, clock_id, flags, req, rem);
 }
 
-int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
+int sched_setaffinity(__pid_t __pid, size_t __cpusetsize,
 		       __const cpu_set_t *__cpuset)
 {
 	return -EINVAL;
@@ -292,7 +292,7 @@ static int tracemark_fd = -1;
  * if a call fails, return the error
  * if successful return 0
  * if fails, return -1
-*/
+ */
 static int raise_soft_prio(int policy, const struct sched_param *param)
 {
 	int err;
@@ -352,7 +352,8 @@ try_again:
 		if (err == EPERM) {
 			int err1;
 			err1 = raise_soft_prio(policy, param);
-			if (!err1) goto try_again;
+			if (!err1)
+				goto try_again;
 		}
 	}
 
@@ -551,7 +552,7 @@ static void *timerthread(void *param)
 		fatal("timerthread%d: failed to set priority to %d\n",
 		      par->cpu, par->prio);
 
-	if(smi) {
+	if (smi) {
 		par->msr_fd = open_msr_file(par->cpu);
 		if (par->msr_fd < 0)
 			fatal("Could not open MSR interface, errno: %d\n",
@@ -569,7 +570,7 @@ static void *timerthread(void *param)
 			clock_gettime(par->clock, &globalt);
 			if (secaligned) {
 				/* Ensure that the thread start timestamp is not
-				   in the past */
+				 * in the past */
 				if (globalt.tv_nsec > 900000000)
 					globalt.tv_sec += 2;
 				else
@@ -709,10 +710,8 @@ static void *timerthread(void *param)
 		}
 		stat->avg += (double) diff;
 
-		if (trigger && (diff > trigger)) {
+		if (trigger && (diff > trigger))
 			trigger_update(par, diff, calctime(now));
-		}
-
 
 		if (duration && (calcdiff(now, stop) >= 0))
 			shutdown++;
@@ -831,7 +830,7 @@ static void display_help(int error)
 	       "	 --latency=PM_QOS  write PM_QOS to /dev/cpu_dma_latency\n"
 	       "-F       --fifo=<path>     create a named pipe at path and write stats to it\n"
 	       "-h       --histogram=US    dump a latency histogram to stdout after the run\n"
-	       "                           US is the max latency time to be be tracked in microseconds\n"
+	       "                           US is the max latency time to be tracked in microseconds\n"
 	       "			   This option runs all threads at the same priority.\n"
 	       "-H       --histofall=US    same as -h except with an additional summary column\n"
 	       "	 --histfile=<path> dump the latency histogram to <path> instead of stdout\n"
@@ -933,9 +932,8 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus)
 
 	num_cpus = rt_numa_bitmask_count(affinity_mask);
 
-	if (num_cpus == 0) {
+	if (num_cpus == 0)
 		fatal("No allowable cpus to run on\n");
-	}
 
 	m = thread_num % num_cpus;
 
@@ -962,9 +960,8 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 	CPU_ZERO(&cpuset);
 
 	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
-	if (res != 0) {
+	if (res != 0)
 		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
-	}
 
 	num_cpus = CPU_COUNT(&cpuset);
 	m = thread_num % num_cpus;
@@ -983,7 +980,8 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
 
 
 /* After this function is called, affinity_mask is the intersection of the user
- * supplied affinity mask and the affinity mask from the run time environment */
+ * supplied affinity mask and the affinity mask from the run time environment
+ */
 static void use_current_cpuset(const int max_cpus)
 {
 	int i;
@@ -996,11 +994,11 @@ static void use_current_cpuset(const int max_cpus)
 	numa_sched_getaffinity(pid, curmask);
 
 	/* Clear bits that are not set in both the cpuset from the environment,
-	 * and in the user specified affinity for cyclictest */
+	 * and in the user specified affinity for cyclictest
+	 */
 	for (i=0; i < max_cpus; i++) {
-		if ((!rt_numa_bitmask_isbitset(affinity_mask, i)) || (!rt_numa_bitmask_isbitset(curmask, i))) {
+		if ((!rt_numa_bitmask_isbitset(affinity_mask, i)) || (!rt_numa_bitmask_isbitset(curmask, i)))
 			numa_bitmask_clearbit(affinity_mask, i);
-		}
 	}
 
 	numa_bitmask_free(curmask);
@@ -1097,7 +1095,7 @@ static void numa_initialize(void)
 }
 
 /* Process commandline options */
-static void process_options (int argc, char *argv[], int max_cpus)
+static void process_options(int argc, char *argv[], int max_cpus)
 {
 	int error = 0;
 	int option_affinity = 0;
@@ -1163,7 +1161,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			if (optarg != NULL) {
 				parse_cpumask(optarg, max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
-			} else if (optind<argc && (atoi(argv[optind]) || argv[optind][0] == '0' || argv[optind][0] == '!')) {
+			} else if (optind < argc && (atoi(argv[optind]) || argv[optind][0] == '0' || argv[optind][0] == '!')) {
 				parse_cpumask(argv[optind], max_cpus);
 				setaffinity = AFFINITY_SPECIFIED;
 			} else {
@@ -1172,10 +1170,10 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			break;
 		case 'A':
 		case OPT_ALIGNED:
-			aligned=1;
+			aligned = 1;
 			if (optarg != NULL)
 				offset = atoi(optarg) * 1000;
-			else if (optind<argc && atoi(argv[optind]))
+			else if (optind < argc && atoi(argv[optind]))
 				offset = atoi(argv[optind]) * 1000;
 			else
 				offset = 0;
@@ -1270,7 +1268,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
 			}
 			if (optarg != NULL)
 				num_threads = atoi(optarg);
-			else if (optind<argc && atoi(argv[optind]))
+			else if (optind < argc && atoi(argv[optind]))
 				num_threads = atoi(argv[optind]);
 			else
 				num_threads = -1; /* update after parsing */
@@ -1590,7 +1588,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
 				(long)(stat->avg/stat->cycles) : 0, stat->max);
 
 			if (smi)
-				fprintf(fp," SMI:%8ld", stat->smi_count);
+				fprintf(fp, " SMI:%8ld", stat->smi_count);
 
 			fprintf(fp, "\n");
 		}
@@ -1646,7 +1644,7 @@ static void rstat_print_stat(struct thread_param *par, int index, int verbose, i
 				(long)(stat->avg/stat->cycles) : 0, stat->max);
 
 			if (smi)
-				dprintf(fd," SMI:%8ld", stat->smi_count);
+				dprintf(fd, " SMI:%8ld", stat->smi_count);
 
 			dprintf(fd, "\n");
 		}
@@ -1745,7 +1743,8 @@ static void trigger_print()
 	struct thread_trigger *trig = head;
 	char *fmt = "T:%2d Spike:%8ld: TS: %12ld\n";
 
-	if (current == head) return;
+	if (current == head)
+		return;
 	printf("\n");
 	while (trig->next != current) {
 		fprintf(stdout, fmt,  trig->tnum, trig->diff, trig->ts);
@@ -1788,9 +1787,8 @@ static int rstat_shm_open(void)
 
 	errno = 9;
 	fd = shm_open(shm_name, O_RDWR|O_CREAT|O_EXCL, S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH|S_IWOTH);
-	if (fd == -1) {
+	if (fd == -1)
 		fprintf(stderr, "ERROR: shm_open %s\n", strerror(errno));
-	}
 
 	rstat_fd = fd;
 
@@ -1803,9 +1801,8 @@ static int rstat_ftruncate(int fd, off_t len)
 
 	errno = 0;
 	err = ftruncate(fd, len);
-	if (err) {
+	if (err)
 		fprintf(stderr, "ftruncate error %s\n", strerror(errno));
-	}
 
 	return err;
 }
@@ -1817,9 +1814,8 @@ static void *rstat_mmap(int fd)
 	errno = 0;
 	mptr = mmap(0, _SC_PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
 
-	if (mptr == (void*)-1) {
+	if (mptr == (void*)-1)
 		fprintf(stderr, "ERROR: mmap, %s\n", strerror(errno));
-	}
 
 	return mptr;
 }
@@ -1830,9 +1826,8 @@ static int rstat_mlock(void *mptr)
 
 	errno = 0;
 	err = mlock(mptr, _SC_PAGE_SIZE);
-	if (err == -1) {
+	if (err == -1)
 		fprintf(stderr, "ERROR, mlock %s\n", strerror(errno));
-	}
 
 	return err;
 }
@@ -1895,9 +1890,8 @@ int main(int argc, char **argv)
 
 		errno = 0;
 		res = numa_sched_setaffinity(getpid(), affinity_mask);
-		if (res != 0) {
+		if (res != 0)
 			warn("Couldn't setaffinity in main thread: %s\n", strerror(errno));
-		}
 	}
 
 	if (trigger) {
@@ -1939,11 +1933,10 @@ int main(int argc, char **argv)
 
 		clock = clocksources[clocksel];
 
-		if (clock_getres(clock, &res)) {
+		if (clock_getres(clock, &res))
 			warn("clock_getres failed");
-		} else {
+		else
 			reported_resolution = (NSEC_PER_SEC * res.tv_sec) + res.tv_nsec;
-		}
 
 
 		/*
@@ -1954,9 +1947,8 @@ int main(int argc, char **argv)
 		 */
 		times = 1000;
 		clock_gettime(clock, &prev);
-		for (k=0; k < times; k++) {
+		for (k=0; k < times; k++)
 			clock_gettime(clock, &now);
-		}
 
 		diff = calcdiff_ns(now, prev);
 		if (diff == 0) {
@@ -1979,9 +1971,8 @@ int main(int argc, char **argv)
 
 		time = calloc(times, sizeof(*time));
 
-		for (k=0; k < times; k++) {
+		for (k=0; k < times; k++)
 			clock_gettime(clock, &time[k]);
-		}
 
 		if (ct_debug) {
 			info("For %d consecutive calls to clock_gettime():\n", times);
@@ -1994,9 +1985,8 @@ int main(int argc, char **argv)
 			diff = calcdiff_ns(time[k], prev);
 			prev = time[k];
 
-			if (diff && (diff < min_non_zero_diff)) {
+			if (diff && (diff < min_non_zero_diff))
 				min_non_zero_diff = diff;
-			}
 
 			if (ct_debug)
 				info("%ld.%06ld  %5llu\n",
@@ -2027,7 +2017,7 @@ int main(int argc, char **argv)
 
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signum);
-	sigprocmask (SIG_BLOCK, &sigset, NULL);
+	sigprocmask(SIG_BLOCK, &sigset, NULL);
 
 	signal(SIGINT, sighand);
 	signal(SIGTERM, sighand);
@@ -2076,7 +2066,7 @@ int main(int argc, char **argv)
 			/* find the memory node associated with the cpu i */
 			node = rt_numa_numa_node_of_cpu(cpu);
 
-			/* get the stack size set for for this thread */
+			/* get the stack size set for this thread */
 			if (pthread_attr_getstack(&attr, &currstk, &stksize))
 				fatal("failed to get stack size for thread %d\n", i);
 
@@ -2207,7 +2197,7 @@ int main(int argc, char **argv)
 		for (i = 0; i < num_threads; i++) {
 
 			print_stat(stdout, parameters[i], i, verbose, quiet);
-			if(max_cycles && statistics[i]->cycles >= max_cycles)
+			if (max_cycles && statistics[i]->cycles >= max_cycles)
 				allstopped++;
 		}
 
-- 
2.26.2

