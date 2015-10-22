From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 1/4] Android: clean up the bypass ifdeffery
Date: Thu, 22 Oct 2015 10:30:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221029490.5687@riemann>
References: <1445454011-18839-1-git-send-email-haustad@cisco.com> <1445454011-18839-2-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37182 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755327AbbJVIai (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 04:30:38 -0400
Received: by wicfv8 with SMTP id fv8so108957225wic.0
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 01:30:36 -0700 (PDT)
In-Reply-To: <1445454011-18839-2-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 21 Oct 2015, Henrik Austad wrote:

> 88af643971b9 (android: adjust target for android) introduced some really
> ugly ifdefs to avoid calling into pthread_barrier_wait and
> pthread_barrier_init.
> 
> This patch attempts to coalesce this into a single place and let the
> compiler handle the linking so that cyclictest.c is untouched by evil
> ifdefs.
> 
> It also combines NO_PTHREAD_BARRIER and NO_PTHREAD_SETAFFINITY into a
> PTHREAD_BIONIC as it does not make much sense to keep them separated.
> 
> Compiled and tested on:
> - x86_64 (v3.13 kernel)
> - tilegx (v3.10 kernel)
> - arm64 android (v3.10 kernel)
> 
> Note: this includes bionic.h unconditionally, so it makes most sense to
> keep bionic.h in src/include/ (and not in src/arch/bionic/).
> 
> Cc: John Kacur <jkacur@redhat.com>
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  src/arch/bionic/Makefile    |  7 ++-----
>  src/cyclictest/cyclictest.c | 35 ++++-------------------------------
>  src/include/bionic.h        | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+), 36 deletions(-)
>  create mode 100644 src/include/bionic.h
> 
> diff --git a/src/arch/bionic/Makefile b/src/arch/bionic/Makefile
> index 410d2c9c7c37..e25f67203e5a 100644
> --- a/src/arch/bionic/Makefile
> +++ b/src/arch/bionic/Makefile
> @@ -6,8 +6,7 @@
>  # Typically see something like "aarch64-linux-android"
>  ifeq (android,$(ostype))
>  	USE_BIONIC := 1
> -	CFLAGS += -DNO_PTHREAD_BARRIER
> -	CFLAGS += -DNO_PTHREAD_SETAFFINITY
> +	CFLAGS += -DPTHREAD_BIONIC
>  
>  	LDFLAGS += -pie
>  # -lrt and -lpthread is in standard bionic library, no standalone library
> @@ -19,7 +18,5 @@ ifeq (android,$(ostype))
>  # and link properly:
>  # - cyclictest
>  # - hackbench
> -# - hwlatdetect
> -	sources := cyclictest.c hackbench.c hwlatdetect.c
> +	sources := cyclictest.c hackbench.c
>  endif
> -
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 975e7858fb8e..b53fb27a2a41 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -40,6 +40,8 @@
>  
>  #include "rt-utils.h"
>  
> +#include <bionic.h>
> +
>  #define DEFAULT_INTERVAL 1000
>  #define DEFAULT_DISTANCE 500
>  
> @@ -87,15 +89,7 @@ int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
>  extern int clock_nanosleep(clockid_t __clock_id, int __flags,
>  			   __const struct timespec *__req,
>  			   struct timespec *__rem);
> -#endif
> -
> -#ifdef NO_PTHREAD_SETAFFINITY
> -static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
> -                                         const cpu_set_t *cpuset)
> -{
> -    return sched_setaffinity(0, cpusetsize, cpuset);
> -}
> -#endif
> +#endif	/* __UCLIBC__ */
>  
>  #define USEC_PER_SEC		1000000
>  #define NSEC_PER_SEC		1000000000
> @@ -202,14 +196,12 @@ static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
>  static pid_t break_thread_id = 0;
>  static uint64_t break_thread_value = 0;
>  
> -#ifndef NO_PTHREAD_BARRIER
>  static int aligned = 0;
>  static int secaligned = 0;
>  static int offset = 0;
>  static pthread_barrier_t align_barr;
>  static pthread_barrier_t globalt_barr;
>  static struct timespec globalt;
> -#endif
>  
>  /* Backup of kernel variables that we modify */
>  static struct kvars {
> @@ -813,7 +805,6 @@ static void *timerthread(void *param)
>  		      par->cpu, par->prio);
>  
>  	/* Get current time */
> -#ifndef NO_PTHREAD_BARRIER
>  	if (aligned || secaligned) {
>  		pthread_barrier_wait(&globalt_barr);
>  		if (par->tnum == 0) {
> @@ -838,7 +829,6 @@ static void *timerthread(void *param)
>  			tsnorm(&now);
>  		}
>  	} else
> -#endif
>  		clock_gettime(par->clock, &now);
>  
>  	next = now;
> @@ -1052,9 +1042,7 @@ static void display_help(int error)
>  	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
>  	       "                           with NUM pin all threads to the processor NUM\n"
>  #endif
> -#ifndef NO_PTHREAD_BARRIER
>  	       "-A USEC  --aligned=USEC    align thread wakeups to a specific offset\n"
> -#endif
>  	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>  	       "-B       --preemptirqs     both preempt and irqsoff tracing (used with -b)\n"
>  	       "-c CLOCK --clock=CLOCK     select clock\n"
> @@ -1095,9 +1083,7 @@ static void display_help(int error)
>  	       "-R       --resolution      check clock resolution, calling clock_gettime() many\n"
>  	       "                           times.  list of clock_gettime() values will be\n"
>  	       "                           reported with -X\n"
> -#ifndef NO_PTHREAD_BARRIER
>  	       "         --secaligned [USEC] align thread wakeups to the next full second,\n"
> -#endif
>  	       "                           and apply the optional offset\n"
>  	       "-s       --system          use sys_nanosleep and sys_setitimer\n"
>  	       "-S       --smp             Standard SMP testing: options -a -t -n and\n"
> @@ -1247,10 +1233,7 @@ enum option_values {
>  	OPT_PRIOSPREAD, OPT_RELATIVE, OPT_RESOLUTION, OPT_SYSTEM, OPT_SMP, OPT_THREADS,
>  	OPT_TRACER, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP, OPT_WAKEUPRT,
>  	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
> -#ifndef NO_PTHREAD_BARRIER
> -	OPT_ALIGNED, OPT_SECALIGNED,
> -#endif
> -        OPT_LAPTOP,
> +	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP,
>  };
>  
>  /* Process commandline options */
> @@ -1268,9 +1251,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  		static struct option long_options[] = {
>  			{"affinity",         optional_argument, NULL, OPT_AFFINITY},
>  			{"notrace",          no_argument,       NULL, OPT_NOTRACE },
> -#ifndef NO_PTHREAD_BARRIER
>  			{"aligned",          optional_argument, NULL, OPT_ALIGNED },
> -#endif
>  			{"breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
>  			{"preemptirqs",      no_argument,       NULL, OPT_PREEMPTIRQ },
>  			{"clock",            required_argument, NULL, OPT_CLOCK },
> @@ -1300,9 +1281,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			{"priospread",       no_argument,       NULL, OPT_PRIOSPREAD },
>  			{"relative",         no_argument,       NULL, OPT_RELATIVE },
>  			{"resolution",       no_argument,       NULL, OPT_RESOLUTION },
> -#ifndef NO_PTHREAD_BARRIER
>  			{"secaligned",       optional_argument, NULL, OPT_SECALIGNED },
> -#endif
>  			{"system",           no_argument,       NULL, OPT_SYSTEM },
>  			{"smp",              no_argument,       NULL, OPT_SMP },
>  			{"threads",          optional_argument, NULL, OPT_THREADS },
> @@ -1337,7 +1316,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  				setaffinity = AFFINITY_USEALL;
>  			}
>  			break;
> -#ifndef NO_PTHREAD_BARRIER
>  		case 'A':
>  		case OPT_ALIGNED:
>  			aligned=1;
> @@ -1348,7 +1326,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			else
>  				offset = 0;
>  			break;
> -#endif
>  		case 'b':
>  		case OPT_BREAKTRACE:
>  			tracelimit = atoi(optarg); break;
> @@ -1449,7 +1426,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  		case OPT_RESOLUTION:
>  			check_clock_resolution = 1; break;
>  		case 's':
> -#ifndef NO_PTHREAD_BARRIER
>  		case OPT_SECALIGNED:
>  			secaligned = 1;
>  			if (optarg != NULL)
> @@ -1459,7 +1435,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			else
>  				offset = 0;
>  			break;
> -#endif
>  		case OPT_SYSTEM:
>  			use_system = MODE_SYS_OFFSET; break;
>  		case 'S':
> @@ -1596,7 +1571,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  	if (num_threads < 1)
>  		error = 1;
>  
> -#ifndef NO_PTHREAD_BARRIER
>  	if (aligned && secaligned)
>  		error = 1;
>  
> @@ -1604,7 +1578,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  		pthread_barrier_init(&globalt_barr, NULL, num_threads);
>  		pthread_barrier_init(&align_barr, NULL, num_threads);
>  	}
> -#endif
>  	if (error) {
>  		if (affinity_mask)
>  			rt_bitmask_free(affinity_mask);
> diff --git a/src/include/bionic.h b/src/include/bionic.h
> new file mode 100644
> index 000000000000..54f9c54b0824
> --- /dev/null
> +++ b/src/include/bionic.h
> @@ -0,0 +1,42 @@
> +#ifndef BIONIC_H
> +#define BIONIC_H
> +
> +#ifdef PTHREAD_BIONIC
> +#warning Program is being compiled with PTHREAD_BIONIC, some options may behave erratically.
> +
> +/*
> + * We do not have pthread_barrier_t available, but since we are not
> + * going to use them for anything useful, just typedef them to int
> + */
> +typedef int pthread_barrier_t;
> +typedef int pthread_barrierattr_t;
> +
> +#ifndef PTHREAD_BARRIER_SERIAL_THREAD
> +#define PTHREAD_BARRIER_SERIAL_THREAD 0
> +#endif
> +
> +static inline int pthread_barrier_wait(pthread_barrier_t *barrier)
> +{
> +        return PTHREAD_BARRIER_SERIAL_THREAD;
> +}
> +
> +static inline int pthread_barrier_destroy(pthread_barrier_t *barrier)
> +{
> +        return 0;
> +}
> +static inline int pthread_barrier_init(pthread_barrier_t * barrier,
> +                                       const pthread_barrierattr_t * attr,
> +                                       unsigned count)
> +{
> +        return 0;
> +}
> +
> +static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
> +                                         const cpu_set_t *cpuset)
> +{
> +    return sched_setaffinity(0, cpusetsize, cpuset);
> +}
> +
> +#endif	/* PTHREAD_BIONIC */
> +
> +#endif /* BIONIC_H */
> -- 
> 1.9.1
> 
> --


Thank you.

Signed-off-by: John Kacur <jkacur@redhat.com>
