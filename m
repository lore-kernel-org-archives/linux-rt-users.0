Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5073C4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3234D2192A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN8D/RgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754786AbgJWSZf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754784AbgJWSZe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:25:34 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1EC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:25:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f5so1162552qvx.6
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=NS//3SSCWba5cGLNRf98XQytET94DgIpjlVKjWh1R7I=;
        b=hN8D/RgOH0ENFVimtAo0DmI491kIKgkv1iySi+x9x9FF6jjCpr1tEbF96RsOCGjSwI
         XpCVVbSJYV6GCexz9dqWBkyJIr7zag8xTsYxhM62SjPraF4st/3s2fLZHUdTsfdCAIGT
         u91MKg/2LewJ6m1Opy2etXIfTFl4MHM1Y4j4aMCrjAPkkc4b9u/MZ8blu4nwtVOMc5ur
         JbsWRSdFRQ1hbEPp5TlXmr01OTsVcT5KexRrXrwNWXzXoB1astivB/mIdwp0SG3WoC7U
         cg++KdH2Cg6R4hvzTilHTWjuF7ruwlp158EmBiIPv5I9iH4JmCF9i8q6QTlsJyVmp+SP
         +8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=NS//3SSCWba5cGLNRf98XQytET94DgIpjlVKjWh1R7I=;
        b=rkz5GecHxi+nB4DipKjQQQMXzIr3Gt6LNVaqxHwwlcn2kRLqWrQDZe999kiLkp49Cu
         OjDabPlT7zlwcR7QaNEAI/17MwR/eCE6RYO3sQGH4WEXDCokebyzq8KQsqPEfYbfgf6N
         uQpBjTv83g4rzMwhM4cQU3apOjnLGpYErT29Q8BECubG50kTC3ePwtdd56DbY2gqjqTG
         uZyZIl3VCysSMmV1PUUuD/WN6G8OXO18zi8HrzJtJbWayiFs8Dk1LD68b/+3gIG1M8Gl
         n/mIn9KDdgAdOEQV/dZAmjt9HOYTMxNyJn4rZJ96K7oVz3qSy9268e2O/WCyFdGf3DCA
         vtfA==
X-Gm-Message-State: AOAM531vcGoDibKRcQW8Jl5gIcTHujK9PWEcQUXWn9plbAaQZ7kOyOzz
        wVA474XbSkJinGk28gBsV/Y=
X-Google-Smtp-Source: ABdhPJxSYaUsx6fRA12F2fNL1zT2ee3M6dXuF2jszTXkB9/xZAtb/2k1iKwEzW+Cm3kvhzZ2dzx/8g==
X-Received: by 2002:ad4:4d46:: with SMTP id m6mr117071qvm.60.1603477532231;
        Fri, 23 Oct 2020 11:25:32 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id p38sm1462770qtb.20.2020.10.23.11.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:25:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:25:31 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 11/18] ptsematest: Streamline usage output and man
 page
