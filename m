Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJ/hxY71"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1436AD4F
	for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 07:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702482132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T6rTvqKZcnu/AGV6OJJnDpYQxDDSQZglpsOUS86ThYo=;
	b=OJ/hxY71UYDQ12WQ2Xk7+rFmemJidP2J4DD9T8IADFv/SCEkXJ29IhxYinMcjlLLW9Cl1X
	g77V5Ez03v5Q1Nzy9Kd+1oB/46stRBdZ1XEf0+KmrfP6grbx4j8vp0YE4yxlaOGeoSxZ+j
	Xkm5299KVoYbZtgiDRglFn4y1VqVDQA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-F5foabGuMgyClMr_ZZabLQ-1; Wed, 13 Dec 2023 10:42:09 -0500
X-MC-Unique: F5foabGuMgyClMr_ZZabLQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-67ac11bfa46so89240206d6.1
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Dec 2023 07:42:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702482129; x=1703086929;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6rTvqKZcnu/AGV6OJJnDpYQxDDSQZglpsOUS86ThYo=;
        b=BATTrybRi0CZpD8Lv3XWNueaRoVoboGd0E4+UIJ63cIq0/OJSdaUP50wls5swOCt7B
         Zw6a+7bs8pw77DAZMDjXJnpfRL3YgEjg9jQyQo2NOe+ZhL4peyUZ/4QQ4uT+pnXEAo4M
         SMxEFQXzvya0XGkqjSiVJth2ehpUi8+YokKQ1qbquHxik/XVdh6j7LUISBPrt4ycK8Rb
         UsMDhRHLd9nBdP3VIQ8P/IjwswoP6c+mBAsXym2fmqNOZIMfB5z4IBKbfEEzzP7EVcXF
         RK++G3M0voawn7TxOagPRuM2OYkulFZvgPB+Pbm+TjDzu91yYBWEYxPpAd70ECPprZFD
         okaQ==
X-Gm-Message-State: AOJu0YwMXwmOl/6Kw9XVg6BCWIMJaE+c1IQM7g4MPrvRMpZBoZhZOzx6
	Yx0Bw3Z18LKhhqqlXQZlhX0NPpmuwNwdZBdnU8uoIQX4HMfOkLkx4+CBKotlqcAcBQYS6Hd5erW
	ddN9kJbs4mE6nM//Mcx3migLpcbwox2Ax2AE=
X-Received: by 2002:ad4:4b66:0:b0:67a:b136:197d with SMTP id m6-20020ad44b66000000b0067ab136197dmr8848977qvx.91.1702482128938;
        Wed, 13 Dec 2023 07:42:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJBAMXIt+W1cY+aa29BZm7Ip0nnnYKedB23tZEf0azk4/YM+w2QMsbciJUn0E/9CL2rVGnxw==
X-Received: by 2002:ad4:4b66:0:b0:67a:b136:197d with SMTP id m6-20020ad44b66000000b0067ab136197dmr8848969qvx.91.1702482128679;
        Wed, 13 Dec 2023 07:42:08 -0800 (PST)
Received: from fionn ([174.88.88.134])
        by smtp.gmail.com with ESMTPSA id d17-20020a0cea91000000b0067eabe0116dsm4885424qvp.72.2023.12.13.07.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 07:42:08 -0800 (PST)
Date: Wed, 13 Dec 2023 10:41:59 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: Crystal Wood <crwood@redhat.com>
cc: linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/4] rt-tests: Fix warnings
In-Reply-To: <20231206205508.17148-2-crwood@redhat.com>
Message-ID: <0ac949ff-3c02-84b2-e367-c338d0e87174@redhat.com>
References: <20231206205508.17148-1-crwood@redhat.com> <20231206205508.17148-2-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 6 Dec 2023, Crystal Wood wrote:

