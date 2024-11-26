Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F971DBB3A
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Nov 2024 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732660175; cv=none; b=AT/XBzGNOH2Md5E3ESriOhJrz/8z65OnOBAeM4H4gIX0/2Zt8bsjeG8xMIsUresJAf8WOkt7083cTekRqIM9wGSkNlI/tHcz8AoEqDmoUlqfY18O1qwqaOtRRB0e1pXc05lfKM0KXP1y9GaGPP24mOHbNKvNnoYnuIGvZyXBDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732660175; c=relaxed/simple;
	bh=z0ID2pPeJbFa8jPRqQiApsb64yeHq8NLu/ZwTJuZ/ow=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aE/7SKdl00PfgnVYeipKgdDC4fgxZHvgywscGk9uUgk/k5wbAMv5C+UnBZiYSPbTfdjlqNLt/F0in1axW3tp5F7bHfEioAEp79BBfXIjCZW3EXD07nwqaqgkg3+0pWBk+Agnfb8n74bAAFf3KdpRAt6Kx2WkAnMay8/uF7TPW8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V8ls1cqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V8ls1cqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732660171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZG8RjXY9ANHUL0pqZm57Lv6qdDiTyRhvkmIDHSge/o=;
	b=V8ls1cqi7G+wQ52pIyX2s8ml+NO8Rh4Uf4ZLGP9mHJ/uXmCtERYSnHoRe2NbLcYmSLGhb5
	VAorrUcefcUMVEljN2IxhWieHLSK2Rwd5nWc/kO43W7IhxQAiAapdr/XjhFSlWkGniYshz
	5pED11ENZ54rbdJXjZ5zjBfrBv4IAGk=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-HHOyIQOQOnW0HAfVHelL4Q-1; Tue, 26 Nov 2024 17:29:30 -0500
X-MC-Unique: HHOyIQOQOnW0HAfVHelL4Q-1
X-Mimecast-MFC-AGG-ID: HHOyIQOQOnW0HAfVHelL4Q
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e391a2f0f1fso6551552276.3
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Nov 2024 14:29:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732660170; x=1733264970;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZG8RjXY9ANHUL0pqZm57Lv6qdDiTyRhvkmIDHSge/o=;
        b=MbK4oJAy0RB5L+ex42RmnJEemH8ThzMZ3QsrxU2CLAPDAFFwgBhudPQqCfqjpJYRfS
         QAV3ODBoOZOIe8ZCS5YQF8PIswvH55Y5HtGVze3RY7N2pOtMuq+02x8rS+bhuCI7xiRJ
         EjYUOZY/EDAw2NoWH2R6jryDzbsRWzIwKRhPDN5lXOZfUD7aN894ApH578w29GcDckfF
         FKZTmT20a1eJrfHLWVQThj6zPXBhS0InuKwrPOFF36k/vccEcjp0mSGgKOrB2yH/yk9M
         q+9HG288UPANQCbA5zJCX+lDGTIcuGteYfc8HGSGuCkeCvYi7CNtWjGBuApk3FmdryDz
         oJnw==
X-Gm-Message-State: AOJu0YymY93GF0cjKsQ5b6FPovbqtR5D9SLa4dr3uRcqanuwufgdd/qQ
	KpsOOOskFw1c7gJCjLc1YfodJAnVxOKDNY7qJc+2GICS5hWlFGUmTgXKlLZKncbvjy3GqJ0PsEw
	GI0NSlaCZQvtNRp5GBTu/wHhkhSMIAXmShtnSFy60s1Jfm9rvd+JIqfrVMfKRt+uQ10DCziL4
X-Gm-Gg: ASbGncvVmspgXUrEDBWbDNUUtqH0vpeRlG7ItKX3ozQixlM4D/B/IN2yO/StU7fPDI7
	N1sGYRO+4Yebp42OW0v+d+m0cINumd65OLTgwmMNHqPlze4vPgo5F4/9OyVEjc7V3pfQsP0/FcS
	+4gY6W5TNNz+n1g4TqdidfmRrgP80r6Uq+6vi8gWJxVC3ce7Onr7j9CuY6udXUliow2Ea1vMQ4b
	5+dbwWMltkWOpkKq6P/0UpU56k1OHjJwP6po1rQ
