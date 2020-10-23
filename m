Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BB0C55178
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332A720BED
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3s/WtOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbgJWSkb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbgJWSkb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:40:31 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B4C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:40:29 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id 140so2119050qko.2
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hOFKreiTphtxIfVzZgm5ClVfGZsyLIPpTC4PVvop2as=;
        b=e3s/WtODzuF6vlAOmZygR2ZaY6srcKPPLrfchaFNq3FHc+khZdOqZl4jSK5K04M8sS
         7CQJoYjlVb865lmmGCNYxQjPuLT7vlKiEtrlLByIEtcvMb7XZRIaCvkGe/go+mzO4dqa
         TDDUx33J37LWFtyEI3ENuKLr3KUUYRbW54DmdJNxUyLcHgyt/98cx0ZSNRBAMs1LlZ9A
         wBG1PFLJhH113L2bvalXkTiWG45Rry8t78h+LFI251R7ASK8bMhg+Ie4NcGrzVQG8rzl
         SywV97xGdhKn2Cl9OuEsOjZQasczXa5ei1xqCfbgzB64c4eyD2V0+FwhAfcNIjXTP0o+
         fJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=hOFKreiTphtxIfVzZgm5ClVfGZsyLIPpTC4PVvop2as=;
        b=Jflu3Zi4cZF+yhEc5dIEzU2GeG3nlpswbaZVyl06Z6aSGI5jWPaFBSboViS1llMHzX
         JYRWSfX1hUpRwij2NQw5BEMrzmzRKz6appAjMsfbfZgKNnBndtQOV0H3O8iOKA9bDr+p
         JcWIKVaKUdYOkJxrNfzjVIi7oeuu/OgfQn2uM4iHOBWAQ0UiYdHJdgQuqFGsJjZ3CJBu
         J8+J/c6rSZAUXLlP+oy8c9CrSwfZAcxDSUaGngehieQ9kzeu9hbpIWE23nzd09zLAZDZ
         JJqnUpIPRJlPfxT65Vxbkv30Yqo0tii5MCZ+fh4Xre7d8rhxbaNVWXCW/YFDXJ8Lmm94
         LpjQ==
X-Gm-Message-State: AOAM533dumFxO9bvRKPmniX2VkwTMKEIybI1WPufGv2kfzvb9vwb5Yc9
        pzfmCA8Asjf4y3eA7DhJiAA=
X-Google-Smtp-Source: ABdhPJyCwKNL1Di8O4NP5Wetb0nSZok0gtlV3UpTaxYg2CiuzMo/yFFzrE41oB+x6n5Un8WxMVlFrQ==
X-Received: by 2002:ae9:eb0e:: with SMTP id b14mr3737676qkg.39.1603478428780;
        Fri, 23 Oct 2020 11:40:28 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id c206sm1315696qkg.106.2020.10.23.11.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:40:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:40:27 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 12/18] queuelat: Streamline usage and man page
