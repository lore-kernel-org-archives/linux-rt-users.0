From: john stultz <johnstul@us.ibm.com>
Subject: -O option causing test jitter?
Date: Thu, 17 Apr 2008 16:59:54 -0700
Message-ID: <1208476794.6307.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-l0bP1ul4r/Aeimbq1jQa"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59445 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755456AbYDQX76 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Apr 2008 19:59:58 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3HNxvJd005381
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Apr 2008 19:59:57 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id m3HNxviE1089924
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Apr 2008 19:59:57 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m3HNxv3h022994
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Apr 2008 19:59:57 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-l0bP1ul4r/Aeimbq1jQa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

So I've been using the attached test case (a hacked up version of
sched_jitter, which can now be found in ltp) to measure jitter in a
cpu-bound workload. The idea being if nothing preempts us, we might get
some irq caused jitter, but it should be pretty minimal.

Only recently I had noticed it wasn't that minimal. For 2.5 seconds of
work, I was seeing up to 5-10ms of jitter, which seemed a bit high.

So I dug in and instrumented the kernel and logged any time we got
preempted by a process, or an irq blocked us, or even time spent waiting
on raw locks and seqlocks.

With all the instrumenting I could, I could only account for maybe 2% of
the jitter (in one case the jitter was 1.5ms, and I could only account
for 30us from interrupt overhead).

Finally I rebuilt the test using -O2, and suddenly the jitter dropped
way down, and was then 90% or so accounted for by the instrumentation.

The issue seems to be that building w/ -O1, the compiler is doing
something pretty badly that causes the execution time for a fixed amount
of work to be much more variable.

Anyway, I wanted to hit the list with this so folks could look at it and
let me know if such severe jitter was expected from just compile
options?

thanks
-john




To build:
gcc -lrt -O1 sched_jitter.c -o sched_jitter-O1
gcc -lrt -O2 sched_jitter.c -o sched_jitter-O2


Here's example output:

./sched_jitter-O1
delta: 2479.231934 ms
delta: 2476.494629 ms
delta: 2473.964355 ms
delta: 2474.239746 ms
delta: 2472.457275 ms
delta: 2476.843262 ms
delta: 2475.494141 ms
delta: 2478.266113 ms
delta: 2476.601074 ms
delta: 2475.466553 ms
max jitter: 6.774889 ms
average runtime: 2475.905762 ms



./sched_jitter-O2
delta: 2069.088867 ms
delta: 2069.086914 ms
delta: 2068.875977 ms
delta: 2068.900146 ms
delta: 2068.948242 ms
delta: 2068.889893 ms
delta: 2068.878906 ms
delta: 2068.915283 ms
delta: 2068.913086 ms
delta: 2068.939453 ms
max jitter: 212.876007 us
average runtime: 2068.943848 ms



--=-l0bP1ul4r/Aeimbq1jQa
Content-Disposition: attachment; filename=sched_jitter.c
Content-Type: text/x-csrc; name=sched_jitter.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

/*    Filename: sched_jitter.c
 *      Author: John Stultz <johnstul@us.ibm.com>
 * Description: This test measures scheduling jitter w/ realtime
 * processes.  It spawns a realtime thread that repeatedly times how long
 * it takes to do a fixed amount of work. It then prints out the maximum
 * jitter seen (longest execution time - the shortest execution time).
 * It also spawns off a realtime thread of higher priority that simply
 * wakes up and goes back to sleep. This tries to measure how much
 * overhead the scheduler adds in switching quickly to another task and
 * back.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2006, 2007
 *
 * 2006-May-05:	Initial version by John Stultz <johnstul@us.ibm.com>
 * 2007-July-18: Support to gather stats by Ankita Garg <ankita@in.ibm.com>
 */

#include <stdio.h>
#include <time.h>
#include <pthread.h>
#include <sched.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/prctl.h>

#define PR_PREEMPT_TRACING	23

#define NUMRUNS 10
#define NUMLOOPS 10000000
#define NSEC_PER_SEC 1000000000
#define WORKLEN 64

char  array[WORKLEN];


unsigned long long ts_sub(struct timespec a , struct timespec b)
{
	unsigned long long first, second;
	
	first = (unsigned long long)a.tv_sec * NSEC_PER_SEC + a.tv_nsec;
	second = (unsigned long long)b.tv_sec * NSEC_PER_SEC + b.tv_nsec;
	return first - second;	
}

void print_unit(unsigned long long val)
{
	if (val > 1000000)
		printf("%f ms\n", (float)(val)/1000000);
	else if (val > 1000)
		printf("%f us\n", (float)(val)/1000);
	else
		printf("%f ns\n", (float)val); 

}

void do_work(int runs)
{
	int i, j;
	for (i=0; i < runs; i++) {
		for (j=0; j < WORKLEN-1; j++)
			array[j] = array[j]+array[j+1];
		for (j=0; j < WORKLEN-1; j++)
			array[j] = array[j]-array[j+1];
	}
}



int main(int argc, char *argv[])
{
	struct sched_param param;

	struct timespec start, stop;
	int i;
	unsigned long long delta;
	unsigned long long min=-1, max=0;
	unsigned long long avg=0;

	param.sched_priority = sched_get_priority_max(SCHED_FIFO);
	sched_setscheduler(0, SCHED_FIFO, &param);
	mlockall(MCL_CURRENT|MCL_FUTURE);

        for (i=0; i < NUMRUNS; i++) {

		do_work(1); /* warm cache */

		/* do test */
//		prctl(PR_PREEMPT_TRACING, 1);
		clock_gettime(CLOCK_MONOTONIC, &start);
		do_work(NUMLOOPS);
		clock_gettime(CLOCK_MONOTONIC, &stop);
//		prctl(PR_PREEMPT_TRACING, 0);

		/* calc delta, min and max */
		delta = ts_sub(stop, start);
		if (delta < min)
			min = delta;
		if (delta> max)
			max = delta;
		avg += delta;
		printf("delta: ");
		print_unit(delta);
		usleep(1); /* let other things happen */
	}

	printf("max jitter: ");
	print_unit(max - min);
	printf("average runtime: ");
	print_unit(avg/NUMRUNS);

	return 0;
}

--=-l0bP1ul4r/Aeimbq1jQa--

