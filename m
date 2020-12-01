Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5481C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475592087C
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NIph+sYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgLAHFQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbgLAHFQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:05:16 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0397BC0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:04:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q137so573864iod.9
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=j89XDJoyUY/uFjXwgrA+oPoh9bo+7xkkEO4nN0RD1kQ=;
        b=NIph+sYdTm2jjfjiQv6ki+AtG+bEUHpnnL9hTFbgy1iVC6ANmdEMNFQHu/AVOTZWCr
         VHtawO+qf9jmHOZU45OzhokFIPiXShmwGeug2/5NRyY2omiRdVA1WDRXuPGGUpyvK4gk
         ET9GKASyqrAXvxb6ZnZH/q9eQoZyENjSBq1RoHvSHD41Ruwt9naIoiYVzeoAJ07aQ1rE
         N2BOFSxozdx9rabbRrlZZyOvt+m0+6aoGMVDgXEMaC39dKkJfOMjluU+FpWr4xN966MW
         d42CADDTQ6AeUtqGmPklb3uQxDFAdHXix0e/r0Dn8qmzEkDvb9gtyv6SByogDvKHXm2e
         kcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=j89XDJoyUY/uFjXwgrA+oPoh9bo+7xkkEO4nN0RD1kQ=;
        b=WZw1uBJvZCyJCiulKxSC6BaUxqXVZlnXtFig2z5F8RHsfJibfY8RWQYZZVuHVh5ocG
         YL8ftzCExnVwrGD/BrDlVu2oezquEmBCwUpXYrI6oQ8kW9zPVeDXbi0DZSxIq+Hkx4Hw
         UgVZ2quXYytU2XzLP3jK8g9FBfh5+mxuu66qKC0mJKp8acbmWhUX6F9oe6+R8JSMJnrh
         YJoHQ43WqUkxRpjxDwgSZ66EsGmEF6riqNgEEFf7+Gv6QV8vYZ0X+grIZoQ47CPLWfxe
         YGUVaTWYSkVnDWz0DjBmsHvbXpd/zWvXEXeBvzGqDP+Q9QExGUFzy6FjaCGxOErB+P+C
         t70Q==
X-Gm-Message-State: AOAM533Fq/N9JRRHGNDhJE6dEpwLJa+BiYQZDJ0sZXpuWDuTIOtmT/zF
        nRLGkg7z67v4I13lDCuAExdR8W/1MqQKVQ==
X-Google-Smtp-Source: ABdhPJwvoAQW0ljcXC1QhNJMMfy4+L8gs7n7N7g0MOxwjjHTGPCQMypCQchKR8aXTNl0RYGbZjVOCw==
X-Received: by 2002:a02:b011:: with SMTP id p17mr1524664jah.55.1606806275437;
        Mon, 30 Nov 2020 23:04:35 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id t1sm610469ile.1.2020.11.30.23.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:04:35 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:04:31 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 05/12] pmqtest: Add quiet command line option
In-Reply-To: <20201118190642.16006-6-dwagner@suse.de>
Message-ID: <c442721-39-5a34-702-67cd4a1b1ff6@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-6-dwagner@suse.de>
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
>  src/pmqtest/pmqtest.8 |  5 ++++-
>  src/pmqtest/pmqtest.c | 19 +++++++++++++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
> index e44411ce0ef3..36678d0c5026 100644
> --- a/src/pmqtest/pmqtest.8
> +++ b/src/pmqtest/pmqtest.8
> @@ -4,7 +4,7 @@
>  \fBpmqtest\fR \- Start pairs of threads and measure the latency of interprocess communication with POSIX messages queues
>  .SH "SYNTAX"
>  .LP
> -pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [-l LOOPS] [-p PRIO] [-S] [-t|-t NUM]
> +pmqtest [-a|-a PROC] [-b USEC] [-d DIST] [-D TIME] [-f TO] [-h] [-i INTV] [-l LOOPS] [-p PRIO] [-q] [-S] [-t|-t NUM]
>  .br
>  .SH "DESCRIPTION"
>  .LP
> @@ -41,6 +41,9 @@ Set the number of loops. The default is 0 (endless). This option is useful for a
>  .B \-p, \-\-prio=PRIO
>  Set the priority of the process.
>  .TP
> +.B \-q, \-\-quiet
> +Print a summary only on exit. Useful for automated tests, where only the summary output needs to be captured.
> +.TP
>  .B \-S, \-\-smp
>  Test mode for symmetric multi-processing, implies -a and -t and uses the same priority on all threads.
>  .TP
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index b0a2cbede4a0..5f7a24d55db6 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -232,6 +232,7 @@ static void display_help(int error)
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
> +	       "-q       --quiet           print a summary only on exit\n"
>  	       "-S       --smp             SMP testing: options -a -t and same priority\n"
>  	       "                           of all threads\n"
>  	       "-t       --threads         one thread per available processor\n"
> @@ -256,6 +257,7 @@ static int smp;
>  static int sameprio;
>  static int timeout;
>  static int forcetimeout;
> +static int quiet;
>  
>  static void process_options(int argc, char *argv[])
>  {
> @@ -275,12 +277,13 @@ static void process_options(int argc, char *argv[])
>  			{"interval",		required_argument,	NULL, 'i'},
>  			{"loops",		required_argument,	NULL, 'l'},
>  			{"priority",		required_argument,	NULL, 'p'},
> +			{"quiet",		no_argument,		NULL, 'q'},
>  			{"smp",			no_argument,		NULL, 'S'},
>  			{"threads",		optional_argument,	NULL, 't'},
>  			{"timeout",		required_argument,	NULL, 'T'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:D:f:i:l:p:St::T:",
> +		int c = getopt_long (argc, argv, "a::b:d:D:f:i:l:p:qSt::T:",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -309,6 +312,7 @@ static void process_options(int argc, char *argv[])
>  		case 'i': interval = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
> +		case 'q': quiet = 1; break;
>  		case 'S':
>  			smp = 1;
>  			num_threads = max_cpus;
> @@ -378,6 +382,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
>  {
>  	int i;
>  
> +	if (quiet)
> +		return;
> +
>  	for (i = 0; i < num_threads; i++) {
>  		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, TO %d, Cycles %d\n",
>  			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
> @@ -505,8 +512,9 @@ int main(int argc, char *argv[])
>  
>  		if (minsamples > 1 && (shutdown || newsamples > oldsamples ||
>  			newtimeoutcount > oldtimeoutcount)) {
> -			print_stat(stdout, receiver, sender, 0, 0);
> -			printf("\033[%dA", num_threads*2);
> +			print_stat(stdout, receiver, sender, 0, quiet);
> +			if (!quiet)
> +				printf("\033[%dA", num_threads*2);
>  		}
>  
>  		fflush(NULL);
> @@ -525,7 +533,10 @@ int main(int argc, char *argv[])
>  
>  	} while (!shutdown);
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
