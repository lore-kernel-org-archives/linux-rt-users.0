Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A14C388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D9C20EDD
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6IWidsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751716AbgJWS50 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374707AbgJWS5Z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 14:57:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B53C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:57:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id k9so2165826qki.6
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GG/H40HFyHzrR8Bc2ec3eesFhTzw/xRFfgRtjE9fKJM=;
        b=N6IWidsw6dboaLsnI80DXihKY7+8wPwnPh9G4zMZljo+cPz3F2KatmN2y2I8STQsAW
         hPmmA3EP3MJG6ljoKcaJgLYpbwRNLOvARiuUSo+b04cYSrYn31sB8RkzHE3QzqQOOwM0
         jHzGD75kT2SM6WdTqylM+1yG2YVGPfRykIa+GhykVoQh6OaNNJVAWP4Y6paI9dPt0t2K
         Wv35dcpmlV6yf0TqBsN82wIsDwPmmQi9RCRzYks03XQJtCaDHMWLonCZ/bRM5O51VvWb
         hmVtF+X4RLsAWI7jqrzJ5kaoEUpIOQ7N6LZ4We/JFnzYQvzlSRBw+cnoRO2EPRj1wQkw
         6lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=GG/H40HFyHzrR8Bc2ec3eesFhTzw/xRFfgRtjE9fKJM=;
        b=k3c1mwEEseqyfUVkYTsyyL4klI3rwfwrnLcVMs2upNWAR9cgAbKYZUgX7L8D81VkdV
         UwtKKka2i4QvjrdjGuCsrpKn84JVhB4aIsc0QytAEu5+NZxSjy5arE8mgBzC84TDlgr+
         V1qD+6CDek1zEShd7tbCIwJZV3RIWEqLTcmRlAkGqzUuRsLjt5zZD0flBCtU4b4b/LQ1
         HVxlegLqC5rBljexvuq0TWBt6Vt01HJABYPJMAQxMYMfwf/zkJwB2m5ld177Yq3ElkCr
         B9vnQcWb8luj+m5DxGSZ49FzHtr5QcjQKHsrscqoYORHeppa6DgAZABZfVL1S28IZzXo
         eoTA==
X-Gm-Message-State: AOAM530RTtqalEIFV1xag8UQ3al4zyAANXaJDazFXNv6hnSqCeQPgbEy
        GJ1Nbj64IZzZUb9gIazyix8=
X-Google-Smtp-Source: ABdhPJwZAORgo/+29asPluHJVfQhFE/aYJiUyWVj27+OKH8rGWmX9nzYnwOAVqGlDNY3wwLPZzfd/A==
X-Received: by 2002:a37:46d0:: with SMTP id t199mr3555073qka.308.1603479444726;
        Fri, 23 Oct 2020 11:57:24 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id l125sm1396432qke.23.2020.10.23.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:57:24 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 14:57:23 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 16/18] ssdd: Streamline usage and man page