X-Received: by 2002:a05:6902:2789:b0:e38:d1e5:c247 with SMTP id 3f1490d57ef6-e395b890858mr764214276.19.1732660169709;
        Tue, 26 Nov 2024 14:29:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGiXhNr4XSOEe2sTjvQVBhDMBWe7qlkwrjzxXoNkFW5b7wWpiFzP4kthHJ+UnqgHHYHAdIO5g==
X-Received: by 2002:a05:6902:2789:b0:e38:d1e5:c247 with SMTP id 3f1490d57ef6-e395b890858mr764183276.19.1732660169121;
        Tue, 26 Nov 2024 14:29:29 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4669f626dc4sm21019131cf.30.2024.11.26.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 14:29:28 -0800 (PST)
Date: Tue, 26 Nov 2024 17:29:27 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
cc: linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 2/3] rt-tests: cyclictest: Support idle state disabling
 via libcpupower
In-Reply-To: <20241113114509.1058593-3-tglozar@redhat.com>
Message-ID: <c0bf98ab-ac45-eb0f-e239-47e235465ab0@redhat.com>
References: <20241113114509.1058593-1-tglozar@redhat.com> <20241113114509.1058593-3-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 13 Nov 2024, tglozar@redhat.com wrote:

> From: Tomas Glozar <tglozar@redhat.com>
> 
> cyclictest allows reducing latency on wake up from idle by setting
> /dev/cpu_dma_latency during the measurement. This has an effect on
> the idle states of all CPUs, including those which are not included
> in the measurement.
> 
> Add option --deepest-idle-state that allows limiting the idle state
> only on cpus where the measurement is running.
> 
> libcpupower is used to do the disabling of idle states via
> the corresponding sysfs interface.
> 
> Note: The feature was first implemented for rtla-timerlat, this
> implementation is based on the rtla one.
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 205 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 204 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 1ce62cf..b1f8420 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -8,6 +8,9 @@
>   * (C) 2005-2007 Thomas Gleixner <tglx@linutronix.de>
>   *
>   */
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +#include <cpuidle.h>
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <stdint.h>
> @@ -223,6 +226,8 @@ static void rstat_setup(void);
>  static int latency_target_fd = -1;
>  static int32_t latency_target_value = 0;
>  
> +static int deepest_idle_state = -2;
> +
>  static int rstat_ftruncate(int fd, off_t len);
>  static int rstat_fd = -1;
>  /* strlen("/cyclictest") + digits in max pid len + '\0' */
> @@ -254,6 +259,11 @@ static void set_latency_target(void)
>  		return;
>  	}
>  
> +	if (deepest_idle_state >= -1) {
> +		warn("not setting cpu_dma_latency, --deepest-idle-state is set instead\n");

I don't think we want to have a warning when the software is doing what we 
request of it.
Can we either just move the logic out of this function into main and
call either set_latency_target or the deepest latency state logic as 
appropriate, or move all the power management logic into a new function?


> +		return;
> +	}
> +
>  	errno = 0;
>  	err = stat("/dev/cpu_dma_latency", &s);
>  	if (err == -1) {
> @@ -278,6 +288,161 @@ static void set_latency_target(void)
>  	printf("# /dev/cpu_dma_latency set to %dus\n", latency_target_value);
>  }
>  
> +#ifdef HAVE_LIBCPUPOWER_SUPPORT
> +static unsigned int **saved_cpu_idle_disable_state;
> +static size_t saved_cpu_idle_disable_state_alloc_ctr;
> +
> +/*
> + * save_cpu_idle_state_disable - save disable for all idle states of a cpu
> + *
> + * Saves the current disable of all idle states of a cpu, to be subsequently
> + * restored via restore_cpu_idle_disable_state.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +static int save_cpu_idle_disable_state(unsigned int cpu)
> +{
> +	unsigned int nr_states;
> +	unsigned int state;
> +	int disabled;
> +	int nr_cpus;
> +
> +	nr_states = cpuidle_state_count(cpu);
> +
> +	if (nr_states == 0)
> +		return 0;
> +
> +	if (saved_cpu_idle_disable_state == NULL) {
> +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +		saved_cpu_idle_disable_state = calloc(nr_cpus, sizeof(unsigned int *));
> +		if (!saved_cpu_idle_disable_state)
> +			return -1;
> +	}
> +
> +	saved_cpu_idle_disable_state[cpu] = calloc(nr_states, sizeof(unsigned int));
> +	if (!saved_cpu_idle_disable_state[cpu])
> +		return -1;
> +	saved_cpu_idle_disable_state_alloc_ctr++;
> +
> +	for (state = 0; state < nr_states; state++) {
> +		disabled = cpuidle_is_state_disabled(cpu, state);
> +		if (disabled < 0)
> +			return disabled;
> +		saved_cpu_idle_disable_state[cpu][state] = disabled;
> +	}
> +
> +	return nr_states;
> +}
> +
> +/*
> + * restore_cpu_idle_disable_state - restore disable for all idle states of a cpu
> + *
> + * Restores the current disable state of all idle states of a cpu that was
> + * previously saved by save_cpu_idle_disable_state.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +static int restore_cpu_idle_disable_state(unsigned int cpu)
> +{
> +	unsigned int nr_states;
> +	unsigned int state;
> +	int disabled;
> +	int result;
> +
> +	nr_states = cpuidle_state_count(cpu);
> +
> +	if (nr_states == 0)
> +		return 0;
> +
> +	if (!saved_cpu_idle_disable_state)
> +		return -1;
> +
> +	for (state = 0; state < nr_states; state++) {
> +		if (!saved_cpu_idle_disable_state[cpu])
> +			return -1;
> +		disabled = saved_cpu_idle_disable_state[cpu][state];
> +		result = cpuidle_state_disable(cpu, state, disabled);
> +		if (result < 0)
> +			return result;
> +	}
> +
> +	free(saved_cpu_idle_disable_state[cpu]);
> +	saved_cpu_idle_disable_state[cpu] = NULL;
> +	saved_cpu_idle_disable_state_alloc_ctr--;
> +	if (saved_cpu_idle_disable_state_alloc_ctr == 0) {
> +		free(saved_cpu_idle_disable_state);
> +		saved_cpu_idle_disable_state = NULL;
> +	}
> +
> +	return nr_states;
> +}
> +
> +/*
> + * free_cpu_idle_disable_states - free saved idle state disable for all cpus
> + *
> + * Frees the memory used for storing cpu idle state disable for all cpus
> + * and states.
> + *
> + * Normally, the memory is freed automatically in
> + * restore_cpu_idle_disable_state; this is mostly for cleaning up after an
> + * error.
> + */
> +static void free_cpu_idle_disable_states(void)
> +{
> +	int cpu;
> +	int nr_cpus;
> +
> +	if (!saved_cpu_idle_disable_state)
> +		return;
> +
> +	nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
> +
> +	for (cpu = 0; cpu < nr_cpus; cpu++) {
> +		free(saved_cpu_idle_disable_state[cpu]);
> +		saved_cpu_idle_disable_state[cpu] = NULL;
> +	}
> +
> +	free(saved_cpu_idle_disable_state);
> +	saved_cpu_idle_disable_state = NULL;
> +}
> +
> +/*
> + * set_deepest_cpu_idle_state - limit idle state of cpu
> + *
> + * Disables all idle states deeper than the one given in
> + * deepest_state (assuming states with higher number are deeper).
> + *
> + * This is used to reduce the exit from idle latency. Unlike
> + * set_cpu_dma_latency, it can disable idle states per cpu.
> + *
> + * Return: idle state count on success, negative on error
> + */
> +static int set_deepest_cpu_idle_state(unsigned int cpu, unsigned int deepest_state)
> +{
> +	unsigned int nr_states;
> +	unsigned int state;
> +	int result;
> +
> +	nr_states = cpuidle_state_count(cpu);
> +
> +	for (state = deepest_state + 1; state < nr_states; state++) {
> +		result = cpuidle_state_disable(cpu, state, 1);
> +		if (result < 0)
> +			return result;
> +	}
> +
> +	return nr_states;
> +}
> +
> +static inline int have_libcpupower_support(void) { return 1; }
> +#else
> +static inline int save_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
> +static inline int restore_cpu_idle_disable_state(__attribute__((unused)) unsigned int cpu) { return -1; }
> +static inline void free_cpu_idle_disable_states(void) { }
> +static inline int set_deepest_cpu_idle_state(__attribute__((unused)) unsigned int cpu,
> +											 __attribute__((unused)) unsigned int state) { return -1; }
> +static inline int have_libcpupower_support(void) { return 0; }
> +#endif /* HAVE_LIBCPUPOWER_SUPPORT */
>  
>  enum {
>  	ERROR_GENERAL	= -1,
> @@ -779,6 +944,10 @@ static void display_help(int error)
>  	       "-c CLOCK --clock=CLOCK     select clock\n"
>  	       "                           0 = CLOCK_MONOTONIC (default)\n"
>  	       "                           1 = CLOCK_REALTIME\n"
> +	       "         --deepest-idle-state=n\n"
> +	       "                           Reduce exit from idle latency by limiting idle state\n"
> +	       "                           up to n on used cpus (-1 disables all idle states).\n"
> +	       "                           Power management is not suppresed on other cpus.\n"
>  	       "         --default-system  Don't attempt to tune the system from cyclictest.\n"
>  	       "                           Power management is not suppressed.\n"
>  	       "                           This might give poorer results, but will allow you\n"
> @@ -919,7 +1088,7 @@ enum option_values {
>  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE,
>  	OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
>  	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI,
> -	OPT_TRACEMARK, OPT_POSIX_TIMERS,
> +	OPT_TRACEMARK, OPT_POSIX_TIMERS, OPT_DEEPEST_IDLE_STATE,
>  };
>  
>  /* Process commandline options */
> @@ -975,6 +1144,7 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			{"policy",           required_argument, NULL, OPT_POLICY },
>  			{"help",             no_argument,       NULL, OPT_HELP },
>  			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
> +			{"deepest-idle-state", required_argument,	NULL, OPT_DEEPEST_IDLE_STATE },
>  			{NULL, 0, NULL, 0 },
>  		};
>  		int c = getopt_long(argc, argv, "a::A::b:c:d:D:F:h:H:i:l:MNo:p:mqrRsSt::uvD:x",
> @@ -1175,6 +1345,9 @@ static void process_options(int argc, char *argv[], int max_cpus)
>  			break;
>  		case OPT_TRACEMARK:
>  			trace_marker = 1; break;
> +		case OPT_DEEPEST_IDLE_STATE:
> +			deepest_idle_state = atoi(optarg);
> +			break;
>  		}
>  	}
>  
> @@ -1782,6 +1955,26 @@ int main(int argc, char **argv)
>  	/* use the /dev/cpu_dma_latency trick if it's there */
>  	set_latency_target();
>  
> +	if (deepest_idle_state >= -1) {
> +		if (!have_libcpupower_support()) {
> +			fprintf(stderr, "cyclictest built without libcpupower, --deepest-idle-state is not supported\n");
> +			goto out;
> +		}
> +
> +		for (i = 0; i < max_cpus; i++) {
> +			if (affinity_mask && !numa_bitmask_isbitset(affinity_mask, i))
> +				continue;
> +			if (save_cpu_idle_disable_state(i) < 0) {
> +				fprintf(stderr, "Could not save cpu idle state.\n");
> +				goto out;
> +			}
> +			if (set_deepest_cpu_idle_state(i, deepest_idle_state) < 0) {
> +				fprintf(stderr, "Could not set deepest cpu idle state.\n");
> +				goto out;
> +			}
> +		}
> +	}
> +
>  	if (tracelimit && trace_marker)
>  		enable_trace_mark();
>  
> @@ -2147,6 +2340,16 @@ int main(int argc, char **argv)
>  	if (latency_target_fd >= 0)
>  		close(latency_target_fd);
>  
> +	/* restore and free cpu idle disable states */
> +	if (deepest_idle_state >= -1) {
> +		for (i = 0; i < max_cpus; i++) {
> +			if (affinity_mask && !numa_bitmask_isbitset(affinity_mask, i))
> +				continue;
> +			restore_cpu_idle_disable_state(i);
> +		}
> +	}
> +	free_cpu_idle_disable_states();
> +
>  	if (affinity_mask)
>  		rt_bitmask_free(affinity_mask);
>  
> -- 
> 2.47.0
> 
> 
> 

