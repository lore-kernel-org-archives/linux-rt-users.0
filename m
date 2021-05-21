Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD35C04FF3
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32394613AD
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 May 2021 21:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhEUVhA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 17:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60671 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhEUVg4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 17:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621632932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9B0LAOgaY5JWNROjw9oEmJICpmjoVNUggdOUK5kXGdY=;
        b=KECV4VEtCivO79OL8Lu4D7ctGaQ8/kDSbWl9m66C+BZgPBUPBx8JoG+supTJ7EnsVaWDF+
        f6mK2he73ggJcSYrQH6aOGF130mcPsUYu66HTq6H+A0XN3itfNAQihWI4+WVmO6uWQmAL/
        84SCdp5r39pgtSqS8T07mzCRMfHYvrU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-IoRfJjJVMwKrjG9usmXZmg-1; Fri, 21 May 2021 17:35:30 -0400
X-MC-Unique: IoRfJjJVMwKrjG9usmXZmg-1
Received: by mail-qk1-f199.google.com with SMTP id e8-20020a05620a2088b02903a5edeec4d6so7683012qka.11
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 14:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=9B0LAOgaY5JWNROjw9oEmJICpmjoVNUggdOUK5kXGdY=;
        b=iR/bZ+8Ncj73oo5fRGKxC4aDKAoVPtF1TZH0TD5Lju57vy8bMCKhhaIlhVSkH4hm5N
         pFjmrNZnVwfEJErtu7ES9QyiK4KqlzEWFMy9+I5kSRS8/f6NJpJkw5Nv7qGFNV3aBSrL
         Bp6VPpYyoelrWtPANzdO+qxeXpuxKjv2DeNx30R72XWep2UApJI+YU2V++Mgsdd3chTP
         wNND+Ic7PyRgFXq5C2W83xpHCJJyp+ZZlpfekIgQGPmtEDU5UN2jrnyXvXzgFt6fFqm/
         sh/1YPGKbOFdMp+U65oIOumFcyvlKntVHaD5f92cAs7amJ7TETifqi4//B2SekhBzMOd
         rtjw==
X-Gm-Message-State: AOAM531nSrhdAVABSYWYkyB8fA+EpG+kX1ZqwsLjGxRdiADzVL1j7IgB
        aIrhZC8DsdcCHGI/fFJGsyHUt/QqHDavUf4XuUJmZkbdR/CdD23LKEmlysnTZzQ4RB9hBiHxv3d
        9+K8npaW6qmtYuTISIf+6TxZE/TU=
X-Received: by 2002:ac8:5d16:: with SMTP id f22mr13651044qtx.84.1621632930295;
        Fri, 21 May 2021 14:35:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuA8mtoWIvqA5sC/MYx/VttSClGK1NfINL6hG+Oula2z7PEchX4bohDMPy3KwmCGe0+6+USQ==
X-Received: by 2002:ac8:5d16:: with SMTP id f22mr13651034qtx.84.1621632930111;
        Fri, 21 May 2021 14:35:30 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id d11sm6021109qkk.110.2021.05.21.14.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:35:29 -0700 (PDT)
Date:   Fri, 21 May 2021 17:35:28 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 03/23] oslat: Rename command line option
 --output to --json
