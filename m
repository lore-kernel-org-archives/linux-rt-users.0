Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E0AC31E45
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BCB207E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGPgqNBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732995AbfFMPBH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:01:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35767 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbfFMOka (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 10:40:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2097455wrv.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 07:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=PkWn2lgv2CllPV0Duld3jWJnB7xlntDqJd9OSR+tpdE=;
        b=rGPgqNBAH4PMlDmT5Qy8pd8Tr94UZr2hNNLtVQY67D6aTgEleBx6rpYggoMgekZn+C
         JC9RxeZPz2xekV5Q90glgtS65HS0CyDu39trtCKETfYxNTCx9lg9sBsPmhUBEfFfbmxX
         /JEysAe9jlrPwFC8er38XbX5Hupz+CCRjRv7JcMgdlv8+Nknibh0YIvviaS4AmY0FCSq
         uS7ug+nR9cMyPt2HhrHZrSAUTHoN5jBlDLbIRhSWepvwKH4PdhY/GoCtnKNKiZQZzArl
         GdFIOD0mpyQb5cl+WD8ZCcy7a7mmnsGv8b/D+ScKJ51eCPiwQf4KIRnLSKLS7Yc/bmG/
         rXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=PkWn2lgv2CllPV0Duld3jWJnB7xlntDqJd9OSR+tpdE=;
        b=pkj/+liw8HFkxl7YZT92Yccg7mYIxhnbHZHLyxa+hmHxkJBEguZ1hEEbdtdikb2N+8
         1cHNQ15c6xbS7frJbG7UdWD0uK1akLd2n5Pg5JY6SlwnAeP3boBFgf9Y/bGtPloRtUaY
         TRQt8o6R5QGtYAFS7oJxU14/E7Kx+JOSV5H1V56241znYR5VHedMJRHNV/VImYSGnqYa
         O6hVi5ZN/5zJte9KM0Zyhoj9jmzGb3F1xm9Tuj9QKvixJFk5HCLXfeQV2IlPcIabkFd7
         S52RIB2Bnv96WDc1ADby0zJQLvn7zCH3pNADkBUw8QzrZMau/tCOelf/xIBj9F0CPFlg
         1Dag==
X-Gm-Message-State: APjAAAUCy5kULKlhqPHNLwdxIsnkloq4rUCJSM6RP5ydXejL2gBqSK+z
        qnTdsUxqA8wjCFvRvHmQhUA4yq3WTU0=
X-Google-Smtp-Source: APXvYqxhM4wZqsR1ixls0bJeVGkDQorZW9VTMAIBlMaaZIA2jqQj+7t/QD69ittKnXfxTD511mo7LQ==
X-Received: by 2002:adf:b447:: with SMTP id v7mr25051907wrd.208.1560436828172;
        Thu, 13 Jun 2019 07:40:28 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id l4sm66608wmh.18.2019.06.13.07.40.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:40:26 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:40:20 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 08/12] cyclicdeadline: Add duration command line
 argument
In-Reply-To: <20190605160617.22987-9-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131637120.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-9-wagi@monom.org>
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
>   # timeout 11m cyclicdeadline -D 10m
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/sched_deadline/cyclicdeadline.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 6d461b27ac43..47892daf747b 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -21,6 +21,8 @@
>  #include <linux/unistd.h>
>  #include <linux/magic.h>
>  
> +#include <rt-utils.h>
> +
>  #ifdef __i386__
>  #ifndef __NR_sched_setattr
>  #define __NR_sched_setattr		351
> @@ -1049,6 +1051,7 @@ int main (int argc, char **argv)
>  	unsigned int interval = 1000;
>  	unsigned int step = 500;
>  	int percent = 60;
> +	int duration = 0;
>  	u64 runtime;
>  	u64 start_period;
>  	u64 end_period;
> @@ -1062,7 +1065,7 @@ int main (int argc, char **argv)
>  		exit(-1);
>  	}
>  
> -	while ((c = getopt(argc, argv, "+hac:i:s:t:")) >= 0) {
> +	while ((c = getopt(argc, argv, "+hac:i:s:t:D:")) >= 0) {
>  		switch (c) {
>  		case 'a':
>  			all_cpus = 1;
> @@ -1081,6 +1084,9 @@ int main (int argc, char **argv)
>  		case 't':
>  			nr_threads = atoi(optarg);
>  			break;
> +		case 'D':
> +			duration = parse_time_string(optarg);
> +			break;
>  		case 'h':
>  		default:
>  			usage(argv);
> @@ -1246,6 +1252,10 @@ int main (int argc, char **argv)
>  
>  	signal(SIGINT, sighand);
>  	signal(SIGTERM, sighand);
> +	signal(SIGALRM, sighand);
> +
> +	if (duration)
> +		alarm(duration);
>  
>  	if (!fail)
>  		loop(sched_data, nr_threads);
> -- 
> 2.20.1
> 

I'm reluctantly giving you a signed-off-by.
I say reluctantly because the program needs some work, so the problems 
exited before your patch, but it's a little hard to test your patch until 
these problems get resolved.

I can't run this without getting the message

For less than 2ms run times, you need to
have HRTICK enabled in debugfs/sched_features

- The usage message is broken
- There is no help
- There are no long options

Anyone looking for place to start hacking, this program could use some 
love

Signed-off-by: John Kacur <jkacur@redhat.com>
