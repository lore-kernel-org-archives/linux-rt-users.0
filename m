Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0778C55178
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7B320E65
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpSgU2Wu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465902AbgJWSrz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462467AbgJWSrz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:47:55 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38FC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:47:55 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 188so2110785qkk.12
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=liAaHnnQC1McxI4ECLhC2Qz6+0iuzIre5AqZYgSvWWU=;
        b=QpSgU2WuRIiW06dUF/Tz5/+Z1LOF/tuKNVd21pC1RFnyf4hdc+/2nIrFqG9t9rBVKX
         ji3VY61PB060snGqBf5NWkOKKTUDeeQMj15NP3tjxpSQaaqos4EDIkMhWKCaPpV1yIar
         RPC3au5EcQJXagy11LHgyqMXcgqN1RpP1WZ2e3OsM6N0f7iMIFKwZw8vEyBEufGWgqXa
         tlxBROis73Ark4mtJs2CwIoO0O6fRiZ1YKDXBgNBr5YDu+0NRIn9VtNyszaQeLViw7JS
         ZIwMgZ1vUoEgswsLPdbWIoXwjlbdz39YimX+Gpmt9Jn4duC+/gLvnAanJ5yU9hOrkToL
         morA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=liAaHnnQC1McxI4ECLhC2Qz6+0iuzIre5AqZYgSvWWU=;
        b=jclqeqaD0qbQFSJB+atpcK1GLIYVhJ/9n9rx4H7S3zHvr2oBn8MlajVma+qXvHAwz1
         wkJ/InNW7s85d3vtP00/XiE902g19Zlx3qP74VTTpWCyJXePm9NVmHLgFrhEoK3QTjmM
         GW1WFZ3qtno/9uNrYZJH39KQ8pY+VJLRmL+1p4e2zyETp/brFoawEBcttnS1zjexd7hX
         CBKfEdhB/lLIEXJDhb2zdf9wvV8n3asCUcesuxIVAH/qWS3ygKCAFUYFR3k8/5TiUfEK
         OPgla0+k/S7wUOBNPKKnMV/0e+UTT+QpklQMg4AK/64SfYJwpswLxRex/3Po6m4978NW
         De+A==
X-Gm-Message-State: AOAM531UkIfqip2wBGdvfbb2bG16XnqT6fF88fUezspR65UAVWML0JIG
        UvADfOrjDLq0o+gNfR0IBgU=
X-Google-Smtp-Source: ABdhPJznYb6Q95V4tAwtpVC3mk9knuHbK2RS8Q7X3I9aX8tiFSMlhSGu6KlXXClyeCa/ZPOYt+rx8A==
X-Received: by 2002:a37:2795:: with SMTP id n143mr3726439qkn.321.1603478874484;
        Fri, 23 Oct 2020 11:47:54 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id f22sm1403747qtf.4.2020.10.23.11.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:47:53 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:47:52 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 13/18] rt-migrate-test: Streamline usage and man
 page
