Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C82DC4332F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Dec 2022 15:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiLNPeD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Dec 2022 10:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238450AbiLNPeA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Dec 2022 10:34:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9F062CB
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Dec 2022 07:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671031997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=23+K/bO8KVuvS2VBT12PgugdJMzVr+9BJvyQdMytlRM=;
        b=WfriOFY7y239dXQBPS202Zx7KphJXiGdEgkOptc6Nat9tuVPM2duYb5Wlki35rWM5Legwt
        d+qIUbJh79v/l06uNZZ8FzYWISqUVIyqug7Vw/jWM+TMBVBdRFo7v+LghPJIBSppkphzC8
        dSA+DygjORasgF8VCXOvVhoZA4Xmzdw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-458-nVmWPDn9NiqhMVpDkvW3QA-1; Wed, 14 Dec 2022 10:33:15 -0500
X-MC-Unique: nVmWPDn9NiqhMVpDkvW3QA-1
Received: by mail-qk1-f199.google.com with SMTP id de43-20020a05620a372b00b006fae7e5117fso3332666qkb.6
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Dec 2022 07:33:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23+K/bO8KVuvS2VBT12PgugdJMzVr+9BJvyQdMytlRM=;
        b=m2wg0YfDeXaU9ZdQcXInbh6QynSEBvxizR8jj7WIF1E8/CPmqBdWr5W6l4XY4JcdxT
         FCHgGLw6+08iQscv+jxuG9HRNM6UxYfnh8t0xd/4kvwfKjGEm9Z7VLWBHbL0fKm0qNB4
         530ivYBhJJ6z/9t2txUKE1OpJ96tB2hDANAx0CHwyPJx+NHqrl7lCODISSlSc5GHGIx3
         9yirVNZ1ztzOCDTkmEcO6TbdRinRXC8AjVnS+2BVFFXt3wiW8Gam+pdrdQzPUC39W+ai
         YddwYTu3Q38y43YrZslvhTp0Mlf4yT/DZVNfG+8jAhdrQMXuc039raNL12hIG1UP68mr
         V+gw==
X-Gm-Message-State: ANoB5pklfmjqN4cdDgnsgsMJDEBPT1nM1n8z+sejdCwSlXaUrt9Z8OQm
        QLrkyv8Lnz8t/ct3IfQAkx2ltvv+08/Nwy9UVuXCQAeunUggyvApTYiw/HnF0psJSvHtb9Ol6zr
        6O0Ab6Sq8NongeWlAf50t85pzyKU=
X-Received: by 2002:a05:622a:6018:b0:3a5:62e1:2855 with SMTP id he24-20020a05622a601800b003a562e12855mr30452159qtb.65.1671031994392;
        Wed, 14 Dec 2022 07:33:14 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7O8Ijt6whDIitll37tSaTzGwmsCX86bM5HnnNXde5f+XyRGVSL1xJdpyb+GSMxqWgTF7+JqQ==
X-Received: by 2002:a05:622a:6018:b0:3a5:62e1:2855 with SMTP id he24-20020a05622a601800b003a562e12855mr30452131qtb.65.1671031994000;
        Wed, 14 Dec 2022 07:33:14 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id n11-20020ac8674b000000b003a7f1e16649sm1838160qtp.42.2022.12.14.07.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:33:13 -0800 (PST)
