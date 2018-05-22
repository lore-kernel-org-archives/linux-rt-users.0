Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-ua0-f195.google.com ([209.85.217.195]:46527 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751214AbeEVKAu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 May 2018 06:00:50 -0400
Received: by mail-ua0-f195.google.com with SMTP id e8-v6so11877727uam.13
        for <linux-rt-users@vger.kernel.org>; Tue, 22 May 2018 03:00:49 -0700 (PDT)
MIME-Version: 1.0
From: Jordan Palacios <jordan.palacios@pal-robotics.com>
Date: Tue, 22 May 2018 12:00:27 +0200
Message-ID: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
Subject: Non RT threads impact on RT thread
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users@vger.kernel.org

Hello,

We are currently running a version of the linux kernel (3.18.24) with
the RT-PREEMPT patch. In our system there are several non RT tasks and
one RT task. The RT process runs in the FIFO scheduler with 95
priority and a control loop of 1ms.

We have achieved latencies of about 5us which are perfect for us.

Our issue is that the RT task sometimes misses one of its cycles due
to an unexpected very long execution time of its control loop. In our
system this is a critical failure.

We enabled tracing in the kernel and started measuring the execution
time of the RT thread. The execution time is quite constant (about
200us), which random spikes every now and then. Thing is, the less non
RT tasks running in the system the better the RT task behaves.

We wrote a very simple RT application that does some light work and
writes its execution time using the trace_marker. Execution time is
constant but IO intensive stuff, like a stress --io 32 or a hdparm,
will have and impact on its execution time. This is surprising because
the test does not any kind of work related to IO. Nor does the RT task
in our system for that matter.

Our question is: Is this behaviour normal? Why are non RT tasks
affecting the RT task performance? Is there any other kind of test
that we could run that would shed some light on this issue?

Thanks in advance.

Jordan.



#include <limits.h>
#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sstream>
#include <math.h>
#include <unistd.h>
#include <stdarg.h>

typedef long long NANO_TIME;
typedef struct timespec TIME_SPEC;

static const long int INTERVAL = 1000000LL; // 1ms

static TIME_SPEC nano2timespec(NANO_TIME hrt)
{
  TIME_SPEC timevl;
  timevl.tv_sec = hrt / 1000000000LL;
  timevl.tv_nsec = hrt % 1000000000LL;
  return timevl;
}

static double to_us(NANO_TIME ns)
{
  return static_cast<double>(ns) / 1000.0;
}

static NANO_TIME get_time_ns(void)
{
  TIME_SPEC tv;
  clock_gettime(CLOCK_REALTIME, &tv);
  return NANO_TIME(tv.tv_sec) * 1000000000LL + NANO_TIME(tv.tv_nsec);
}

static const unsigned int WORK_SIZE = 10000;

void do_work()
{
  unsigned int i = 0;
  double aux = 2;

  // do some stuff to use cpu
  while (i < WORK_SIZE)
  {
    aux = pow(aux, i);
    ++i;
  }
}

int trace_fd = -1;

void trace_write(const char* fmt, ...)
{
  va_list ap;
  char buf[256];
  int n;

  if (trace_fd < 0)
    return;

  va_start(ap, fmt);
  n = vsnprintf(buf, 256, fmt, ap);
  va_end(ap);

  write(trace_fd, buf, n);
}

void* thread_func(void* /*data*/)
{
  pid_t tid = syscall(__NR_gettid);
  printf("pthread joined. TID %i \n", tid);

  TIME_SPEC ts_next;
  NANO_TIME wake, init, after_work;

  wake = get_time_ns() + INTERVAL;
  ts_next = nano2timespec(wake);

  while (true)
  {
    init = get_time_ns();

    if (init < wake)
    {
      do_work();
      after_work = get_time_ns();

      const double exec_time = to_us(after_work - init);
      trace_write("rt_test_exec_time - %f", exec_time);
    }
    else
    {
      printf("overrun detected\n");
    }

    clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &(ts_next), NULL);
    wake = wake + INTERVAL;
    ts_next = nano2timespec(wake);
  }
  return NULL;
}

int main(int /*argc*/, char* /*argv*/[])
{
  struct sched_param param;
  pthread_attr_t attr;
  pthread_t thread;
  int ret;

  /* Lock memory */
  if (mlockall(MCL_CURRENT | MCL_FUTURE) == -1)
  {
    printf("mlockall failed: %m\n");
    exit(-2);
  }

  /* Allocate all the memory required by the process */
  if (!malloc(100 * 1048576))  // 100MB
  {
    printf("malloc failed\n");
    exit(-3);
  }

  /* Initialize pthread attributes (default values) */
  ret = pthread_attr_init(&attr);
  if (ret)
  {
    printf("init pthread attributes failed\n");
    return ret;
  }

  /* Set a specific stack size  */
  ret = pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN * 100);
  if (ret)
  {
    printf("pthread setstacksize failed\n");
    return ret;
  }

  /* Set scheduler policy and priority of pthread */
  ret = pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
  if (ret)
  {
    printf("pthread setschedpolicy failed\n");
    return ret;
  }

  param.sched_priority = 95;
  ret = pthread_attr_setschedparam(&attr, &param);
  if (ret)
  {
    printf("pthread setschedparam failed\n");
    return ret;
  }

  /* Use scheduling parameters of attr */
  ret = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
  if (ret)
  {
    printf("pthread setinheritsched failed\n");
    return ret;
  }

  /* Create a pthread with specified attributes */
  ret = pthread_create(&thread, &attr, thread_func, NULL);
  if (ret)
  {
    printf("create pthread failed\n");
    return ret;
  }

  /* Open tracer_marker */
  trace_fd = open("/tracing/trace_marker", O_WRONLY);
  if (trace_fd == -1)
  {
    printf("trace_marker open failed\n");
    return ret;
  }

  system("echo 1 > /tracing/tracing_on");             // enable tracing
  system("echo nop > /tracing/current_tracer");       // reset trace
  system("echo function > /tracing/current_tracer");  // use function tracer
  system("echo 1 > /tracing/events/enable");          // enable all events

  /* Join the thread and wait until it is done */
  ret = pthread_join(thread, NULL);
  if (ret)
    printf("join pthread failed: %m\n");

  system("echo 0 > /tracing/tracing_on");     // disable tracing
  system("echo 0 > /tracing/events/enable");  // disable all events

  return ret;
}
