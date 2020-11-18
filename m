Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D51C63798
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF7521D1A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 19:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgKRTGu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:06:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:49998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727139AbgKRTGt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 14:06:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7CBEBB12;
        Wed, 18 Nov 2020 19:06:47 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, Daniel Wagner <dwagner@suse.de>
Subject: [rt-tests v1 02/12] cyclicdeadline: Use common error handlers
Date:   Wed, 18 Nov 2020 20:06:32 +0100
Message-Id: <20201118190642.16006-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201118190642.16006-1-dwagner@suse.de>
References: <20201118190642.16006-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use the common error handlers. This will make the fatal, error and
debug output consistent with the output from cyclictest. The current
normal output is not changed.

While at it drop the 'fail' flag and use 'shutdown' flag which does
the same thing.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 src/sched_deadline/cyclicdeadline.c | 165 ++++++++++------------------
 1 file changed, 59 insertions(+), 106 deletions(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index e0db9669f676..7adc91465f44 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -32,6 +32,7 @@
 
 #include <rt-utils.h>
 #include <rt-sched.h>
+#include <error.h>
 
 #define _STR(x) #x
 #define STR(x) _STR(x)
@@ -165,10 +166,8 @@ static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
 			p++;
 			switch (*p) {
 			case 's':
-				if (l) {
-					fprintf(stderr, "Illegal print format l used with %%s\n");
-					exit(-1);
-				}
+				if (l)
+					fatal("Illegal print format l used with %%s\n");
 				str = va_arg(ap, char *);
 				l = strlen(str);
 				strncpy(s, str, end - s);
@@ -184,10 +183,9 @@ static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
 				}
 				if (l == 2)
 					lng = va_arg(ap, long long);
-				else if (l > 2) {
-					fprintf(stderr, "Illegal print format l=%d\n", l);
-					exit(-1);
-				} else
+				else if (l > 2)
+					fatal("Illegal print format l=%d\n", l);
+				else
 					lng = va_arg(ap, int);
 				i = 0;
 				while (lng > 0) {
@@ -204,8 +202,7 @@ static int my_vsprintf(char *buf, int size, const char *fmt, va_list ap)
 				}
 				break;
 			default:
-				fprintf(stderr, "Illegal print format '%c'\n", *p);
-				exit(-1);
+				fatal("Illegal print format '%c'\n", *p);
 			}
 			continue;
 		}
@@ -397,8 +394,8 @@ enum {
 	CPUSET_FL_CLONE_CHILDREN	= (1 << 6),
 };
 