In-Reply-To: <20201007085653.11961-14-dwagner@suse.de>
Message-ID: <5a5eb6ec-aa76-dcba-43bd-1fc3822a1ea7@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-14-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/rt-migrate-test/rt-migrate-test.8 | 41 +++++++-------
>  src/rt-migrate-test/rt-migrate-test.c | 82 +++++++++++++--------------
>  2 files changed, 59 insertions(+), 64 deletions(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt-migrate-test.8
> index b9c07f1ed80a..5bbacb5333b8 100644
> --- a/src/rt-migrate-test/rt-migrate-test.8
> +++ b/src/rt-migrate-test/rt-migrate-test.8
> @@ -1,11 +1,11 @@
>  .\"
> -.TH RT-MIGRATE-TEST 8 "April 21, 2016"
> +.TH RT-MIGRATE-TEST 8 "September 18, 2020"
>  .\" Please adjust this date whenever editing this manpage
>  .SH NAME
>  rt-migrate-test \- real-time task migration program
>  .SH SYNOPSIS
> -.B rt-migrate-test 
> -.RI "[\-ceh] [\-p prio] [\-r time] [\-s time] [\-m time] [\-l loops] [nr_tasks]
> +.LP
> +rt-migrate-test [-c|--check] [-D|--duration TIME] [-e|--equal] [-h|--help] [-l|--loops LOOPS] [-m|--maxerr TIME] [-p|--prio PRIO] [-r|--run-time TIME] [-s|--sleep-time TIME] [NR_TASKS]
>  .SH DESCRIPTION
>  Test real-time multiprocessor scheduling of tasks to ensure the highest priority tasks are running on all available CPUs
>  .SH OPTIONS
> @@ -15,44 +15,43 @@ This program follows the usual GNU command line syntax, with long options starti
>  In the summary of options, a value in brackets (), indicates a default value
>  .br
>  .TP
> +.B \-c, \-\-check
> +Stop if lower prio task is quicker than higher (off)
> +.TP
>  .B \-D, \-\-duration=TIME
>  Specify a length for the test run.
>  .br
>  Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .TP
> -.B \-p, \-\-prio=prio
> -base priority to start RT tasks with (2)
> +.B \-e, \-\-equal
> +Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
>  .br
>  .TP
> -.B \-r, \-\-run\-time=time
> -Run time (ms) to busy loop the threads (20)
> +.B \-h, \-\-help
> +Display usage
>  .br
>  .TP
> -.B \-s, \-\-sleep\-time=time
> -Sleep time (ms) between intervals (100)
> +.B \-l \-\-loops=LOOPS
> +Number of iterations to run (50)
>  .br
>  .TP
> -.B \-m, \-\-maxerr=time
> +.B \-m, \-\-maxerr=TIME
>  Max allowed error (microsecs)
>  .br
>  .TP
> -.B \-l \-\-loops=loops
> -Number of iterations to run (50)
> -.br
> -.TP
> -.B \-e
> -Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
> +.B \-p, \-\-prio=PRIO
> +base priority to start RT tasks with (2)
>  .br
>  .TP
> -.B \-c, \-\-check
> -Stop if lower prio task is quicker than higher (off)
> +.B \-r, \-\-run\-time=TIME
> +Run time (ms) to busy loop the threads (20)
>  .br
>  .TP
> -.B \-h, \-\-help
> -Display usage
> +.B \-s, \-\-sleep\-time=TIME
> +Sleep time (ms) between intervals (100)
>  .br
>  .TP
> -.B [nr\-tasks]
> +.B [NR_TASKS]
>  number of tasks to run (number of cpus + 1)
>  .br
>  .SH AUTHOR
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 4863238edeb4..68824606faf1 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -146,71 +146,67 @@ static void print_progress_bar(int percent)
>  	fflush(stderr);
>  }
>  
> -static void usage(char **argv)
> +static void usage(int error)
>  {
> -	char *arg = argv[0];
> -	char *p = arg+strlen(arg);
> -
> -	while (p >= arg && *p != '/')
> -		p--;
> -	p++;
> -
> -	printf("%s %1.2f\n", p, VERSION);
> +	printf("rt-migrate-test %1.2f\n", VERSION);
>  	printf("Usage:\n"
> -	       "%s <options> nr_tasks\n\n"
> -	       "-p prio --prio  prio        base priority to start RT tasks with (2)\n"
> -	       "-r time --run-time time     Run time (ms) to busy loop the threads (20)\n"
> -	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
> -	       "-m time --maxerr time       Max allowed error (microsecs)\n"
> -	       "-l loops --loops loops      Number of iterations to run (50)\n"
> -	       "-D       --duration=TIME    specify a length for the test run.\n"
> -	       "                            Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
> -	       "-e                          Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
> -	       "-c    --check               Stop if lower prio task is quicker than higher (off)\n"
> -	       "-h    --help\n"
> -	       "  () above are defaults \n",
> -		p);
> -	exit(0);
> +	       "rt-migrate-test <options> [NR_TASKS]\n\n"
> +	       "-c       --check           Stop if lower prio task is quicker than higher (off)\n"
> +	       "-D TIME  --duration=TIME   Specify a length for the test run.\n"
> +	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
> +	       "                           days.\n"
> +	       "-e       --equal           Use equal prio for #CPU-1 tasks (requires > 2 CPUS)\n"
> +	       "-h       --help            Print this help message\n"
> +	       "-l LOOPS --loops=LOOPS     Number of iterations to run (50)\n"
> +	       "-m TIME  --maxerr=TIME     Max allowed error (microsecs)\n"
> +	       "-p PRIO  --prio=PRIO       base priority to start RT tasks with (2)\n"
> +	       "-r TIME  --run-time=TIME   Run time (ms) to busy loop the threads (20)\n"
> +	       "-s TIME  --sleep-time=TIME Sleep time (ms) between intervals (100)\n\n"
> +	       "  () above are defaults \n"
> +	       );
> +	exit(error);
>  }
>  
> -static void parse_options (int argc, char *argv[])
> +static void parse_options(int argc, char *argv[])
>  {
>  	for (;;) {
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"prio", required_argument, NULL, 'p'},
> -			{"run-time", required_argument, NULL, 'r'},
> -			{"sleep-time", required_argument, NULL, 's'},
> -			{"maxerr", required_argument, NULL, 'm'},
> -			{"loops", required_argument, NULL, 'l'},
> -			{"duration", required_argument, NULL, 'D'},
> -			{"check", no_argument, NULL, 'c'},
> -			{"help", no_argument, NULL, '?'},
> +			{"check",	no_argument,		NULL, 'c'},
> +			{"duration",	required_argument,	NULL, 'D'},
> +			{"equal",	no_argument,		NULL, 'e'},
> +			{"help",	no_argument,		NULL, 'h'},
> +			{"loops",	required_argument,	NULL, 'l'},
> +			{"maxerr",	required_argument,	NULL, 'm'},
> +			{"prio",	required_argument,	NULL, 'p'},
> +			{"run-time",	required_argument,	NULL, 'r'},
> +			{"sleep-time",	required_argument,	NULL, 's'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "p:r:s:m:l:D:ech",
> +		int c = getopt_long(argc, argv, "cD:ehl:m:p:r:s:",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> -		case 'p': prio_start = atoi(optarg); break;
> -		case 'r':
> -			run_interval = atoi(optarg);
> -			break;
> -		case 's': interval = atoi(optarg); break;
> -		case 'l': nr_runs = atoi(optarg); break;
> +		case 'c': check = 1; break;
>  		case 'D': duration = parse_time_string(optarg); break;
> -		case 'm': max_err = usec2nano(atoi(optarg)); break;
>  		case 'e': equal = 1; break;
> -		case 'c': check = 1; break;
>  		case '?':
>  		case 'h':
> -			usage(argv);
> +			usage(0);
>  			break;
> +		case 'l': nr_runs = atoi(optarg); break;
> +		case 'm': max_err = usec2nano(atoi(optarg)); break;
> +		case 'p': prio_start = atoi(optarg); break;
> +		case 'r':
> +			run_interval = atoi(optarg);
> +			break;
> +		case 's': interval = atoi(optarg); break;
> +		default:
> +			usage(1);
>  		}
>  	}
> -
>  }
>  
>  static unsigned long long get_time(void)
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
