From: thierry bultel <tbultel@pixelsurmer.com>
Subject: 4.9.6-rt4: big latency due to a kworker upon serial interrupts
Date: Tue, 31 Jan 2017 17:05:28 +0100
Message-ID: <488a615d-8256-3dc6-9e9d-8101adca3126@pixelsurmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smart-C.cogent.hosteam.fr ([154.41.64.12]:41098 "EHLO
        smart-C.cogent.hosteam.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbdAaQPN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Jan 2017 11:15:13 -0500
Received: from webmail10.hosteam.fr (unknown [192.168.2.161])
        by smart-C.cogent.hosteam.fr (Postfix) with ESMTPS id 986CF2A013F
        for <linux-rt-users@vger.kernel.org>; Tue, 31 Jan 2017 17:05:28 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I am using the latest 4.9.6-rt4 patch. I can reproduce the issue with
4.9.4, too.

The machine is an imx6 solo, and the kernel is the vanilla one.
I have CONFIG_PREEMPT_RT_FULL

I have basically taken the trivial hello_world example, and just added a 
check on the wakeup time (see below):

The problem is that I am getting errors.
The process should wakeup every 20 milliseconds, but sometimes wakes up 
2 to 4 msecs too late.

To reproduce this very easily, I generate interrupts by just keeping
the return key pressed in the serial console.
It it also reproducible, by performing a 'ping -f' from another machine.

I have tried to investigate this, with lttng at first.

In the control flow, I can see kworker/u:2 that can use 100% CPU during 
about 27 msecs

After having activated some debug traces, I found out that the work 
function for the kworker is 'write_to_ldisc' , which seems
pertinent since the interrupts come from the serial console.
But I still unable to tell why it starves the CPU for so much time.

Another fact is that test shows less fails, with CONFIG_PREEMPT, than 
with CONFIG_PREEMPT_RT_FULL. And with CONFIG_PREEMPT, the late delay in 
never bigger than 2 msecs.

As anyone encountered such an issue ?
Thanks !

-----------------


#include <stdlib.h>
#include <stdio.h>
#include <time.h>
#include <sched.h>
#include <sys/mman.h>
#include <string.h>
#include <stdint.h>

#define MY_PRIORITY (49) /* we use 49 as the PRREMPT_RT use 50
                                 as the priority of kernel tasklets
                                 and interrupt handler by default */

#define MAX_SAFE_STACK (8*1024) /* The maximum stack size which is
                                        guaranteed safe to access without
                                        faulting */

#define NSEC_PER_SEC    (1000000000) /* The number of nsecs per sec. */

void stack_prefault(void) {

	unsigned char dummy[MAX_SAFE_STACK];

	memset(dummy, 0, MAX_SAFE_STACK);
	return;
}

uint64_t timespec2msec(const struct timespec * t) {
	return (t->tv_sec*1000 + t->tv_nsec / 1000000.0);
}

int main(int argc, char* argv[])
{
	struct timespec t;
	struct sched_param param;
	int interval = 20000000; /* 20 milliseconds */

	/* Declare ourself as a real time task */

	param.sched_priority = MY_PRIORITY;
	if(sched_setscheduler(0, SCHED_FIFO, &param) == -1) {
		perror("sched_setscheduler failed");
		exit(-1);
	}

	/* Lock memory */

	if(mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
		perror("mlockall failed");
		exit(-2);
	}

	/* Pre-fault our stack */

	stack_prefault();

	clock_gettime(CLOCK_MONOTONIC ,&t);
	/* start after one second */
	t.tv_sec++;

	while(1) {
		struct timespec now;
		int ret;
		/* wait until next shot */
		ret = clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL);

		clock_gettime(CLOCK_MONOTONIC, &now);
		uint64_t late = timespec2msec(&now) - timespec2msec(&t);

		if (ret < 0)
			printf("ERROR\n");

		if (late >= 2) {
			printf("Too late: %lld\n", late);
		}

		/* do the stuff */

		/* calculate next shot */
		t.tv_nsec += interval;

		while (t.tv_nsec >= NSEC_PER_SEC) {
			t.tv_nsec -= NSEC_PER_SEC;
			t.tv_sec++;
		}
	}
}


