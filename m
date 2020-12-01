Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8542DC71156
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DBC2087D
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/+hTT8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgLAHQu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbgLAHQt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:16:49 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AC0C0613D3
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:16:09 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id d8so580222ioc.13
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=kktEVHZtzBjeN0/3NFWVzb2nsxyKfokGD+310q9YXXI=;
        b=g/+hTT8AFOnvuHNQqI44kgDKjejWBDHsvc4aMhLoRkM9SuLRbC3/33MQXQ6rEZiB+N
         4YTU8MOwmwq910Ik09yVdMBXsmCFMBF5QL+GlGNCuEYGHnQmlNLFK4O903Bey4Ojl3Rl
         MKih5k1UA7YcQ6UDN6D9Uc6SXZGOssby4PQuZgBPmKcgqEs+DeP71mlgD6a/4KEF4atE
         isulJXgTsNrGpDr+OomdTcLHVMKoDl/u79erShTd4jyKSETAUgUnoSS5CqFmfMusM+55
         tk5Ptuq6TJgFKRk8EFQGdp1KtV2uugMKY8pJtsOQH1Wvse0S5oavKZxo2cHy4Mmb4B3k
         iKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=kktEVHZtzBjeN0/3NFWVzb2nsxyKfokGD+310q9YXXI=;
        b=gKeTht+HrRgjpwH6DwE5Jg4z2BdxZchZ19waPeiMWfIlsBxOHEWtoqnuKMifTQrWfq
         Nf6TAr0H4yp+/hihhX3LFaZCverT9CoM044fTWKXf8B0DIGuXPQEkBs44j0J7ooVoXZh
         2Bk5Li6hgjfGuYKWo0pip8WgM3GMsrmWLqZDAzGVFw4Sv3LQLaVtdnjWiiq72CJRUhwa
         RybLy9m4hTA8OPjpA8XDDpDDYynoupnQ2aYV/PY4PJAMOXC0uYZhPOmpbd65JK0Uh3dd
         QSAYsIMxLy+wbGw51jTYUCUkfkfl0wpJbTjofWJwcIzt8GevQi0Ng6f16qwTgVryLplX
         Fecw==
X-Gm-Message-State: AOAM532ctfGuLpHTPAB9//c9tCgppBBxImZHGcjFD6uZxzNQ3G3sMzcU
        WpV9dXW+IfGxQL9aR5nPzrp5WcQ9ZaCs6w==
X-Google-Smtp-Source: ABdhPJyeu9mHi2H92sb4E0tznVvvXX27Pma0DLzbvvhn6Y3wkvI25Kf/zu0e0sSpXDtpR3dTjgKHcA==
X-Received: by 2002:a02:830f:: with SMTP id v15mr1561453jag.12.1606806969033;
        Mon, 30 Nov 2020 23:16:09 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id o10sm646963ili.82.2020.11.30.23.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:16:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:16:04 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 11/12] sigwaittest: Add quiet command line option
In-Reply-To: <20201118190642.16006-12-dwagner@suse.de>
Message-ID: <a9512176-a2b-c570-1fc8-af62693abf1@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-12-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 18 Nov 2020, Daniel Wagner wrote:

> The quiet option is useful for automated test setups where
> only the final result of the run is interesting. This avoids
> to fill up the logs.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sigwaittest/sigwaittest.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index d3be2fd9508c..7e287bd2424f 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -221,6 +221,7 @@ static void display_help(int error)
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
> +	       "-q       --quiet           print a summary only on exit\n"
>  	       "-t       --threads         one thread per available processor\n"
>  	       "-t [NUM] --threads=NUM     number of threads:\n"
>  	       "                           without NUM, threads = max_cpus\n"
> @@ -238,6 +239,7 @@ static int max_cycles;
>  static int duration;
>  static int interval = 1000;
>  static int distance = 500;
> +static int quiet;
>  
>  static void process_options(int argc, char *argv[])
>  {
> @@ -258,10 +260,11 @@ static void process_options(int argc, char *argv[])
>  			{"interval",		required_argument,	NULL, 'i'},
>  			{"loops",		required_argument,	NULL, 'l'},
>  			{"priority",		required_argument,	NULL, 'p'},
> +			{"quiet",		no_argument,		NULL, 'q'},
>  			{"threads",		optional_argument,	NULL, 't'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:t::",
> +		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:qt::",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -298,6 +301,7 @@ static void process_options(int argc, char *argv[])
>  		case 'i': interval = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
> +		case 'q': quiet = 1; break;
>  		case 't':
>  			if (optarg != NULL)
>  				num_threads = atoi(optarg);
> @@ -352,6 +356,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
>  {
>  	int i;
>  
> +	if (quiet)
> +		return;
> +
>  	for (i = 0; i < num_threads; i++) {
>  		int receiver_pid, sender_pid;
>  		if (mustfork) {
> @@ -577,8 +584,9 @@ int main(int argc, char *argv[])
>  			    sender[i].shutdown;
>  
>  		if (receiver[0].samples > oldsamples || mustshutdown) {
> -			print_stat(stdout, receiver, sender, 0, 0);
> -			printf("\033[%dA", num_threads*2);
> +			print_stat(stdout, receiver, sender, 0, quiet);
> +			if (!quiet)
> +				printf("\033[%dA", num_threads*2);
>  		}
>  
>  		sigemptyset(&sigset);
> @@ -593,7 +601,10 @@ int main(int argc, char *argv[])
>  		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
>  	}
>  
> -	printf("\033[%dB", num_threads*2 + 2);
> +	if (!quiet)
> +		printf("\033[%dB", num_threads*2 + 2);
> +	else
> +		print_stat(stdout, receiver, sender, 0, 0);
>  
>  	for (i = 0; i < num_threads; i++) {
>  		receiver[i].shutdown = 1;
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
