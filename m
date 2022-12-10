Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFA9C04FDE
	for <linux-rt-users@archiver.kernel.org>; Sat, 10 Dec 2022 01:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLJBEu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 9 Dec 2022 20:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLJBEt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 9 Dec 2022 20:04:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8462E4C251
        for <linux-rt-users@vger.kernel.org>; Fri,  9 Dec 2022 17:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670634226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLuQNb1RDhlOlQOYA5PoWW9n1L4rv7I/z3pEWrseWS8=;
        b=EBTxrXPNyXvul3R+xWgA5EnZxo1bYJiYwDM0aInnmr3Obdpt3lUQYuJJbZ5hTyHuvbI7gj
        NH1tnLuNw4pqAd8sOtcOqRKBKB+MD2ccL99CZJ4digw+ECbOEISMqFtGYxcaYTmsIxZoFD
        YHGgdktiAH4fD11tY/1xkMb4CccNuS8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-yjvzeE0GPpWBFFfpeHpl9w-1; Fri, 09 Dec 2022 20:03:45 -0500
X-MC-Unique: yjvzeE0GPpWBFFfpeHpl9w-1
Received: by mail-qt1-f197.google.com with SMTP id hg24-20020a05622a611800b003a66175d924so5931960qtb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 09 Dec 2022 17:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tLuQNb1RDhlOlQOYA5PoWW9n1L4rv7I/z3pEWrseWS8=;
        b=eT7k7pL2MZCBSStlsSJUa21Ns0RaCgze3hE3qQVkAfbTs7fW4F0qxC+Kn8J9JTx96y
         U26z0gmRiTq/vMYuZdMPM0rAi2tS+6b7Mbh8PCo1yWKqMzZKrN/wEmW4/rxFBZLu0xWG
         vcxrfMefbOEcidAqDhLwYlj3sueyQFqR/1WrtMELLd4XpP8CtSUyNoOyXxMQY9g+0XKa
         19baEJ0Sk/JsWDGMnWgbyQgDlLZCM2KPEv9pty7yuivnOwa2kYdO68JqUCsWaU4oAZMa
         2EWM0dnCmfjG8qDb9J7ohMKQXYs+QEmMx7y3c65tRHt/cemZQG5RxWvX3JTgDg9rP9IP
         OAoA==
X-Gm-Message-State: ANoB5pmAN68TN1PhC4BV1cGsYIPfjpGoGP52vtPyu1Bc8QghwW8Yr0Fi
        tYfdo/6E2orYnY29duiMwS8ucUprSyt03cjgtQStyb1keNW6TI4qHM/WEyAh+wfHPLly0VYkOMB
        Sf2liZjnLCSzgdP7rEbBuT7zZc+I=
X-Received: by 2002:a05:6214:14ec:b0:4c6:ff2d:29b1 with SMTP id k12-20020a05621414ec00b004c6ff2d29b1mr10816985qvw.1.1670634224616;
        Fri, 09 Dec 2022 17:03:44 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5NT8aEt86xhoDTaYnvTOl8HgJhM86drZ11LOuS4G1I0l4BU6fjBPRbYEZu1oafZYhIJ+DNMw==
X-Received: by 2002:a05:6214:14ec:b0:4c6:ff2d:29b1 with SMTP id k12-20020a05621414ec00b004c6ff2d29b1mr10816954qvw.1.1670634224285;
        Fri, 09 Dec 2022 17:03:44 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id bs40-20020a05620a472800b006cbc6e1478csm1038358qkb.57.2022.12.09.17.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 17:03:43 -0800 (PST)
Date:   Fri, 9 Dec 2022 20:03:27 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Crystal Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] oslat: Add command line option for bucket width
In-Reply-To: <20221209052254.2609767-1-swood@redhat.com>
Message-ID: <1624dd34-d12c-38dc-aed1-a34366ceafba@redhat.com>
References: <20221209052254.2609767-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 8 Dec 2022, Crystal Wood wrote:

