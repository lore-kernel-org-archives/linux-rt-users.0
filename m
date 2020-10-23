Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B07C388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF1220EDD
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2nUCWfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbgJWS7X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbgJWS7X (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:59:23 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72ABC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:59:21 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id v200so2183342qka.0
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Z92Ii/p1zU2nwb7ed3zeQDzVX0tKdJQU2ge0oh/UU1U=;
        b=B2nUCWfZq4h8Fx6dsbsPJPxGDDPU1d9hwKlCXZHGRwaVo5FUIxvH+gQAwv+W8OQDBD
         e11r597XpCQ/O3fp34csZUXp8RTPaw5t8mv7MW+1MPLQmDm68Z66tIEowIZpYRhy+64v
         GKH7ndxa6ez7SB8Z28Ex+wl9VdqtW+xN2ep7GmLWEyvX9S3BMf0HWy+d7kVDm7SCBlhb
         yqnQd1I9bMYPwojWFkwfd7lvuEBisFdqpgi1UN0Yd+b4QibxIMk9+l7N14S4ExMWVm88
         dxrYQpJWFgI4WJvqbHcVmIAv6V5oFP0Sg4CRnTfU57RQF9xq1lloue2VPPMhaHdggGkt
         O16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Z92Ii/p1zU2nwb7ed3zeQDzVX0tKdJQU2ge0oh/UU1U=;
        b=Pv5muzAcbdmiAvtRetZF0OGgdigGeRJvhAIV/zkO9qT5itkKDUCEQXrtDYI6RyUL1A
         CwU3sYKekx/RZ43h29WI7SLUYBKKprrI66Vrhf9+zFtvQAa+lI1CHg/YaFAqpsANG7p3
         lb3fsDeIjiL2oF7ewGKgDcJZW6GdGpT37hGXf+9vTKJSBrCvXXAWUeTQLHVnymjvq6Lw
         c4QOWLuucya5WOG35Tq2U7yOq/t+5wzCXTdUwQyEaBGhK2zQLi/0FVBZYgw7ZH5Xb6yn
         xKMliecGIbVOaut17gT6IUY7eFu4m3t4kVUT9ij+LXJ0/zpCLHKmNeoapJxS8I+c4a+N
         OvIw==
X-Gm-Message-State: AOAM533DlDrE+fEFDqcfC4bYmykkzE7l3zvWijSJkY5DVKJ26Z/cBTLL
        z2GSij1lmtGMPR+owO5eTXsIvLZTJjWnfA==
X-Google-Smtp-Source: ABdhPJw2rbddvPUJsnT0hjT2ZnnS+ZoL4F4d/QVDns4RE6uh+JPu7IpzgD8j2f8ivCajrN/Tr8kVKQ==
X-Received: by 2002:ae9:f501:: with SMTP id o1mr3456772qkg.133.1603479560887;
        Fri, 23 Oct 2020 11:59:20 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z26sm1531030qtb.85.2020.10.23.11.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:59:20 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:59:19 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 17/18] svsematest: Streamline usage and man page
