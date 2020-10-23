Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F61EC4363A
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EED21527
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 17:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyW1NWaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461642AbgJWRdo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461616AbgJWRdo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 13:33:44 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B45C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 10:33:44 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id r8so1530493qtp.13
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 10:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=K67JeOxR95x4o1WyP3Jt9pfMzO8v2V1BJTfFbyuTLgY=;
        b=LyW1NWaZudGem2WznT/QYijkOCSeQyWW0CVhdebf9ntnvCIEObG2CJTLQBGJHdrJxu
         AlIbb3CAN4ICPkvlMVFgzbFXuudzOZ8CHPlm8Zrc+Xq+vjbSImd+YcmHVHKPn5FDY8J2
         d2CTui6c0ISRP6zsENPj1D6Kk6kcZ/P/bnzwZQVuUqu84/zejYsXRHxOpHemgngjQTg/
         X8eMvkRS849LgUfDjFfiPKgRV26++15mIs0O+ZmtgB8cu5xKzsGLiaEiRhFiEn620/Ol
         9OiiOGMZCKj8QhA+JF8P8YS/3x1q9oWbsVyetg3Nz/Ikh9l+xlQv/lJo7eXHTS8EClLR
         +qPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=K67JeOxR95x4o1WyP3Jt9pfMzO8v2V1BJTfFbyuTLgY=;
        b=ci5YUAykp9HSYjMr2+qw7tztLyFrjbUjqxe2SNuiEgbwjbO263lFAEdJHkuVp+iBcE
         qSWTC4vexCPAxjBEPAG9lPbefy6jYYDwkAcrwfNA/gpc6mB483EEp6WqNhzqmjC8sBZW
         aL/1wIwmjnx6XxHNud7if+3lsIveYOQo6UGbKqMJwr6SqvBwwj6FTmu5r0CmSBxIFqXZ
         BabAG+AXnzRzgz0FcLcEFJmyxSBVHK3UODFtnPsCjcnztOYXSnsky/Ojm7PQNX4rbPWN
         fMgdosiJqGnp/qY8TOe5QB/vnNza6pRAdn7QV9hIQWC1MoE3QciE9jY346Wf5XNFyIJr
         NM2A==
X-Gm-Message-State: AOAM532+E58UWPh6KkV6xviTJqBB/mYjo4PVTyFtC16773QGfwyZBPUi
        HiMKalX7dUZMo771Ovh0azA=
X-Google-Smtp-Source: ABdhPJxMFFkbYW5HXkcHTfFy4nUCtib3ADb13BfkPFp6MfJEYQ8DJ+Qu8UNcOmnnmHsbWU3a9P5+Bw==
X-Received: by 2002:ac8:71cc:: with SMTP id i12mr3287696qtp.262.1603474423578;
        Fri, 23 Oct 2020 10:33:43 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z66sm1179062qkb.50.2020.10.23.10.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:33:43 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 23 Oct 2020 13:33:42 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 08/18] pip_stress: Add command line parser
In-Reply-To: <20201007085653.11961-9-dwagner@suse.de>
Message-ID: <6b9b3b38-f2e3-ed6e-8d3b-61c08387b69c@redhat.com>
References: <20201007085653.11961-1-dwagner@suse.de> <20201007085653.11961-9-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 7 Oct 2020, Daniel Wagner wrote:

> Add a default command line parser to print at least the current
> version.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pip_stress.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index c9dbd992e15d..74cf53dcfa7a 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -67,12 +67,17 @@ struct State *statep;
>  const int policy = SCHED_FIFO;
>  const int prio_min;	/* Initialized for the minimum priority of policy */
>  
> -struct option long_options[] = {
> -    { "usleep", required_argument, 0, 0 },
> -    { 0,        0,                 0, 0 },
> -};
> +static void usage(int error)
> +{
> +	printf("pip_stress V %1.2f\n", VERSION);
> +	printf("Usage:\n"
> +	       "pip_stress <options>\n"\
> +	       "-h	--help                  Show this help menu.\n"
> +	       );
> +	exit(error);
> +}
>  
> -int main(void)
> +int main(int argc, char *argv[])
>  {
>  	void *mptr;	/* memory pointer */
>  	pid_t pid1, pid2;
> @@ -80,6 +85,25 @@ int main(void)
>  	int res;
>  	int *minimum_priority = (int*)&prio_min;
>  
> +	for (;;) {
> +		struct option long_options[] = {
> +			{ "help",	no_argument,		NULL,	'h' },
> +			{ NULL,		0,			NULL,	0 },
> +		};
> +
> +		int c = getopt_long(argc, argv, "s:h", long_options, NULL);
> +		if (c == -1)
> +			break;
> +		switch (c) {
> +		case 'h':
> +			usage(0);
> +			break;
> +		default:
> +			usage(1);
> +			break;
> +		};
> +	}
> +
>  	*minimum_priority = sched_get_priority_min(policy);
>  
>  	if (check_privs())
> -- 
> 2.28.0
> 
> 

Uglifying my beautiful program in the name conformity?

Ugh, ok fine

Signed-off-by: John Kacur <jkacur@redhat.com>