In-Reply-To: <20201007085653.11961-17-dwagner@suse.de>
Message-ID: <b6a0d556-a4b5-d9c2-e6a9-f3f69bf87961@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-17-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ssdd/ssdd.8 | 35 +++++++++++++++++-----------------
>  src/ssdd/ssdd.c | 50 +++++++++++++++++++++++++++----------------------
>  2 files changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
> index 99f30145d079..5c29d0abb732 100644
> --- a/src/ssdd/ssdd.8
> +++ b/src/ssdd/ssdd.8
> @@ -1,31 +1,30 @@
> -.TH SSDD 8 "June 13, 2019"
> +.TH SSDD 8 "September 19, 2020"
>  .SH NAME
>  ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
>  .SH SYNOPSIS
> -.B ssdd
> -.RI "<options>"
> +.LP
> +ssdd [-f|--forks NUM] [-h|--help] [-i|--iters NUM]
>  .SH DESCRIPTION
> -Have a tracer do a bunch of PTRACE_SINGLESTEPs against
> -a tracee as fast as possible.  Create several of these
> -tracer/tracee pairs and see if they can be made to
> -interfere with each other.
> -The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
> -and checks that waitpid's return values for correctness.
> +Have a tracer do a bunch of PTRACE_SINGLESTEPs against a tracee as
> +fast as possible. Create several of these tracer/tracee pairs and
> +see if they can be made to interfere with each other. The tracer
> +waits on each PTRACE_SINGLESTEP with a waitpid(2) and checks that
> +waitpid's return values for correctness.
>  .SH OPTIONS
> -.B \-f, \-\-forks
> -number of tracer/tracee pairs to fork off.
> -Default is 10.
> -.br
>  .TP
> -.B \-i, \-\-iters
> -number of PTRACE_SINGLESTEP iterations to
> -do before declaring success, for each tracer/
> -tracee pair set up. Default is 10,000.
> +.B \-f, \-\-forks=NUM
> +number of tracer/tracee pairs to fork off.
>  .br
> +Default is 10.
>  .TP
>  .B \-h, \-\-help
>  Display usage
> -
> +.TP
> +.B \-i, \-\-iters=NUM
> +number of PTRACE_SINGLESTEP iterations to do before declaring
> +success, for each tracer tracee pair set up.
> +.br
> +Default is 10,000.
>  .SH AUTHOR
>  ssdd was written by Joe Korty <joe.korty@concurrent-rt.com>
>  .PP
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index f165da96e23a..66d6009dc572 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -68,13 +68,16 @@ static int got_sigchld;
>  
>  enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP };
>  
> -static void usage()
> +static void usage(int error)
>  {
> -	printf("ssdd <options>\n");
> -	printf("\t-f --forks=<number of forks>\n");
> -	printf("\t-i --iters=<number of iterations>\n");
> -	printf("\t-h --help\n");
> -	exit(0);
> +	printf("ssdd V %1.2f\n", VERSION);
> +	printf("Usage:\n"
> +	       "ssdd <options>\n\n"
> +	       "-f       --forks=NUM       number of forks\n"
> +	       "-h       --help            print this message\n"
> +	       "-i       --iters=NUM       number of iterations\n"
> +	       );
> +	exit(error);
>  }
>  
>  static int do_wait(pid_t *wait_pid, int *ret_sig)
> @@ -292,27 +295,30 @@ int main(int argc, char **argv)
>  		int option_index = 0;
>  
>  		static struct option long_options[] = {
> -			{"forks", required_argument, NULL, OPT_NFORKS},
> -			{"iters", required_argument, NULL, OPT_NITERS},
> -			{"help", no_argument, NULL, OPT_HELP},
> +			{"forks",		required_argument,	NULL, OPT_NFORKS},
> +			{"help",		no_argument,		NULL, OPT_HELP},
> +			{"iters",		required_argument,	NULL, OPT_NITERS},
>  			{NULL, 0, NULL, 0},
>  		};
> -		int c = getopt_long(argc, argv, "f:i:h", long_options, &option_index);
> +		int c = getopt_long(argc, argv, "f:hi:", long_options, &option_index);
>  		if (c == -1)
>  			break;
>  		switch(c) {
> -			case 'f':
> -			case OPT_NFORKS:
> -				nforks = atoi(optarg);
> -				break;
> -			case 'i':
> -			case OPT_NITERS:
> -				nsteps = atoi(optarg);
> -				break;
> -			case 'h':
> -			case OPT_HELP:
> -				usage();
> -				break;
> +		case 'f':
> +		case OPT_NFORKS:
> +			nforks = atoi(optarg);
> +			break;
> +		case 'h':
> +		case OPT_HELP:
> +			usage(0);
> +			break;
> +		case 'i':
> +		case OPT_NITERS:
> +			nsteps = atoi(optarg);
> +			break;
> +		default:
> +			usage(1);
> +			break;
>  		}
>  	}
>  
> -- 
> 2.28.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
