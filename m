Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59717C64E7A
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D56A8216C4
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 07:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzqmwS3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgLAHJr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbgLAHJr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 02:09:47 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D03C0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:09:07 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id p5so673885iln.8
        for <linux-rt-users@vger.kernel.org>; Mon, 30 Nov 2020 23:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Aumb2cBeYp+PSwJZ6rBFhOrng5dIooqIPk/bo0BUKcg=;
        b=hzqmwS3hg6wYYmho2QDkNdOJElaqw40MlOR+yLWRu0gzydggKM783ZmgT95EefezYV
         xDg0+RRTGvbXTwoQyyY8YlFufERwcNcmXCij1fs7ZQyyjI6aCvoDlAqUK1q7cmCNWdAX
         Ip/llDHnPU/7T7Rur/cfXCW++aa/yOgSNwG9DlScaqMLyUviCm5GpgkXUQ+Sdy26Uy2K
         6txfXLlQbug9CAEovg+/4Y35kaC/cXBZg2zjZTHVl4msMGrHM8H/J9aLmfsxDifkBEf1
         ARA1dirs2Fw0SVQyc+8L/a39Dm05rucEYF4+2+jgAoyqJTcyKqnrMJkf8gvVsXLdAFPI
         2R+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=Aumb2cBeYp+PSwJZ6rBFhOrng5dIooqIPk/bo0BUKcg=;
        b=o4wXgvLlqZSSEBTaxj3tqdUke/Su64xtkwWsgpTzSTyAFpCh+U48QI5uB1PCP+1UL2
         DvZPHJalT5i9FLlfE/R8jpMINTejxiahi/TZgyIth6HDAdmibf+VhqqvgXMvDVtt8ZXU
         pIUlQ7vJFH9sna9j6a4c52t9gMZE2Ap0aLnbbdEVO0JSEToSLoHKK9oslmgOvUhVHHNv
         OCa/8Q/XgB0NiJWrhrmCm6Hn6iKlDROSEoA9MD9P8HGTMCjiuEsFGrVfvviXaGPmG0+Y
         QWy3mqQ3+iC7x08tmuMgfgiMPG4h0pOeWIzRNrdOZKCzsXLLyA7ckbrzVKeI522qc27r
         rWRw==
X-Gm-Message-State: AOAM5311TCuu9toqdUoTt43RtfPX5PmTOxOfEp/PcuaONGWQcn0z2ca7
        qw8aNxBzNddywOkihrebCcl+Z5HdwWt38Q==
X-Google-Smtp-Source: ABdhPJwcuJC1XX4EZdy7qATXkKL9Gh7N3U5A0YIL8jXCnFsT9H00BE3JsoRfZZh4X3eNb1Tmn9fEQw==
X-Received: by 2002:a05:6e02:13a3:: with SMTP id h3mr1516394ilo.164.1606806546424;
        Mon, 30 Nov 2020 23:09:06 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id u1sm596857ilb.74.2020.11.30.23.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 23:09:06 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 1 Dec 2020 02:09:02 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 07/12] ptsematest: Add quiet command line option
In-Reply-To: <20201118190642.16006-8-dwagner@suse.de>
Message-ID: <af10cfde-f6e1-e1ce-302b-9a7cdcb1132@redhat.com>
References: <20201118190642.16006-1-dwagner@suse.de> <20201118190642.16006-8-dwagner@suse.de>
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
>  src/ptsematest/ptsematest.8 |  5 ++++-
>  src/ptsematest/ptsematest.c | 20 ++++++++++++++++----
>  2 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/src/ptsematest/ptsematest.8 b/src/ptsematest/ptsematest.8
> index 05a0cdfd3657..a435e7a6221c 100644
> --- a/src/ptsematest/ptsematest.8
> +++ b/src/ptsematest/ptsematest.8
> @@ -4,7 +4,7 @@
>  \fBptsematest\fR \- Start two threads and measure the latency of interprocess communication with POSIX mutex.
>  .SH "SYNOPSIS"
>  .LP
> -ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-S|--smp] [-t|--threads [NUM]]
> +ptsematest [-a|--affinity [PROC]] [-b|--breaktrace USEC] [-d|--distance DIST] [-D|--duration TIME] [-h|--help] [-i|--interval INTV] [-l|--loops LOOPS] [-p|--prio PRIO] [-q|--quiet] [-S|--smp] [-t|--threads [NUM]]
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
>  SMP testing: options -a -t and same priority
>  .TP
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 69b4e1221361..2e392299fdc4 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -156,6 +156,7 @@ static void display_help(int error)
>  	       "-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	       "-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
>  	       "-p PRIO  --prio=PRIO       priority\n"
> +	       "-q       --quiet           print a summary only on exit\n"
>  	       "-S       --smp             SMP testing: options -a -t and same priority\n"
>  	       "                           of all threads\n"
>  	       "-t       --threads         one thread per available processor\n"
> @@ -178,6 +179,7 @@ static int interval = 1000;
>  static int distance = 500;
>  static int smp;
>  static int sameprio;
> +static int quiet;
>  
>  static void process_options(int argc, char *argv[])
>  {
> @@ -196,11 +198,12 @@ static void process_options(int argc, char *argv[])
>  			{"interval",	required_argument,	NULL, 'i'},
>  			{"loops",	required_argument,	NULL, 'l'},
>  			{"priority",	required_argument,	NULL, 'p'},
> +			{"quiet",	no_argument	,	NULL, 'q'},
>  			{"smp",		no_argument,		NULL, 'S'},
>  			{"threads",	optional_argument,	NULL, 't'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:St::h",
> +		int c = getopt_long (argc, argv, "a::b:d:i:l:D:p:qSt::h",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -228,6 +231,7 @@ static void process_options(int argc, char *argv[])
>  		case 'h': display_help(0); break;
>  		case 'l': max_cycles = atoi(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
> +		case 'q': quiet = 1; break;
>  		case 'S':
>  			smp = 1;
>  			num_threads = max_cpus;
> @@ -293,6 +297,9 @@ static void print_stat(FILE *fp, struct params *receiver, struct params *sender,
>  {
>  	int i;
>  
> +	if (quiet)
> +		return;
> +
>  	for (i = 0; i < num_threads; i++) {
>  		printf("#%1d: ID%d, P%d, CPU%d, I%ld; #%1d: ID%d, P%d, CPU%d, Cycles %d\n",
>  			i*2, receiver[i].tid, receiver[i].priority, receiver[i].cpu,
> @@ -391,8 +398,9 @@ int main(int argc, char *argv[])
>  			shutdown |= receiver[i].shutdown | sender[i].shutdown;
>  
>  		if (receiver[0].samples > oldsamples || shutdown) {
> -			print_stat(stdout, receiver, sender, 0, 0);
> -			printf("\033[%dA", num_threads*2);
> +			print_stat(stdout, receiver, sender, 0, quiet);
> +			if (!quiet)
> +				printf("\033[%dA", num_threads*2);
>  		}
>  
>  		sigemptyset(&sigset);
> @@ -405,7 +413,11 @@ int main(int argc, char *argv[])
>  		sigemptyset(&sigset);
>  		pthread_sigmask(SIG_SETMASK, &sigset, NULL);
>  	}
> -	printf("\033[%dB", num_threads*2 + 2);
> +
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
