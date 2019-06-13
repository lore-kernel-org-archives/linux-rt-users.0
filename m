Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE41AC31E49
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 19:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C97E02173C
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 19:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qp/AtARy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbfFMTIA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:08:00 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40451 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfFMTH7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 15:07:59 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so21962333wre.7
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 12:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=+f5imq8VPizfBpN0BC6do0ZNkBAnwUHTsb46fqlVbBo=;
        b=qp/AtARyzvGobQKnDlggFrFWW42apfXSK5qkDWJxxMLGy04lcZYbcM1NF3LovA4pEx
         8m/ZlZEVHsyhFHTEjiI0+5VjQ7pqalw1iMrmTIbHR+3yjsnNYBHxjtU+ZRuKErlzIwF0
         xzxCi6lfYx4rSJiRfWtI5nXdAWS+Tdi08bVY3JvWr7x4iRJRnH003Q65gOA1Pq6loCNk
         165jI95ldySFnuQkS3wNdAWGQLU0yR86nTe5J2FLTv5jVxRZslYndJbHpYE06ERm2tFi
         XA4u4Hovnjq6OILRchbUXUkviQbhP0ce03uq4+hmHZTTEKcWLtNewPGI4pjnllx9dLNJ
         sp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=+f5imq8VPizfBpN0BC6do0ZNkBAnwUHTsb46fqlVbBo=;
        b=eKNomJ/qX806CQMbxGvx++831X8sv4BFOsIMDWo1kGZ/6YL90JF9tFm13ImUHDnOvU
         mAgqWSo3zV4fkJ4i7TUyRHJL+bAg9slnrhhJb4zMIJM2ySPBRgQ9z2Obh1MiwIKGE93X
         2nXEG7HpyhP8KTyCtif8755fY8JiquyPUXng3r4fKr7w+DM1Egct+NBlxL4lR6kWkHD3
         RqDwtz0G60BDxKxMVXJICUAmw8hXsqQxNI94/QJ1cChMswuwNnhyVcfxeQ8eRN8IqeWB
         FS0NOQw3KNr0NdmN9JEoKx17oY8JrWD1b+R+fuySBBibfDXs3Q1jcoGV8Sl7sfrw9OmX
         mTpA==
X-Gm-Message-State: APjAAAWOXCUuk8sDxqaD967kg4O2zh6dPsex3GdNzMefE0DZTbj1gqFB
        RuIptG5Ap0Aw/HpWfPYe+rfR2A9W+74=
X-Google-Smtp-Source: APXvYqzspFP0Uz9n1A2AutcF0oJu8G4S+LiJvgIhcJQ+8Z0Sjjar3CjnPplBZw5yDe12FOYZ58sp2A==
X-Received: by 2002:adf:f951:: with SMTP id q17mr33632428wrr.173.1560452877065;
        Thu, 13 Jun 2019 12:07:57 -0700 (PDT)
Received: from planxty ([2a02:8108:1740:237c:5dea:4cb8:6516:9736])
        by smtp.gmail.com with ESMTPSA id l12sm1024257wrb.81.2019.06.13.12.07.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 12:07:56 -0700 (PDT)
Date:   Thu, 13 Jun 2019 21:07:49 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 09/12] signaltest: Add duration command line
 argument
In-Reply-To: <20190605160617.22987-10-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906132107300.4541@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-10-wagi@monom.org>
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
>   # timeout 11m signaltest -D 10m
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/signaltest/signaltest.8 |  5 +++++
>  src/signaltest/signaltest.c | 14 +++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/src/signaltest/signaltest.8 b/src/signaltest/signaltest.8
> index 634d392a6da5..bd6ffe5c7a36 100644
> --- a/src/signaltest/signaltest.8
> +++ b/src/signaltest/signaltest.8
> @@ -13,6 +13,11 @@ starting with two dashes ('\-\-').
>  .B \-b, \-\-breaktrace=USEC
>  Send break trace command when latency > USEC
>  .TP
> +.B \-D, \-\-duration=TIME
> +Specify a length for the test run.
> +.br
> +Append 'm', 'h', or 'd' to specify minutes, hours or days.
> +.TP
>  .B \-l, \-\-loops=LOOPS
>  Number of loops: default=0 (endless)
>  .TP
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 59f979ec5ad1..a168191b7573 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -208,6 +208,8 @@ static void display_help(void)
>  		"signaltest <options>\n\n"
>  		"-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
>  		"-l LOOPS --loops=LOOPS     number of loops: default=0(endless)\n"
> +		"-D       --duration=TIME   specify a length for the test run.\n"
> +		"                           Append 'm', 'h', or 'd' to specify minutes, hours or days.\n"
>  		"-p PRIO  --prio=PRIO       priority of highest prio thread\n"
>  		"-q       --quiet           print a summary only on exit\n"
>  		"-t NUM   --threads=NUM     number of threads: default=2\n"
> @@ -221,6 +223,7 @@ static void display_help(void)
>  static int priority;
>  static int num_threads = 2;
>  static int max_cycles;
> +static int duration;
>  static int verbose;
>  static int quiet;
>  static int lockall = 0;
> @@ -235,6 +238,7 @@ static void process_options (int argc, char *argv[])
>  		static struct option long_options[] = {
>  			{"breaktrace", required_argument, NULL, 'b'},
>  			{"loops", required_argument, NULL, 'l'},
> +			{"duration", required_argument, NULL, 'D'},
>  			{"priority", required_argument, NULL, 'p'},
>  			{"quiet", no_argument, NULL, 'q'},
>  			{"threads", required_argument, NULL, 't'},
> @@ -243,13 +247,14 @@ static void process_options (int argc, char *argv[])
>  			{"help", no_argument, NULL, '?'},
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c = getopt_long (argc, argv, "b:c:d:i:l:np:qrsmt:v",
> +		int c = getopt_long (argc, argv, "b:c:d:i:l:D:np:qrsmt:v",
>  			long_options, &option_index);
>  		if (c == -1)
>  			break;
>  		switch (c) {
>  		case 'b': tracelimit = atoi(optarg); break;
>  		case 'l': max_cycles = atoi(optarg); break;
> +		case 'D': duration = parse_time_string(optarg); break;
>  		case 'p': priority = atoi(optarg); break;
>  		case 'q': quiet = 1; break;
>  		case 't': num_threads = atoi(optarg); break;
> @@ -259,6 +264,9 @@ static void process_options (int argc, char *argv[])
>  		}
>  	}
>  
> +	if (duration < 0)
> +		error = 1;
> +
>  	if (priority < 0 || priority > 99)
>  		error = 1;
>  
> @@ -340,6 +348,10 @@ int main(int argc, char **argv)
>  
>  	signal(SIGINT, sighand);
>  	signal(SIGTERM, sighand);
> +	signal(SIGALRM, sighand);
> +
> +	if (duration)
> +		alarm(duration);
>  
>  	par = calloc(num_threads, sizeof(struct thread_param));
>  	if (!par)
> -- 
> 2.20.1
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
