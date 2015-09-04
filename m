From: Ioan-Adrian Ratiu <adrian.ratiu@ni.com>
Subject: ARMv7 futex latency spike
Date: Fri, 4 Sep 2015 11:05:05 +0300
Message-ID: <55E950B1.4070603@ni.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000406050005020604050806"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:57462 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751445AbbIDIFI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Sep 2015 04:05:08 -0400
Received: from us-aus-mgwout1.amer.corp.natinst.com (nb-chan1-1338.natinst.com [130.164.19.134])
	by us-aus-skprod2.natinst.com (8.15.0.59/8.15.0.59) with ESMTP id t84857D1014284
	for <linux-rt-users@vger.kernel.org>; Fri, 4 Sep 2015 03:05:07 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a multi-part message in MIME format.
--------------000406050005020604050806
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=utf-8; format=flowed

Hello

I wrote a C program to check jitter levels in userspace (source 
attached), ran it on various kernels (3.14.19-rt9, 3.18.9-rt5 and 
4.1.5-rt5) and on multiple machines.
The problem I'm describing here does not reproduce on x86 architectures, 
only on the armv7 ones with all those kernels, specifically xilinx zynq 
Z-7020 and raspberrypi 2.

The C program simulates some workloads using timed busy waits inside and 
outside a mutex lock.
I have two threads which acquire that mutex in a loop, one with high 
priority called "High-prio******" (CPU1) and a normal priority one 
called "Low-prio******" (no CPU affinity).
There is also a third thread called "Busy-loop******" (CPU1) which has 1 
level lesser priority than "High-prio******", and it should be running 
on CPU1 when the high priority thread is not.

The jitter is measured between two acquisitions of the mutex in 
"High-prio******" thread and the numbers I get are from 20-30us to 120us 
for ex.

Considering these results show high jitter, I've created traces to 
understand what is happening. trace-cmd adds more jiiter, so the values 
are between 40-60us to almost 200us, but the jitter spikes still reproduce.
When jitter is high, the "High-prio******" thread does priority 
inheritace and waits on the "Low-prio******" thread twice. This second 
priority inheritace is suspicious since "Low-prio******" is already in 
the mutex/futex unlock syscall.
Normally there is only one priority inheritance before "High-prio******" 
acquires the lock and continues to run.

This is a most intruiguing part in one of the traces from the zynq 
machine (full trace at [1], also from rpi2 at [2]):

