Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007D3C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jul 2022 19:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiGGTcP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 15:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiGGTcN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jul 2022 15:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 083BD21260
        for <linux-rt-users@vger.kernel.org>; Thu,  7 Jul 2022 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657222331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lLQqitHF7TUs+vy1ObQBX8567GU2U9pgVlyM5wLJpmQ=;
        b=OT2LkQoli5+F6qWxLIzt9Z9rPKIpITYRdWILme1ZocpROUCj3Of6PE2hYzUaYwoZZdIzPc
        WdtGsrolxpz5cht8X12tKj/w60xieqIhIfEtAu4Oy2AATKNqChyAfp2SdqpL9s2nvfDZoV
        LF8Q7GzRwVrineJNyD2Y48f3z8rQgs8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-fCGAMpqcNYubhuZnFNU__g-1; Thu, 07 Jul 2022 15:32:10 -0400
X-MC-Unique: fCGAMpqcNYubhuZnFNU__g-1
Received: by mail-qt1-f198.google.com with SMTP id q21-20020ac84115000000b0031bf60d9b35so16242861qtl.4
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Jul 2022 12:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=lLQqitHF7TUs+vy1ObQBX8567GU2U9pgVlyM5wLJpmQ=;
        b=CyjO48A6z7ci2ihqKphLSBz/J8Zmfzusl4aReR5Pnl8JY+M/HTcAsp3Ac3XqksJasZ
         +XIaz+JhXRyDSyFziwyDRRKmT+h0ibmqFiTbWuxT5AtzmWGgcDi4Crhu6NItx3RLojDc
         OOaQlvLO+Yl8zuyeBGep6VLxeU+8Q98oOEs0oPhcZ81nZHc9PqsORbuIXNpG7Z1v2UxC
         VyfkbuH0rUGKyRXPklsoLtPbgJNXMDIaDv4yssEzd1SOXCwf6NrDQQgC24NBH6HVyoHi
         m6A+t0N5O23RS1/DsZWKbTUBYwsgqeR9/ZB8WuBWFMjpnEru61RH4Iqsf5HZCZyHUmYC
         fuPQ==
X-Gm-Message-State: AJIora+WoLEUW5gA25gvx2Bw638Bji+y/zfobirHLdknAI/RrdtEoxEn
        aO48anVTa0rgU8szeh9Nlte4T3GB7//ySAjf6C9RfE/IGNqmwnli/1kflre3PuMaAkupbDxyZ8b
        DmKt3BDM3Oh6um7uxA7zKBXypTi8=
X-Received: by 2002:a05:620a:2805:b0:67d:5c7e:c43a with SMTP id f5-20020a05620a280500b0067d5c7ec43amr32740123qkp.84.1657222329930;
        Thu, 07 Jul 2022 12:32:09 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tX/8YPRrI5TJSoXoIqIaEX6Z439ViSsVl9a10R8bT2OfTHDWwx3Lg3+pVcsEqXYwoVufDABQ==
X-Received: by 2002:a05:620a:2805:b0:67d:5c7e:c43a with SMTP id f5-20020a05620a280500b0067d5c7ec43amr32740100qkp.84.1657222329648;
        Thu, 07 Jul 2022 12:32:09 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm30057341qkp.130.2022.07.07.12.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:32:08 -0700 (PDT)
Date:   Thu, 7 Jul 2022 15:31:55 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Song Chen <chensong_2000@189.cn>
cc:     wagi@monom.org, williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] sched_deadline/cyclicdeadline: add tracelimit
In-Reply-To: <1656576028-20474-1-git-send-email-chensong_2000@189.cn>
Message-ID: <ab1d4f62-46e7-9e47-1a9b-9de5bc79d312@redhat.com>
References: <1656576028-20474-1-git-send-email-chensong_2000@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 30 Jun 2022, Song Chen wrote:

