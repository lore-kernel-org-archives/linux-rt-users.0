Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590EC46477
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F562217D7
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlM0iAzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbfFMPGK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:06:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44855 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbfFMOKY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 10:10:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16so1815953wrl.11
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WsXDHYjy3AqAU2cgrj1sXFpcJKGJPutaiFPT5jC9TYI=;
        b=UlM0iAzVkJJdGilP2Vhu3mtDkJYisi/GPXZ1CSrWk2zkW34tJ3DgQt3Z/3N2/lW7we
         gFv81R5q4C3yUxvFrGOKnyPEwNzDs9b/MdwZBvZLTs8c0X+bQgyvr4T/rVWiw07s1kcA
         dNnni/z7x9ffJpa32G/Un5VP5sfYG8onqw8lj9bHGjGqT3f1yF8y1BI/+5eCnKsMyxx5
         KCMpPbP8lwT9o2eFsxKZw4ZMWtCbA5RoS7ctAOhWe7MdP4McbAtLlPSi3kEnaxz7yDam
         pG7ixEdWxgLMIAAmMnYF9g2JWLXq8kkxpfjCajBVgxR2nLvEAHjPOttx6+mJxXd9DGis
         t8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=WsXDHYjy3AqAU2cgrj1sXFpcJKGJPutaiFPT5jC9TYI=;
        b=ULIp8qT/hNtemxMi1jkloQYjlpwOfCR0+LIueNODB4NnPyQPdRUZ4dUKFXfQwN1l/f
         uuo9DUEoURkyd3C41PZkhAQExa66nMuqRQJcN8OegHoKlxbST35p0zxK0IGHJeEtggej
         wmhmWtlwuA4F2NpT4DxDUOYwd0wjy7xKMjiD5tl3D9uRIZJXQt45zsqNQVzjuQC+BvG3
         080pWrjygbsuJCUeIdhzJQGegEO4CdPpt8FqDrlvDyBpMwVYClwjNx7rBA3hDIsAarbQ
         /K8mSA0gK2rOttjCdb/Mw/7emG+P6Heb+21cHMxgDadSuw/SK87xrOBrLk85y5udPPs5
         LTXw==
X-Gm-Message-State: APjAAAUL5BKuNLmqRRk/0rgrJ4/Gw6l4ohrqZe8GoEw9TyXH9NEpARE0
        jIvOsv4FRVddxDa785jagfk=
X-Google-Smtp-Source: APXvYqzF68bHfpfyMpRZZvdwLvylAaKRGfSccywURsHhYYHIhRUXMTZtRBwuibl0r7mtuMNQG+5wWg==
X-Received: by 2002:adf:dc42:: with SMTP id m2mr35921062wrj.275.1560435021441;
        Thu, 13 Jun 2019 07:10:21 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id p3sm4029672wrd.47.2019.06.13.07.10.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:10:20 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:10:14 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 06/12] pmqtest: Add duration command line argument
In-Reply-To: <20190605160617.22987-7-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131609380.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-7-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 5 Jun 2019, Daniel Wagner wrote:

> Many of the test programs have the --loop argument for automatic
> stopping. The main problem with the --loop argument is how long is
> --loop 1000?
> 
> To simplify automated tests introduce a --duration argument which
> allows to set the time how long a test should run. This allows the
> test suite to define the execution time and also the timeout which a
> normal human can understand.
> 
> For example run the test for 10 minutes and timeout at 11 minutes:
> 
>   # timeout 11m pmqtest -D 10m
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/pmqtest/pmqtest.8 |  5 +++++
>  src/pmqtest/pmqtest.c | 17 +++++++++++++++--
>  2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.8 b/src/pmqtest/pmqtest.8
> index 05421e01e70b..9108a939b9f7 100644
> --- a/src/pmqtest/pmqtest.8
> +++ b/src/pmqtest/pmqtest.8
> @@ -21,6 +21,11 @@ It is useful to track down unexpected large latencies of a system.
>  .B \-d, \-\-distance=DIST
>  Set the distance of thread intervals in microseconds (default is 500 us). When pmqtest is called with the -t option and more than one thread is created, then this distance value is added to the interval of the threads: Interval(thread N) = Interval(thread N-1) + DIST
>  .TP
> +.B \-D, \-\-duration=TIME
> +Specify a length for the test run.
> +.br
> +Append 'm', 'h', or 'd' to specify minutes, hours or days.
> +.TP
>  .B \-f, \-\-forcetimeout=TO
>  Set an artificial delay of the send function to force timeout of the receiver, requires the -T option
>  .TP
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 75d5ee8185a0..054768d161a7 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -252,6 +252,8 @@ static void display_help(void)
>  	"-f TO    --forcetimeout=TO force timeout of mq_timedreceive(), requires -T\n"
>  	"-i INTV  --interval=INTV   base interval of thread in us default=1000\n"
>  	"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +	"-D       --duration=TIME   specify a length for the test run.\n"
> +	"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
>  	"-p PRIO  --prio=PRIO       priority\n"
>  	"-S       --smp             SMP testing: options -a -t and same priority\n"
>          "                           of all threads\n"
> @@ -271,6 +273,7 @@ static int tracelimit;
>  static int priority;
>  static int num_threads = 1;
>  static int max_cycles;
> +static int duration;
>  static int interval = 1000;
>  static int distance = 500;
>  static int smp;
> @@ -293,6 +296,7 @@ static void process_options (int argc, char *argv[])
>  			{"forcetimeout", required_argument, NULL, 'f'},
>  			{"interval", required_argument, NULL, 'i'},
>  			{"loops", required_argument, NULL, 'l'},
> +			{"duration", required_argument, NULL, 'D'},
>  			{"priority", required_argument, NULL, 'p'},
>  			{"smp", no_argument, NULL, 'S'},
>  			{"threads", optional_argument, NULL, 't'},
> @@ -300,7 +304,7 @@ static void process_options (int argc, char *argv[])
>  			{"help", no_argument, NULL, '?'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "a::b:d:f:i:l:p:St::T:",
> +		int c = getopt_long (argc, argv, "a::b:d:f:i:l:D:p:St::T:",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
> @@ -325,6 +329,7 @@ static void process_options (int argc, char *argv[])
>  		case 'f': forcetimeout = atoi(optarg); break;
>  		case 'i': interval = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
> +		case 'D': duration = parse_time_string(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 'S':
>  			smp = 1;
> @@ -369,7 +374,10 @@ static void process_options (int argc, char *argv[])
>  
>  	if (forcetimeout && !timeout)
>  		error = 1;
> - 
> +
> +	if (duration < 0)
> +		error = 1;
> +
>  	if (priority && smp)
>  		sameprio = 1;
>  
> @@ -418,10 +426,15 @@ int main(int argc, char *argv[])
>  	sigemptyset(&sigset);
>  	sigaddset(&sigset, SIGTERM);
>  	sigaddset(&sigset, SIGINT);
> +	sigaddset(&sigset, SIGALRM);
>  	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
>  
>  	signal(SIGINT, sighand);
>  	signal(SIGTERM, sighand);
> +	signal(SIGALRM, sighand);
> +
> +	if (duration)
> +		alarm(duration);
>  
>  	receiver = calloc(num_threads, sizeof(struct params));
>  	sender = calloc(num_threads, sizeof(struct params));
> -- 
> 2.20.1
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
