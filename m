Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6997C388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8E120E65
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drFKq1lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbgJWSwB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S463543AbgJWSwA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:52:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94357C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:52:00 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id z33so1743693qth.8
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=M7KwCaPxt8fwt9wFZjdUraa1lILual+DLH3awjUti7Q=;
        b=drFKq1luFYLuQVezVgcTKjFKjdUySN4PeH/EZe3eD1UbDYwC9sTMtb54PrwDywRtWv
         MIF/BB3ymO6jn70d6rdyikNr2hQ9zC4Hj12rnDmgQbKFQLTkyG/PN+0CZ8zHqGVsm9Px
         SfgUsYJM30xATf71uALJJdL/RIEF5ugEYmlVE/VkJHNjLpqTtFXwM4qyFCxT6Sr5wSkp
         GrdgodMR5ms7lDpOoKwZwv62+ZoNR7MkjNabHneD37fTMDobPECNTgNHZZR0IZID9Hi+
         X0srrwdvPbGovpc3h6FvPGW/Uj5seaq+gv4/lyq+ZK769L8FrhugJrRgdD/2xsg6zl/W
         NMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=M7KwCaPxt8fwt9wFZjdUraa1lILual+DLH3awjUti7Q=;
        b=UnTOyBlr3wJXLOsoIt6VrYRqa/y+HQa14FbudHyXgyxDr6CiMFKbvVJOKDQqdHUyDf
         DBrMYmdIEaIKISi1UIMwYrzet7rxmJxM7DK2xTCqzgcuTE9vXGr5Fl4ICyioJ5gBUCbl
         mEzp8Xr805xJMmt+tSJ6QN0G/U8T8eSz/29Nkk9UIhZRY16Igdw2aEJrvS/Ut+glufID
         dAdbVj6XQQELTxjIEfu8TUj9K7kcBbydkzp/lhDBSO/JM4L3ave+PuYkGZkkyzT+VoKH
         vg8AxBZkhb1TRTEv4hzdcu32ccU7PhBvQPdQXOOMuejk1JCy62nnDSBh6W4997FACxHF
         LvlQ==
X-Gm-Message-State: AOAM533TJpO+KfMzhG3i+4i2Rm5BJPtPfZzFprPW6102MPatKF7HWhZD
        Mj0GVjUWL6kX5marBL41+M8=
X-Google-Smtp-Source: ABdhPJzeEwwbb8t29LfhEIE8CaQzo5tQQRGRf++9zAzl1rXg0R4nfw/6nbFfuRj6woH6O6hDRTHLdQ==
X-Received: by 2002:aed:3163:: with SMTP id 90mr3808768qtg.225.1603479119733;
        Fri, 23 Oct 2020 11:51:59 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id u16sm1514151qth.42.2020.10.23.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:51:59 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:51:58 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 15/18] sigwaittest: Streamline usage and man page
In-Reply-To: <20201007085653.11961-16-dwagner@suse.de>
Message-ID: <1d31d031-10f2-583-c6c5-9c9c594fcd4c@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-16-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sigwaittest/sigwaittest.8 |  4 +-
>  src/sigwaittest/sigwaittest.c | 76 +++++++++++++++++++----------------
>  2 files changed, 44 insertions(+), 36 deletions(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.8 b/src/sigwaittest/sigwaittest.8
> index 2be9c03d05ca..a2dc1bc080a3 100644
> --- a/src/sigwaittest/sigwaittest.8
> +++ b/src/sigwaittest/sigwaittest.8
> @@ -4,7 +4,7 @@
>  \fBsigwaittest\fR \- Start two threads or fork two processes and measure the latency between sending and receiving a signal
>  .SH "SYNTAX"
>  .LP
> -sigwaittest [-a|-a PROC] [-b USEC] [-d DIST] [-f] [-i INTV] [-l loops] [-p PRIO] [-t|-t NUM]
> +sigwaittest [-a|--affinity PROC] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-t|--threads [NUM]]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -26,7 +26,7 @@ Specify a length for the test run.
>  .br
>  Append 'm', 'h', or 'd' to specify minutes, hours or days.
>  .TP
> -.B \-f, \-\-fork
> +.B \-f, \-\-fork[=OPT]
>  Instead of creating threads (which is the default), fork new processes
>  .TP
>  .B \-i, \-\-interval=INTV
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index e7393f791519..12b55e901ce5 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -206,28 +206,30 @@ void *semathread(void *param)
>  }
>  
>  
> -static void display_help(void)
> +static void display_help(int error)
>  {
>  	printf("sigwaittest V %1.2f\n", VERSION);
> -	puts("Usage: sigwaittest <options>");
> -	puts("Function: test sigwait() latency");
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
> -	"-t       --threads         one thread per available processor\n"
> -	"-t [NUM] --threads=NUM     number of threads:\n"
> -	"                           without NUM, threads = max_cpus\n"
> -	"                           without -t default = 1\n");
> -	exit(1);
> +	printf("Usage:\n"
> +	       "sigwaittest <options>\n\n"
> +	       "Function: test sigwait() latency\n\n"
> +	       "Available options:\n"
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
> +	       "-t       --threads         one thread per available processor\n"
> +	       "-t [NUM] --threads=NUM     number of threads:\n"
> +	       "                           without NUM, threads = max_cpus\n"
> +	       "                           without -t default = 1\n"
> +	       );
> +	exit(error);
>  }
>  
>  
> @@ -250,19 +252,19 @@ static void process_options (int argc, char *argv[])
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
> +			{"threads",		optional_argument,	NULL, 't'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:f::i:l:D:p:t::",
> +		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:t::",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -280,6 +282,7 @@ static void process_options (int argc, char *argv[])
>  			break;
>  		case 'b': thistracelimit = atoi(optarg); break;
>  		case 'd': distance = atoi(optarg); break;
> +		case 'D': duration = parse_time_string(optarg); break;
>  		case 'f':
>  			if (optarg != NULL) {
>  				wasforked = 1;
> @@ -291,9 +294,12 @@ static void process_options (int argc, char *argv[])
>  			} else
>  				mustfork = 1;
>  			break;
> +		case '?':
> +		case 'h':
> +			display_help(0);
> +			break;
>  		case 'i': interval = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
> -		case 'D': duration = parse_time_string(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 't':
>  			if (optarg != NULL)
> @@ -303,7 +309,9 @@ static void process_options (int argc, char *argv[])
>  			else
>  				num_threads = max_cpus;
>  			break;
> -		case '?': error = 1; break;
> +		default:
> +			display_help(1);
> +			break;
>  		}
>  	}
>  
> @@ -331,7 +339,7 @@ static void process_options (int argc, char *argv[])
>  		tracelimit = thistracelimit;
>  	}
>  	if (error)
> -		display_help ();
> +		display_help (error);
>  }
>  
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
