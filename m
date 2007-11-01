From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [RFC] [PATCH] powerpc Re: [announce] IBM RT Test Cases v.0.3
Date: Thu, 01 Nov 2007 18:01:04 +0000
Message-ID: <1193940064.20891.43.camel@Aeon>
References: <200707201540.58269.dvhltc@us.ibm.com>
	 <yyiir4uqxn9.wl@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Tsutomu OWA <tsutomu.owa@toshiba.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47392 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbXKASBz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Nov 2007 14:01:55 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA1I1qN5018151
	for <linux-rt-users@vger.kernel.org>; Thu, 1 Nov 2007 14:01:52 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id lA1I1qYf114064
	for <linux-rt-users@vger.kernel.org>; Thu, 1 Nov 2007 14:01:52 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lA1I1pg8026373
	for <linux-rt-users@vger.kernel.org>; Thu, 1 Nov 2007 14:01:52 -0400
In-Reply-To: <yyiir4uqxn9.wl@toshiba.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Fri, 2007-10-26 at 13:59 +0900, Tsutomu OWA wrote:
> Hello Darren Hart,
> 
> At Fri, 20 Jul 2007 15:40:58 -0700, Darren Hart wrote:
> > Please download the tarball, give the updated documentation a cursory glance 
> > and give them a go on your -rt system.  Please post your experience here as 
> > well as any questions or problems you may run into.
> 
> This patch adds powerpc version of rdtscll() macro which actually reads
> the timebase register and powerpc version of atomic_inc() to compile.
> Compile and run tested on a Celleb (a powerpc64 machine).

Thank you for the patch.  I think we should perhaps move all the rdtscl
stuff into a header file with a more generic name.. rdsystimer or
something.  Would you mind resending your patch with a:

Signed-off-by: Your Name <your_email_address>

So I can properly track the origin and credit you in the changelogs.

> 
> Comments and suggestions are welcome.
> 
> By the way, would you mind if I use and/or refer to your test
> results found at http://www.kernel.org/pub/linux/kernel/people/dvhart/ols2007/ to compare with the results taken on powerpc?  I'm going to present
> the test results at the ELC/E2007 (Embedded Linux Conference Europe;
> http://www.celinux.org/elc_europe07/elc_europe_index.html).

Please feel free to use the results, but do site the ols2007 publication
as the source.

--Darren Hart

> 
> thanks for your understanding!
> -- owa
> Corprate Software Engineering Center, TOSHIBA
> 
> diff -rup rt-test-0.3.org/func/async_handler/async_handler_tsc.c rt-test-0.3/func/async_handler/async_handler_tsc.c
> --- rt-test-0.3.org/func/async_handler/async_handler_tsc.c	2007-07-21 00:32:57.000000000 +0900
> +++ rt-test-0.3/func/async_handler/async_handler_tsc.c	2007-10-17 19:55:34.000000000 +0900
> @@ -65,6 +65,16 @@ pthread_mutex_t mutex;
>  		__asm__ __volatile__ ("rdtsc" : "=a" (low), "=d" (high)); \
>  		val = (uint64_t)high << 32 | low;	\
>  	} while(0)
> +#elif defined(__powerpc__)	/* 32bit version */
> +#define rdtscll(val)							\
> +	 do {								\
> +		uint32_t tbhi, tblo ;					\
> +		__asm__ __volatile__ ("mftbu %0" : "=r" (tbhi));	\
> +		__asm__ __volatile__ ("mftbl %0" : "=r" (tblo));	\
> +		val = 1000 * ((uint64_t) tbhi << 32) | tblo;		\
> +	} while(0)
> +#else
> +#error
>  #endif
> 
>  /* return difference in microseconds */
> diff -rup rt-test-0.3.org/func/measurement/preempt_timing.c rt-test-0.3/func/measurement/preempt_timing.c
> --- rt-test-0.3.org/func/measurement/preempt_timing.c	2007-07-21 00:32:56.000000000 +0900
> +++ rt-test-0.3/func/measurement/preempt_timing.c	2007-10-17 19:56:56.000000000 +0900
> @@ -50,6 +50,16 @@
>  		 __asm__ __volatile__ ("rdtsc" : "=a" (low), "=d" (high)); \
>  		val = (uint64_t)high << 32 | low;	\
>  	} while(0)
> +#elif defined(__powerpc__)	/* 32bit version */
> +#define rdtscll(val)							\
> +	 do {								\
> +		uint32_t tbhi, tblo ;					\
> +		__asm__ __volatile__ ("mftbu %0" : "=r" (tbhi));	\
> +		__asm__ __volatile__ ("mftbl %0" : "=r" (tblo));	\
> +		val = 1000 * ((uint64_t) tbhi <<32) | tblo;		\
> +	} while(0)
> +#else
> +#error
>  #endif
> 
>  #define ITERATIONS 1000000ULL
> diff -rup rt-test-0.3.org/func/measurement/rdtsc-latency.c rt-test-0.3/func/measurement/rdtsc-latency.c
> --- rt-test-0.3.org/func/measurement/rdtsc-latency.c	2007-07-21 00:32:56.000000000 +0900
> +++ rt-test-0.3/func/measurement/rdtsc-latency.c	2007-10-17 19:57:31.000000000 +0900
> @@ -42,6 +42,16 @@
>  		__asm__ __volatile__ ("rdtsc" : "=a" (low), "=d" (high)); \
>  		val = (uint64_t)high << 32 | low;	\
>  	} while(0)
> +#elif defined(__powerpc__)	/* 32 bit version */
> +#define rdtscll(val)							\
> +	 do {								\
> +		uint32_t tbhi, tblo ;					\
> +		__asm__ __volatile__ ("mftbu %0" : "=r" (tbhi));	\
> +		__asm__ __volatile__ ("mftbl %0" : "=r" (tblo));	\
> +		val = 1000 * ((uint64_t) tbhi <<32) | tblo;		\
> +	} while(0)
> +#else
> +#error
>  #endif
> 
>  /* return difference in nanoseconds */
> diff -rup rt-test-0.3.org/include/librt.h rt-test-0.3/include/librt.h
> --- rt-test-0.3.org/include/librt.h	2007-07-21 00:32:56.000000000 +0900
> +++ rt-test-0.3/include/librt.h	2007-10-16 18:19:08.000000000 +0900
> @@ -92,6 +92,7 @@ extern int _dbg_lvl;
>   */
>  static inline int atomic_add(int i, atomic_t *v)
>  {
> +#if defined(__x86_64__) || defined(__i386__)
>  	int __i;
>  	__i = i;
>  	asm volatile(
> @@ -99,6 +100,26 @@ static inline int atomic_add(int i, atom
>  			:"=r"(i)
>  			:"m"(v->counter), "0"(i));
>  	return i + __i;
> +
> +#elif defined(__powerpc__)
> +#define ISYNC_ON_SMP	"\n\tisync\n"
> +#define LWSYNC_ON_SMP	__stringify(LWSYNC) "\n"
> +	int t;
> +	asm volatile(
> +"	lwsync \n\
> +1:	lwarx   %0,0,%2		# atomic_add_return	\n\
> +	add     %0,%1,%0\n\
> +	stwcx.  %0,0,%2 \n\
> +	bne-    1b"
> +	ISYNC_ON_SMP
> + 	: "=&r" (t)
> +	: "r" (i), "r" (&v->counter)
> +	: "cc", "memory");
> +
> +	return t;
> +#else
> +#error
> +#endif
>  }
>  /* atomic_inc: atomically increment the integer passed by reference
>   */
