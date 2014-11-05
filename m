From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 9/9] pi_stress: Store schedule attributes per thread
Date: Wed,  5 Nov 2014 10:09:45 +0100
Message-ID: <1415178585-3192-10-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52829 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753495AbaKEJJx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:53 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Currently, the scheduling class is configured on a global
level. It is possible to run the test either with SCHED_FIFO
or SCHED_RR. All threads run then with the same configuration
except sched_priority is different.

By storing the scheduling attributes per thread we will be able
to use different scheduler classes at the same time. The aim is
to use SCHED_DEADLINE for the high priority thread.

First thing to get there is to introduce low_sa, med_sa, high_sa
and admin_sa. They are configured using the global policy variable
on default. Either using SCHED_FIFO or SCHED_RR. The user
can though use --sched command line options to configure each
thread seperately. E.g.

Starting PI Stress Test
Number of thread groups: 1
Duration of test run: infinite
Number of inversions per group: unlimited
     Admin thread SCHED_FIFO priority 4
1 groups of 3 threads will be created
      High thread SCHED_DEADLINE runtime 100000 deadline 200000 period 200000
       Med thread SCHED_FIFO priority 2
       Low thread SCHED_FIFO priority 1
Current Inversions: 2446249
Stopping test
Terminated

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/pi_tests/pi_stress.c | 245 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 211 insertions(+), 34 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index d834b86..46058e2 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -53,7 +53,14 @@
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <sys/syscall.h>
 #include <termios.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <limits.h>
+
+#include "rt-sched.h"
+#include "rt-utils.h"
 
 #include "error.h"
 
@@ -145,6 +152,7 @@ struct option options[] = {
 	{"groups", required_argument, NULL, 'g'},
 	{"inversions", required_argument, NULL, 'i'},
 	{"rr", no_argument, NULL, 'r'},
+	{"sched", required_argument, NULL, 's'},
 	{"uniprocessor", no_argument, NULL, 'u'},
 	{"prompt", no_argument, NULL, 'p'},
 	{"debug", no_argument, NULL, 'd'},
@@ -154,15 +162,6 @@ struct option options[] = {
 	{NULL, 0, NULL, 0},
 };
 
-/* max priority for the scheduling policy */
-int prio_min;
-
-/* define priorities for the threads */
-#define MAIN_PRIO() (prio_min + 3)
-#define HIGH_PRIO() (prio_min + 2)
-#define MED_PRIO()  (prio_min + 1)
-#define LOW_PRIO()  (prio_min + 0)
-
 #define NUM_TEST_THREADS 3
 #define NUM_ADMIN_THREADS 1
 
@@ -173,6 +172,19 @@ cpu_set_t test_cpu_mask, admin_cpu_mask;
 
 int policy = SCHED_FIFO;
 
+/* scheduling attributes per thread */
+struct sched_attr low_sa;
+struct sched_attr med_sa;
+struct sched_attr high_sa;
+struct sched_attr admin_sa;
+
+#define SA_INIT_LOW	(1 << 0)
+#define SA_INIT_MED	(1 << 1)
+#define SA_INIT_HIGH	(1 << 2)
+#define SA_INIT_ADMIN	(1 << 3)
+
+unsigned int sa_initialized;
+
 struct group_parameters {
 
 	/* group id (index) */
@@ -226,8 +238,8 @@ void *med_priority(void *arg);
 void *high_priority(void *arg);
 void *reporter(void *arg);
 void *watchdog(void *arg);
-int setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
-		      int schedpolicy);
+int setup_thread_attr(pthread_attr_t * attr, struct sched_attr * sa,
+		      cpu_set_t * mask);
 int set_cpu_affinity(cpu_set_t * test_mask, cpu_set_t * admin_mask);
 void process_command_line(int argc, char **argv);
 void usage(void);
@@ -242,6 +254,8 @@ void summary(void);
 void wait_for_termination(void);
 int barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
 		 unsigned count, const char *name);
