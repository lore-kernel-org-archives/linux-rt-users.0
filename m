Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB0C55178
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAF820BED
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJo1QP/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbgJWSue (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbgJWSud (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:50:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A305C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:50:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id a23so2122534qkg.13
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=huWANSxnp/kv3zbJjklPstz1Insys2n8Wd3pIzELJtM=;
        b=JJo1QP/XglrfwJdt5qvrZ9H2f9ty0srJ16oemzo6LqTmhHZLJKZtQwxrYR1vOV+tIX
         27Ik3SryJB2MKiIMNJj5LlHMoRrcVGU5WkxYuLcbaw/CkWAySEzYfEpzbk1m5UAzV+Ac
         0RNwPwUP1S5DwuDKliRWjowyw1wGA5g8dMiVtvAS7yKpeAYitzJ1/WYmZ2HW6YkOgH9r
         C0m2ubjuKffgMP95DF35Aj+1thy4SSvascET9DCUmavoW8rFCA8IVg5yGlk3klwRfJ7T
         +12E2SBGhMGIqMcdCpOpmxFP9jm1NP1PKz249xyuGScs7UUrcjR0Oawh3xVY7v7504CE
         GRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=huWANSxnp/kv3zbJjklPstz1Insys2n8Wd3pIzELJtM=;
        b=AnXHh0GR8DtWIJfkebc/xoZfAXcq/0hXlYVArfPi5B9G2rrhmXVSrWZ4Qr0dANObas
         aSktuTerQZGj9g9Tdr3omSPClBcnHCpr9uFsYr/uJcXrc154kLZ85oHs/ST8AxhHNRhu
         o6VwoVbzTD3fZSERgrWWpES0PWiYwqdlBIcY2PkgVFl+KTbI9W0+sieAzBKQRb1HQnST
         N7U6rHZnljVo0NpxcZL3kGwpqhdh1rP16yMiR9q4nmftpvuobXdEcHWmRUwD+KJxdoA5
         4pZlpwtXYaSfwAPXqUx0AX0qUe/TeaNNg4ZyObCGZNxc8TUnIFudqGuL0Xp/gQT4bFTw
         9L8w==
X-Gm-Message-State: AOAM531Rvt+z6/DyKcMW/0jW0MAk3Ut4F/2Dk+Ldj0xBrEzQ/CcZFI3A
        MmstMgGplmv7W8LgSeRCxB7Wg7m5yUWowQ==
X-Google-Smtp-Source: ABdhPJyGiYVdZrH/hYF4ExeT2fEG46ssAexEn5kylrBNDTqEflVfNtkmUUZJHTJgvHas6t6Rh8VTUg==
X-Received: by 2002:a05:620a:235:: with SMTP id u21mr3820292qkm.500.1603479032836;
        Fri, 23 Oct 2020 11:50:32 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id o5sm1477425qtt.3.2020.10.23.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:50:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:50:31 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 14/18] signaltest: Streamline usage and man page
In-Reply-To: <20201007085653.11961-15-dwagner@suse.de>
Message-ID: <73d4c019-d694-b331-f369-1d9ddffa5722@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-15-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/signaltest/signaltest.8 | 13 +++++-----
>  src/signaltest/signaltest.c | 47 ++++++++++++++++++++-----------------
>  2 files changed, 32 insertions(+), 28 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
> index bd6ffe5c7a36..dc3eaab2293a 100644
> --- a/src/signaltest/signaltest.8
> +++ b/src/signaltest/signaltest.8
> @@ -1,11 +1,11 @@
>  .\"
> -.TH SIGNALTEST 8 "October 1, 2015"
> +.TH SIGNALTEST 8 "September 18, 2020"
>  .\" Please adjust this date whenever updating this manpage
>  .SH NAME
>  signaltest \- signal roundtrip test software
>  .SH SYNOPSIS
> -.B signaltest
> -.RI "[ \-b USEC ] [ \-l LOOPS ] [ \-p PRIO] [ \-q ] [ \-t NUM ] [ \-m ] [ \-v ] [ \-\-help ]"
> +.LP
> +signaltest [ -b|--backtrace USEC ] [-D|--duration TIME] [-h|--help] [-l|--loops LOOPS ] [-p|--prio PRIO] [-q|--quiet] [-t|--threads NUM] [-m|--mlockall ] [-v|--verbose ]
>  .SH OPTIONS
>  These programs follow the usual GNU command line syntax, with long options
>  starting with two dashes ('\-\-').
> @@ -18,6 +18,10 @@ Specify a length for the test run.
>  .br
>  Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .TP
> +.B \-\-help
> +.br
> +display usage information
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Number of loops: default=0 (endless)
>  .TP
> @@ -37,9 +41,6 @@ lock current and future memory allocations
>  output values on stdout for statistics
>  .br
>  format: n:c:v n=tasknum c=count v=value in us
> -.TP
> -.B \-\-help
> -display usage information
>  .SH AUTHOR
>  signaltest was written by Thomas Gleixner <tglx@linuxtronix.de>.
>  .PP
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index a67eddaf8420..c718f8676b9f 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -180,23 +180,25 @@ void *signalthread(void *param)
>  
>  
>  /* Print usage information */
> -static void display_help(void)
> +static void display_help(int error)
>  {
>  	printf("signaltest V %1.2f\n", VERSION);
>  	printf("Usage:\n"
>  		"signaltest <options>\n\n"
>  		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> -		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  		"-D       --duration=TIME   specify a length for the test run.\n"
> -		"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
> +		"                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
> +		"                           days.\n"
> +		"-h       --help            display usage information\n"
> +		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +		"-m       --mlockall        lock current and future memory allocations\n"
>  		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
>  		"-q       --quiet           print a summary only on exit\n"
>  		"-t NUM   --threads=NUM     number of threads: default=2\n"
> -		"-m       --mlockall        lock current and future memory allocations\n"
>  		"-v       --verbose         output values on stdout for statistics\n"
>  		"                           format: n:c:v n=tasknum c=count v=value in us\n"
> -		"--help			    display usage information\n");
> -	exit(0);
> +		);
> +	exit(error);
>  }
>  
>  static int priority;
> @@ -208,38 +210,39 @@ static int quiet;
>  static int lockall = 0;
>  
>  /* Process commandline options */
> -static void process_options (int argc, char *argv[])
> +static void process_options(int argc, char *argv[])
>  {
>  	int error = 0;
>  	for (;;) {
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"breaktrace", required_argument, NULL, 'b'},
> -			{"loops", required_argument, NULL, 'l'},
> -			{"duration", required_argument, NULL, 'D'},
> -			{"priority", required_argument, NULL, 'p'},
> -			{"quiet", no_argument, NULL, 'q'},
> -			{"threads", required_argument, NULL, 't'},
> -			{"verbose", no_argument, NULL, 'v'},
> -			{"mlockall", no_argument, NULL, 'm'},
> -			{"help", no_argument, NULL, '?'},
> +			{"breaktrace",		required_argument,	NULL, 'b'},
> +			{"duration",		required_argument,	NULL, 'D'},
> +			{"help",		no_argument,		NULL, 'h'},
> +			{"loops",		required_argument,	NULL, 'l'},
> +			{"mlockall",		no_argument,		NULL, 'm'},
> +			{"priority",		required_argument,	NULL, 'p'},
> +			{"quiet",		no_argument,		NULL, 'q'},
> +			{"threads",		required_argument,	NULL, 't'},
> +			{"verbose",		no_argument,		NULL, 'v'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "b:c:d:i:l:D:np:qrsmt:v",
> -			long_options, &option_index);
> +		int c = getopt_long(argc, argv, "b:D:hl:mp:qt:v",
> +				long_options, &option_index);
>  		if (c == -1)
>  			break;
>  		switch (c) {
>  		case 'b': tracelimit = atoi(optarg); break;
> -		case 'l': max_cycles = atoi(optarg); break;
>  		case 'D': duration = parse_time_string(optarg); break;
> +		case '?':
> +		case 'h': display_help(0); break;
> +		case 'l': max_cycles = atoi(optarg); break;
> +		case 'm': lockall = 1; break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 'q': quiet = 1; break;
>  		case 't': num_threads = atoi(optarg); break;
> -		case 'm': lockall = 1; break;
>  		case 'v': verbose = 1; break;
> -		case '?': error = 1; break;
>  		}
>  	}
>  
> @@ -253,7 +256,7 @@ static void process_options (int argc, char *argv[])
>  		error = 1;
>  
>  	if (error)
> -		display_help ();
> +		display_help(error);
>  }
>  
>  static void check_kernel(void)
> -- 
> 2.28.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
