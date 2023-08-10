Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0601BC001B0
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Aug 2023 17:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjHJRDM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Aug 2023 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjHJRDL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Aug 2023 13:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C8726A9
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 10:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691686943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eJ5lkA6f8Y8tmWyLQ8HodlKVMu8Vq2kWBKUgDm8kNdg=;
        b=MSYb7xAXwFh3NxUXzwwi3iBcQAnoI58JLFPkhjnJcK0sQk5Qmvpb5GnY8RrQn74x5wb9iT
        x49zjwZuDX3A1vAqijAUCL4rFXvvvrV7eFTNLYUxc31fdi4PIJYAuuuJ186Lb5luDTcYuH
        SMofJTFqsDMQ2tnGAafGgfcubvupHsI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-UJ-WMmHPMaqD1ty9-L2Ngw-1; Thu, 10 Aug 2023 13:02:22 -0400
X-MC-Unique: UJ-WMmHPMaqD1ty9-L2Ngw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7659d103147so139229785a.3
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Aug 2023 10:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691686941; x=1692291741;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ5lkA6f8Y8tmWyLQ8HodlKVMu8Vq2kWBKUgDm8kNdg=;
        b=QryuckyveKyOZJUaLV7q1A64sJhBaLjJqEv/EmqLH0CS6rbeuMCsVJHwhOFteta3Ju
         HXA3HlXfKygWBidCpc2do6HNg6UqFCF/dO14p4gdGikMEHhz/inEkhib5QP16nBbX8rD
         llMqKIHyzDYs8o2AEVRHw7qaaqxvWn1Ew88e+QJBiAQGd4KL5AXJpJVA0SiZyCtcU8WV
         Poj2umFgK4hlf0KmpY5QV6lHAMXhqnZwgTSRl/70SkZ2iejDoQndvV1zYC2+oD1CH632
         F+ZZsm0ZTYNBERC2PxZt5pqgmRkZkCi8NiWqg3WZlubFwY4vusC8qZ/rY9QR6l6BnffJ
         tMtQ==
X-Gm-Message-State: AOJu0YyVrgq9ytdpGzyaUQyryeFgcs7+uqY08nzvZFVnOQWy21VDNFxo
        ITtvbTK97BJdBWntDe4cHA1NjRc4QvcACt4BGYcXnDsoZYmqAJRYvKZjz5fRvh52yjXGIFZgzvg
        OekhyDDpOytEYn0Xmga+ULj2t5o7hirIyuz0=
X-Received: by 2002:a05:620a:462a:b0:767:1b06:ba58 with SMTP id br42-20020a05620a462a00b007671b06ba58mr3250656qkb.29.1691686941570;
        Thu, 10 Aug 2023 10:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXpqXt224QMYR1tEBggZL+r2V4CwiQr9LyJDoG5N16J0rQ83cyLSCQlhmFeX1vYapPONeV9Q==
X-Received: by 2002:a05:620a:462a:b0:767:1b06:ba58 with SMTP id br42-20020a05620a462a00b007671b06ba58mr3250627qkb.29.1691686941227;
        Thu, 10 Aug 2023 10:02:21 -0700 (PDT)
Received: from fionn ([184.147.140.157])
        by smtp.gmail.com with ESMTPSA id g12-20020a05620a108c00b007339c5114a9sm612302qkk.103.2023.08.10.10.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 10:02:20 -0700 (PDT)
Date:   Thu, 10 Aug 2023 13:01:59 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2] rt-error: added conditional to info() and debug()
In-Reply-To: <20230809194810.169162-1-ashelat@redhat.com>
Message-ID: <e57d2ccc-10a3-41ee-ad83-b3a5535a5fc0@redhat.com>
References: <20230809194810.169162-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 9 Aug 2023, Anubhav Shelat wrote:

> This change was motivated by the desire to clean up the output of
> cyclicdeadline, and include the extra info only when requested.
> 
> Instead of having to check if the program is in debugging mode, the
> rt-error functions will automatically check by passing in an argument.
> 
> The other changes in this patch edit the function calls to debug() and
> info() to work with the changes in rt-error.
> 
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> ---
>  src/cyclictest/cyclictest.c         | 13 +++++--------
>  src/include/rt-error.h              |  4 ++--
>  src/lib/rt-error.c                  | 28 ++++++++++++++++------------
>  src/lib/rt-utils.c                  |  2 +-
>  src/pi_tests/pi_stress.c            |  4 ++--
>  src/sched_deadline/cyclicdeadline.c | 26 +++++++++++++++++++-------
>  6 files changed, 45 insertions(+), 32 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 7b0f80fe5a1e..4a7108ea2c8f 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1950,10 +1950,8 @@ int main(int argc, char **argv)
>  		for (k=0; k < times; k++)
>  			clock_gettime(clock, &time[k]);
>  
> -		if (ct_debug) {
> -			info("For %d consecutive calls to clock_gettime():\n", times);
> -			info("time, delta time (nsec)\n");
> -		}
> +		info(ct_debug, "For %d consecutive calls to clock_gettime():\n", times);
> +		info(ct_debug, "time, delta time (nsec)\n");
>  
>  		prev = time[0];
>  		for (k=1; k < times; k++) {
> @@ -1964,10 +1962,9 @@ int main(int argc, char **argv)
>  			if (diff && (diff < min_non_zero_diff))
>  				min_non_zero_diff = diff;
>  
> -			if (ct_debug)
> -				info("%ld.%06ld  %5llu\n",
> -				     time[k].tv_sec, time[k].tv_nsec,
> -				     (unsigned long long)diff);
> +			info(ct_debug, "%ld.%06ld  %5llu\n",
> +					time[k].tv_sec, time[k].tv_nsec,
> +					(unsigned long long)diff);
>  		}
>  
>  		free(time);
> diff --git a/src/include/rt-error.h b/src/include/rt-error.h
> index d205e49ff041..7c4a9db55a52 100644
> --- a/src/include/rt-error.h
> +++ b/src/include/rt-error.h
> @@ -11,8 +11,8 @@ void err_exit(int err, char *fmt, ...) __attribute__((noreturn));
>  void err_msg(char *fmt, ...);
>  void err_msg_n(int err, char *fmt, ...);
>  void err_quit(char *fmt, ...) __attribute__((noreturn));
> -void debug(char *fmt, ...);
> -void info(char *fmt, ...);
> +void debug(int enable, char *fmt, ...);
> +void info(int enable, char *fmt, ...);
>  void warn(char *fmt, ...);
>  void fatal(char *fmt, ...) __attribute__((noreturn));
>  void err_doit(int err, const char *fmt, va_list ap);
> diff --git a/src/lib/rt-error.c b/src/lib/rt-error.c
> index 616f70b044e0..9f0827530ccb 100644
> --- a/src/lib/rt-error.c
> +++ b/src/lib/rt-error.c
> @@ -47,24 +47,28 @@ void err_quit(char *fmt, ...)
>  	exit(1);
>  }
>  
> -void debug(char *fmt, ...)
> +void debug(int enable, char *fmt, ...)
>  {
> -	va_list ap;
> +	if (enable) {
> +		va_list ap;
>  
> -	va_start(ap, fmt);
> -	fputs("DEBUG: ", stderr);
> -	err_doit(0, fmt, ap);
> -	va_end(ap);
> +		va_start(ap, fmt);
> +		fputs("DEBUG: ", stderr);
> +		err_doit(0, fmt, ap);
> +		va_end(ap);
> +	}
>  }
>  
> -void info(char *fmt, ...)
> +void info(int enable, char *fmt, ...)
>  {
> -	va_list ap;
> +	if (enable) {
> +		va_list ap;
>  
> -	va_start(ap, fmt);
> -	fputs("INFO: ", stderr);
> -	err_doit(0, fmt, ap);
> -	va_end(ap);
> +		va_start(ap, fmt);
> +		fputs("INFO: ", stderr);
> +		err_doit(0, fmt, ap);
> +		va_end(ap);
> +	}
>  }
>  
>  void warn(char *fmt, ...)
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 6c0235d0d2e0..14dac5608037 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -109,7 +109,7 @@ int mount_debugfs(char *path)
>  	/* if it's already mounted just return */
>  	prefix = get_debugfileprefix();
>  	if (strlen(prefix) != 0) {
> -		info("debugfs mountpoint: %s\n", prefix);
> +		info(1, "debugfs mountpoint: %s\n", prefix);
>  		return 0;
>  	}
>  	if (!mountpoint)
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index cba1ad92ac2d..9ce7d66751da 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -71,9 +71,9 @@
>  #define DOWN_ONE "\033[1B"
>  
>  #define pi_info(fmt, arg...) \
> -	do { if (verbose) info(fmt, ## arg); } while (0)
> +	do { info(verbose, fmt, ## arg); } while (0)
>  #define pi_debug(fmt, arg...) \
> -	do { if (debugging) debug(fmt, ## arg); } while (0)
> +	do { debug(debugging, fmt, ## arg); } while (0)
>  #define pi_error(fmt, arg...) \
>  	do { err_msg(fmt, ## arg); have_errors = 1; } while (0)
>  
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 39de1b799458..ef00a0d6b2dd 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -80,6 +80,8 @@ struct sched_data {
>  };
>  
>  static int shutdown;
> +static int info_enable;
> +static int debug_enable;
>  static int tracelimit;
>  static int trace_marker;
>  static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
> @@ -698,6 +700,8 @@ static void usage(int error)
>  	       "-q       --quiet           print a summary only on exit\n"
>  	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>  	       "         --tracemark       write a trace mark when -b latency is exceeded\n"
> +		   "		 --debug		   Print debugging info for cyclicdeadline\n"
> +		   "		 --verbose		   Print useful information about the test\n"
>  	       );
>  	exit(error);
>  }
> @@ -794,8 +798,8 @@ void *run_deadline(void *data)
>  	u64 period;
>  	int ret;
>  
> -	printf("deadline thread %ld\n", tid);
> -
> +	debug(debug_enable, "deadline thread %ld\n", tid);
> +	// set up for each measurment thread
>  	stat->tid = tid;
>  
>  	ret = sched_getattr(0, &attr, sizeof(attr), 0);
> @@ -811,7 +815,7 @@ void *run_deadline(void *data)
>  	attr.sched_runtime = sd->runtime_us * 1000;
>  	attr.sched_deadline = sd->deadline_us * 1000;
>  
> -	printf("thread[%d] runtime=%lldus deadline=%lldus\n",
> +	debug(debug_enable, "thread[%d] runtime=%lldus deadline=%lldus\n",
>  	      gettid(), sd->runtime_us, sd->deadline_us);
>  
>  	ret = sched_setattr(0, &attr, 0);
> @@ -1083,7 +1087,7 @@ static void write_stats(FILE *f, void *data)
>  enum options_values {
>  	OPT_AFFINITY=1, OPT_DURATION, OPT_HELP, OPT_INTERVAL,
>  	OPT_JSON, OPT_STEP, OPT_THREADS, OPT_QUIET,
> -	OPT_BREAKTRACE, OPT_TRACEMARK,
> +	OPT_BREAKTRACE, OPT_TRACEMARK, OPT_INFO, OPT_DEBUG,
>  };
>  
>  int main(int argc, char **argv)
> @@ -1124,6 +1128,8 @@ int main(int argc, char **argv)
>  			{ "quiet",	no_argument,		NULL,	OPT_QUIET },
>  			{ "breaktrace",       required_argument, NULL, OPT_BREAKTRACE },
>  			{ "tracemark",	     no_argument,	NULL, OPT_TRACEMARK },
> +			{ "verbose",	no_argument,	NULL,	OPT_INFO},
> +			{ "debug",	no_argument, 	NULL, 	OPT_DEBUG},
>  			{ NULL,		0,			NULL,	0   },
>  		};
>  		c = getopt_long(argc, argv, "a::c:D:hi:s:t:b:q", options, NULL);
> @@ -1176,6 +1182,12 @@ int main(int argc, char **argv)
>  		case OPT_TRACEMARK:
>  			trace_marker = 1;
>  			break;
> +		case OPT_INFO:
> +			info_enable = 1;
> +			break;
> +		case OPT_DEBUG:
> +			debug_enable = 1;
> +			break;
>  		default:
>  			usage(1);
>  		}
> @@ -1250,7 +1262,7 @@ int main(int argc, char **argv)
>  		sd->runtime_us = runtime;
>  		sd->deadline_us = interval;
>  
> -		printf("interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
> +		info(info_enable, "interval: %lld:%lld\n", sd->runtime_us, sd->deadline_us);
>  
>  		/* Make sure that we can make our deadlines */
>  		start_period = get_time_us();
> @@ -1260,7 +1272,7 @@ int main(int argc, char **argv)
>  			fatal("Failed to perform task within runtime: Missed by %lld us\n",
>  			      end_period - start_period - sd->runtime_us);
>  
> -		printf("  Tested at %lldus of %lldus\n",
> +		info(info_enable, "  Tested at %lldus of %lldus\n",
>  		       end_period - start_period, sd->runtime_us);
>  
>  		interval += step;
> @@ -1303,7 +1315,7 @@ int main(int argc, char **argv)
>  		system("cat /sys/fs/cgroup/cpuset/my_cpuset/tasks");
>  	}
>  
> -	printf("main thread %d\n", gettid());
> +	debug(debug_enable, "main thread %d\n", gettid());
>  
>  	if (shutdown)
>  		fatal("failed to setup child threads at step 2");
> -- 
> 2.39.3
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