+void setup_sched_attr(struct sched_attr *attr, int policy, int prio);
+void setup_sched_config(int policy);
 
 int main(int argc, char **argv)
 {
@@ -261,9 +275,13 @@ int main(int argc, char **argv)
 	/* calculate the number of inversion groups to run */
 	ngroups = num_processors == 1 ? 1 : num_processors - 1;
 
+
 	/* process command line arguments */
 	process_command_line(argc, argv);
 
+	/* set default sched attributes */
+	setup_sched_config(policy);
+
 	/* lock memory */
 	if (lockall)
 		if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1) {
@@ -271,9 +289,9 @@ int main(int argc, char **argv)
 			return FAILURE;
 		}
 	/* boost main's priority (so we keep running) :) */
-	prio_min = sched_get_priority_min(policy);
-	thread_param.sched_priority = MAIN_PRIO();
-	status = pthread_setschedparam(pthread_self(), policy, &thread_param);
+	thread_param.sched_priority = admin_sa.sched_priority;
+	status = pthread_setschedparam(pthread_self(), admin_sa.sched_policy,
+				       &thread_param);
 	if (status) {
 		pi_error("main: boosting to max priority: 0x%x\n", status);
 		return FAILURE;
@@ -365,8 +383,8 @@ int main(int argc, char **argv)
 }
 
 int
-setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
-		  int schedpolicy)
+setup_thread_attr(pthread_attr_t * attr, struct sched_attr * sa,
+		  cpu_set_t * mask)
 {
 	int status;
 	struct sched_param thread_param;
@@ -378,11 +396,23 @@ setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
 		     status);
 		return FAILURE;
 	}
-	status = pthread_attr_setschedpolicy(attr, schedpolicy);
+	status = pthread_attr_setaffinity_np(attr, sizeof(cpu_set_t), mask);
+	if (status) {
+		pi_error("setup_thread_attr: setting affinity attribute: 0x%x\n",
+		      status);
+		return FAILURE;
+	}
+
+	/* The pthread API does not yet support SCHED_DEADLINE, defer the
+	 * thread configuration to setup_thread() */
+	if (sa->sched_policy == SCHED_DEADLINE)
+		return SUCCESS;
+
+	status = pthread_attr_setschedpolicy(attr, sa->sched_policy);
 	if (status) {
 		pi_error
 		    ("setup_thread_attr: setting attribute policy to %s: 0x%x\n",
-		     schedpolicy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR",
+		     policy_to_string(sa->sched_policy),
 		     status);
 		return FAILURE;
 	}
@@ -393,19 +423,13 @@ setup_thread_attr(pthread_attr_t * attr, int prio, cpu_set_t * mask,
 		     status);
 		return FAILURE;
 	}
-	thread_param.sched_priority = prio;
+	thread_param.sched_priority = sa->sched_priority;
 	status = pthread_attr_setschedparam(attr, &thread_param);
 	if (status) {
 		pi_error("setup_thread_attr: setting scheduler param: 0x%x\n",
 		      status);
 		return FAILURE;
 	}
-	status = pthread_attr_setaffinity_np(attr, sizeof(cpu_set_t), mask);
-	if (status) {
-		pi_error("setup_thread_attr: setting affinity attribute: 0x%x\n",
-		      status);
-		return FAILURE;
-	}
 	return SUCCESS;
 }
 
@@ -859,6 +883,16 @@ void *high_priority(void *arg)
 	pthread_mutex_t *loop_mtx = &p->loop_mtx;
 	int *loop = &p->loop;
 
