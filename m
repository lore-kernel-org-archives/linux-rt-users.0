From: Hector Perez Tijero <perezh@unican.es>
Subject: Posix Execution time clock
Date: Tue, 01 Dec 2009 07:14:45 -0500
Message-ID: <4B1508B5.7030202@unican.es>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ccserver2.unican.es ([130.206.5.101]:34228 "EHLO
	ccserver2.unican.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbZLAGiH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Dec 2009 01:38:07 -0500
Received: from ccserver2.unican.es (ccserver2.unican.es [127.0.0.1])
	by ccserver2.unican.es (Postfix) with ESMTP id C513C182E2B
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Dec 2009 07:15:28 +0100 (CET)
Received: from correo.unican.es (ccserver18.unican.es [130.206.5.18])by
	ccserver2.unican.es (Postfix) with ESMTP id B9BFC182E1Ffor
	<linux-rt-users@vger.kernel.org>; Tue,  1 Dec 2009 07:15:28 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

My question might be a little basic for this list... Maybe someone could 
point me out to another forum :)

I'm trying to get some measures using the execution time clock in my 
system and I found some slight differences in the use of the 
CLOCK_THREAD_CPUTIME_ID and CLOCK_MONOTONIC clocks. The measures are 
between the same points of code. My concern is that, sometimes, the 
measure obtained with CLOCK_MONOTONIC is lower than using 
CLOCK_THREAD_CPUTIME_ID. Find below a dummy example to test this strange 
behavior.

It doesn't happen very often but the error could be around hundreds of 
microseconds.

So my question is: are both POSIX clocks based on different physical 
clocks? I always though they use the TSC...

My previous guess was that such behavior could be caused by the CPU 
frequency scaling but the same happened when I disabled it.

My system is running Linux 2.6.24-25-rt #1 SMP PREEMPT RT  (Ubuntu 
package) and I run my tests using the affinity parameter to bind all the 
threads included in the test to the same CPU.

Thanks so much and great work

Hector

---

#include <time.h>
#include <pthread.h>
#include <float.h>

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>

#define THREAD_CLOCK CLOCK_THREAD_CPUTIME_ID
#define COMMON_CLOCK CLOCK_MONOTONIC

#define LAST_JOB   10000
#define PRIO_HIGH    90

#define MAX_SAFE_STACK (8*1024) /* The maximum stack size which is
                       guaranteed safe to access without
                       faulting */

#define CHK(p) { int ret;                                      \
                 if ((ret = p)) {                   \
                   printf ("Error:"#p":%s\n", strerror (ret)); \
                   exit (-1);                                  \
}                                             \
}

static int error_count = 0;

double timespec_to_double(const struct timespec *time)
{
  return time->tv_nsec*1E-9 + (double)time->tv_sec;
}

void double_to_timespec(double time, struct timespec *ts)
{
  ts->tv_sec = (long) time;
  ts->tv_nsec = (long)((time - (double)ts->tv_sec) * 1E9);
}

void  add_timespec (struct timespec *s,
                    const struct timespec *t1,
                    const struct timespec *t2)
{
  s->tv_sec  = t1->tv_sec  + t2->tv_sec;
  s->tv_nsec = t1->tv_nsec + t2->tv_nsec;
  if (s->tv_nsec >= 1E9) {
    s->tv_sec ++;
    s->tv_nsec -= 1E9;
  }
}

void incr_timespec (struct timespec *t1, const struct timespec *t2)
{
  t1->tv_sec += t2->tv_sec;
  t1->tv_nsec += t2->tv_nsec;
  if (t1->tv_nsec >= 1E9) {
    t1->tv_sec ++;
    t1->tv_nsec -= 1E9;
  }
}

int smaller_or_equal_timespec (const struct timespec *t1,
                                             const struct timespec *t2)
{
  return t1->tv_sec < t2->tv_sec || (t1->tv_sec == t2->tv_sec &&
      t1->tv_nsec <= t2->tv_nsec);
}

int compare_times (float time, struct timespec* start, struct timespec* 
stop)
{
  double diff, start_time, stop_time = 0.0;
 
  start_time = timespec_to_double (start);
  stop_time = timespec_to_double (stop);
 
  diff = stop_time - start_time;
 
  if (time > diff)
  {
    ++error_count;
    printf ("\tError number %d: %7.6f microseconds\n", error_count, 
(time-diff)*1E6);
  }
  return 0;
}

void stack_prefault(void) {

  unsigned char dummy[MAX_SAFE_STACK];

  memset(&dummy, 0, MAX_SAFE_STACK);
  return;
}

int posix_linux_requirements (void) {
  /* Lock memory */
  if(mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {
    perror("mlockall failed");
    return (-1);
  }
 
  /* Pre-fault our stack */
  stack_prefault ();
 
  return 0;
}

void eat (float for_seconds)
{
  struct timespec now, temp, end;
 
  clock_gettime (THREAD_CLOCK, &now);
 
  double_to_timespec (for_seconds, &temp);
  add_timespec (&end, &now, &temp);
 
  do {
    clock_gettime(THREAD_CLOCK, &now);
  }
  while ( smaller_or_equal_timespec (&now, &end) );
}

int main (int argc, char *argv[])
{
  //  Execution Time
  float time = 9E-4;                 //900 microseconds
  struct timespec period = {0, 1.8E6}; //  1.8 milliseconds
  struct sched_param param_rt;
  struct timespec next_activation, start_time, stop_time;
  int count = 0;
 
    
  //  Change policy to SCHED_FIFO and priority to main thread
  param_rt.sched_priority = PRIO_HIGH;
  //CHK ( pthread_setschedparam (pthread_self(), SCHED_FIFO, &param_rt) );
  CHK ( sched_setscheduler (0, SCHED_FIFO, &param_rt) );
 
  //  Set Linux RT-PREEMPT requirements
  CHK ( posix_linux_requirements () );
 
  CHK ( clock_gettime(COMMON_CLOCK, &next_activation) );
 
  for (count = 0; count < LAST_JOB; count++)
  {
 
    CHK (clock_nanosleep(COMMON_CLOCK, TIMER_ABSTIME,
                       &next_activation, NULL));
   
    CHK ( clock_gettime(COMMON_CLOCK, &start_time) );
    //  Do job: execution time clock
    eat (time);
    CHK ( clock_gettime(COMMON_CLOCK, &stop_time) );
    CHK ( compare_times (time, &start_time, &stop_time) );
    //  Compute next activation
    incr_timespec (&next_activation, &period);
  }
  printf ("\nEnd of test\n");
  return 0;
}
