Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DDEC433E9
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F5A22795
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390862AbhAZRVK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404109AbhAZQg3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 11:36:29 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4CBC061574
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jan 2021 08:35:39 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n7so5178247qkc.4
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jan 2021 08:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Suzs02spaG8WI2nydB9982rHJgC5PrFitucLsUIStIU=;
        b=OyE0fN8g5oPUr0zqKRohAeWk/w5jmcPMvbIScMgfyqlgFi0M3iN8q1WN5sFz7oiCmA
         cx172SPqzdYtjIMVfkWJB6g006PVsXMGn+SdMZXuKoRl1G4ew/0/4C96L1Ql7xOtby0L
         iURKen6X2rouQq5hVORfK5lKBphEzAASo5qlXHyPw4AIMOOyBygJFadXcHPoclpc9pDl
         6lAhbNdGsqj6pUewgxgA9H2jPQkSO2gOTbQQSw6hHCWHoikQSu+4jK+qnrrgXVNCLDDT
         IR++ezuH/0nwAPBv/vqsThNw5hVSJM2qYHRzTJBP0DlWuTFIW58v0c7hX+PCCApDcqGo
         ieHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Suzs02spaG8WI2nydB9982rHJgC5PrFitucLsUIStIU=;
        b=dpD4oGExfyNInGYQusvhXdkTKOBvnA+mrl6eVDfeUgYXVmJXFHcUxq3Z9OhbIGiZOd
         OuaY0jrHQGqorIzy+z8oy9b/b7hPoHy6Y+zWMRZ8ZBRaNt6TTyXLd58sdRFJhmOUPDLk
         o9RJc4YxFoM6T5OorpCb2hPS6Kh/jopMv7Gy26fQ0xU0u6lWlZDUODvfhJXH4x+wXOp4
         W5RTtdNYM+Bp0P8aAa4Kjx6iMVvindihFVfci7UQ10scL5tKQg+cOVa9KL3Yei7dospk
         z6zahNXvZkZxsk2gPtnaSVHGCGSfVM3F0bPvn/5zQQT1cGjXKfA22WwKldMKNnnCQ0/k
         S4Qw==
X-Gm-Message-State: AOAM533AHmX6FaqitEoe/bTqXgH6NpVk+amDuNA+V55Y2UcT0hJto62F
        ydrFGSS4zJrjiHDUmWGj2FM=
X-Google-Smtp-Source: ABdhPJyl77GeAHZZZ+QKmKfDJ5sVGos/h1eBV2aMj2tzi+m+qOAdFDTZdDvp48looxRH4fdsAe60Rg==
X-Received: by 2002:a37:884:: with SMTP id 126mr6528505qki.404.1611678938532;
        Tue, 26 Jan 2021 08:35:38 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id 196sm13313651qkl.4.2021.01.26.08.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 08:35:37 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 11:35:36 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v4 11/12] oslat: Add JSON output feature
In-Reply-To: <20210126091946.1241-12-dwagner@suse.de>
Message-ID: <b12e3868-e2d4-cb84-d024-27dda1931fd2@redhat.com>
References: <20210126091946.1241-1-dwagner@suse.de> <20210126091946.1241-12-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 26 Jan 2021, Daniel Wagner wrote:

> Write the test results as JSON output to a file. This allows to
> simplifies any parsing later on.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 97 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 82 insertions(+), 15 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 9e6f70600830..5858c6c17fcf 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -29,7 +29,7 @@
>  #include <numa.h>
>  #include <math.h>
>  #include <limits.h>
> -#include <linux/unistd.h>
> +#include <inttypes.h>
>  
>  #include <sys/prctl.h>
>  #include <sys/stat.h>
> @@ -41,6 +41,8 @@
>  #include <sys/mman.h>
>  #include <sys/syscall.h>
>  
> +#include <linux/unistd.h>
> +
>  #include "rt-utils.h"
>  #include "rt-numa.h"
>  #include "rt-error.h"
> @@ -171,6 +173,7 @@ struct global {
>  	uint64_t              bias;
>  	int                   single_preheat_thread;
>  	int                   output_omit_zero_buckets;
> +	char                  outfile[MAX_PATH];
>  
>  	/* Mutable state. */
>  	volatile enum command cmd;
> @@ -479,6 +482,39 @@ static void write_summary(struct thread *t)
>  	printf("\n");
>  }
>  
> +static void write_summary_json(FILE *f, void *data)
> +{
> +	struct thread *t = data;
> +	int i, j, comma;
> +
> +	fprintf(f, "  \"num_threads\": %d,\n", g.n_threads);
> +	fprintf(f, "  \"thread\": {\n");
> +	for (i = 0; i < g.n_threads; ++i) {
> +		fprintf(f, "    \"%u\": {\n", i);
> +		fprintf(f, "      \"cpu\": %d,\n", t[i].core_i);
> +		fprintf(f, "      \"freq\": %d,\n", t[i].cpu_mhz);
> +		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].minlat);
> +		fprintf(f, "      \"avg\": %3lf,\n", t[i].average);
> +		fprintf(f, "      \"min\": %" PRIu64 ",\n", t[i].maxlat);
> +		fprintf(f, "      \"duration\": %.3f,\n",
> +			cycles_to_sec(&(t[i]), t[i].runtime));
> +		fprintf(f, "      \"histogram\": {");
> +		for (j = 0, comma = 0; j < g.bucket_size; j++) {
> +			if (t[i].buckets[j] == 0)
> +				continue;
> +			fprintf(f, "%s", comma ? ",\n" : "\n");
> +			fprintf(f, "        \"%" PRIu64 "\": %" PRIu64,
> +				g.bias+j+1, t[i].buckets[j]);
> +			comma = 1;
> +		}
> +		if (comma)
> +			fprintf(f, "\n");
> +		fprintf(f, "      },\n");
> +		fprintf(f, "    }%s\n", i == g.n_threads - 1 ? "" : ",");
> +	}
> +	fprintf(f, "  }\n");
> +}
> +
>  static void run_expt(struct thread *threads, int runtime_secs)
>  {
>  	int i;
> @@ -533,6 +569,7 @@ static void usage(int error)
>  	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
>  	       "                       are locked before using this parmater.  If you don't know how\n"
>  	       "                       to lock the freq then please don't use this parameter.\n"
> +	       "    --output=FILENAME  write final results into FILENAME, JSON formatted\n"
>  	       "-T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
>  	       "                       print a marker in ftrace and stop ftrace too.\n"
>  	       "-v, --version          Display the version of the software.\n"
> @@ -557,34 +594,45 @@ static int workload_select(char *name)
>  	return -1;
>  }
>  
> +enum option_value {
> +	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
> +	OPT_DURATION, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
> +	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS, OPT_OUTPUT,
> +	OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT, OPT_VERSION
> +
> +};
> +
>  /* Process commandline options */
>  static void parse_options(int argc, char *argv[])
>  {
>  	while (1) {
> +		int option_index = 0;
>  		static struct option options[] = {
> -			{ "bucket-size", required_argument, NULL, 'b' },
> -			{ "cpu-list", required_argument, NULL, 'c' },
> -			{ "cpu-main-thread", required_argument, NULL, 'C'},
> -			{ "duration", required_argument, NULL, 'D' },
> -			{ "rtprio", required_argument, NULL, 'f' },
> -			{ "help", no_argument, NULL, 'h' },
> -			{ "trace-threshold", required_argument, NULL, 'T' },
> -			{ "workload", required_argument, NULL, 'w'},
> -			{ "workload-mem", required_argument, NULL, 'm'},
> -			{ "bias", no_argument, NULL, 'B'},
> -			{ "single-preheat", no_argument, NULL, 's'},
> -			{ "zero-omit", no_argument, NULL, 'u'},
> -			{ "version", no_argument, NULL, 'v'},
> +			{ "bucket-size",required_argument,	NULL, OPT_BUCKETSIZE },
> +			{ "cpu-list",	required_argument,	NULL, OPT_CPU_LIST },
> +			{ "cpu-main-thread", required_argument, NULL, OPT_CPU_MAIN_THREAD},
> +			{ "duration",	required_argument,	NULL, OPT_DURATION },
> +			{ "rtprio",	required_argument,	NULL, OPT_RT_PRIO },
> +			{ "help",	no_argument,		NULL, OPT_HELP },
> +			{ "trace-threshold", required_argument,	NULL, OPT_TRACE_TH },
> +			{ "workload",	required_argument,	NULL, OPT_WORKLOAD },
> +			{ "workload-mem", required_argument,	NULL, OPT_WORKLOAD_MEM },
> +			{ "bias",	no_argument,		NULL, OPT_BIAS },
> +			{ "single-preheat", no_argument,	NULL, OPT_SINGLE_PREHEAT },
> +			{ "output",	required_argument,      NULL, OPT_OUTPUT },
> +			{ "zero-omit",	no_argument,		NULL, OPT_ZERO_OMIT },
> +			{ "version",	no_argument,		NULL, OPT_VERSION },
>  			{ NULL, 0, NULL, 0 },
>  		};
>  		int i, c = getopt_long(argc, argv, "b:Bc:C:D:f:hm:sw:T:vz",
> -				       options, NULL);
> +				       options, &option_index);
>  		long ncores;
>  
>  		if (c == -1)
>  			break;
>  
>  		switch (c) {
> +		case OPT_BUCKETSIZE:
>  		case 'b':
>  			g.bucket_size = strtol(optarg, NULL, 10);
>  			if (g.bucket_size > 1024 || g.bucket_size <= 4) {
> @@ -593,12 +641,15 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_BIAS:
>  		case 'B':
>  			g.enable_bias = 1;
>  			break;
> +		case OPT_CPU_LIST:
>  		case 'c':
>  			g.cpu_list = strdup(optarg);
>  			break;
> +		case OPT_CPU_MAIN_THREAD:
>  		case 'C':
>  			ncores = sysconf(_SC_NPROCESSORS_CONF);
>  			g.cpu_main_thread = strtol(optarg, NULL, 10);
> @@ -608,6 +659,7 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_DURATION:
>  		case 'D':
>  			g.runtime = parse_time_string(optarg);
>  			if (!g.runtime) {
> @@ -615,6 +667,7 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_RT_PRIO:
>  		case 'f':
>  			g.rtprio = strtol(optarg, NULL, 10);
>  			if (g.rtprio < 1 || g.rtprio > 99) {
> @@ -622,6 +675,10 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_OUTPUT:
> +			strncpy(g.outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
> +		case OPT_TRACE_TH:
>  		case 'T':
>  			g.trace_threshold = strtol(optarg, NULL, 10);
>  			if (g.trace_threshold <= 0) {
> @@ -630,6 +687,7 @@ static void parse_options(int argc, char *argv[])
>  			}
>  			enable_trace_mark();
>  			break;
> +		case OPT_WORKLOAD:
>  		case 'w':
>  			if (workload_select(optarg)) {
>  				printf("Unknown workload '%s'.  Please choose from: ", optarg);
> @@ -642,12 +700,14 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> +		case OPT_WORKLOAD_MEM:
>  		case 'm':
>  			if (parse_mem_string(optarg, &g.workload_mem_size)) {
>  				printf("Unknown workload memory size '%s'.\n\n", optarg);
>  				exit(1);
>  			}
>  			break;
> +		case OPT_SINGLE_PREHEAT:
>  		case 's':
>  			/*
>  			 * Only use one core for pre-heat.  Then if --bias is used, the
> @@ -655,6 +715,7 @@ static void parse_options(int argc, char *argv[])
>  			 */
>  			g.single_preheat_thread = true;
>  			break;
> +		case OPT_VERSION:
>  		case 'v':
>  			/*
>  			 * Because we always dump the version even before parsing options,
> @@ -662,9 +723,11 @@ static void parse_options(int argc, char *argv[])
>  			 */
>  			exit(0);
>  			break;
> +		case OPT_ZERO_OMIT:
>  		case 'z':
>  			g.output_omit_zero_buckets = 1;
>  			break;
> +		case OPT_HELP:
>  		case 'h':
>  			usage(0);
>  			break;
> @@ -781,6 +844,10 @@ int main(int argc, char *argv[])
>  
>  	write_summary(threads);
>  
> +	if (strlen(g.outfile) != 0)
> +		rt_write_json(g.outfile, argc, argv,
> +			write_summary_json, threads);
> +
>  	if (g.cpu_list) {
>  		free(g.cpu_list);
>  		g.cpu_list = NULL;
> -- 
> 2.30.0
> 
> 

I haven't looked at the implementation of JSON yet, but I am excited about 
this feature, looking forward to it. Please finish the numa changes
and other clean-ups first though.

Thanks

John