-static const char *make_cpuset(const char *name, const char *cpus,
-			       const char *mems, unsigned flags, ...)
+static void make_cpuset(const char *name, const char *cpus,
+		        const char *mems, unsigned flags, ...)
 {
 	struct stat st;
 	char path[MAXPATH];
@@ -413,64 +410,64 @@ static const char *make_cpuset(const char *name, const char *cpus,
 
 	ret = mount_cpuset();
 	if (ret < 0)
-		return "mount_cpuset";
+		fatal("mount_cpuset");
 
 	ret = stat(path, &st);
 	if (ret < 0) {
 		ret = mkdir(path, 0755);
 		if (ret < 0)
-			return "mkdir";
+			fatal("mkdir");
 	}
 
 	fd = open_cpuset(path, "cpuset.cpus");
 	if (fd < 0)
-		return "cset";
+		fatal("cset");
 	ret = write(fd, cpus, strlen(cpus));
 	close(fd);
 	if (ret < 0)
-		return "write cpus";
+		fatal("write cpus");
 
 	if (mems) {
 		fd = open_cpuset(path, "cpuset.mems");
 		if (fd < 0)
-			return "open mems";
+			fatal("open mems");
 		ret = write(fd, mems, strlen(mems));
 		close(fd);
 		if (ret < 0)
-			return "write mems";
+			fatal("write mems");
 	}
 
 	if (flags & CPUSET_FL_CPU_EXCLUSIVE) {
 		fd = open_cpuset(path, "cpuset.cpu_exclusive");
 		if (fd < 0)
-			return "open cpu_exclusive";
+			fatal("open cpu_exclusive");
 		ret = write(fd, "1", 2);
 		close(fd);
 		if (ret < 0)
-			return "write cpu_exclusive";
+			fatal("write cpu_exclusive");
 	}
 
 	if (flags & (CPUSET_FL_CLEAR_LOADBALANCE | CPUSET_FL_SET_LOADBALANCE)) {
 		fd = open_cpuset(path, "cpuset.sched_load_balance");
 		if (fd < 0)
-			return "open sched_load_balance";
+			fatal("open sched_load_balance");
 		if (flags & CPUSET_FL_SET_LOADBALANCE)
 			ret = write(fd, "1", 2);
 		else
 			ret = write(fd, "0", 2);
 		close(fd);
 		if (ret < 0)
-			return "write sched_load_balance";
+			fatal("write sched_load_balance");
 	}
 
 	if (flags & CPUSET_FL_CLONE_CHILDREN) {
 		fd = open_cpuset(path, "cgroup.clone_children");
 		if (fd < 0)
-			return "open clone_children";
+			fatal("open clone_children");
 		ret = write(fd, "1", 2);
 		close(fd);
 		if (ret < 0)
-			return "write clone_children";
+			fatal("write clone_children");
 	}
 
 
@@ -482,7 +479,7 @@ static const char *make_cpuset(const char *name, const char *cpus,
 
 		fd = open_cpuset(path, "tasks");
 		if (fd < 0)
-			return "open tasks";
+			fatal("open tasks");
 
 		ret = 0;
 		pids = va_arg(ap, int *);
@@ -492,10 +489,8 @@ static const char *make_cpuset(const char *name, const char *cpus,
 		}
 		va_end(ap);
 		close(fd);
-		if (ret < 0) {
-			fprintf(stderr, "Failed on task %d\n", pids[i]);
-			return "write tasks";
-		}
+		if (ret < 0)
+			fatal("Failed on task %d\n", pids[i]);
 	}
 
 	if (flags & CPUSET_FL_ALL_TASKS) {
@@ -507,7 +502,7 @@ static const char *make_cpuset(const char *name, const char *cpus,
 		snprintf(path, MAXPATH - 1, "%s/tasks", CPUSET_PATH);
 		if ((fp = fopen(path, "r")) == NULL) {
 			close(fd);
-			return "opening cpuset tasks";
+			fatal("opening cpuset tasks");
 		}
 
 		while (fscanf(fp, "%d", &pid) == 1) {
@@ -521,14 +516,12 @@ static const char *make_cpuset(const char *name, const char *cpus,
 			if (ret < 0 && errno == ENOSPC) {
 				fclose(fp);
 				close(fd);
-				return "Can not move tasks";
+				fatal("Can not move tasks");
 			}
 		}
 		fclose(fp);
 		close(fd);
 	}
-
-	return NULL;
 }
 
 static void destroy_cpuset(const char *name, int print)
@@ -580,16 +573,14 @@ static void destroy_cpuset(const char *name, int print)
 	snprintf(path, MAXPATH - 1, "%s/%s", CPUSET_PATH, name);
 	path[MAXPATH - 1] = 0;
 
-//	return;
 	sleep(1);
 	ret = rmdir(path);
 	if (ret < 0) {
 		if (retry++ < 5)
 			goto again;
-		fprintf(stderr, "Failed to remove %s\n", path);
-		perror("rmdir");
+		err_msg_n(errno, "Failed to remove %s\n", path);
 		if (retry++ < 5) {
-			fprintf(stderr, "Trying again\n");
+			err_msg("Trying again\n");
 			goto again;
 		}
 	}
@@ -640,8 +631,6 @@ static void usage(int error)
 	exit(error);
 }
 
-static int fail;
-
 static u64 get_time_us(void)
 {
 	struct timespec ts;
@@ -740,9 +729,8 @@ void *run_deadline(void *data)
 
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
 	if (ret < 0) {
-		fprintf(stderr, "[%ld]", tid);
-		perror("sched_getattr");
-		fail = 1;
+		err_msg_n(errno, "[%ld]", tid);
+		shutdown = 1;
 		pthread_barrier_wait(&barrier);
 		pthread_exit("Failed sched_getattr");
 		return NULL;
@@ -750,23 +738,19 @@ void *run_deadline(void *data)
 
 	pthread_barrier_wait(&barrier);
 
-	if (fail)
-		return NULL;
-
 	attr.sched_policy = SCHED_DEADLINE;
 	attr.sched_runtime = sd->runtime_us * 1000;
 	attr.sched_deadline = sd->deadline_us * 1000;
 
 	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
-	       gettid(), sd->runtime_us, sd->deadline_us);
+	      gettid(), sd->runtime_us, sd->deadline_us);
 
 	pthread_barrier_wait(&barrier);
 
 	ret = sched_setattr(0, &attr, 0);
 	if (ret < 0) {
-		fprintf(stderr, "[%ld]", tid);
-		perror("sched_setattr");
-		fail = 1;
+		err_msg_n(errno, "[%ld]", tid);
+		shutdown = 1;
 		pthread_barrier_wait(&barrier);
 		pthread_exit("Failed sched_setattr");
 		return NULL;
@@ -774,9 +758,6 @@ void *run_deadline(void *data)
 
 	pthread_barrier_wait(&barrier);
 
-	if (fail)
-		return NULL;
-
 	sched_yield();
 	period = get_time_us();
 
@@ -786,7 +767,7 @@ void *run_deadline(void *data)
 	}
 	ret = sched_getattr(0, &attr, sizeof(attr), 0);
 	if (ret < 0) {
-		perror("sched_getattr");
+		err_msg_n(errno, "sched_getattr");
 		pthread_exit("Failed second sched_getattr");
 	}
 
@@ -1015,10 +996,8 @@ int main(int argc, char **argv)
 	int c;
 
 	cpu_count = sysconf(_SC_NPROCESSORS_CONF);
-	if (cpu_count < 1) {
-		fprintf(stderr, "Can not calculate number of CPUS\n");
-		exit(-1);
-	}
+	if (cpu_count < 1)
+		err_quit("Can not calculate number of CPUS\n");
 
 	for (;;) {
 		static struct option options[] = {
@@ -1069,10 +1048,8 @@ int main(int argc, char **argv)
 
 	if (setcpu) {
 		nr_cpus = calc_nr_cpus(setcpu, &setcpu_buf);
-		if (nr_cpus < 0 || nr_cpus > cpu_count) {
-			fprintf(stderr, "Invalid cpu input '%s'\n", setcpu);
-			exit(-1);
-		}
+		if (nr_cpus < 0 || nr_cpus > cpu_count)
+			fatal("Invalid cpu input '%s'\n", setcpu);
 	} else
 		nr_cpus = cpu_count;
 
@@ -1084,10 +1061,8 @@ int main(int argc, char **argv)
 	/* Default cpu to use is the last one */
 	if (!all_cpus && !setcpu) {
 		setcpu_buf = malloc(10);
-		if (!setcpu_buf) {
-			perror("malloc");
-			exit(-1);
-		}
+		if (!setcpu_buf)
+			fatal("malloc");
 		sprintf(setcpu_buf, "%d", cpu_count - 1);
 	}
 
@@ -1097,16 +1072,14 @@ int main(int argc, char **argv)
 		make_other_cpu_list(setcpu, &allcpu_buf);
 
 	if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
-		perror("mlockall");
+		warn("mlockall");
 
 	setup_ftrace_marker();
 
 	thread = calloc(nr_threads, sizeof(*thread));
 	sched_data = calloc(nr_threads, sizeof(*sched_data));
-	if (!thread || !sched_data) {
-		perror("allocating threads");
-		exit(-1);
-	}
+	if (!thread || !sched_data)
+		fatal("allocating threads");
 
 	if (nr_threads > nr_cpus) {
 		/*
@@ -1130,11 +1103,9 @@ int main(int argc, char **argv)
 			 * If the runtime is less than 2ms, then we better
 			 * have HRTICK enabled.
 			 */
-			if (!setup_hr_tick()) {
-				fprintf(stderr, "For less than 2ms run times, you need to\n"
-					"have HRTICK enabled in debugfs/sched_features\n");
-				exit(-1);
-			}
+			if (!setup_hr_tick())
+				fatal("For less than 2ms run times, you need to\n"
+				      "have HRTICK enabled in debugfs/sched_features\n");
 		}
 		sd->runtime_us = runtime;
 		sd->deadline_us = interval;
@@ -1145,11 +1116,9 @@ int main(int argc, char **argv)
 		start_period = get_time_us();
 		do_runtime(gettid(), sd, start_period);
 		end_period = get_time_us();
-		if (end_period - start_period > sd->runtime_us) {
-			fprintf(stderr, "Failed to perform task within runtime: Missed by %lld us\n",
-				end_period - start_period - sd->runtime_us);
-			exit(-1);
-		}
+		if (end_period - start_period > sd->runtime_us)
+			fatal("Failed to perform task within runtime: Missed by %lld us\n",
+			      end_period - start_period - sd->runtime_us);
 
 		printf("  Tested at %lldus of %lldus\n",
 		       end_period - start_period, sd->runtime_us);
@@ -1169,42 +1138,29 @@ int main(int argc, char **argv)
 
 	pthread_barrier_wait(&barrier);
 
-	if (fail) {
-		printf("fail 1\n");
-		exit(-1);
-	}
+	if (shutdown)
+		fatal("failed to setup child threads at step 1\n");
 
 	if (!all_cpus) {
 		int *pids;
 
-		res = make_cpuset(CPUSET_ALL, allcpu_buf, "0",
+		make_cpuset(CPUSET_ALL, allcpu_buf, "0",
 				  CPUSET_FL_SET_LOADBALANCE |
 				  CPUSET_FL_CLONE_CHILDREN |
 				  CPUSET_FL_ALL_TASKS);
-		if (res) {
-			perror(res);
-			exit(-1);
-		}
 
 		pids = calloc(nr_threads + 1, sizeof(int));
-		if (!pids) {
-			perror("Allocating pids");
-			exit(-1);
-		}
+		if (!pids)
+			fatal("Allocating pids");
 
 		for (i = 0; i < nr_threads; i++)
 			pids[i] = sched_data[i].stat.tid;
 
-		res = make_cpuset(CPUSET_LOCAL, setcpu, "0",
+		make_cpuset(CPUSET_LOCAL, setcpu, "0",
 				  CPUSET_FL_CPU_EXCLUSIVE |
 				  CPUSET_FL_SET_LOADBALANCE |
 				  CPUSET_FL_CLONE_CHILDREN |
 				  CPUSET_FL_TASKS, pids);
-		free(pids);
-		if (res) {
-			perror(res);
-			exit(-1);
-		}
 
 		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
 	}
@@ -1213,10 +1169,8 @@ int main(int argc, char **argv)
 
 	pthread_barrier_wait(&barrier);
 
-	if (fail) {
-		printf("fail 2\n");
-		exit(-1);
-	}
+	if (shutdown)
+		fatal("failed to setup child threads at step 2");
 
 	pthread_barrier_wait(&barrier);
 
@@ -1227,8 +1181,7 @@ int main(int argc, char **argv)
 	if (duration)
 		alarm(duration);
 
-	if (!fail)
-		loop(sched_data, nr_threads);
+	loop(sched_data, nr_threads);
 
 	for (i = 0; i < nr_threads; i++) {
 
@@ -1236,7 +1189,7 @@ int main(int argc, char **argv)
 
 		res = join_thread(&thread[i]);
 		if (res) {
-			printf("Thread %d failed: %s\n", i, res);
+			warn("Thread %d failed: %s\n", i, res);
 			continue;
 		}
 	}
-- 
2.29.2