In-Reply-To: <20201007085653.11961-13-dwagner@suse.de>
Message-ID: <10cde065-80c5-b5b-25b8-faaa6bfa8ed3@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-13-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/queuelat/queuelat.8 | 41 +++++++----------
>  src/queuelat/queuelat.c | 99 +++++++++++++++++++----------------------
>  2 files changed, 62 insertions(+), 78 deletions(-)
> 
> diff --git a/src/queuelat/queuelat.8 b/src/queuelat/queuelat.8
> index f67a0bb7556e..2f99e703c990 100644
> --- a/src/queuelat/queuelat.8
> +++ b/src/queuelat/queuelat.8
> @@ -15,9 +15,8 @@
>  .SH NAME
>  queuelat \- Queue latency test program
>  .SH SYNOPSIS
> -.B queuelat
> -.RI "[\-h] [\-m " max-queue-len "] [\-c " cycles-per-packet "] [\-p " mpps "] [\-f " tsc-freq "] [\-t " timeout "] \
> -
> +.LP
> +queuelat [-c|--cycles N] [-f|--freq F] [-h|--help] [-m|--max-len LEN] [-p|--packets F] [-q|--queue-len N] [-t|--timeout TIME]
>  .SH DESCRIPTION
>  queuelat simulates a network queue checking for latency
>  violations in packet processing.
> @@ -25,36 +24,26 @@ violations in packet processing.
>  .SH OPTIONS
>  A summary of options is included below.
>  .TP
> -.B \-h
> -Show help
> -.br
> +.B \-c, \-\-cycles=N
> +Estimated number of cycles it takes to process one packet. This value should come from the envisioned packet forwarding application being simulated.
>  .TP
> -.B \-m max-queue-len
> -Maximum allowed latency, in nanoseconds. If latency to process
> -.br
> -any packet exceeds this value, the program quits,
> -writing
> -.br
> -a message to the trace buffer.
> +.B \-f, \-\-freq=F
> +TSC frequency in MHz.
>  .TP
> -.B \-c cycles-per-packet
> -Estimated number of cycles it takes to process one packet.
> -.br
> -This value should come from the envisioned packet
> -.br
> -forwarding application being simulated.
> +.B \-h, \-\-help
> +Show help
>  .TP
> -.B \-p mpps
> +.B \-m, \-\-max-len=N
> +Maximum allowed latency, in nanoseconds. If latency to process any packet exceeds this value, the program quits, writing a message to the trace buffer.
> +.TP
> +.B \-p, \-\-packets=F
>  Million packets per second that arrive for processing.
>  .TP
> -.B \-f tsc-freq-mhz
> -TSC frequency in MHz.
> +.B \-q, \-\-queue-len=N
> +Minimum queue length to print in the trace
>  .TP
> -.B \-t timeout
> +.B \-t, \-\-timeout=TIME
>  Timeout in seconds to quit the program.
> -.TP
> -.B \-q min_queue_len_to_print_trace
> -Minimum queue length to print in the trace
>  
>  .SH AUTHOR
>  queuelat was written by Marcelo Tosatti <mtosatti@redhat.com>
> diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
> index 2b9118d8a8a5..661e48db88ac 100644
> --- a/src/queuelat/queuelat.c
> +++ b/src/queuelat/queuelat.c
> @@ -16,6 +16,7 @@
>  #include <unistd.h>
>  #include <signal.h>
>  #include <time.h>
> +#include <getopt.h>
>  
>  #include "rt-utils.h"
>  
> @@ -560,17 +561,20 @@ int calculate_nr_packets_drain_per_block(void)
>  	return nr_packets_drain_per_block;
>  }
>  
> -
> -void print_help(void)
> +static void print_help(int error)
>  {
> -	printf("usage: queuelat [options]\n");
> -	printf("-h show this help menu\n");
> -	printf("-m max-queue-len (maximum latency allowed, in nanoseconds) (int)\n");
> -	printf("-c cycles-per-packet (number of cycles to process one packet (int)\n");
> -	printf("-p million-packet-per-sec (million packets per second) (float)\n");
> -	printf("-f tsc-freq-mhz (TSC frequency in MHz) (float)\n");
> -	printf("-t timeout (timeout, in seconds) (int)\n");
> -	printf("-q min_queue_len_to_print_trace (int)\n");
> +	printf("queuelat V %1.2f\n", VERSION);
> +	printf("Usage:\n"
> +	       "queuelat <options>\n\n"
> +	       "-c N     --cycles N        number of cycles to process one packet (int)\n"
> +	       "-f F     --freq F          TSC frequency in MHz (float)\n"
> +	       "-h       --help            show this help menu\n"
> +	       "-m LEN   --max-len LEN     maximum latency allowed, in nanoseconds (int)\n"
> +	       "-p F     --packets F       million packets per second (float)\n"
> +	       "-q N     --queue-len N     minimum queue len to print trace (int)\n"
> +	       "-t TIME  --timeout TIME    timeout, in seconds (int)\n"
> +	       );
> +	exit(error);
>  }
>  
>  int main(int argc, char **argv)
> @@ -584,61 +588,59 @@ int main(int argc, char **argv)
>  	char *tvalue = NULL;
>  	char *qvalue = NULL;
>  	int index;
> -	int c;
> -
> -	install_signals();
>  
>  	opterr = 0;
>  
> -	while ((c = getopt (argc, argv, "m:c:p:f:t:q:h")) != -1)
> -		switch (c)
> -		{
> -		case 'm':
> -			mvalue = optarg;
> +	for (;;) {
> +		static struct option options[] = {
> +			{"cycles",	required_argument,	NULL, 'c'},
> +			{"freq",	required_argument,	NULL, 'f'},
> +			{"help",	no_argument,		NULL, 'h'},
> +			{"max-len",	required_argument,	NULL, 'm'},
> +			{"packets",	required_argument,	NULL, 'p'},
> +			{"queue-len",	required_argument,	NULL, 'q'},
> +			{"timeout",	required_argument,	NULL, 't'},
> +			{NULL, 0, NULL, 0}
> +		};
> +		int c = getopt_long(argc, argv, "c:f:hm:p:q:t:", options, NULL);
> +		if (c == -1)
>  			break;
> +		switch (c) {
>  		case 'c':
>  			cvalue = optarg;
>  			break;
> -		case 'p':
> -			pvalue = optarg;
> -			break;
>  		case 'f':
>  			fvalue = optarg;
>  			break;
> -		case 't':
> -			tvalue = optarg;
> +		case '?':
> +		case 'h':
> +			print_help(0);
> +			break;
> +		case 'm':
> +			mvalue = optarg;
> +			break;
> +		case 'p':
> +			pvalue = optarg;
>  			break;
>  		case 'q':
>  			qvalue = optarg;
>  			break;
> -		case 'h':
> -			print_help();
> -			return 0;
> -		case '?':
> -			if (optopt == 'm' || optopt == 'c' || optopt == 'p' ||
> -			    optopt == 'f' || optopt == 't' || optopt == 'q') {
> -				printf ("Option -%c requires an argument.\n", optopt);
> -			} else if (isprint (optopt)) {
> -				printf ("Unknown option `-%c'.\n", optopt);
> -				print_help();
> -				return 1;
> -			} else {
> -				printf ( "Unknown option character `\\x%x'.\n", optopt);
> -				print_help();
> -				return 1;
> -			}
> +		case 't':
> +			tvalue = optarg;
>  			break;
>  		default:
> -			abort ();
> +			print_help(1);
> +			break;
>  		}
> +	}
>  
> -	if (mvalue == NULL || cvalue == NULL || pvalue == NULL ||
> -	    fvalue == NULL) {
> -		printf("options -m, -c, -p and -f are required.\n");
> -		printf("usage: %s -m maxlatency -c cycles_per_packet -p mpps(million-packet-per-sec) -f tsc_freq_mhz [-t timeout (in secs)] [-q min_queue_len_to_print_trace]\n", argv[0]);
> -		return 1;
> +	if (mvalue == NULL || cvalue == NULL || pvalue == NULL || fvalue == NULL) {
> +		printf("options -m, -c, -p and -f are required\n");
> +		exit(1);
>  	}
>  
> +	install_signals();
> +
>  	maxlatency = atoi(mvalue);
>          cycles_per_packet = atoi(cvalue);
>          mpps = atof(pvalue);
> @@ -654,13 +656,6 @@ int main(int argc, char **argv)
>  		min_queue_size_to_print = atoi(qvalue);
>  	}
>  
> -	if (optind != argc) {
> -		for (index = optind; index < argc; index++) {
> -			printf ("Error, non-option argument %s\n", argv[index]);
> -		}
> -		return 1;
> -	}
> -
>  	convert_to_ghz(tsc_freq_mhz);
>  
>  	max_queue_len_f = maxlatency / (cycles_per_packet*cycles_to_ns);
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