+	if (high_sa.sched_policy == SCHED_DEADLINE) {
+		status = sched_setattr(gettid(), &high_sa, 0);
+		if (status < 0) {
+			pi_error
+			    ("high_priority[%d]: sched_setattr(dl): %x\n",
+			    p->id, status);
+			return NULL;
+		}
+	}
+
 	allow_sigterm();
 	if (verify_cpu(p->cpu) != SUCCESS) {
 		pi_error("high_priority[%d]: not bound to %ld\n", p->id, p->cpu);
@@ -980,6 +1014,10 @@ void usage(void)
 	    ("\t--inversions=<n>- number of inversions per group [infinite]\n");
 	printf("\t--report=<path>\t- output to file [/dev/null]\n");
 	printf("\t--rr\t\t- use SCHED_RR for test threads [SCHED_FIFO]\n");
+	printf("\t--sched\t\t- scheduling options per thread type:\n");
+	printf("\t\tid=[high|med|low]\t\t\t- select thread\n");
+	printf("\t\t,policy=[fifo,rr],priority=<n>\t\t- SCHED_FIFO or SCHED_RR\n");
+	printf("\t\t,policy=deadline,runtime=<n>,deadline=<n>,period=<n>\t- SCHED_DEADLINE\n");
 	printf("\t--prompt\t- prompt before starting the test\n");
 	printf
 	    ("\t--uniprocessor\t- force all threads to run on one processor\n");
@@ -1135,7 +1173,7 @@ int create_group(struct group_parameters *group)
 
 	/* start the low priority thread */
 	pi_debug("creating low priority thread\n");
-	if (setup_thread_attr(&thread_attr, LOW_PRIO(), &mask, policy))
+	if (setup_thread_attr(&thread_attr, &low_sa, &mask))
 		return FAILURE;
 	status = pthread_create(&group->low_tid,
 				&thread_attr, low_priority, group);
@@ -1146,7 +1184,7 @@ int create_group(struct group_parameters *group)
 
 	/* create the medium priority thread */
 	pi_debug("creating medium priority thread\n");
-	if (setup_thread_attr(&thread_attr, MED_PRIO(), &mask, policy))
+	if (setup_thread_attr(&thread_attr, &med_sa, &mask))
 		return FAILURE;
 	status = pthread_create(&group->med_tid,
 				&thread_attr, med_priority, group);
@@ -1157,7 +1195,7 @@ int create_group(struct group_parameters *group)
 
 	/* create the high priority thread */
 	pi_debug("creating high priority thread\n");
-	if (setup_thread_attr(&thread_attr, HIGH_PRIO(), &mask, policy))
+	if (setup_thread_attr(&thread_attr, &high_sa, &mask))
 		return FAILURE;
 	status = pthread_create(&group->high_tid,
 				&thread_attr, high_priority, group);
@@ -1169,6 +1207,99 @@ int create_group(struct group_parameters *group)
 	return SUCCESS;
 }
 
+unsigned long parse_unsigned(const char *str)
+{
+	unsigned long n;
+	char *p;
+
+	errno = 0;
+	n = strtoul(str, &p, 10);
+
+	if ((errno == ERANGE && n == ULONG_MAX)
+			|| (errno != 0 && n == 0)) {
+		pi_error("parsing number failed: %s\n", str);
+		exit(EXIT_FAILURE);
+	}
+
+	return n;
+}
+
+long parse_signed(const char *str)
+{
+	long n;
+	char *p;
+
+	errno = 0;
+	n = strtol(str, &p, 10);
+
+	if ((errno == ERANGE && (n == LONG_MAX || n == LONG_MIN))
+			|| (errno != 0 && n == 0)) {
+		pi_error("parsing number failed: %s\n", str);
+		exit(EXIT_FAILURE);
+	}
+
+	return n;
+}
+
+int process_sched_line(const char *arg)
+{
+	char *buf, *k, *v;
+	const char del[] = ",=";
+	struct sched_attr sa = { 0, };
+	char *id = NULL;
+	int retval = SUCCESS;
+
+	buf = strdupa(arg);
+
+	k = strsep(&buf, del);
+	while (k) {
+		v = strsep(&buf, del);
+		if (!v)
+			break;
+
+		if (!strcmp(k, "id"))
+			id = v;
+		else if (!strcmp(k, "policy"))
+			sa.sched_policy = string_to_policy(v);
+		else if (!strcmp(k, "nice"))
+			sa.sched_nice = parse_signed(v);
+		else if (!strcmp(k, "priority"))
+			sa.sched_priority = parse_unsigned(v);
+		else if (!strcmp(k, "runtime"))
+			sa.sched_runtime = parse_unsigned(v);
+		else if (!strcmp(k, "deadline"))
+			sa.sched_deadline = parse_unsigned(v);
+		else if (!strcmp(k, "period"))
+			sa.sched_period = parse_unsigned(v);
+
+		k = strsep(&buf, del);
+	}
+
+	if (!id) {
+		free(buf);
+		return FAILURE;
+	}
+
+	/* We do not validate the options, instead we pass all garbage
+	 * to the kernel and see what's happening */
+
+	if (!strcmp(id, "low")) {
+		memcpy(&low_sa, &sa, sizeof(struct sched_attr));
+		sa_initialized |= SA_INIT_LOW;
+	} else if (!strcmp(id, "med")) {
+		memcpy(&med_sa, &sa, sizeof(struct sched_attr));
+		sa_initialized |= SA_INIT_MED;
+	} else if (!strcmp(id, "high")) {
+		memcpy(&high_sa, &sa, sizeof(struct sched_attr));
+		sa_initialized |= SA_INIT_HIGH;
+	} else {
+		retval = FAILURE;
+	}
+
+	free(buf);
+	return retval;
+}
+
 void process_command_line(int argc, char **argv)
 {
 	int opt;
@@ -1200,6 +1331,10 @@ void process_command_line(int argc, char **argv)
 		case 'r':
 			policy = SCHED_RR;
 			break;
+		case 's':
+			if (process_sched_line(optarg))
+				pi_error("ignoring invalid options '%s'\n", optarg);
+			break;
 		case 'p':
 			prompt = 1;
 			break;
@@ -1231,6 +1366,27 @@ unsigned long total_inversions(void)
 	return total;
 }
 
