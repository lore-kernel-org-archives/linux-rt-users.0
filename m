Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9642C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB476145D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhEGQ7T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236622AbhEGQ7I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:59:08 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7646DC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:58:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id p6so7062427qtk.13
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cV6eG4pMLYU8mlotfJhkYovT9Bh7oYL13b4T46lvyTU=;
        b=aHF8jie395lQLOJlDHDjyWQJp5pK/uzFlwkuFpD33WEpO/QjyUFTkgnH5M2w9ce31+
         +o9+z+0YVpsvr/t6ceW5DXy3EuQjRPq9MYbNpMkgh8BMZQ1elPOXRgU5odGIciM7FTsx
         r7kFaqmw1+foj1Tm+18zALg4BP6ZYTBSTEzSJQ/9OMK0cFJXmlyCtNW9sg8V/7grbeLk
         d2lHTrIX7yEwRGQlWYvxUMEl0BOyCOJhpv+/9+EuvUchRDsEqIzu2DpWpTLRQk50Tq4U
         hY6fls+axorz77WHAB43Rg3I+pKa8LtTKknsr9H9AWCtGpdbdhqMJGWD1/MP0ajpdjUg
         zu7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=cV6eG4pMLYU8mlotfJhkYovT9Bh7oYL13b4T46lvyTU=;
        b=RT76XdRVMxr+w/XqpMAKJ4ss+1NpsiLaDsMw2ohiNpgsSSoJnp/antxF739qTR3Flk
         0jtemmnh1MzefhBg9l1Mnk/InhqZ01E/zP33JWoNOm5wuwX8LFArMMvW/Mw3VIx8lF09
         csnnENgQmAx/TCLPCkUm5wqHsezPjbDd2LtFsGZrnGzq7K6FvKt8pY5/x0kErv80oMny
         FF1SbfktWx/89C8AgdmeUVFUTDfSIt8gkc25BWyJssNUIul9st6o7h81Paf/J4pr2VIV
         XDmaOkwaNg+j3LQosEJGgpurCqgHtmIr8WMUSaiCHG1s+Wf7QecvTGiJFtVdfbUEJZcs
         YIHg==
X-Gm-Message-State: AOAM532r6MiMqbiy9j3zCf6vk9MJbynM5ElVWqXqwRFQkHVl3l8AibU/
        MgeEAuIDSnV9mtgPzSNnR6s=
X-Google-Smtp-Source: ABdhPJzBxUXYjLaYILY7TL6Xx/gVYtRvICqhQtdligAJTFYtTBgbO5aRue1kbzAYrMZbj6PjUsiuwg==
X-Received: by 2002:ac8:7252:: with SMTP id l18mr10317913qtp.78.1620406687754;
        Fri, 07 May 2021 09:58:07 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id j9sm6477503qtl.15.2021.05.07.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:58:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:58:05 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 29/33] pip_stress: Add JSON output feature
In-Reply-To: <20210320183829.1318-30-dwagner@suse.de>
Message-ID: <2f3f7246-455f-42cd-e580-8a2c9a81c94c@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-30-dwagner@suse.de>
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
>  src/pi_tests/pip_stress.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 0831f698ff1d..f6096a2de273 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -67,18 +67,21 @@ struct State *statep;
>  const int policy = SCHED_FIFO;
>  static int prio_min;	/* Initialized for the minimum priority of policy */
>  
> +static char outfile[MAX_PATH];
> +
>  static void usage(int error)
>  {
>  	printf("pip_stress V %1.2f\n", VERSION);
>  	printf("Usage:\n"
>  	       "pip_stress <options>\n"\
> -	       "-h	--help                  Show this help menu.\n"
> +	       "-h	 --help            Show this help menu.\n"
> +	       "         --output=FILENAME write final results into FILENAME, JSON formatted\n"
>  	       );
>  	exit(error);
>  }
>  
>  enum option_values {
> -	OPT_HELP=1
> +	OPT_HELP=1, OPT_OUTPUT,
>  };
>  
>  int main(int argc, char *argv[])
> @@ -89,9 +92,11 @@ int main(int argc, char *argv[])
>  	int res;
>  	int *minimum_priority = (int*)&prio_min;
>  
> +	rt_init(argc, argv);
>  	for (;;) {
>  		struct option long_options[] = {
>  			{"help",	no_argument,		NULL, OPT_HELP},
> +			{"output",	required_argument,	NULL, OPT_OUTPUT },
>  			{NULL,		0,			NULL, 0}
>  		};
>  
> @@ -103,6 +108,9 @@ int main(int argc, char *argv[])
>  		case 'h':
>  			usage(0);
>  			break;
> +		case OPT_OUTPUT:
> +			strncpy(outfile, optarg, strnlen(optarg, MAX_PATH-1));
> +			break;
>  		default:
>  			usage(1);
>  			break;
> @@ -145,6 +153,7 @@ int main(int argc, char *argv[])
>  		err_exit(err, NULL);
>  	}
>  
> +	rt_test_start();
>  	pid1 = fork();
>  	if (pid1 == -1) {
>  		perror("fork");
> @@ -165,6 +174,9 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (strlen(outfile) != 0)
> +		rt_write_json(outfile, !statep->inversion, NULL, NULL);
> +
>  	if (!statep->inversion) {
>  		printf("No inversion incurred\n");
>  		exit(1);
> -- 
> 2.30.2
> 
> 

I'm not opposed to json in this test in general, but need to think more 
about how this should look. Omiting for now, but I might be amendable in 
the future.

thanks

John
