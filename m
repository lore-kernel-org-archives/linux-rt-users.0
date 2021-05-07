Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2400DC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 17:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD6561463
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 17:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbhEGRBe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 13:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhEGRBa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 13:01:30 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F85AC061761
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 10:00:29 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q127so9158356qkb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VQwfI+GjP6AJbLNO05C7sBqZjoPPDU8l9CmlX0F9ggQ=;
        b=goXjakACLAaiaNCDiFkPdOAWkidd28xGcWlv5mABl5uk5gRem76Iq5k9c0+aRKxALm
         aHYuycLu7/K/MHc8KiXJ1Yd4IE/HvAMnCP05XGncMp4Ri1uRDEWIbywcIHXU9CrvwKMp
         rMqO4ihXzB98mx7bMwYr0pA2j8G3Nk45vn42nMYZFwq+30o7dHLye/Eu0KM+8U2b465h
         PydfB4qpo6/6LcxMxfh4UHilAkocLihRnl00alURMBYBFoJKGuAsop9cMxv2pDsgwy1+
         QZp7J80Qz3vVepLQhFNr8sUljnOdsi6SFDBP9QUQg+A6jvndqyKfUPERKDUdQ+J8U1b1
         k8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=VQwfI+GjP6AJbLNO05C7sBqZjoPPDU8l9CmlX0F9ggQ=;
        b=WlC0kzW1+eHCZBt8hOG0h6ryH1DegvfDsX3qXuah7OOmwq4xvO2V7CWSsXu3jC7buk
         xg/9wNjFiRY8I7C53TVuquKqDtb3d3FYqPhNPh8sRCsH/8+B4FiGUA2yso5WWBeqNYpS
         5fGSw1455l3S1ckTqYg2tvOirFZuEzMtuhljAz3as6UIM9WXSuo4GUuV+BNkL6pbRjX1
         VpzFTMbCDjSQD+FzueX8vLlwerDfrcQEukHM2nZ0KnbEy5s23BYpZ9pZGoRHKogdF/Sc
         znfCC1U7AF3dyUafoM255ETF0EvrTVd9rujDJ/rXmylRIrK5EZO8j5hyeQG2NraOaH6k
         W0Ew==
X-Gm-Message-State: AOAM530j9l10VUHFxjbMXVHnN35zUU4nn1T5j4ZQST4aw24yVp5GjcLn
        AGOPesENMTaRdnqSpO+IXjQ=
X-Google-Smtp-Source: ABdhPJxs6PimPiejzvHFAv6qcfGXPpoH2Jhwf7+ySuEk2zlZwJi0ZYCXxkWul9zxhvjlsqIDY3avEQ==
X-Received: by 2002:a37:a287:: with SMTP id l129mr1115349qke.481.1620406828612;
        Fri, 07 May 2021 10:00:28 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id y29sm5267346qtm.13.2021.05.07.10.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 10:00:28 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 13:00:27 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 33/33] ssdd: Add JSON output feature
In-Reply-To: <20210320183829.1318-34-dwagner@suse.de>
Message-ID: <1fa331bb-3a85-20aa-6cad-33b54657ea17@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-34-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Write the test results as JSON output to a file. This allows to
> simplifies any parsing later on.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ssdd/ssdd.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/src/ssdd/ssdd.c b/src/ssdd/ssdd.c
> index 50bec824b2e8..3ead14d0127e 100644
> --- a/src/ssdd/ssdd.c
> +++ b/src/ssdd/ssdd.c
> @@ -36,6 +36,8 @@
>  #include <sys/wait.h>
>  #include <sys/ptrace.h>
>  
> +#include "rt-utils.h"
> +
>  /* do_wait return values */
>  #define STATE_EXITED	1
>  #define STATE_STOPPED	2
> @@ -65,10 +67,11 @@ static const char *get_state_name(int state)
>  #define unused __attribute__((unused))
>  
>  static int quiet;
> +static char outfile[MAX_PATH];
>  
>  static int got_sigchld;
>  
> -enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_QUIET };
> +enum option_value { OPT_NFORKS=1, OPT_NITERS, OPT_HELP, OPT_OUTPUT, OPT_QUIET };
>  
>  static void usage(int error)
>  {
> @@ -77,6 +80,7 @@ static void usage(int error)
>  	       "ssdd <options>\n\n"
>  	       "-f       --forks=NUM       number of forks\n"
>  	       "-h       --help            print this message\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       "-q       --quiet           suppress running output\n"
>  	       "-i       --iters=NUM       number of iterations\n"
>  	       );
> @@ -295,12 +299,14 @@ int main(int argc, char **argv)
>  
>  	setbuf(stdout, NULL);
>  
> +	rt_init(argc, argv);
>  	for (;;) {
>  		int option_index = 0;
>  
>  		static struct option long_options[] = {
>  			{"forks",		required_argument,	NULL, OPT_NFORKS},
>  			{"help",		no_argument,		NULL, OPT_HELP},
> +			{"output",		required_argument,	NULL, OPT_OUTPUT},
>  			{"quiet",		no_argument,		NULL, OPT_QUIET},
>  			{"iters",		required_argument,	NULL, OPT_NITERS},
>  			{NULL, 0, NULL, 0},
> @@ -317,6 +323,9 @@ int main(int argc, char **argv)
>  		case OPT_HELP:
>  			usage(0);
>  			break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		case OPT_QUIET:
>  		case 'q':
>  			quiet = 1;
> @@ -348,6 +357,7 @@ int main(int argc, char **argv)
>  			forktests(i);
>  	}
>  
> +	rt_test_start();
>  	for (i = 0; i < nforks; i++) {
>  		status = do_wait(&wait_pid, &ret_sig);
>  		if (status != STATE_EXITED) {
> @@ -363,5 +373,9 @@ int main(int argc, char **argv)
>  	printf("%s.\n", error ?
>  		"One or more tests FAILED" :
>  		"All tests PASSED");
> +
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, error, NULL, NULL);
> +
>  	exit(error);
>  }
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
