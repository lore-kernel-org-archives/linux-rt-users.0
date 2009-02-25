From: Lukasz Majewski <majess1982@gmail.com>
Subject: [linux-2.6.26.8-rt14] modified "square wave" example program
Date: Wed, 25 Feb 2009 15:44:16 +0100
Message-ID: <49A55940.6090207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: majess1982@gmail.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:10467 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757208AbZBYOoV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Feb 2009 09:44:21 -0500
Received: by fk-out-0910.google.com with SMTP id f33so41260fkf.5
        for <linux-rt-users@vger.kernel.org>; Wed, 25 Feb 2009 06:44:18 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello.

I'm trying to solve problem with my RT application.

I've  downloaded "square.c" example program from rt-wiki web page.
I've modified it a bit and set 20 ms period of my RT task and busy wait 
for 15ms on this task. I'm "yielding" CPU for other tasks for 5ms. The 
whole source code is pasted below.
This busy waiting simulates my "real" application in which I'm 
performing some calculations (signal filtering).
I've unchanged priorities of other tasks (as also shown below).

On my target, root file system is mounted via NFS. I'm not using any ram 
disk for startup purposes, just mounting root file system via NFS from 
my host machine (root=/dev/nfs on my kernel's cmd line).
I'm using brand new arm-v5te-linux-gnueabi toolchain with glibc 2.8, gcc 
4.3.2, binutils 2.18 (special thanks to Mark and Robert from 
pengutronix.de for support :-) )

I have to use static linking during building of my application, because 
on my NFS mounted root file system I've got other toolchain built (gcc 
3.2 with OABI) and shared libraries from it aren't working with my 
program.  Due to this, linked binary has 3.2 MB and after stripping 
around 460KB.

When I start my program, it runs once and exit normally. When I want to 
start it again ,it hangs and target is not responsive anymore.

I'd like to ask if there is any limit on the amount of time that RT 
process/ thread can consume only for it? To be more precise , if I have 
20 ms period for RT process/thread is it safe to busy waiting(i.e. 
executing some operations) for 15 ms in it? How can I assure that other, 
necessary processes will not starve (especially those responsible for 
NFS root file system )?

For the original "square wave" example RT thread wakes up with period of 
50us performs it's operation for maybe 5us and then goes sleep. It means 
(in a big simplification) that it only consumes 10% of processor time. 
In my modified example it's consuming  around 75% of CPU time ( 
nonetheless top utility shows always up to 50%).

Are there any special guidelines for writing programs employing cyclic 
schedule?

Regards,
Lukasz

p.s. All comments on pasted below application are very welcomed. :-)

Modified "square wave " application source code.

#include <stdlib.h>

#include <stdio.h>

#include <time.h>

#include <sched.h>

#include <sys/mman.h>

#include <string.h>

#include <errno.h> /*Error number definitions*/

#define MY_PRIORITY (71) /* we use 49 as the PRREMPT_RT use 50

                            as the priority of kernel tasklets

                            and interrupt handler by default */

#define MAX_SAFE_STACK (8*1024) /* The maximum stack size which is

                                   guranteed safe to access without

                                   faulting */

#define NSEC_PER_SEC    (1000000000) /* The number of nsecs per sec. */

/* Time measurement definition */

static struct timespec tim_start, tim;

void init_reftime(void) {

    int ret;

    ret = clock_gettime(CLOCK_MONOTONIC, &tim_start);

    if (ret == -1) {

        perror("clock_gettime");

    }

}

unsigned long reftime(void) { /* usek resolution */ 

    int ret;

    static unsigned long long reftime;

    static long tmp_reftime;

    

    ret = clock_gettime(CLOCK_MONOTONIC, &tim);

    if (ret == -1) {

        perror("clock_gettime");

    }

    /* Calculating time stamp at us resolution */

    tmp_reftime = tim.tv_sec - tim_start.tv_sec;

    

    reftime = (unsigned long long) tmp_reftime * 1000000000; /* sec to ns */

    tmp_reftime = tim.tv_nsec - tim_start.tv_nsec;

    reftime += (unsigned long long) tmp_reftime;

    /* ns to us */

    reftime /= 1000;

    

    return reftime;

}

void stack_prefault(void) {

  unsigned char dummy[MAX_SAFE_STACK];

  memset(&dummy, 0, MAX_SAFE_STACK);

  return;

}

int main(int argc, char* argv[])

{

  static int cnt;

  static unsigned long tt,ta;

  struct timespec t;

  struct sched_param param;

  int interval = 20000000; /* 20ms*/

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

  init_reftime();

  

  clock_gettime(CLOCK_MONOTONIC ,&t);

  /* start after one second */

  t.tv_sec++;

  for(cnt = 0; cnt < 10000; cnt++) {

    /* wait until next shot */

    clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL);

    /* do the stuff */

    /* busy waiting for 15 ms -> period is 20ms */

    

    tt = reftime();

    ta = tt;


    while (ta <= (tt+15000)) {

      ta = reftime();

    }

    

    /* calculate next shot */

    t.tv_nsec += interval;

    while (t.tv_nsec >= NSEC_PER_SEC) {

      t.tv_nsec -= NSEC_PER_SEC;

      t.tv_sec++;

    }

  }

  return 0;

}

Output from ps -eH -o pid,rtptio,sched,cmd command executed on my target 
(rt_test is the name of my application):

172:~# ps -eH -o pid,rtprio,sched,cmd

  PID RTPRIO SCH CMD

    2      -   0 [kthreadd]

    3     99   1   [posixcputmr/0]

    4     50   1   [sirq-high/0]

    5     50   1   [sirq-timer/0]

    6     50   1   [sirq-net-tx/0]

    7     50   1   [sirq-net-rx/0]

    8     50   1   [sirq-block/0]

    9     50   1   [sirq-tasklet/0]

   10     50   1   [sirq-sched/0]

   11     50   1   [sirq-hrtimer/0]

   12     50   1   [sirq-rcu/0]

   13      -   0   [desched/0]

   14      -   0   [rcu_sched_grace]

   15      1   1   [events/0]

   16      -   0   [khelper]

   63      1   1   [krcupreemptd]

   64      -   0   [pdflush]

   65      -   0   [pdflush]

   66      -   0   [kswapd0]

   67      -   0   [aio/0]

   68      -   0   [nfsiod]

  660     50   1   [IRQ-5]

  695      -   0   [rpciod/0]

  696     50   1   [loadavg]

  701     50   1   [IRQ-1]

    1      -   0 init [2]  

  719      -   0   /usr/sbin/sshd

  735      -   0     sshd: root@pts/0 

  738      -   0       -bash

  743      -   0         ps -eH -o pid,rtprio,sched,cmd

  721      -   0   /bin/bash

  734     71   1     ./rt_test