> Numerous places threw sign comparison warnings; we could fix them but
> it's kind of an obnoxious warning that requires casts to deal with things
> such as ARRAY_SIZE() while still being able to check for the user
> entering a negative number.
> 
> -Wunused-parameter is another obnoxious warning as it flags perfectly
> reasonable code that takes unneeded parameters in order to comply with
> a function pointer interface or similar; however, all of the instances
> that were flagged here were actual dead parameters, so just fix them.
> 
> Add volatile to timer_started in hackbench so that it doesn't get
> clobbered by longjmp().
> 
> Signed-off-by: Crystal Wood <crwood@redhat.com>
> --
> Let me know if you'd rather I fix the sign warnings.
> ---
>  Makefile                            |  2 +-
>  src/hackbench/hackbench.c           |  2 +-
>  src/sched_deadline/cyclicdeadline.c |  6 +++---
>  src/sched_deadline/deadline_test.c  | 10 +++++-----
>  src/sigwaittest/sigwaittest.c       |  6 +++---
>  5 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2808c212058a..ad481a73cf93 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -31,7 +31,7 @@ prefix  ?= /usr/local
>  bindir  ?= $(prefix)/bin
>  mandir	?= $(prefix)/share/man
>  
> -CFLAGS ?= -Wall -Wno-nonnull -Wextra
> +CFLAGS ?= -Wall -Wno-nonnull -Wextra -Wno-sign-compare
>  CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>  LDFLAGS ?=
>  
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index 69dd5f087fb6..4430db0e4ed6 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -494,7 +494,7 @@ int main(int argc, char *argv[])
>  	struct timeval start, stop, diff;
>  	int readyfds[2], wakefds[2];
>  	char dummy;
> -	int timer_started = 0;
> +	volatile int timer_started = 0;
>  	struct sched_param sp;
>  
>  	process_options (argc, argv);
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 9bdc4b5deaf1..097e2e5d4580 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -750,7 +750,7 @@ static void print_stat(FILE *fp, struct sched_data *sd, int index, int verbose,
>  	}
>  }
>  
> -static u64 do_runtime(long tid, struct sched_data *sd, u64 period)
> +static u64 do_runtime(struct sched_data *sd, u64 period)
>  {
>  	struct thread_stat *stat = &sd->stat;
>  	u64 next_period = period + sd->deadline_us;
> @@ -833,7 +833,7 @@ void *run_deadline(void *data)
>  	period = get_time_us();
>  
>  	while (!shutdown) {
> -		period = do_runtime(tid, sd, period);
> +		period = do_runtime(sd, period);
>  		if (tracelimit && (stat->max > tracelimit)) {
>  			shutdown++;
>  			pthread_mutex_lock(&break_thread_id_lock);
> @@ -1266,7 +1266,7 @@ int main(int argc, char **argv)
>  
>  		/* Make sure that we can make our deadlines */
>  		start_period = get_time_us();
> -		do_runtime(gettid(), sd, start_period);
> +		do_runtime(sd, start_period);
>  		end_period = get_time_us();
>  		if (end_period - start_period > sd->runtime_us)
>  			fatal("Failed to perform task within runtime: Missed by %lld us\n",
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index cd8ef01f7d68..ca2da476ec95 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -1181,7 +1181,7 @@ static int read_ctx_switches(int *vol, int *nonvol, int *migrate)
>   *  @data->total_time - Total time it took to complete all loops
>   *  @data->nr_periods - Number of periods that were executed.
>   */
> -static u64 do_runtime(long tid, struct sched_data *data, u64 period)
> +static u64 do_runtime(struct sched_data *data, u64 period)
>  {
>  	u64 next_period = period + data->deadline_us;
>  	u64 now = get_time_us();
> @@ -1354,7 +1354,7 @@ void *run_deadline(void *data)
>  	period = get_time_us();
>  
>  	while (!done) {
> -		period = do_runtime(tid, sched_data, period);
> +		period = do_runtime(sched_data, period);
>  		sched_yield();
>  	}
>  	ret = sched_getattr(0, &attr, sizeof(attr), 0);
> @@ -1714,7 +1714,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
>  	do_sleep(1000);
>  
>  	start = get_time_us();
> -	do_runtime(0, &sd, start + sd.deadline_us);
> +	do_runtime(&sd, start + sd.deadline_us);
>  	end = get_time_us();
>  
>  	diff = end - start;
> @@ -1743,7 +1743,7 @@ static u64 calculate_loops_per_ms(u64 *overhead)
>  	do_sleep(1000);
>  
>  	start = get_time_us();
> -	do_runtime(0, &sd, start + sd.deadline_us);
> +	do_runtime(&sd, start + sd.deadline_us);
>  	end = get_time_us();
>  
>  	odiff = end - start;
> @@ -1962,7 +1962,7 @@ int main(int argc, char **argv)
>  
>  		/* Make sure that we can make our deadlines */
>  		start_period = get_time_us();
> -		do_runtime(gettid(), sd, start_period);
> +		do_runtime(sd, start_period);
>  		end_period = get_time_us();
>  		if (end_period - start_period > sd->runtime_us) {
>  			printf("Failed to perform task within runtime: Missed by %lld us\n",
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 55855769c63b..8c1c16fb3081 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -375,7 +375,7 @@ static void sighand(int sig __attribute__ ((unused)))
>  	mustshutdown = 1;
>  }
>  
> -static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
> +static void print_stat(struct params *receiver, struct params *sender,
>  		       int verbose __attribute__ ((unused)), int quiet)
>  {
>  	int i;
> @@ -644,7 +644,7 @@ int main(int argc, char *argv[])
>  			    sender[i].shutdown;
>  
>  		if (receiver[0].samples > oldsamples || mustshutdown) {
> -			print_stat(stdout, receiver, sender, 0, quiet);
> +			print_stat(receiver, sender, 0, quiet);
>  			if (!quiet)
>  				printf("\033[%dA", num_threads*2);
>  		}
> @@ -664,7 +664,7 @@ int main(int argc, char *argv[])
>  	if (!quiet)
>  		printf("\033[%dB", num_threads*2 + 2);
>  	else
> -		print_stat(stdout, receiver, sender, 0, 0);
> +		print_stat(receiver, sender, 0, 0);
>  
>  	for (i = 0; i < num_threads; i++) {
>  		receiver[i].shutdown = 1;
> -- 
> 2.43.0
> 
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