Low-prio******-1311 [000] 12165.412116: sys_enter: NR 240 (11524, 86, 
220, b6e46920, 51f, 0)
...
Low-prio******-1311 [000] 12165.412198: sys_exit: NR 240 = 0
...
High-prio******-1312 [001] 12165.412223: sys_enter: NR 263 (1, b6e05e30, 
1290, 1, 0, 0)
High-prio******-1312 [001] 12165.412226: sys_exit: NR 263 = 0
High-prio******-1312 [001] 12165.412229: sys_enter: NR 240 (11524, 86, 
1, 0, 11524, b6e06920)
Low-prio******-1311 [000] 12165.412238: sched_stat_runtime: 
comm=Low-prio****** pid=1311 runtime=15384 [ns] vruntime=945770545539 [ns]
Low-prio******-1311 [000] 12165.412243: sched_switch: 
Low-prio******:1311 [120] R ==> trace-cmd:1308 [120]
High-prio******-1312 [001] 12165.412248: sched_pi_setprio: 
comm=Low-prio****** pid=1311 oldprio=120 newprio=40
trace-cmd-1308 [000] 12165.412251: sys_exit: NR 162 = 0
High-prio******-1312 [001] 12165.412251: sched_stat_runtime: 
comm=trace-cmd pid=1308 runtime=12957 [ns] vruntime=945764543112 [ns]
trace-cmd-1308 [000] 12165.412255: sys_enter: NR 340 (5, 0, 8, 0, 1000, 1)
trace-cmd-1308 [000] 12165.412263: sched_stat_runtime: comm=trace-cmd 
pid=1308 runtime=11568 [ns] vruntime=945764554680 [ns]
High-prio******-1312 [001] 12165.412266: sched_switch: 
High-prio******:1312 [40] S ==> Busy-loop******:1313 [41]
trace-cmd-1308 [000] 12165.412268: sched_switch: trace-cmd:1308 [120] R 
==> Low-prio******:1311 [40]
Low-prio******-1311 [000] 12165.412273: sys_enter: NR 263 (1, b6e45e20, 
220, b6e45e20, 0, 0)
Low-prio******-1311 [000] 12165.412276: sys_exit: NR 263 = 0
Low-prio******-1311 [000] 12165.412280: sys_enter: NR 240 (11524, 87, 
220, b6e46920, 51f, 0)
Low-prio******-1311 [000] 12165.412295: sched_wakeup: 
High-prio******:1312 [40] success=1 CPU:001
Low-prio******-1311 [000] 12165.412300: sched_pi_setprio: 
comm=Low-prio****** pid=1311 oldprio=40 newprio=120
Busy-loop******-1313 [001] 12165.412301: sched_switch: 
Busy-loop******:1313 [41] R ==> High-prio******:1312 [40]
Low-prio******-1311 [000] 12165.412306: sched_stat_runtime: 
comm=Low-prio****** pid=1311 runtime=2136 [ns] vruntime=945770547675 [ns]
Low-prio******-1311 [000] 12165.412312: sched_stat_runtime: 
comm=Low-prio****** pid=1311 runtime=6441 [ns] vruntime=945770554116 [ns]
Low-prio******-1311 [000] 12165.412316: sched_switch: 
Low-prio******:1311 [120] R ==> trace-cmd:1308 [120]
High-prio******-1312 [001] 12165.412321: sched_pi_setprio: 
comm=Low-prio****** pid=1311 oldprio=120 newprio=40
High-prio******-1312 [001] 12165.412324: sched_stat_runtime: 
comm=trace-cmd pid=1308 runtime=11910 [ns] vruntime=945764566590 [ns]
trace-cmd-1308 [000] 12165.412335: sched_stat_runtime: comm=trace-cmd 
pid=1308 runtime=9912 [ns] vruntime=945764576502 [ns]
High-prio******-1312 [001] 12165.412337: sched_switch: 
High-prio******:1312 [40] D ==> Busy-loop******:1313 [41]
trace-cmd-1308 [000] 12165.412340: sched_switch: trace-cmd:1308 [120] R 
==> Low-prio******:1311 [40]
Low-prio******-1311 [000] 12165.412352: sched_wakeup: 
High-prio******:1312 [40] success=1 CPU:001
Low-prio******-1311 [000] 12165.412356: sched_pi_setprio: 
comm=Low-prio****** pid=1311 oldprio=40 newprio=120
Busy-loop******-1313 [001] 12165.412356: sched_switch: 
Busy-loop******:1313 [41] R ==> High-prio******:1312 [40]
Low-prio******-1311 [000] 12165.412361: sched_stat_runtime: 
comm=Low-prio****** pid=1311 runtime=1998 [ns] vruntime=945770556114 [ns]
Low-prio******-1311 [000] 12165.412368: sched_stat_runtime: 
comm=Low-prio****** pid=1311 runtime=6108 [ns] vruntime=945770562222 [ns]
High-prio******-1312 [001] 12165.412370: sys_exit: NR 240 = 0
Low-prio******-1311 [000] 12165.412372: sched_switch: 
Low-prio******:1311 [120] R ==> trace-cmd:1308 [120]
High-prio******-1312 [001] 12165.412374: sys_enter: NR 263 (1, b6e05e10, 
26c, b6e05e10, 0, 0)
High-prio******-1312 [001] 12165.412377: sys_exit: NR 263 = 0
...
Low-prio******-1311 [000] 12165.412519: sys_exit: NR 240 = 0

