Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F409C6379D
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 21:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D961822403
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 21:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBE0DnTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgKTVip (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgKTVio (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Nov 2020 16:38:44 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3790CC0613CF
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2020 13:38:44 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id r7so10389575qkf.3
        for <linux-rt-users@vger.kernel.org>; Fri, 20 Nov 2020 13:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=B/Ke0nbB9RsO2EbsEskcfTBzEvm+EPefzIfEPIHDRQ0=;
        b=vBE0DnTKxv/Hed1j0IcL1Y2YAxmYoi+b7VDFp6TUOBufpfPObr6R4oVsTcUJoj+iY5
         NrrsYURrN9UjmUgTC8NVjZK2uuSEpNMjuEghRjLQd7TrC19gOaIC5DW2tI0jYZA2mKO2
         70zRDeTrsUFUvinmU5E36pbRPBJqN5cBlggWtnxt8HP54q1IRWPzz76KAWH1iJptaTuc
         3ccUcLAfemEYEA8DJknfnZpw450xxhkjCUd+b7lI8hvrbGIV5Q6akWEj1C0xY7zfB7n4
         5ggHoFR1hjqPS0QHQSlccXAtURTX1d+4WjUcO9PiLISmlMooT0IU4FhwmxWpPv7/Famy
         pwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=B/Ke0nbB9RsO2EbsEskcfTBzEvm+EPefzIfEPIHDRQ0=;
        b=IrwzLLKkMVrHxE8aYoGeudjVFdz9ZwT/LJbVcG7+V/UQZz2FLeRqJfTzfQz/Xj8E0z
         y5YlUMjKvyufdlYqaywI0Mla5c4azMeBZ6vAAkgV3cjmxkFxRzL4VryvDne07Gw1emXT
         MPzMtgG7UitaNHqFoCH7N5uSSEnbFCY16KcmiSFzncpudum6qPyJxbPqpvCz0/Rkh91O
         /3lN9nfC+/dZu1Z1ohRrZ3TcHqPO6qyG8v/a3hXaKRS7myzvGj/syIwBrF9E+Up/XIi5
         HiO4mv0gV0GcvgyJY5JIoDjj9SZmIPY/4V9awovH+bp1uZ82hKGH0eWfMK9L9gWVYP0O
         Tyew==
X-Gm-Message-State: AOAM533dklp/mQCA2WlEVEa/IPlUmH0AsZgzswdUo7e8Mz7eI5GpGI7L
        hTQSwJORUz+EsFyjRdNPyT4=
X-Google-Smtp-Source: ABdhPJx614x/TckBDKbCPDQlfIZQwCjI/DObJMtAyrJXQOKwEERWs4ynXQgRUECWwmv4iGUeXyFvfg==
X-Received: by 2002:a37:a2d1:: with SMTP id l200mr18185273qke.237.1605908323267;
        Fri, 20 Nov 2020 13:38:43 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id p134sm2973597qke.66.2020.11.20.13.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:38:42 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 20 Nov 2020 16:38:34 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rt-tests v1 1/3] rt-numa: Move thread placement code to rt-numa
 library
In-Reply-To: <20201115184059.7286-2-dwagner@suse.de>
Message-ID: <1d542ce5-955d-1cc9-cc83-543711fa62b@redhat.com>
References: <20201115184059.7286-1-dwagner@suse.de> <20201115184059.7286-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sun, 15 Nov 2020, Daniel Wagner wrote:

> cyclictest contains code for calculating where to place threads
> accoring the cpumask. Let's move it the rt-numa library to be able to
> reuse it.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 98 +++----------------------------------
>  src/include/rt-numa.h       | 12 +++++
>  src/lib/rt-numa.c           | 78 +++++++++++++++++++++++++++++
>  3 files changed, 98 insertions(+), 90 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index f10f064f7a8e..0a797c540531 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -893,12 +893,6 @@ static int interval = DEFAULT_INTERVAL;
>  static int distance = -1;
>  static struct bitmask *affinity_mask = NULL;
>  static int smp = 0;
> -
> -enum {
> -	AFFINITY_UNSPECIFIED,
> -	AFFINITY_SPECIFIED,
> -	AFFINITY_USEALL
> -};
>  static int setaffinity = AFFINITY_UNSPECIFIED;
>  
>  static int clocksources[] = {
> @@ -906,72 +900,6 @@ static int clocksources[] = {
>  	CLOCK_REALTIME,
>  };
>  
> -/* Get available cpus according to getaffinity or according to the
> - * intersection of getaffinity and the user specified affinity
> - * in the case of AFFINITY_SPECIFIED, the function has to be called
> - * after the call to parse_cpumask made in process_options()
> - */
> -static int get_available_cpus(void)
> -{
> -	if (affinity_mask)
> -		return numa_bitmask_weight(affinity_mask);
> -
> -	return numa_num_task_cpus();
> -}
> -
> -/* cpu_for_thread AFFINITY_SPECIFIED */
> -static int cpu_for_thread_sp(int thread_num, int max_cpus)
> -{
> -	unsigned int m, cpu, i, num_cpus;
> -
> -	num_cpus = rt_numa_bitmask_count(affinity_mask);
> -
> -	if (num_cpus == 0)
> -		fatal("No allowable cpus to run on\n");
> -
> -	m = thread_num % num_cpus;
> -
> -	/* there are num_cpus bits set, we want position of m'th one */
> -	for (i = 0, cpu = 0; i < max_cpus; i++) {
> -		if (rt_numa_bitmask_isbitset(affinity_mask, i)) {
> -			if (cpu == m)
> -				return i;
> -			cpu++;
> -		}
> -	}
> -	fprintf(stderr, "Bug in cpu mask handling code.\n");
> -	return 0;
> -}
> -
> -/* cpu_for_thread AFFINITY_USEALL */
> -static int cpu_for_thread_ua(int thread_num, int max_cpus)
> -{
> -	int res, num_cpus, i, m, cpu;
> -	pthread_t thread;
> -	cpu_set_t cpuset;
> -
> -	thread = pthread_self();
> -	CPU_ZERO(&cpuset);
> -
> -	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
> -	if (res != 0)
> -		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
> -
> -	num_cpus = CPU_COUNT(&cpuset);
> -	m = thread_num % num_cpus;
> -
> -	for (i = 0, cpu = 0; i < max_cpus; i++) {
> -		if (CPU_ISSET(i, &cpuset)) {
> -			if (cpu == m)
> -				return i;
> -			cpu++;
> -		}
> -	}
> -
> -	fprintf(stderr, "Bug in cpu mask handling code.\n");
> -	return 0;
> -}
> -
>  static void handlepolicy(char *polname)
>  {
>  	if (strncasecmp(polname, "other", 5) == 0)
> @@ -1027,20 +955,6 @@ enum option_values {
>  	OPT_TRACEMARK, OPT_POSIX_TIMERS,
>  };
>  
> -/* numa_available() must be called before any other calls to the numa library */
> -static void numa_initialize(void)
> -{
> -	static int is_initialized;
> -
> -	if (is_initialized == 1)
> -		return;
> -
> -	if (numa_available() != -1)
> -		numa = 1;
> -
> -	is_initialized = 1;
> -}
> -
>  /* Process commandline options */
>  static void process_options(int argc, char *argv[], int max_cpus)
>  {
> @@ -1104,7 +1018,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			/* smp sets AFFINITY_USEALL in OPT_SMP */
>  			if (smp)
>  				break;
> -			numa_initialize();
> +			if (numa_initialize())
> +				fatal("Couldn't initilize libnuma");

Watch your spelling

> +			numa = 1;
>  			if (optarg) {
>  				parse_cpumask(optarg, max_cpus, &affinity_mask);
>  				setaffinity = AFFINITY_SPECIFIED;
> @@ -1285,7 +1201,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  
>  	/* if smp wasn't requested, test for numa automatically */
>  	if (!smp) {
> -		numa_initialize();
> +		if (numa_initialize())
> +			fatal("Couldn't initilize libnuma");

The correct spelling is right above this!
Plus checkpatch would have caught this for you.

> +		numa = 1;
>  		if (setaffinity == AFFINITY_UNSPECIFIED)
>  			setaffinity = AFFINITY_USEALL;
>  	}
> @@ -1330,7 +1248,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  		error = 1;
>  
>  	if (num_threads == -1)
> -		num_threads = get_available_cpus();
> +		num_threads = get_available_cpus(affinity_mask);
>  
>  	if (priospread && priority == 0) {
>  		fprintf(stderr, "defaulting realtime priority to %d\n",
> @@ -1998,7 +1916,7 @@ int main(int argc, char **argv)
>  		switch (setaffinity) {
>  		case AFFINITY_UNSPECIFIED: cpu = -1; break;
>  		case AFFINITY_SPECIFIED:
> -			cpu = cpu_for_thread_sp(i, max_cpus);
> +			cpu = cpu_for_thread_sp(i, max_cpus, affinity_mask);
>  			if (verbose)
>  				printf("Thread %d using cpu %d.\n", i, cpu);
>  			break;
> diff --git a/src/include/rt-numa.h b/src/include/rt-numa.h
> index 047c8b6257cc..ca86a45dab3a 100644
> --- a/src/include/rt-numa.h
> +++ b/src/include/rt-numa.h
> @@ -4,6 +4,18 @@
>  
>  #include <numa.h>
>  
> +enum {
> +	AFFINITY_UNSPECIFIED,
> +	AFFINITY_SPECIFIED,
> +	AFFINITY_USEALL
> +};
> +
> +int numa_initialize(void);
> +
> +int get_available_cpus(struct bitmask *cpumask);
> +int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask);
> +int cpu_for_thread_ua(int thread_num, int max_cpus);
> +
>  int parse_cpumask(char *str, int max_cpus, struct bitmask **cpumask);
>  
>  #endif
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index a52a56e8aadd..76f8bd2f0ebe 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -6,9 +6,87 @@
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include <errno.h>
> +#include <sched.h>
> +#include <pthread.h>
>  
> +#include "error.h"
>  #include "rt-numa.h"
>  
> +/* numa_available() must be called before any other calls to the numa library */
> +int numa_initialize(void)
> +{
> +	static int is_initialized;
> +
> +	if (is_initialized == 1)
> +		return 0;
> +
> +	if (numa_available() == -1)
> +		return -1;
> +
> +	is_initialized = 1;
> +	return 0;
> +}
> +
> +int get_available_cpus(struct bitmask *cpumask)
> +{
> +	if (cpumask)
> +		return numa_bitmask_weight(cpumask);
> +
> +	return numa_num_task_cpus();
> +}
> +
> +int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpumask)
> +{
> +	unsigned int m, cpu, i, num_cpus;
> +
> +	num_cpus = numa_bitmask_weight(cpumask);
> +
> +	if (num_cpus == 0)
> +		fatal("No allowable cpus to run on\n");
> +
> +	m = thread_num % num_cpus;
> +
> +	/* there are num_cpus bits set, we want position of m'th one */
> +	for (i = 0, cpu = 0; i < max_cpus; i++) {
> +		if (numa_bitmask_isbitset(cpumask, i)) {
> +			if (cpu == m)
> +				return i;
> +			cpu++;
> +		}
> +	}
> +	fprintf(stderr, "Bug in cpu mask handling code.\n");
> +	return 0;
> +}
> +
> +/* cpu_for_thread AFFINITY_USEALL */
> +int cpu_for_thread_ua(int thread_num, int max_cpus)
> +{
> +	int res, num_cpus, i, m, cpu;
> +	pthread_t thread;
> +	cpu_set_t cpuset;
> +
> +	thread = pthread_self();
> +	CPU_ZERO(&cpuset);
> +
> +	res = pthread_getaffinity_np(thread, sizeof(cpu_set_t), &cpuset);
> +	if (res != 0)
> +		fatal("pthread_getaffinity_np failed: %s\n", strerror(res));
> +
> +	num_cpus = CPU_COUNT(&cpuset);
> +	m = thread_num % num_cpus;
> +
> +	for (i = 0, cpu = 0; i < max_cpus; i++) {
> +		if (CPU_ISSET(i, &cpuset)) {
> +			if (cpu == m)
> +				return i;
> +			cpu++;
> +		}
> +	}
> +
> +	fprintf(stderr, "Bug in cpu mask handling code.\n");
> +	return 0;
> +}
> +
>  /*
>   * After this function is called, affinity_mask is the intersection of
>   * the user supplied affinity mask and the affinity mask from the run
> -- 
> 2.29.2
> 
> 
    - small spelling / grammar fix in description
    - fixed spelling of initialize in code
    Signed-off-by: John Kacur <jkacur@redhat.com>

