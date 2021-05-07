Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1C9C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA00461424
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238167AbhEGQ25 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbhEGQ24 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:28:56 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16AC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:27:55 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id j19so6994756qtp.7
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=wgAm4cGeoeuB5w9pzZaBTcRWZMMjhO+JKsm6R78Lz7U=;
        b=X/qEMzUzjwVuFb8hWlM9wpjGq3Rsomv1hIRpO7fuQWf9/272bQIVuG+V8uQlY9oyaA
         wwRNU1dLyd7MsK2tVC1200EoVnVVMROqCDFp8HjhKEopww9pu1M7IfnKviEMerJnqJsu
         rcvhwkHOcZU1cOCs1srmd5vfOcdizvVnXpRSNQoChS5Wb7hb4ORZMMf9V7mh3P9jkNuR
         R+N6U7WgmlN+M8GX+HIZR2PBnMpOpHT/6l0w8caRFtKLQk/o++00BOJ6QymN4jXmCGKk
         aI3bGvcC21XKgHdAyMmybWf0uIArGpbb6SgKA4T0S6edfWMtx4ziakWSIBiZ+BfFCdEi
         elwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=wgAm4cGeoeuB5w9pzZaBTcRWZMMjhO+JKsm6R78Lz7U=;
        b=cmwWrfzRBv4IBR65+NGnb+87OZLZDYq3MOyv6GSrZA6VVYQCSFxc8DaXtxuk4z/rCQ
         g2U4n5Dur/D0tTVd6uFfH4LFdZIKppdMwpzA/iTMZUNe7u3NG3YlJatpWqVmyPIEgrDI
         JQX5RjPGfcNO85Puo4c5HZhjzqUWGNaAZpDRe5MSLU/kjSed5cR2woBlGS8zIehkp4HE
         +3gBULkkXB92T/bd8enDwwXx53OCfuvKZO7XoU+2BEWGeEQbX6dwTQpiUNIn1lhG02Md
         GnMVFZvfxRNgpQr9dlGtcYBfH6o0yhzodEC46e2CqaF4xi0X+GB5pp+BUMtsMyQFLpaO
         pGkg==
X-Gm-Message-State: AOAM531jr1qVerH+hZs2BhxHDz7IEjFs3JMoLhTxp44nlRKxAnJf3syq
        5csS7uwkLc3OfLBI33NLEet3AQPLZzhwpw==
X-Google-Smtp-Source: ABdhPJyMvUfgM8krK3b5m/j7bt+clUdb46UkNW963o3O6SQv1EltL4RL2GPeFZAG8eWygbWiAm/YCA==
X-Received: by 2002:ac8:7303:: with SMTP id x3mr10354307qto.271.1620404874741;
        Fri, 07 May 2021 09:27:54 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id g64sm5085185qkf.41.2021.05.07.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:27:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:27:53 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 04/33] rt-util: Add rt_init function
In-Reply-To: <20210320183829.1318-5-dwagner@suse.de>
Message-ID: <644e52d1-acdb-dc12-b715-3847c9318027@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-5-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> rt_init() should be called as first in the test program.
> The main job for this function is to copy the command line
> before getopt() runs. By default, getopt_long() permutes
> the contents of argv as it scans, so that eventually all the
> nonoptions are at the end. This is confusing in the JSON
> output, thus copy the command line before we call getopt_long().
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/include/rt-utils.h |  2 ++
>  src/lib/rt-utils.c     | 47 +++++++++++++++++++++++++++++++++++-------
>  2 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index 36af92b170df..1dbd3f1dd8e3 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -80,6 +80,8 @@ static inline int64_t calctime(struct timespec t)
>  	return time;
>  }
>  
> +void rt_init(int argc, char *argv[]);
> +
>  void rt_write_json(const char *filename, int argc, char *argv[],
>  		   void (*cb)(FILE *, void *),
>  		   void *data);
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index 00907c573d6a..8f0e0943b137 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -29,12 +29,15 @@
>  #include "rt-error.h"
>  
>  #define  TRACEBUFSIZ  1024
> +#define  MAX_COMMAND_LINE 4096
>  
>  static char debugfileprefix[MAX_PATH];
>  static char *fileprefix;
>  static int trace_fd = -1;
>  static int tracemark_fd = -1;
>  static __thread char tracebuf[TRACEBUFSIZ];
> +static char test_cmdline[MAX_COMMAND_LINE];
> +static int rt_init_run;
>  
>  /*
>   * Finds the tracing directory in a mounted debugfs
> @@ -486,6 +489,34 @@ void disable_trace_mark(void)
>  	close_tracemark_fd();
>  }
>  
> +void rt_init(int argc, char *argv[])
> +{
> +	int offset = 0;
> +	int len, i;
> +
> +	test_cmdline[0] = '\0';
> +
> +	/*
> +	 * getopt_long() permutes the contents of argv as it scans, so
> +	 * that eventually all the nonoptions are at the end. Make a
> +	 * copy before calling getopt_long().
> +	 */
> +	for (i = 0; i < argc;) {
> +		len = strlen(argv[i]);
> +		if (offset + len + 1 >= MAX_COMMAND_LINE)
> +			break;
> +
> +		strcat(test_cmdline, argv[i]);
> +		i++;
> +		if (i < argc)
> +			strcat(test_cmdline, " ");
> +
> +		offset += len + 1;
> +	}
> +
> +	rt_init_run = 1;
> +}
> +
>  static char *get_cmdline(int argc, char *argv[])
>  {
>  	char *cmdline;
> @@ -519,7 +550,7 @@ void rt_write_json(const char *filename, int argc, char *argv[],
>  	struct timeval tv;
>  	char tsbuf[64];
>  	struct tm *tm;
> -	char *cmdline;
> +	char *cmdline = NULL;
>  	FILE *f, *s;
>  	time_t t;
>  	size_t n;
> @@ -533,10 +564,11 @@ void rt_write_json(const char *filename, int argc, char *argv[],
>  			err_exit(errno, "Failed to open '%s'\n", filename);
>  	}
>  
> -	cmdline = get_cmdline(argc, argv);
> -	if (!cmdline)
> -		err_exit(ENOMEM, "get_cmdline()");
> -
> +	if (!rt_init_run) {
> +		cmdline = get_cmdline(argc, argv);
> +		if (!cmdline)
> +			err_exit(ENOMEM, "get_cmdline()");
> +	}
>  
>  	gettimeofday(&tv, NULL);
>  	t = tv.tv_sec;
> @@ -557,7 +589,7 @@ void rt_write_json(const char *filename, int argc, char *argv[],
>  
>  	fprintf(f, "{\n");
>  	fprintf(f, "  \"file_version\": 1,\n");
> -	fprintf(f, "  \"cmdline:\": \"%s\",\n", cmdline);
> +	fprintf(f, "  \"cmdline:\": \"%s\",\n", rt_init_run? test_cmdline : cmdline);
>  	fprintf(f, "  \"rt_test_version:\": \"%1.2f\",\n", VERSION);
>  	fprintf(f, "  \"finished\": \"%s\",\n", tsbuf);
>  	fprintf(f, "  \"sysinfo\": {\n");
> @@ -573,7 +605,8 @@ void rt_write_json(const char *filename, int argc, char *argv[],
>  
>  	fprintf(f, "}\n");
>  
> -	free(cmdline);
> +	if (!rt_init_run)
> +		free(cmdline);
>  
>  	if (!filename || strcmp("-", filename))
>  		fclose(f);
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

But I don't like the name, it's not initing any test state, it's copying 
the command line, and the name should reflect that.