Analysis:
At .412229, "High-prio******" does a futex lock (system call 240, 
parameters:11524, 86,)
At .412248, "Low-prio******" holds that lock so its priority is raised 
because "High-prio******" is waiting for it
At .412266, CPU1 switches from "High-prio******" to "Busy-loop******" 
because it is waiting at the lock
At .412280, "Low-prio******" wants to release the lock as it has 
finished its workload (system call 240, parameters: 11524, 87,)
At .412295, "Low-prio******" sends wake up event for "High-prio******" 
to run (probably because it is not holding the lock anymore)
At .412300, "Low-prio******" lowers its priority
At .412301, "High-prio******" gets to run, but this is interesting as in 
the next steps it won't exit the system call 240 (parameters:11524, 86,) 
until .412370
At .412321, "Low-prio******"'s priority is raised by "High-prio******" 
again, as if "High-prio******" is waiting for something, but then why 
was it woken up before?
* did "Low-prio******" acquire the lock again? How could it manage this 
feat since it is already in the unlock system call?
The next steps do the same as the above, raise priority for 
"Low-prio******" while "High-prio******" waits. "Low-prio******" will 
wakeup "High-prio******".
At .412372 "High-prio******" finally exits the acquire lock system call, 
141us later.
Much later, at .412519 "Low-prio******" finishes the unlock call.

[1] http://documents.adirat.com/zynq-trace
[2] http://documents.adirat.com/rpi2-trace

--------------000406050005020604050806
Content-Transfer-Encoding: 7bit
Content-Type: text/x-csrc;
 name="mutex_overhead.c"
Content-Disposition: attachment;
 filename="mutex_overhead.c"

#define _GNU_SOURCE
#include <pthread.h>
#include <sys/prctl.h>
#include <stdio.h>
#include <string.h>
#include <sched.h>

#define TRAINING		(50)
#define ITERATIONS		(10^3)
#define HIGH_THD_ITERATIONS	(TRAINING + ITERATIONS)

#define NS_PER_SEC	(10^9)

#define HIGH_PRIO	(59)

#define CORE0_ID	(0)
#define CORE1_ID	(1)

pthread_mutex_t lock;

/* the busyloop & lowpriority threads will loop on this while the high priority
   thread will set it after it finishes all its iterations */
int threads_stop_flag = 0;

/* the high-priority thread uses this struct to find the maximum latency between
   payloads from all its iterations */
struct timespec max_latency = {0, 0};

struct loads
{
	struct timespec hold_lock_load;
	struct timespec no_lock_load;
};

int subtract_timespec(struct timespec *x,
		      struct timespec *y,
		      struct timespec *result)
{
	if (x->tv_nsec < y->tv_nsec) {
		int sec = (y->tv_nsec - x->tv_nsec) / NS_PER_SEC + 1;
		y->tv_nsec -= NS_PER_SEC * sec;
		y->tv_sec += sec;
	}
	if (x->tv_nsec - y->tv_nsec > NS_PER_SEC) {
		int sec = (x->tv_nsec - y->tv_nsec) / NS_PER_SEC;
		y->tv_nsec += NS_PER_SEC * sec;
		y->tv_sec -= sec;
	}

	result->tv_sec = x->tv_sec - y->tv_sec;
	result->tv_nsec = x->tv_nsec - y->tv_nsec;

	return x->tv_sec < y->tv_sec;
}

int compare_timespec(struct timespec *x,
		     struct timespec *y)
{
	if (x->tv_sec > y->tv_sec)
		return 1;
	if (x->tv_sec == y->tv_sec)
	{
		if (x->tv_nsec == y->tv_nsec)
			return 0;
		if (x->tv_nsec > y->tv_nsec)
			return 1;
	}
	return -1;
}

int setup_rt_pthread(int prio, int cpu, const char* name)
{
	struct sched_param schedp;
	cpu_set_t cpuset;
	pthread_t thread = pthread_self();
	int error = 0;

	memset(&schedp, 0, sizeof(schedp));
	CPU_ZERO(&cpuset);

	schedp.sched_priority = prio;
	error = pthread_setschedparam(thread, SCHED_FIFO, &schedp);
	if (error)
		fprintf(stderr, "%s: Couldn't setschedparam, returned %d\n", name, error);

	CPU_SET(cpu, &cpuset);
	error = pthread_setaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
	if (error)
		fprintf(stderr, "%s: Couldn't setaffinity, returned %d\n", name, error);

	error = prctl(PR_SET_NAME, name, NULL, NULL, NULL,NULL);
	if (error)
		fprintf(stderr, "%s: Couldn't set proc name, returned %d\n", name, error);

	return -error;
}