+void print_sched_attr(const char *name, struct sched_attr * sa)
+{
+	printf("    %6s thread", name);
+	printf(" %s", policy_to_string(sa->sched_policy));
+
+	switch(sa->sched_policy) {
+	case SCHED_OTHER:
+		printf(" nice %d\n", sa->sched_nice);
+		break;
+	case SCHED_FIFO:
+	case SCHED_RR:
+		printf(" priority %d\n", sa->sched_priority);
+		break;
+	case SCHED_DEADLINE:
+		printf(" runtime %" PRIu64 " deadline %" PRIu64 " period %" PRIu64 "\n",
+			sa->sched_runtime, sa->sched_deadline,
+			sa->sched_period);
+		break;
+	}
+}
+
 void banner(void)
 {
 	if (quiet)
@@ -1246,13 +1402,12 @@ void banner(void)
 		printf("Number of inversions per group: unlimited\n");
 	else
 		printf("Number of inversions per group: %d\n", inversions);
-	printf("Test threads using scheduler policy: %s\n",
-	       policy == SCHED_FIFO ? "SCHED_FIFO" : "SCHED_RR");
-	printf("    Admin thread priority:  %d\n", MAIN_PRIO());
+	print_sched_attr("Admin", &admin_sa);
 	printf("%d groups of 3 threads will be created\n", ngroups);
-	printf("    High thread priority:   %d\n", HIGH_PRIO());
-	printf("    Med  thread priority:   %d\n", MED_PRIO());
-	printf("    Low thread priority:    %d\n\n", LOW_PRIO());
+	print_sched_attr("High", &high_sa);
+	print_sched_attr("Med", &med_sa);
+	print_sched_attr("Low", &low_sa);
+	printf("\n");
 }
 
 void summary(void)
@@ -1279,3 +1434,25 @@ barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
 
 	return SUCCESS;
 }
+
+void setup_sched_attr(struct sched_attr *attr, int policy, int prio)
+{
+	attr->sched_policy = policy;
+	attr->sched_priority = prio;
+}
+
+void setup_sched_config(int policy)
+{
+	int prio_min;
+
+	prio_min = sched_get_priority_min(policy);
+
+	if (!(sa_initialized & SA_INIT_LOW))
+		setup_sched_attr(&low_sa,   policy, prio_min + 0);
+	if (!(sa_initialized & SA_INIT_MED))
+		setup_sched_attr(&med_sa,   policy, prio_min + 1);
+	if (!(sa_initialized & SA_INIT_HIGH))
+		setup_sched_attr(&high_sa,  policy, prio_min + 2);
+	if (!(sa_initialized & SA_INIT_ADMIN))
+		setup_sched_attr(&admin_sa, policy, prio_min + 3);
+}
-- 
1.9.3

