Return-Path: <SRS0=5BY9=B4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51823C433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21FD52063A
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgeCZ4Lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgHRUvW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Aug 2020 16:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHRUvW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Aug 2020 16:51:22 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820AAC061389
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2020 13:51:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so19666783qkb.1
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Aug 2020 13:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kbzJE87YyBBuIKpGL1W+7fSqj4JzV5azDYrkHqvY/0c=;
        b=VgeCZ4Lx8MWfJeR4Z247z1iXRVjh0tEexl7QgTRM3p8MTgHXY2HUOs+xRaKojtkopl
         3z/dWAi/kJ8yamRrd1sHq9mY35JU1shem3S4BoUU7d+pYIfHfDSeOfSsoQlp0oED5aFz
         99UCTRSCMgxJxfA3XEfrQld5zitzxh+LROlR9loL8nxD7zQTr1WAmI8zbLBx4456m5gs
         MmZCkdqS1JPjCX1sKSUI3TWA3J77rS6vxcfnAiSrY99+hxQW5X6UzoSA1NfnRYyP+hiV
         E7FmqH64/MSUYFpEeKSBrnoU8JA9Cc/kmW8tnebMVfQcFCZ23utvkLO9/UcIMwlAh+ws
         HNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=kbzJE87YyBBuIKpGL1W+7fSqj4JzV5azDYrkHqvY/0c=;
        b=mY474fdSsViGmOGsuOuFb5fZL6/FNcY09akaXZqttHn/mJVtcZoDYs7dYr4ZAzMKFZ
         NT1hZt7sPdmURCOkdQa3KG6BePvfYmxg1/AtCvFfx71mCJfgbUVS4ksRT74fLAg8Nzf4
         NnmKkJXO9x23nz04qo6SHIUvnBs5o24UIZKuSOCEygVKEjQp+LFHlLS6z08uobroKuiT
         D9nyqSkJE48HSdyy446tcmK5MzEyVZL+KKTZWtzke8XEK0l6iyGyjHoIo66HLHHw4M2o
         FSo3qWP1SVsfziO2V0N9W+jT7+zbRw93xBXm6TKdTaVIEPEDFUVknnGpw6Z574khILX8
         FEqQ==
X-Gm-Message-State: AOAM531mbTroilGt85/lmILs3w49M+lZBUr7VBTe/HBF9ZXdtbo9yzW1
        8+ih436/zuWLOEUzNdMPzW8=
X-Google-Smtp-Source: ABdhPJxDdDBZu1Z3GVL+Jw9GQxE8tlGP0GnlATk7y1+tWJetdnow2pyidw7hv5aJ+UIeibixGWEGGQ==
X-Received: by 2002:a37:6594:: with SMTP id z142mr18747929qkb.10.1597783880720;
        Tue, 18 Aug 2020 13:51:20 -0700 (PDT)
Received: from fionn (rdwyon0600w-lp140-02-142-113-120-236.dsl.bell.ca. [142.113.120.236])
        by smtp.gmail.com with ESMTPSA id 7sm22331734qky.89.2020.08.18.13.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 13:51:20 -0700 (PDT)
Date:   Tue, 18 Aug 2020 16:51:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@fionn
To:     Peter Xu <peterx@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/2] rt-tests: cyclictest: Move ftrace helpers into
 rt-utils.[ch]
In-Reply-To: <20200817215505.227046-2-peterx@redhat.com>
Message-ID: <alpine.LFD.2.23.451.2008181649080.26982@fionn>
References: <20200817215505.227046-1-peterx@redhat.com> <20200817215505.227046-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 17 Aug 2020, Peter Xu wrote:

> Then they can be further used by other programs too.
> 
> Two trivial things to mention.
> 
> Firstly, move trace_marker out of enable_trace_mark().  No functional change.
> 
> Secondly, remove the fileprefix setting in process_options(), because if
> tracelimit is non-zero, fileprefix will be after all replaced by a further call
> to get_debugfileprefix() in debugfs_prepare().
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 90 +------------------------------------
>  src/include/rt-utils.h      |  3 ++
>  src/lib/rt-utils.c          | 82 +++++++++++++++++++++++++++++++++
>  3 files changed, 86 insertions(+), 89 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index eb61be3..dd41893 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -219,8 +219,6 @@ static pthread_barrier_t align_barr;
>  static pthread_barrier_t globalt_barr;
>  static struct timespec globalt;
>  
> -static char *procfileprefix = "/proc/sys/kernel/";
> -static char *fileprefix;
>  static char fifopath[MAX_PATH];
>  static char histfile[MAX_PATH];
>  
> @@ -330,89 +328,6 @@ static inline int64_t calctime(struct timespec t)
>  	return time;
>  }
>  
> -static int trace_file_exists(char *name)
> -{
> -       struct stat sbuf;
> -       char *tracing_prefix = get_debugfileprefix();
> -       char path[MAX_PATH];
> -       strcat(strcpy(path, tracing_prefix), name);
> -       return stat(path, &sbuf) ? 0 : 1;
> -}
> -
> -#define TRACEBUFSIZ 1024
> -static __thread char tracebuf[TRACEBUFSIZ];
> -
> -static void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
> -static void tracemark(char *fmt, ...)
> -{
> -	va_list ap;
> -	int len;
> -
> -	/* bail out if we're not tracing */
> -	/* or if the kernel doesn't support trace_mark */
> -	if (tracemark_fd < 0 || trace_fd < 0)
> -		return;
> -
> -	va_start(ap, fmt);
> -	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
> -	va_end(ap);
> -
> -	/* write the tracemark message */
> -	write(tracemark_fd, tracebuf, len);
> -
> -	/* now stop any trace */
> -	write(trace_fd, "0\n", 2);
> -}
> -
> -static void open_tracemark_fd(void)
> -{
> -	char path[MAX_PATH];
> -
> -	/*
> -	 * open the tracemark file if it's not already open
> -	 */
> -	if (tracemark_fd < 0) {
> -		sprintf(path, "%s/%s", fileprefix, "trace_marker");
> -		tracemark_fd = open(path, O_WRONLY);
> -		if (tracemark_fd < 0) {
> -			warn("unable to open trace_marker file: %s\n", path);
> -			return;
> -		}
> -	}
> -
> -	/*
> -	 * if we're not tracing and the tracing_on fd is not open,
> -	 * open the tracing_on file so that we can stop the trace
> -	 * if we hit a breaktrace threshold
> -	 */
> -	if (trace_fd < 0) {
> -		sprintf(path, "%s/%s", fileprefix, "tracing_on");
> -		if ((trace_fd = open(path, O_WRONLY)) < 0)
> -			warn("unable to open tracing_on file: %s\n", path);
> -	}
> -}
> -
> -static void debugfs_prepare(void)
> -{
> -	if (mount_debugfs(NULL))
> -		fatal("could not mount debugfs");
> -
> -	fileprefix = get_debugfileprefix();
> -	if (!trace_file_exists("tracing_enabled") &&
> -	    !trace_file_exists("tracing_on"))
> -		warn("tracing_enabled or tracing_on not found\n"
> -		     "debug fs not mounted");
> -}
> -
> -static void enable_trace_mark(void)
> -{
> -	if (!trace_marker)
> -		return;
> -
> -	debugfs_prepare();
> -	open_tracemark_fd();
> -}
> -
>  /*
>   * Raise the soft priority limit up to prio, if that is less than or equal
>   * to the hard limit
> @@ -1498,9 +1413,6 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			      "on this processor\n");
>  	}
>  
> -	if (tracelimit)
> -		fileprefix = procfileprefix;
> -
>  	if (clocksel < 0 || clocksel > ARRAY_SIZE(clocksources))
>  		error = 1;
>  
> @@ -2065,7 +1977,7 @@ int main(int argc, char **argv)
>  	/* use the /dev/cpu_dma_latency trick if it's there */
>  	set_latency_target();
>  
> -	if (tracelimit)
> +	if (tracelimit && trace_marker)
>  		enable_trace_mark();
>  
>  	if (check_timer())
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 6ec2b20..51489b4 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -27,4 +27,7 @@ pid_t gettid(void);
>  
>  int parse_time_string(char *val);
>  
> +void enable_trace_mark(void);
> +void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
> +
>  #endif	/* __RT_UTILS.H */
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 1998a32..f786588 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -24,7 +24,13 @@
>  #include "rt-sched.h"
>  #include "error.h"
>  
> +#define  TRACEBUFSIZ  1024
> +
>  static char debugfileprefix[MAX_PATH];
> +static char *fileprefix;
> +static int trace_fd = -1;
> +static int tracemark_fd = -1;
> +static __thread char tracebuf[TRACEBUFSIZ];
>  
>  /*
>   * Finds the tracing directory in a mounted debugfs
> @@ -355,3 +361,79 @@ int parse_time_string(char *val)
>  	}
>  	return t;
>  }
> +
> +void open_tracemark_fd(void)
> +{
> +	char path[MAX_PATH];
> +
> +	/*
> +	 * open the tracemark file if it's not already open
> +	 */
> +	if (tracemark_fd < 0) {
> +		sprintf(path, "%s/%s", fileprefix, "trace_marker");
> +		tracemark_fd = open(path, O_WRONLY);
> +		if (tracemark_fd < 0) {
> +			warn("unable to open trace_marker file: %s\n", path);
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * if we're not tracing and the tracing_on fd is not open,
> +	 * open the tracing_on file so that we can stop the trace
> +	 * if we hit a breaktrace threshold
> +	 */
> +	if (trace_fd < 0) {
> +		sprintf(path, "%s/%s", fileprefix, "tracing_on");
> +		if ((trace_fd = open(path, O_WRONLY)) < 0)
> +			warn("unable to open tracing_on file: %s\n", path);
> +	}
> +}
> +
> +int trace_file_exists(char *name)
> +{
> +       struct stat sbuf;
> +       char *tracing_prefix = get_debugfileprefix();
> +       char path[MAX_PATH];
> +       strcat(strcpy(path, tracing_prefix), name);
> +       return stat(path, &sbuf) ? 0 : 1;
> +}
> +
> +void debugfs_prepare(void)
> +{
> +	if (mount_debugfs(NULL))
> +		fatal("could not mount debugfs");
> +
> +	fileprefix = get_debugfileprefix();
> +	if (!trace_file_exists("tracing_enabled") &&
> +	    !trace_file_exists("tracing_on"))
> +		warn("tracing_enabled or tracing_on not found\n"
> +		     "debug fs not mounted");
> +}
> +
> +void tracemark(char *fmt, ...)
> +{
> +	va_list ap;
> +	int len;
> +
> +	/* bail out if we're not tracing */
> +	/* or if the kernel doesn't support trace_mark */
> +	if (tracemark_fd < 0 || trace_fd < 0)
> +		return;
> +
> +	va_start(ap, fmt);
> +	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
> +	va_end(ap);
> +
> +	/* write the tracemark message */
> +	write(tracemark_fd, tracebuf, len);
> +
> +	/* now stop any trace */
> +	write(trace_fd, "0\n", 2);
> +}
> +
> +void enable_trace_mark(void)
> +{
> +	debugfs_prepare();
> +	open_tracemark_fd();
> +}
> -- 
> 2.26.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