inline void do_load(struct timespec load)
{
	struct timespec loop_start, current, result;

	clock_gettime(CLOCK_MONOTONIC, &loop_start);

	do {
		clock_gettime(CLOCK_MONOTONIC, &current);
		subtract_timespec(&current, &loop_start, &result);
	} while (compare_timespec(&result, &load) <= 0);
}

void *busy_loop_threadfun(void *busy_loads)
{
	if (setup_rt_pthread(HIGH_PRIO - 1, CORE1_ID, "Busy-loop******")) {
		fprintf(stderr, "Busy-loop****** setup error");
		return (void*) -1;
	}
	
	while (!threads_stop_flag); /* loop until high-prio thread signals */

	return 0;
}

void *low_prio_threadfun(void *low_loads)
{
	struct loads *load = (struct loads*) low_loads;

	if (prctl(PR_SET_NAME, "Low-prio******", NULL, NULL, NULL,NULL) < 0) {
		fprintf(stderr, "Low--prio****** setup error");
		return (void*) -1;
	}

	while (!threads_stop_flag) {
		pthread_mutex_lock(&lock);
		do_load(load->hold_lock_load);
		pthread_mutex_unlock(&lock);
		do_load(load->no_lock_load);
	}

	return 0;
}

void *high_prio_threadfun(void* high_loads)
{
	struct loads *load = (struct loads*)high_loads;
	struct timespec prev, cur, latency;
	int i;

	if (setup_rt_pthread(HIGH_PRIO, CORE1_ID, "High-prio******")) 
	{
		fprintf(stderr, "High-prio****** setup error");
		threads_stop_flag = 1;
		return (void*) -1;
	}

	clock_gettime(CLOCK_MONOTONIC, &prev);

	/* runs the payloads and computes latencies between them, stores max;
	   the first iterations are for training, so no latency is stored */
	for (i = HIGH_THD_ITERATIONS; i > 0; --i) {
		pthread_mutex_lock(&lock);
		do_load(load->hold_lock_load);
		pthread_mutex_unlock(&lock);
		do_load(load->no_lock_load);

		clock_gettime(CLOCK_MONOTONIC, &cur);
		subtract_timespec(&cur, &prev, &latency);
		subtract_timespec(&latency, &load->hold_lock_load, &latency);
		subtract_timespec(&latency, &load->no_lock_load, &latency);

		if (i <= ITERATIONS &&
		    compare_timespec(&latency, &max_latency) > 0) {
			max_latency.tv_sec = latency.tv_sec;
			max_latency.tv_nsec = latency.tv_nsec;
		}

		prev = cur;
	}

	threads_stop_flag = 1;

	return 0;
}

unsigned int initialize_mutex()
{
	pthread_mutexattr_t lock_attr;
	unsigned int error = 0;

	memset(&lock, 0, sizeof(pthread_mutex_t));
	pthread_mutexattr_init(&lock_attr);
	error = pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_NORMAL);
	error |= pthread_mutexattr_setprotocol(&lock_attr, PTHREAD_PRIO_INHERIT);
	error |= pthread_mutex_init(&lock, &lock_attr);
	pthread_mutexattr_destroy(&lock_attr);

	return error;
}

int main (int argc, char* argv[])
{
	pthread_t low_prio_thd, high_prio_thd, busy_loop_thd;
	struct loads high_prio_load = {{0,1001},{0,1001}};
	struct loads low_prio_load = {{0,1001},{0,1001}};

	if (initialize_mutex())
		return -1;

	pthread_create(&low_prio_thd, NULL, &low_prio_threadfun, (void *) &low_prio_load);
	pthread_create(&high_prio_thd, NULL, &high_prio_threadfun, (void *) &high_prio_load);
	pthread_create(&busy_loop_thd, NULL, &busy_loop_threadfun, NULL);

	pthread_join(low_prio_thd, NULL);
	pthread_join(high_prio_thd, NULL);
	pthread_join(busy_loop_thd, NULL);

	pthread_mutex_destroy(&lock);

	printf("Highest latency: %li\n", max_latency.tv_sec * NS_PER_SEC + max_latency.tv_nsec);

	return 0;
}

--------------000406050005020604050806--