In-Reply-To: <20201007085653.11961-18-dwagner@suse.de>
Message-ID: <b64cb59b-8d6f-3743-fc-9ab4c17376a7@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-18-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/svsematest/svsematest.8 |  6 +--
>  src/svsematest/svsematest.c | 83 +++++++++++++++++++------------------
>  2 files changed, 46 insertions(+), 43 deletions(-)
> 
> diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
> index 98322c105803..5fcb96149bdd 100644
> --- a/src/svsematest/svsematest.8
> +++ b/src/svsematest/svsematest.8
> @@ -4,15 +4,15 @@
>  \fBsvsematest\fR \- Start two threads or fork two processes and measure the latency of SYSV semaphores
>  .SH "SYNTAX"
>  .LP
> -svsematest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
> +svsematest [-a|--affinity NUM] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
>  .br
>  .SH "DESCRIPTION"
>  .LP
>  The program \fBsvsematest\fR starts two threads or, optionally, forks two processes that are synchronized via SYSV semaphores and measures the latency between releasing a semaphore on one side and getting it on the other side.
>  .SH "OPTIONS"
>  .TP
> -.B \-a, \-\-affinity[=PROC]
> -Run on processor number PROC. If PROC is not specified, run on current processor.
> +.B \-a, \-\-affinity[=NUM]
> +Run on processor number NUM. If PROC is not specified, run on current processor.
>  .TP
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC. This is a debugging option to control the latency tracer in the realtime preemption patch.
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 607b397bf39e..7412168bd98a 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -218,33 +218,34 @@ union semun {
>  };
>  
>  
> -static void display_help(void)
> +static void display_help(int error)
>  {
>  	printf("svsematest V %1.2f\n", VERSION);
> -	puts("Usage: svsematest <options>");
> -	puts("Function: test SYSV semaphore latency");
> -	puts(
> -	"Options:\n"
> -	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
> -	"                           with NUM pin all threads to the processor NUM\n"
> -	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> -	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
> -	"-f       --fork            fork new processes instead of creating threads\n"
> -	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> -	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> -	"-D       --duration=TIME   specify a length for the test run.\n"
> -	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
> -	"-p PRIO  --prio=PRIO       priority\n"
> -	"-S       --smp             SMP testing: options -a -t and same priority\n"
> -        "                           of all threads\n"
> -	"-t       --threads         one thread per available processor\n"
> -	"-t [NUM] --threads=NUM     number of threads:\n"
> -	"                           without NUM, threads = max_cpus\n"
> -	"                           without -t default = 1\n");
> -	exit(1);
> +	printf("Usage:\n"
> +	       "svsematest <options>\n\n"
> +	       "Function: test SYSV semaphore latency\n\n"
> +	       "Avaiable options:\n"
> +	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
> +	       "                           with NUM pin all threads to the processor NUM\n"
> +	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> +	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
> +	       "-D       --duration=TIME   specify a length for the test run.\n"
> +	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
> +	       "                           days.\n"
> +	       "-f [OPT] --fork[=OPT]      fork new processes instead of creating threads\n"
> +	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +	       "-p PRIO  --prio=PRIO       priority\n"
> +	       "-S       --smp             SMP testing: options -a -t and same priority\n"
> +	       "                           of all threads\n"
> +	       "-t       --threads         one thread per available processor\n"
> +	       "-t [NUM] --threads[=NUM]   number of threads:\n"
> +	       "                           without NUM, threads = max_cpus\n"
> +	       "                           without -t default = 1\n"
> +	       );
> +	exit(error);
>  }
>  
> -
>  static int setaffinity = AFFINITY_UNSPECIFIED;
>  static int affinity;
>  static int priority;
> @@ -256,7 +257,7 @@ static int distance = 500;
>  static int smp;
>  static int sameprio;
>  
> -static void process_options (int argc, char *argv[])
> +static void process_options(int argc, char *argv[])
>  {
>  	int error = 0;
>  	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
> @@ -266,20 +267,20 @@ static void process_options (int argc, char *argv[])
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"affinity", optional_argument, NULL, 'a'},
> -			{"breaktrace", required_argument, NULL, 'b'},
> -			{"distance", required_argument, NULL, 'd'},
> -			{"fork", optional_argument, NULL, 'f'},
> -			{"interval", required_argument, NULL, 'i'},
> -			{"loops", required_argument, NULL, 'l'},
> -			{"duration", required_argument, NULL, 'D'},
> -			{"priority", required_argument, NULL, 'p'},
> -			{"smp", no_argument, NULL, 'S'},
> -			{"threads", optional_argument, NULL, 't'},
> -			{"help", no_argument, NULL, '?'},
> +			{"affinity",		optional_argument,	NULL, 'a'},
> +			{"breaktrace",		required_argument,	NULL, 'b'},
> +			{"distance",		required_argument,	NULL, 'd'},
> +			{"duration",		required_argument,	NULL, 'D'},
> +			{"fork",		optional_argument,	NULL, 'f'},
> +			{"help",		no_argument,		NULL, 'h'},
> +			{"interval",		required_argument,	NULL, 'i'},
> +			{"loops",		required_argument,	NULL, 'l'},
> +			{"priority",		required_argument,	NULL, 'p'},
> +			{"smp",			no_argument,		NULL, 'S'},
> +			{"threads",		optional_argument,	NULL, 't'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:St::h",
> +		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:St::",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -301,6 +302,7 @@ static void process_options (int argc, char *argv[])
>  			break;
>  		case 'b': thistracelimit = atoi(optarg); break;
>  		case 'd': distance = atoi(optarg); break;
> +		case 'D': duration = parse_time_string(optarg); break;
>  		case 'f':
>  			if (optarg != NULL) {
>  				wasforked = 1;
> @@ -312,9 +314,9 @@ static void process_options (int argc, char *argv[])
>  			} else
>  				mustfork = 1;
>  			break;
> +		case 'h': display_help(0); break;
>  		case 'i': interval = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
> -		case 'D': duration = parse_time_string(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 'S':
>  			smp = 1;
> @@ -333,8 +335,9 @@ static void process_options (int argc, char *argv[])
>  			else
>  				num_threads = max_cpus;
>  			break;
> -		case 'h': error = 1; break;
> -		case '?': error = 1; break;
> +		default:
> +			display_help(1);
> +			break;
>  		}
>  	}
>  
> @@ -365,7 +368,7 @@ static void process_options (int argc, char *argv[])
>  		tracelimit = thistracelimit;
>  	}
>  	if (error)
> -		display_help ();
> +		display_help(error);
>  }
>  
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
