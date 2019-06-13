Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64821C31E45
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3857220B7C
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1+28TBR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfFMPEF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:04:05 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33550 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732477AbfFMOSq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 10:18:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so6736945wme.0
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 07:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=baFQ1admLsoXD4khos6wiMdlZv6DdCtt2VF2t/Hem+Q=;
        b=X1+28TBRdMLcFOerUEog3esPhToBDDjbNNyJTbPf3iKuD65UShdNPNJhvEEo2+cxoT
         N8X7Y+WDdyKOKqhidtx8e/u5JxoR4mM5iEOGp2nNuIF/3pjr8Y2hy9ynzEPnwd5os08S
         7D1sik1Uvanfbh2f4tEv1ZgNsFOHXcdm1BpE7G2lSblEzqTXrtgRELe2RgwH+81OJxQI
         lOL/xDsk0IWMZZROM5fHifdBBTX7D4nrrIkDdWpgqK3Ow3381+RrYAzYamLl2wh0d1fM
         sj2vX6zQrcX5Cn5bm9DiSnb5yK4p+JSoJbotwK2joEH1thC/ZLwRw7jdIXsdPJcZi9yq
         6iCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=baFQ1admLsoXD4khos6wiMdlZv6DdCtt2VF2t/Hem+Q=;
        b=fKaN4ZAFVWvjnowUZGvjszemQ3UA5KlE2pc55pH4TLaFq15r6ixGXeVhYrxV3JIBvQ
         kAheKg3ZVUbV2ziYVGJv4wDs4hLnb3yUa+rsgZ8OOudrlRb7iDJKt/3Oca7Qqbxn3/AH
         +pIV+nYe9pgPzI9NpGaLnhs8ZjYAxTDgmJce6yGmCq4hMtWGLR7l4EzprumvlnGNCdzH
         BnyDMndDpZDwWD3379Va3a8f6vQUpy4Fg1/wPFiZLh/WsjyDE88DQeuKf+L03sUjB32h
         WI6fz4DK4OXgIdEsUXvNELqdOOnsdftEKVfZSjBG3O15qjxeebMwCVWG3w1bazGOipWv
         05tg==
X-Gm-Message-State: APjAAAWq6nfTX4sE9UpGMIBCxE0f+kzlxka9D5upKTTaRXkTirCv4SXd
        2HMh6AeTAzCkAsy+RNdw0DU1jxBw1qI=
X-Google-Smtp-Source: APXvYqzdHSrfTm+s46oyRsd/C6qZ2MUSTKXjXvKX6H1W1ku1xPTclT5TnEA3rMPqkZQmFInruMwQwQ==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr3878247wml.97.1560435524725;
        Thu, 13 Jun 2019 07:18:44 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id a10sm4103183wrx.17.2019.06.13.07.18.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 07:18:43 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:18:37 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 08/12] cyclicdeadline: Add duration command line
 argument
In-Reply-To: <20190605160617.22987-9-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131617340.8187@planxty>
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

I fixed-up some dos like line endings you added in the man page, are you 
doing something weird with your editor?

Other than that

Signed-off-by: John Kacur <jkacur@redhat.com>