> New option -W/--bucket-width allows the user to specify how large of a
> range of latencies is covered by a single bucket, including allowing the
> creation of sub-microsecond buckets.
> 
> When the flag is not used, output should be unchanged.  However, if a
> bucket width is specified that is not a multiple of one microsecond,
> latencies will be output as fractional microseconds, at nanosecond
> precision.  This includes JSON output.
> 
> When using this option, it is up to the user to determine what level
> of precision is meaningful relative to measurement error, as is noted
> in the documentation.
> 
> Signed-off-by: Crystal Wood <swood@redhat.com>
> ---
> I'm hoping that this output format is acceptable, including JSON,
> though I'm not familiar with how the latter is typically consumed.
> 
> Another option would be to simplify by not making the output precision
> conditional (probably keeping the decimal for readability's sake, at
> least in the non-JSON output) but I didn't want to risk compatibility
> or user surprise issues.
> ---
>  src/oslat/oslat.8 |   9 +++-
>  src/oslat/oslat.c | 105 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 80 insertions(+), 34 deletions(-)
> 
> diff --git a/src/oslat/oslat.8 b/src/oslat/oslat.8
> index 39b36df0db3f..eb96448bfff1 100644
> --- a/src/oslat/oslat.8
> +++ b/src/oslat/oslat.8
> @@ -7,7 +7,7 @@ oslat \- OS Latency Detector
>  .RI "[ \-shvz ] [ \-b " bucket-size " ] [ \-B " bias " ] [ \-c " cpu-list " ] \
>  [ \-C " cpu-main-thread " ] [ \-f " rt-prio " ] [ \-\-json " filename " ] \
>  [ \-m " workload-mem " ] [\-t " runtime " ] [ \-T " trace-threshold " ] \
> -[ \-w " workload " ]"
> +[ \-w " workload " ] [ \-W " bucket-width " ]"
>  .SH DESCRIPTION
>  .B oslat
>  is an open source userspace polling mode stress program to detect OS level
> @@ -57,6 +57,13 @@ NOTE: please make sure the CPU frequency on all testing cores
>  are locked before using this parmater.  If you don't know how
>  to lock the freq then please don't use this parameter.
>  .TP
> +.B \-W, \-\-bucket-width
> +Interval between buckets in nanoseconds
> +
> +NOTE: Widths not a multiple of 1000 cause ns-precision output
> +You are responsible for considering the impact of measurement
> +overhead at the nanosecond scale.
> +.TP
>  .B \-h, \-\-help
>  Show the help message.
>  .TP
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 55302f11986b..e8a642699cc7 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -192,6 +192,9 @@ struct global {
>  	struct timeval        tv_start;
>  	int                   rtprio;
>  	int                   bucket_size;
> +	int                   bucket_width;
> +	int                   unit_per_us;
> +	int                   precision;
>  	int                   trace_threshold;
>  	int                   runtime;
>  	/* The core that we run the main thread.  Default is cpu0 */
> @@ -325,45 +328,46 @@ static float cycles_to_sec(const struct thread *t, uint64_t cycles)
>  
>  static void insert_bucket(struct thread *t, stamp_t value)
>  {
> -	int index, us;
> +	int index;
> +	unsigned int lat;
>  	uint64_t extra;
> +	double us;
>  
> -	index = value / t->counter_mhz;
> -	assert(index >= 0);
> -	us = index + 1;
> -	assert(us > 0);
> -
> +	lat = (value * g.unit_per_us + t->counter_mhz - 1) / t->counter_mhz;
> +	us = (double)lat / g.unit_per_us;
>  	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
> -		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %u us!\n"
> +		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n"
>  		    "Stopping the test.\n";
> -		tracemark(line, g.app_name, g.trace_threshold, t->core_i, us);
> -		err_quit(line, g.app_name, g.trace_threshold, t->core_i, us);
> +		tracemark(line, g.app_name, g.trace_threshold, t->core_i,
> +		          g.precision, us);
> +		err_quit(line, g.app_name, g.trace_threshold, t->core_i,
> +		         g.precision, us);
>  	}
>  
>  	/* Update max latency */
> -	if (us > t->maxlat)
> -		t->maxlat = us;
> +	if (lat > t->maxlat)
> +		t->maxlat = lat;
>  
> -	if (us < t->minlat)
> -		t->minlat = us;
> +	if (lat < t->minlat)
> +		t->minlat = lat;
>  
>  	if (g.bias) {
>  		/* t->bias will be set after pre-heat if user enabled it */
> -		us -= g.bias;
> +		lat -= g.bias;
>  		/*
>  		 * Negative should hardly happen, but if it happens, we assume we're in
> -		 * the smallest bucket, which is 1us.  Same to index.
> +		 * the smallest bucket.
>  		 */
> -		if (us <= 0)
> -			us = 1;
> -		index -= g.bias;
> -		if (index < 0)
> -			index = 0;
> +		if (lat <= 0)
> +			lat = 1;
>  	}
>  
> +	index = lat / g.bucket_width;
> +	assert(index >= 0);
> +
>  	/* Too big the jitter; put into the last bucket */
>  	if (index >= g.bucket_size) {
> -		/* Keep the extra bit (in us) */
> +		/* Keep the extra bit (in bucket width multiples) */
>  		extra = index - g.bucket_size;
>  		if (t->overflow_sum + extra < t->overflow_sum) {
>  			/* The uint64_t even overflowed itself; bail out */
> @@ -455,6 +459,19 @@ static void *thread_main(void *arg)
>  		printf("%s\n", end);                    \
>  	} while (0)
>  
> +#define putfieldp(label, val, end) do {                        \
> +		printf("%12s:\t", label);                      \
> +		for (i = 0; i < g.n_threads; ++i)              \
> +			printf(" %.*f", g.precision,           \
> +			       (double)(val) / g.unit_per_us); \
> +		printf("%s\n", end);                           \
> +	} while (0)
> +
> +static double bucket_to_lat(int bucket)
> +{
> +	return (g.bias + (bucket + 1) * (double)g.bucket_width) / g.unit_per_us;
> +}
> +
>  void calculate(struct thread *t)
>  {
>  	int i, j;
> @@ -465,11 +482,11 @@ void calculate(struct thread *t)
>  		/* Calculate average */
>  		sum = count = 0;
>  		for (j = 0; j < g.bucket_size; j++) {
> -			sum += 1.0 * t[i].buckets[j] * (g.bias+j+1);
> +			sum += t[i].buckets[j] * bucket_to_lat(j);
>  			count += t[i].buckets[j];
>  		}
>  		/* Add the extra amount of huge spikes in */
> -		sum += t->overflow_sum;
> +		sum += t->overflow_sum * g.bucket_width;
>  		t[i].average = sum / count;
>  	}
>  }
> @@ -501,16 +518,16 @@ static void write_summary(struct thread *t)
>  			print_dotdotdot = 0;
>  		}
>  
> -		snprintf(bucket_name, sizeof(bucket_name), "%03"PRIu64
> -			 " (us)", g.bias+j+1);
> +		snprintf(bucket_name, sizeof(bucket_name), "%03.*f (us)",
> +			 g.precision, bucket_to_lat(j));
>  		putfield(bucket_name, t[i].buckets[j], PRIu64,
>  			 (j == g.bucket_size - 1) ? " (including overflows)" : "");
>  	}
>  
> -	putfield("Minimum", t[i].minlat, PRIu64, " (us)");
> +	putfieldp("Minimum", t[i].minlat, " (us)");
>  	putfield("Average", t[i].average, ".3lf", " (us)");
> -	putfield("Maximum", t[i].maxlat, PRIu64, " (us)");
> -	putfield("Max-Min", t[i].maxlat - t[i].minlat, PRIu64, " (us)");
> +	putfieldp("Maximum", t[i].maxlat, " (us)");
> +	putfieldp("Max-Min", t[i].maxlat - t[i].minlat, " (us)");
>  	putfield("Duration", cycles_to_sec(&(t[i]), t[i].runtime),
>  		 ".3f", " (sec)");
>  	printf("\n");
> @@ -537,8 +554,8 @@ static void write_summary_json(FILE *f, void *data)
>  			if (t[i].buckets[j] == 0)
>  				continue;
>  			fprintf(f, "%s", comma ? ",\n" : "\n");
> -			fprintf(f, "        \"%" PRIu64 "\": %" PRIu64,
> -				g.bias+j+1, t[i].buckets[j]);
> +			fprintf(f, "        \"%.*f\": %" PRIu64,
> +				g.precision, bucket_to_lat(j), t[i].buckets[j]);
>  			comma = 1;
>  		}
>  		if (comma)
> @@ -610,6 +627,10 @@ static void usage(int error)
>  	       "-v, --version          Display the version of the software.\n"
>  	       "-w, --workload         Specify a kind of workload, default is no workload\n"
>  	       "                       (options: no, memmove)\n"
> +	       "-W, --bucket-width     Interval between buckets in nanoseconds\n"
> +	       "                       NOTE: Widths not a multiple of 1000 cause ns-precision output\n"
> +	       "                       You are responsible for considering the impact of measurement\n"
> +	       "                       overhead at the nanosecond scale.\n"
>  	       "-z, --zero-omit        Don't display buckets in the output histogram if all zeros.\n"
>  	       );
>  	exit(error);
> @@ -630,7 +651,7 @@ static int workload_select(char *name)
>  }
>  
>  enum option_value {
> -	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
> +	OPT_BUCKETSIZE=1, OPT_BUCKETWIDTH, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
>  	OPT_DURATION, OPT_JSON, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
>  	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS,
>  	OPT_QUIET, OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT,
> @@ -644,6 +665,7 @@ static void parse_options(int argc, char *argv[])
>  		int option_index = 0;
>  		static struct option options[] = {
>  			{ "bucket-size", required_argument,	NULL, OPT_BUCKETSIZE },
> +			{ "bucket-width", required_argument,	NULL, OPT_BUCKETWIDTH },
>  			{ "cpu-list",	required_argument,	NULL, OPT_CPU_LIST },
>  			{ "cpu-main-thread", required_argument, NULL, OPT_CPU_MAIN_THREAD},
>  			{ "duration",	required_argument,	NULL, OPT_DURATION },
> @@ -660,7 +682,7 @@ static void parse_options(int argc, char *argv[])
>  			{ "version",	no_argument,		NULL, OPT_VERSION },
>  			{ NULL, 0, NULL, 0 },
>  		};
> -		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:qsw:T:vz",
> +		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:qsw:W:T:vz",
>  				       options, &option_index);
>  		long ncores;
>  
> @@ -677,6 +699,20 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_BUCKETWIDTH:
> +		case 'W':
> +			g.bucket_width = strtol(optarg, NULL, 10);
> +			if (g.bucket_size <= 0) {

I think this should be g.bucket_width

> +				printf("Illegal bucket width: %s\n", optarg);
> +				exit(1);
> +			}
> +			if (g.bucket_width % 1000) {
> +				g.unit_per_us = 1000;
> +				g.precision = 3;
> +			} else {
> +				g.bucket_width /= 1000;
> +			}
> +			break;
>  		case OPT_BIAS:
>  		case 'B':
>  			g.enable_bias = 1;
> @@ -811,7 +847,8 @@ static void record_bias(struct thread *t)
>  			bias = t[i].minlat;
>  	}
>  	g.bias = bias;
> -	printf("Global bias set to %" PRId64 " (us)\n", bias);
> +	printf("Global bias set to %.*f (us)\n", g.precision,
> +	       (double)bias / g.unit_per_us);
>  }
>  
>  int main(int argc, char *argv[])
> @@ -835,6 +872,8 @@ int main(int argc, char *argv[])
>  	g.app_name = argv[0];
>  	g.rtprio = 0;
>  	g.bucket_size = BUCKET_SIZE;
> +	g.bucket_width = 1;
> +	g.unit_per_us = 1;
>  	g.runtime = 1;
>  	g.workload = &workload_list[WORKLOAD_DEFAULT];
>  	g.workload_mem_size = WORKLOAD_MEM_SIZE;
> -- 
> 2.38.1
> 
> 

A quick first look through and run, see the one comment above
near "case 'W'"

and then

checkpatch reports some minor easily fixed problems

../linux/scripts/checkpatch.pl oslat.patch 
ERROR: code indent should use tabs where possible
#100: FILE: src/oslat/oslat.c:342:
+^I^I          g.precision, us);$

ERROR: code indent should use tabs where possible
#102: FILE: src/oslat/oslat.c:344:
+^I^I         g.precision, us);$

ERROR: spaces required around that '=' (ctx:VxV)
#227: FILE: src/oslat/oslat.c:654:
+	OPT_BUCKETSIZE=1, OPT_BUCKETWIDTH, OPT_CPU_LIST, 
OPT_CPU_MAIN_THREAD,
 	              ^

I'll have a closer look on Monday, but thanks for your patch!

John

