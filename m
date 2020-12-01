Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4F0C83012
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DE1216C4
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Trv+5XkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgLAHNN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgLAHNM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:13:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99464C0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:12:32 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id w8so662102ilg.12
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8kmgm+MAOmDK5GVASksZAYuQn8aNp3tOlBeqfOsNgys=;
        b=Trv+5XkZ+DOPMrxOP9Jnc6QbKE7nfb3WEd+/rn4aQLomEIR7xUYl/g0okOlIDTi/Sr
         juPNJWK4A8HHZOJBIcStpLj0oN6FaydBFyI2q/VvPVPDeajbsEt99UmlravGpU2MzQc4
         kdEBEvxt8tSbUPI1Tt2TnwZRgFZtNw8IxlK32FXxEq7w7Fsl5WjOZFai+AO01y8qzGsu
         e3MOgHbS6e0270W2RiqZReucQDiyF/TQzp5NBg4GU5Hukm1bEXsXeOtsYwRnjw+3UfcV
         xROxF24LXrtoug8t+DvlTZmBSnqhzeR5fZvHKvFcSHZ7J6s7OF4LYJbMUs8w5hS6e3kX
         aa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=8kmgm+MAOmDK5GVASksZAYuQn8aNp3tOlBeqfOsNgys=;
        b=SNxywOHo+JQyaSNtrmF1gr89GhLDvAUB99tTa0UCrtpQodIkFv1gYClddoMMVUV3cr
         uE5YOI89x5k19zydaSOqTqj/mjdcm4hjeRLcUrTnI6F9O7OnHC8T3XFzEr12Zjqk2BtR
         QOj4cdd+rZJdF/8w2JTOJ46H0Bvgb3cvBoLDaw76ON8P7Q5XQHi+os+PyqdJSQiLgTsv
         igep522di3f66ctanYu79pibxBTK2nzj1c4Vwe7ulqHZ4tHkUZlBOjxGvr7v1utRAnMM
         8WZGVdsp941xOg7wRw1zxov0F5bDGrWSE+EZzPBpsxma1jrgcsrAaaEjo6Q6TpZRLX+8
         1txQ==
X-Gm-Message-State: AOAM531x6fiKFjw4gXogHH4Sj2fqPFXcpmxxED/ZNgbTCgymBZP1EA91
        g8xg1oFmm+RRm8xLi9ltticiM98hZDrVgA==
X-Google-Smtp-Source: ABdhPJwqx0Nc4PcIvOcQWXbxDlyBcLK89o9Yp2J81AQ/hqS5BB1+F1Czrqfi8lp9kWpPwn1aEIAlXg==
X-Received: by 2002:a92:d48e:: with SMTP id p14mr1500739ilg.169.1606806751970;
        Mon, 30 Nov 2020 23:12:31 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id l78sm637858ild.30.2020.11.30.23.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:12:31 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:12:27 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 09/12] svsematest: Add quiet command line option
In-Reply-To: <20201118190642.16006-10-dwagner@suse.de>
Message-ID: <6cd84ff-91aa-4c2c-393-abc1b2590c8@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-10-dwagner@suse.de>
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
>  src/svsematest/svsematest.8 |  5 ++++-
>  src/svsematest/svsematest.c | 18 ++++++++++++++----
>  2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/src/svsematest/svsematest.8 b/src/svsematest/svsematest.8
> index 5fcb96149bdd..828f9154e974 100644
> --- a/src/svsematest/svsematest.8
> +++ b/src/svsematest/svsematest.8
> @@ -4,7 +4,7 @@
>  \fBsvsematest\fR \- Start two threads or fork two processes and measure the latency of SYSV semaphores
>  .SH "SYNTAX"
>  .LP
> -svsematest [-a|--affinity NUM] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
> +svsematest [-a|--affinity NUM] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-f|--fork [OPT]] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -38,6 +38,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
>  .B \-p, \-\-prio=PRIO
>  Set the priority of the process.
>  .TP
> +.B \-q, \-\-quiet
> +Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
> +.TP
>  .B \-S, \-\-smp
>  SMP testing: options -a -t and same priority of all threads
>  .TP
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 7de20dc65445..7388efb3f488 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -253,6 +253,7 @@ static int interval = 1000;
>  static int distance = 500;
>  static int smp;
>  static int sameprio;
> +static int quiet;
>  
>  static void process_options(int argc, char *argv[])
>  {
> @@ -273,11 +274,12 @@ static void process_options(int argc, char *argv[])
>  			{"interval",		required_argument,	NULL, 'i'},
>  			{"loops",		required_argument,	NULL, 'l'},
>  			{"priority",		required_argument,	NULL, 'p'},
> +			{"quiet",		no_argument,		NULL, 'q'},
>  			{"smp",			no_argument,		NULL, 'S'},
>  			{"threads",		optional_argument,	NULL, 't'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:St::",
> +		int c = getopt_long (argc, argv, "a::b:d:D:f::hi:l:p:qSt::",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -315,6 +317,7 @@ static void process_options(int argc, char *argv[])
>  		case 'i': interval = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
> +		case 'q': quiet = 1; break;
>  		case 'S':
>  			smp = 1;
>  			num_threads = max_cpus;
> @@ -381,6 +384,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
>  {
>  	int i;
>  
> +	if (quiet)
> +		return;
> +
>  	for (i = 0; i < num_threads; i++) {
>  		int receiver_pid, sender_pid;
>  
> @@ -646,8 +652,9 @@ int main(int argc, char *argv[])
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
> @@ -662,7 +669,10 @@ int main(int argc, char *argv[])
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