In-Reply-To: <20201007085653.11961-12-dwagner@suse.de>
Message-ID: <db60ad9f-85b3-0e4-68c6-6df2b1150e8@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-12-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ptsematest/ptsematest.8 |  5 ++-
>  src/ptsematest/ptsematest.c | 76 +++++++++++++++++++------------------
>  2 files changed, 44 insertions(+), 37 deletions(-)
> 
> diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
> index 5ee7d694d50d..05a0cdfd3657 100644
> --- a/src/ptsematest/ptsematest.8
> +++ b/src/ptsematest/ptsematest.8
> @@ -4,7 +4,7 @@
>  \fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
>  .SH "SYNOPSIS"
>  .LP
> -ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME][-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
> +ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -26,6 +26,9 @@ Specify a length for the test run.
>  .br
>  Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .TP
> +.B \-h, \-\-help
> +Print help message.
> +.TP
>  .B \-i, \-\-interval=INTV
>  Set the base interval of the thread(s) in microseconds (default is 1000 us). This sets the interval of the first thread. See also -d.
>  .TP
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index de8ea2fe1b0c..02919e3f5eef 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -141,29 +141,31 @@ void *semathread(void *param)
>  }
>  
>  
> -static void display_help(void)
> +static void display_help(int error)
>  {
>  	printf("ptsematest V %1.2f\n", VERSION);
> -	puts("Usage: ptsematest <options>");
> -	puts("Function: test POSIX threads mutex latency");
> -	puts(
> -	"Options:\n"
> -	"-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
> -	"                           with NUM pin all threads to the processor NUM\n"
> -	"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> -	"-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
> -	"-D       --duration=TIME   specify a length for the test run.\n"
> -	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
> -	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> -	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> -	"-p PRIO  --prio=PRIO       priority\n"
> -	"-S       --smp             SMP testing: options -a -t and same priority\n"
> -        "                           of all threads\n"
> -	"-t       --threads         one thread per available processor\n"
> -	"-t [NUM] --threads=NUM     number of threads:\n"
> -	"                           without NUM, threads = max_cpus\n"
> -	"                           without -t default = 1\n");
> -	exit(1);
> +	printf("Usage:\n"
> +	       "ptsematest <options>\n\n"
> +	       "Function: test POSIX threads mutex latency\n\n"
> +	       "Available options:\n"
> +	       "-a [NUM] --affinity        run thread #N on processor #N, if possible\n"
> +	       "                           with NUM pin all threads to the processor NUM\n"
> +	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> +	       "-d DIST  --distance=DIST   distance of thread intervals in us default=500\n"
> +	       "-D       --duration=TIME   specify a length for the test run.\n"
> +	       "                           Append 'm', 'h', or 'd' to specify minutes, hours or\n"
> +	       "                           days.\n"
> +	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
> +	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +	       "-p PRIO  --prio=PRIO       priority\n"
> +	       "-S       --smp             SMP testing: options -a -t and same priority\n"
> +	       "                           of all threads\n"
> +	       "-t       --threads         one thread per available processor\n"
> +	       "-t [NUM] --threads=NUM     number of threads:\n"
> +	       "                           without NUM, threads = max_cpus\n"
> +	       "                           without -t default = 1\n"
> +	       );
> +	exit(0);
>  }
>  
>  
> @@ -188,16 +190,16 @@ static void process_options (int argc, char *argv[])
>  		int option_index = 0;
>  		/** Options for getopt */
>  		static struct option long_options[] = {
> -			{"affinity", optional_argument, NULL, 'a'},
> -			{"breaktrace", required_argument, NULL, 'b'},
> -			{"distance", required_argument, NULL, 'd'},
> -			{"interval", required_argument, NULL, 'i'},
> -			{"loops", required_argument, NULL, 'l'},
> -			{"duration", required_argument, NULL, 'D'},
> -			{"priority", required_argument, NULL, 'p'},
> -			{"smp", no_argument, NULL, 'S'},
> -			{"threads", optional_argument, NULL, 't'},
> -			{"help", no_argument, NULL, '?'},
> +			{"affinity",	optional_argument,	NULL, 'a'},
> +			{"breaktrace",	required_argument,	NULL, 'b'},
> +			{"distance",	required_argument,	NULL, 'd'},
> +			{"duration",	required_argument,	NULL, 'D'},
> +			{"help",	no_argument,		NULL, 'h'},
> +			{"interval",	required_argument,	NULL, 'i'},
> +			{"loops",	required_argument,	NULL, 'l'},
> +			{"priority",	required_argument,	NULL, 'p'},
> +			{"smp",		no_argument,		NULL, 'S'},
> +			{"threads",	optional_argument,	NULL, 't'},
>  			{NULL, 0, NULL, 0}
>  		};
>  		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::h",
> @@ -222,9 +224,11 @@ static void process_options (int argc, char *argv[])
>  			break;
>  		case 'b': tracelimit = atoi(optarg); break;
>  		case 'd': distance = atoi(optarg); break;
> +		case 'D': duration = parse_time_string(optarg); break;
>  		case 'i': interval = atoi(optarg); break;
> +		case '?':
> +		case 'h': display_help(0); break;
>  		case 'l': max_cycles = atoi(optarg); break;
> -		case 'D': duration = parse_time_string(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 'S':
>  			smp = 1;
> @@ -243,9 +247,9 @@ static void process_options (int argc, char *argv[])
>  			else
>  				num_threads = max_cpus;
>  			break;
> -		case 'h':
> -			display_help();
> -		case '?': error = 1; break;
> +		default:
> +			display_help(1);
> +			break;
>  		}
>  	}
>  
> @@ -275,7 +279,7 @@ static void process_options (int argc, char *argv[])
>  		sameprio = 1;
>  
>  	if (error)
> -		display_help();
> +		display_help(error);
>  }
>  
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