Date:   Wed, 14 Dec 2022 10:33:01 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Crystal Wood <swood@redhat.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2] oslat: Add command line option for bucket width
In-Reply-To: <20221213223828.2883942-1-swood@redhat.com>
Message-ID: <63df7bf4-0a2-c46a-238e-878ead94e589@redhat.com>
References: <20221213223828.2883942-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 13 Dec 2022, Crystal Wood wrote:

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
> v2:
>  - change default number of buckets to at least 32 us worth
>  - s/bucket_size/bucket_width/ in error check
>  - fix some checkpatch warnings
> ---
>  src/oslat/oslat.8 |   9 +++-
>  src/oslat/oslat.c | 110 ++++++++++++++++++++++++++++++++--------------
>  2 files changed, 85 insertions(+), 34 deletions(-)
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
> index 55302f11986b..b680f1ebce96 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -192,6 +192,10 @@ struct global {
>  	struct timeval        tv_start;
>  	int                   rtprio;
>  	int                   bucket_size;
> +	bool                  bucket_size_param;
> +	int                   bucket_width;
> +	int                   unit_per_us;
> +	int                   precision;
>  	int                   trace_threshold;
>  	int                   runtime;
>  	/* The core that we run the main thread.  Default is cpu0 */
> @@ -325,45 +329,46 @@ static float cycles_to_sec(const struct thread *t, uint64_t cycles)
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
> +			  g.precision, us);
> +		err_quit(line, g.app_name, g.trace_threshold, t->core_i,
> +			 g.precision, us);
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
> @@ -455,6 +460,19 @@ static void *thread_main(void *arg)
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
> @@ -465,11 +483,11 @@ void calculate(struct thread *t)
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
> @@ -501,16 +519,16 @@ static void write_summary(struct thread *t)
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
> @@ -537,8 +555,8 @@ static void write_summary_json(FILE *f, void *data)
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
> @@ -610,6 +628,10 @@ static void usage(int error)
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
> @@ -630,7 +652,7 @@ static int workload_select(char *name)
>  }
>  
>  enum option_value {
> -	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
> +	OPT_BUCKETSIZE = 1, OPT_BUCKETWIDTH, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
>  	OPT_DURATION, OPT_JSON, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
>  	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS,
>  	OPT_QUIET, OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT,
> @@ -644,6 +666,7 @@ static void parse_options(int argc, char *argv[])
>  		int option_index = 0;
>  		static struct option options[] = {
>  			{ "bucket-size", required_argument,	NULL, OPT_BUCKETSIZE },
> +			{ "bucket-width", required_argument,	NULL, OPT_BUCKETWIDTH },
>  			{ "cpu-list",	required_argument,	NULL, OPT_CPU_LIST },
>  			{ "cpu-main-thread", required_argument, NULL, OPT_CPU_MAIN_THREAD},
>  			{ "duration",	required_argument,	NULL, OPT_DURATION },
> @@ -660,7 +683,7 @@ static void parse_options(int argc, char *argv[])
>  			{ "version",	no_argument,		NULL, OPT_VERSION },
>  			{ NULL, 0, NULL, 0 },
>  		};
> -		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:qsw:T:vz",
> +		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:qsw:W:T:vz",
>  				       options, &option_index);
>  		long ncores;
>  
> @@ -670,6 +693,7 @@ static void parse_options(int argc, char *argv[])
>  		switch (c) {
>  		case OPT_BUCKETSIZE:
>  		case 'b':
> +			g.bucket_size_param = true;
>  			g.bucket_size = strtol(optarg, NULL, 10);
>  			if (g.bucket_size > 1024 || g.bucket_size <= 4) {
>  				printf("Illegal bucket size: %s (should be: 4-1024)\n",
> @@ -677,6 +701,20 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_BUCKETWIDTH:
> +		case 'W':
> +			g.bucket_width = strtol(optarg, NULL, 10);
> +			if (g.bucket_width <= 0) {
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
> @@ -776,6 +814,9 @@ static void parse_options(int argc, char *argv[])
>  			break;
>  		}
>  	}
> +
> +	if (!g.bucket_size_param && g.precision == 3 && g.bucket_width < 1000)
> +		g.bucket_size = BUCKET_SIZE * 1000 / g.bucket_width;
>  }
>  
>  void dump_globals(void)
> @@ -811,7 +852,8 @@ static void record_bias(struct thread *t)
>  			bias = t[i].minlat;
>  	}
>  	g.bias = bias;
> -	printf("Global bias set to %" PRId64 " (us)\n", bias);
> +	printf("Global bias set to %.*f (us)\n", g.precision,
> +	       (double)bias / g.unit_per_us);
>  }
>  
>  int main(int argc, char *argv[])
> @@ -835,6 +877,8 @@ int main(int argc, char *argv[])
>  	g.app_name = argv[0];
>  	g.rtprio = 0;
>  	g.bucket_size = BUCKET_SIZE;
> +	g.bucket_width = 1;
> +	g.unit_per_us = 1;
>  	g.runtime = 1;
>  	g.workload = &workload_list[WORKLOAD_DEFAULT];
>  	g.workload_mem_size = WORKLOAD_MEM_SIZE;
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

