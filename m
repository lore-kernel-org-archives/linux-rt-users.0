Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34772 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeEVLER (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 May 2018 07:04:17 -0400
Received: by mail-ua0-f193.google.com with SMTP id f22-v6so12002147uam.1
        for <linux-rt-users@vger.kernel.org>; Tue, 22 May 2018 04:04:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d3dfe5596f1943c9a287be8a34a40161@de01ex22.GLOBAL.JHCN.NET>
References: <CAGiv7G3sWoamRjg=ArLRi1eYYFJLY4bZvX2VQttMsw8DuVVScA@mail.gmail.com>
 <d3dfe5596f1943c9a287be8a34a40161@de01ex22.GLOBAL.JHCN.NET>
From: Jordan Palacios <jordan.palacios@pal-robotics.com>
Date: Tue, 22 May 2018 13:03:56 +0200
Message-ID: <CAGiv7G2ivUoKrsfaOGnDiPs_0ZLrTL1vEviNnthUXwPvDe+6YQ@mail.gmail.com>
Subject: Re: Non RT threads impact on RT thread
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Lampersperger Andreas <lampersperger.andreas@heidenhain.de>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Hello Andreas,

Thanks for your response.

Our system has hyperthreading currently disabled. In fact we have
tested and applied most of the tips given here:
http://linuxrealtime.org/index.php/Improving_the_Real-Time_Properties

The RT task is running in an isolated CPU (using cset) but even stuff
like hdparm (which is used for testing hard drives) manages to somehow
impact the RT performance.

Kind regards,
Jordan.

On 22 May 2018 at 12:20, Lampersperger Andreas
<lampersperger.andreas@heidenhain.de> wrote:
> Hello Jordan,
>
> IMHO this is because the non-RT Tasks uses the same CPU and therefore the=
 same cache. Especially when your CPU has hyperthreading also the L1-Cache =
is shared between RT and non-RT.
> Try using different CPUs for RT and non-RT tasks und disable hyperthreadi=
ng (in the bios).
>
> @all: When I'm not correct, I would be very pleased if somebody let me kn=
ow about this.
>
> Best regards
> Andreas
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vg=
er.kernel.org] Im Auftrag von Jordan Palacios
> Gesendet: Dienstag, 22. Mai 2018 12:00
> An: linux-rt-users@vger.kernel.org
> Betreff: Non RT threads impact on RT thread
>
> Hello,
>
> We are currently running a version of the linux kernel (3.18.24) with the=
 RT-PREEMPT patch. In our system there are several non RT tasks and one RT =
task. The RT process runs in the FIFO scheduler with 95 priority and a cont=
rol loop of 1ms.
>
> We have achieved latencies of about 5us which are perfect for us.
>
> Our issue is that the RT task sometimes misses one of its cycles due to a=
n unexpected very long execution time of its control loop. In our system th=
is is a critical failure.
>
> We enabled tracing in the kernel and started measuring the execution time=
 of the RT thread. The execution time is quite constant (about 200us), whic=
h random spikes every now and then. Thing is, the less non RT tasks running=
 in the system the better the RT task behaves.
>
> We wrote a very simple RT application that does some light work and write=
s its execution time using the trace_marker. Execution time is constant but=
 IO intensive stuff, like a stress --io 32 or a hdparm, will have and impac=
t on its execution time. This is surprising because the test does not any k=
ind of work related to IO. Nor does the RT task in our system for that matt=
er.
>
> Our question is: Is this behaviour normal? Why are non RT tasks affecting=
 the RT task performance? Is there any other kind of test that we could run=
 that would shed some light on this issue?