In-Reply-To: <20210519170945.21941-4-dwagner@suse.de>
Message-ID: <16eee3dd-3067-49c1-5c9a-eaf61631846@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> The initial idea was to have several different output format
> supported but it turns out everyone is happy with JSON, so
> there is no need to add another format.
> 
> Thus let's make the command line option more specific and
> rename it to --json.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 37d528f0f7ff..32de951f27c0 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -174,7 +174,7 @@ struct global {
>  	int                   quiet;
>  	int                   single_preheat_thread;
>  	int                   output_omit_zero_buckets;
> -	char                  outfile[MAX_PATH];
> +	char                  jsonfile[MAX_PATH];
>  
>  	/* Mutable state. */
>  	volatile enum command cmd;
> @@ -560,6 +560,7 @@ static void usage(int error)
>  	       "-C, --cpu-main-thread  Specify which CPU the main thread runs on.  Default is cpu0.\n"
>  	       "-D, --duration         Specify test duration, e.g., 60, 20m, 2H\n"
>  	       "                       (m/M: minutes, h/H: hours, d/D: days)\n"
> +	       "    --json=FILENAME    write final results into FILENAME, JSON formatted\n"
>  	       "-f, --rtprio           Using SCHED_FIFO priority (1-99)\n"
>  	       "-m, --workload-mem     Size of the memory to use for the workload (e.g., 4K, 1M).\n"
>  	       "                       Total memory usage will be this value multiplies 2*N,\n"
> @@ -570,7 +571,6 @@ static void usage(int error)
>  	       "                       NOTE: please make sure the CPU frequency on all testing cores\n"
>  	       "                       are locked before using this parmater.  If you don't know how\n"
>  	       "                       to lock the freq then please don't use this parameter.\n"
> -	       "    --output=FILENAME  write final results into FILENAME, JSON formatted\n"
>  	       "-T, --trace-threshold  Stop the test when threshold triggered (in us),\n"
>  	       "                       print a marker in ftrace and stop ftrace too.\n"
>  	       "-v, --version          Display the version of the software.\n"
> @@ -597,8 +597,8 @@ static int workload_select(char *name)
>  
>  enum option_value {
>  	OPT_BUCKETSIZE=1, OPT_CPU_LIST, OPT_CPU_MAIN_THREAD,
> -	OPT_DURATION, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
> -	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS, OPT_OUTPUT,
> +	OPT_DURATION, OPT_JSON, OPT_RT_PRIO, OPT_HELP, OPT_TRACE_TH,
> +	OPT_WORKLOAD, OPT_WORKLOAD_MEM, OPT_BIAS,
>  	OPT_QUIET, OPT_SINGLE_PREHEAT, OPT_ZERO_OMIT,
>  	OPT_VERSION
>  };
> @@ -613,6 +613,7 @@ static void parse_options(int argc, char *argv[])
>  			{ "cpu-list",	required_argument,	NULL, OPT_CPU_LIST },
>  			{ "cpu-main-thread", required_argument, NULL, OPT_CPU_MAIN_THREAD},
>  			{ "duration",	required_argument,	NULL, OPT_DURATION },
> +			{ "json",	required_argument,      NULL, OPT_JSON },
>  			{ "rtprio",	required_argument,	NULL, OPT_RT_PRIO },
>  			{ "help",	no_argument,		NULL, OPT_HELP },
>  			{ "trace-threshold", required_argument,	NULL, OPT_TRACE_TH },
> @@ -621,7 +622,6 @@ static void parse_options(int argc, char *argv[])
>  			{ "bias",	no_argument,		NULL, OPT_BIAS },
>  			{ "quiet",	no_argument,		NULL, OPT_QUIET },
>  			{ "single-preheat", no_argument,	NULL, OPT_SINGLE_PREHEAT },
> -			{ "output",	required_argument,      NULL, OPT_OUTPUT },
>  			{ "zero-omit",	no_argument,		NULL, OPT_ZERO_OMIT },
>  			{ "version",	no_argument,		NULL, OPT_VERSION },
>  			{ NULL, 0, NULL, 0 },
> @@ -677,8 +677,8 @@ static void parse_options(int argc, char *argv[])
>  				exit(1);
>  			}
>  			break;
> -		case OPT_OUTPUT:
> -			strncpy(g.outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +		case OPT_JSON:
> +			strncpy(g.jsonfile, optarg, strnlen(optarg, MAX_PATH-1));
>  			break;
>  		case OPT_TRACE_TH:
>  		case 'T':
> @@ -862,8 +862,8 @@ int main(int argc, char *argv[])
>  
>  	write_summary(threads);
>  
> -	if (strlen(g.outfile) != 0)
> -		rt_write_json(g.outfile, 0, write_summary_json, threads);
> +	if (strlen(g.jsonfile) != 0)
> +		rt_write_json(g.jsonfile, 0, write_summary_json, threads);
>  
>  	if (g.cpu_list) {
>  		free(g.cpu_list);
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