> cyclictest has tracelimit to stop running when max latency
> is higher than threshold but cyclicdeadline doesn't.
> 
> Therefore, tracelimit is introduced to cyclicdeadline in
> this commit, once max latency is over, test stops and log
> prints at the bottom of the ftrace file.
> 
> Signed-off-by: Song Chen <chensong_2000@189.cn>
> Reviewed-by:   Daniel Wagner <wagi@monom.org>
> 
> ---
> v2:
> 1, disable ftrace when hitting thresold
> 
> v3:
> 1, update man page
> ---
>  src/sched_deadline/cyclicdeadline.8 |  6 ++++
>  src/sched_deadline/cyclicdeadline.c | 49 ++++++++++++++++++++++++++---
>  2 files changed, 51 insertions(+), 4 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.8 b/src/sched_deadline/cyclicdeadline.8
> index 1a56ed0..fab301e 100644
> --- a/src/sched_deadline/cyclicdeadline.8
> +++ b/src/sched_deadline/cyclicdeadline.8
> @@ -50,6 +50,12 @@ The number of threads to run as deadline (default 1)
>  .B \-q, \-\-quiet
>  Print a summary only on exit. Useful for automated tests, where only
>  the summary output needs to be captured.
> +.TP
> +.B \-b, \-\-breaktrace=USEC
> +Send break trace command when latency > USEC
> +.TP
> +.B \-\-tracemark
> +write a trace mark when \-b latency is exceeded.
>  .br
>  .SH AUTHOR
>  cyclicdeadline was written by Steven Rostedt <rostedt@goodmis.org>
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index d865fa3..a925d1c 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -80,7 +80,11 @@ struct sched_data {
>  };
>  
>  static int shutdown;
> -
> +static int tracelimit = 0;
> +static int trace_marker = 0;
> +static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
> +static pid_t break_thread_id = 0;
> +static uint64_t break_thread_value = 0;
>  static pthread_barrier_t barrier;
>  
>  static int cpu_count;
> @@ -667,6 +671,10 @@ static void teardown(void)
>  
>  	destroy_cpuset(CPUSET_ALL, 0);
>  	destroy_cpuset(CPUSET_LOCAL, 1);
> +
> +	/* close any tracer file descriptors */
> +	disable_trace_mark();
> +
>  }
>  
>  static void usage(int error)
> @@ -689,6 +697,8 @@ static void usage(int error)
>  	       "                           (default 500us).\n"
>  	       "-t NUM   --threads         The number of threads to run as deadline (default 1).\n"
>  	       "-q       --quiet           print a summary only on exit\n"
> +	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> +	       "         --tracemark       write a trace mark when -b latency is exceeded\n"
>  	       );
>  	exit(error);
>  }
> @@ -825,6 +835,18 @@ void *run_deadline(void *data)
>  
>  	while (!shutdown) {
>  		period = do_runtime(tid, sd, period);
> +		if (tracelimit && (stat->max > tracelimit)) {
> +			shutdown++;
> +			pthread_mutex_lock(&break_thread_id_lock);
> +			if (break_thread_id == 0) {
> +				break_thread_id = stat->tid;
> +				break_thread_value = stat->max;
> +				tracemark( "hit latency threshold (%lld > %d)",
> +						 (unsigned long long) stat->max, tracelimit);
> +			}
> +			pthread_mutex_unlock(&break_thread_id_lock);
> +			break;
> +		}
>  		sched_yield();
>  	}
>  	ret = sched_getattr(0, &attr, sizeof(attr), 0);
> @@ -1063,9 +1085,10 @@ static void write_stats(FILE *f, void *data)
>  	fprintf(f, "  }\n");
>  }
>  
> -enum options_valud {
> +enum options_values {
>  	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
> -	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET
> +	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
> +	OPT_BREAKTRACE, OPT_TRACEMARK,
>  };
>  
>  int main(int argc, char **argv)
> @@ -1104,9 +1127,11 @@ int main(int argc, char **argv)
>  			{ "step",	required_argument,	NULL,	OPT_STEP },
>  			{ "threads",	required_argument,	NULL,	OPT_THREADS },
>  			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
> +			{ "breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
> +			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
>  			{ NULL,		0,			NULL,	0   },
>  		};
> -		c = getopt_long(argc, argv, "a::c:D:hi:s:t:q", options, NULL);
> +		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> @@ -1141,6 +1166,10 @@ int main(int argc, char **argv)
>  		case 'D':
>  			duration = parse_time_string(optarg);
>  			break;
> +		case 'b':
> +		case OPT_BREAKTRACE:
> +			tracelimit = atoi(optarg);
> +			break;
>  		case OPT_QUIET:
>  		case 'q':
>  			quiet = 1;
> @@ -1149,6 +1178,9 @@ int main(int argc, char **argv)
>  		case 'h':
>  			usage(0);
>  			break;
> +		case OPT_TRACEMARK:
> +			trace_marker = 1;
> +			break;
>  		default:
>  			usage(1);
>  		}
> @@ -1186,6 +1218,8 @@ int main(int argc, char **argv)
>  		warn("mlockall");
>  
>  	setup_ftrace_marker();
> +	if (tracelimit && trace_marker)
> +		enable_trace_mark();
>  
>  	thread = calloc(nr_threads, sizeof(*thread));
>  	sched_data = calloc(nr_threads, sizeof(*sched_data));
> @@ -1294,6 +1328,13 @@ int main(int argc, char **argv)
>  
>  	loop(sched_data, nr_threads);
>  
> +	if (tracelimit) {
> +		if (break_thread_id) {
> +			printf("# Break thread: %d\n", break_thread_id);
> +			printf("# Break value: %llu\n", (unsigned long long)break_thread_value);
> +		}
> +	}
> +
>  	for (i = 0; i < nr_threads; i++) {
>  
>  		sd = &sched_data[i];
> -- 
> 2.25.1
> 
> 
    - Fixed style problems reported by checkpatch from kernel, namely
    - Don't initialize static to 0
    - no space after open parenthesis
    - removed multiple spaces after Reviewed-by
    Signed-off-by: John Kacur <jkacur@redhat.com>