>
> Thanks in advance.
>
> Jordan.
>
>
>
> #include <limits.h>
> #include <pthread.h>
> #include <sched.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <sys/types.h>
> #include <sys/syscall.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <sstream>
> #include <math.h>
> #include <unistd.h>
> #include <stdarg.h>
>
> typedef long long NANO_TIME;
> typedef struct timespec TIME_SPEC;
>
> static const long int INTERVAL =3D 1000000LL; // 1ms
>
> static TIME_SPEC nano2timespec(NANO_TIME hrt) {
>   TIME_SPEC timevl;
>   timevl.tv_sec =3D hrt / 1000000000LL;
>   timevl.tv_nsec =3D hrt % 1000000000LL;
>   return timevl;
> }
>
> static double to_us(NANO_TIME ns)
> {
>   return static_cast<double>(ns) / 1000.0; }
>
> static NANO_TIME get_time_ns(void)
> {
>   TIME_SPEC tv;
>   clock_gettime(CLOCK_REALTIME, &tv);
>   return NANO_TIME(tv.tv_sec) * 1000000000LL + NANO_TIME(tv.tv_nsec); }
>
> static const unsigned int WORK_SIZE =3D 10000;
>
> void do_work()
> {
>   unsigned int i =3D 0;
>   double aux =3D 2;
>
>   // do some stuff to use cpu
>   while (i < WORK_SIZE)
>   {
>     aux =3D pow(aux, i);
>     ++i;
>   }
> }
>
> int trace_fd =3D -1;
>
> void trace_write(const char* fmt, ...)
> {
>   va_list ap;
>   char buf[256];
>   int n;
>
>   if (trace_fd < 0)
>     return;
>
>   va_start(ap, fmt);
>   n =3D vsnprintf(buf, 256, fmt, ap);
>   va_end(ap);
>
>   write(trace_fd, buf, n);
> }
>
> void* thread_func(void* /*data*/)
> {
>   pid_t tid =3D syscall(__NR_gettid);
>   printf("pthread joined. TID %i \n", tid);
>
>   TIME_SPEC ts_next;
>   NANO_TIME wake, init, after_work;
>
>   wake =3D get_time_ns() + INTERVAL;
>   ts_next =3D nano2timespec(wake);
>
>   while (true)
>   {
>     init =3D get_time_ns();
>
>     if (init < wake)
>     {
>       do_work();
>       after_work =3D get_time_ns();
>
>       const double exec_time =3D to_us(after_work - init);
>       trace_write("rt_test_exec_time - %f", exec_time);
>     }
>     else
>     {
>       printf("overrun detected\n");
>     }
>
>     clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &(ts_next), NULL);
>     wake =3D wake + INTERVAL;
>     ts_next =3D nano2timespec(wake);
>   }
>   return NULL;
> }
>
> int main(int /*argc*/, char* /*argv*/[]) {
>   struct sched_param param;
>   pthread_attr_t attr;
>   pthread_t thread;
>   int ret;
>
>   /* Lock memory */
>   if (mlockall(MCL_CURRENT | MCL_FUTURE) =3D=3D -1)
>   {
>     printf("mlockall failed: %m\n");
>     exit(-2);
>   }
>
>   /* Allocate all the memory required by the process */
>   if (!malloc(100 * 1048576))  // 100MB
>   {
>     printf("malloc failed\n");
>     exit(-3);
>   }
>
>   /* Initialize pthread attributes (default values) */
>   ret =3D pthread_attr_init(&attr);
>   if (ret)
>   {
>     printf("init pthread attributes failed\n");
>     return ret;
>   }
>
>   /* Set a specific stack size  */
>   ret =3D pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN * 100);
>   if (ret)
>   {
>     printf("pthread setstacksize failed\n");
>     return ret;
>   }
>
>   /* Set scheduler policy and priority of pthread */
>   ret =3D pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>   if (ret)
>   {
>     printf("pthread setschedpolicy failed\n");
>     return ret;
>   }
>
>   param.sched_priority =3D 95;
>   ret =3D pthread_attr_setschedparam(&attr, &param);
>   if (ret)
>   {
>     printf("pthread setschedparam failed\n");
>     return ret;
>   }
>
>   /* Use scheduling parameters of attr */
>   ret =3D pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
>   if (ret)
>   {
>     printf("pthread setinheritsched failed\n");
>     return ret;
>   }
>
>   /* Create a pthread with specified attributes */
>   ret =3D pthread_create(&thread, &attr, thread_func, NULL);
>   if (ret)
>   {
>     printf("create pthread failed\n");
>     return ret;
>   }
>
>   /* Open tracer_marker */
>   trace_fd =3D open("/tracing/trace_marker", O_WRONLY);
>   if (trace_fd =3D=3D -1)
>   {
>     printf("trace_marker open failed\n");
>     return ret;
>   }
>
>   system("echo 1 > /tracing/tracing_on");             // enable tracing
>   system("echo nop > /tracing/current_tracer");       // reset trace
>   system("echo function > /tracing/current_tracer");  // use function tra=
cer
>   system("echo 1 > /tracing/events/enable");          // enable all event=
s
>
>   /* Join the thread and wait until it is done */
>   ret =3D pthread_join(thread, NULL);
>   if (ret)
>     printf("join pthread failed: %m\n");
>
>   system("echo 0 > /tracing/tracing_on");     // disable tracing
>   system("echo 0 > /tracing/events/enable");  // disable all events
>
>   return ret;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in the body of a message to majordomo@vger.kernel.org More majordomo info =
at  http://vger.kernel.org/majordomo-info.html
>
> -------------------------------------------------------------------------=
-----------------------------
> Registergericht: Traunstein / Registry Court: HRB 275 - Sitz / Head Offic=
e: Traunreut
> Aufsichtsratsvorsitzender / Chairman of Supervisory Board: Rainer Burkhar=
d
> Gesch=C3=A4ftsf=C3=BChrung / Management Board: Thomas Sesselmann (Vorsitz=
ender / Chairman),
> Hubert Ermer, Michael Grimm, Lutz Rissing
>
> E-Mail Haftungsausschluss / E-Mail Disclaimer: http://www.heidenhain.de/d=
isclaimer
