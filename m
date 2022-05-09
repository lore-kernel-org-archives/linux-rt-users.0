Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5153C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 May 2022 18:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiEITD3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 May 2022 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbiEITD2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 May 2022 15:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBA2E285EC4
        for <linux-rt-users@vger.kernel.org>; Mon,  9 May 2022 11:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652122770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TiboAU7CeSqEfTXrrgcB4LzSoM2I/5Rt5tCZdYkZCow=;
        b=KBSpd4YRVzpaygnTxwbsPgDXfq0uSf1MwZqZ3mhBtgr4KPcHhq4p30pWQrQWxYXNmmcPup
        o+j7NyAObWuoIITdnD//qRLkGlAa+1HMu3JcvLeDy9sfV2K7yqgNWaruc80oEgUBs3kYrv
        WdPcDTQO31INzZPSgdPGmFev/vgS4s4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-h8tcLS1lOvuxeHPybmLAow-1; Mon, 09 May 2022 14:59:29 -0400
X-MC-Unique: h8tcLS1lOvuxeHPybmLAow-1
Received: by mail-qv1-f69.google.com with SMTP id u19-20020ad449b3000000b004523cc11b95so12513972qvx.7
        for <linux-rt-users@vger.kernel.org>; Mon, 09 May 2022 11:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=TiboAU7CeSqEfTXrrgcB4LzSoM2I/5Rt5tCZdYkZCow=;
        b=fHhZxbfDwy8e5ptcbLHsyoOnTAI6RDiTunCwCAnL+nS4zjBool3hl0jZTPvtgfCMKS
         kkAD6vhcYx9ZfCPrRYmWSoibMBCgpLtGsQHnyOzuQGwrQZrEieXnCdA69aIgGnhIrDwm
         2Z/QtSqgc3rN5iOjxHr2x3neUSktK37vHpW81sdcKYuhAWGqsZxB0BGL1HYN/1O0GXRM
         ZOCyrrW6I2zKnqFddR0Z7ti+OUgZUYA1tKM4F1aQsFruPXNZEbfa4gpg0bTokSQxlIIs
         WptS4tyVvmGLQ/62JPZqga4kyyzIB8PomCoG9lSOftaCJQ/s0zJ0VoJZo5/FNjTlqUx3
         VRww==
X-Gm-Message-State: AOAM532ZFWaFExoqYB1I7TB0bLYTLs+uxTD4+2ZLv1952DE/PWZUWwbA
        QVX51sDEwl0ZiYppQ5luIB3Y6uXfw0H9a5rTcoy3yRMgiDT5Pb8bGKp2iRdUim+JuGF8W1Q0ZoZ
        VDXR6klEJeSTAm6PoGGF2QMa8Uqc=
X-Received: by 2002:ad4:4e05:0:b0:456:50a4:7494 with SMTP id dl5-20020ad44e05000000b0045650a47494mr14848273qvb.6.1652122768168;
        Mon, 09 May 2022 11:59:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxUdeCbHC3Y1BmTp1PCjPG+YhHPeUBUbwTon4qS9zGfkQeNw/It0SZ2WHgdX/llL5VLbWewQ==
X-Received: by 2002:ad4:4e05:0:b0:456:50a4:7494 with SMTP id dl5-20020ad44e05000000b0045650a47494mr14848264qvb.6.1652122767872;
        Mon, 09 May 2022 11:59:27 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id k4-20020a37ba04000000b006a05a6243d5sm4041972qkf.13.2022.05.09.11.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 11:59:27 -0700 (PDT)
Date:   Mon, 9 May 2022 14:59:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Yihao Wu <wuyihao@linux.alibaba.com>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 1/2] hackbench: Fix negativity opt checking
In-Reply-To: <20220428103726.108597-2-wuyihao@linux.alibaba.com>
Message-ID: <3986d547-06e-b7f9-353c-1ff05f1bcee@redhat.com>
References: <20220428103726.108597-1-wuyihao@linux.alibaba.com> <20220428103726.108597-2-wuyihao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 28 Apr 2022, Yihao Wu wrote:

> It was easy to escape the checking. For example, run
> 
>   ./hackbench --datasize 4096 -g -1 -l -1
> 
> This patch fixes the checking.
> 
> Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
> ---
>  src/hackbench/hackbench.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/hackbench/hackbench.c b/src/hackbench/hackbench.c
> index 268c232..b9b0af6 100644
> --- a/src/hackbench/hackbench.c
> +++ b/src/hackbench/hackbench.c
> @@ -31,10 +31,10 @@
>  #include <setjmp.h>
>  #include <sched.h>
>  
> -static unsigned int datasize = 100;
> -static unsigned int loops = 100;
> -static unsigned int num_groups = 10;
> -static unsigned int num_fds = 20;
> +static int datasize = 100;
> +static int loops = 100;
> +static int num_groups = 10;
> +static int num_fds = 20;
>  static unsigned int fifo = 0;
>  
>  /*
> @@ -377,7 +377,7 @@ static void process_options(int argc, char *argv[])
>  		}
>  		switch (c) {
>  		case 'f':
> -			if (!(argv[optind] && (num_fds = atoi(optarg)) > 0)) {
> +			if ((num_fds = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --fds|-f requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -386,7 +386,7 @@ static void process_options(int argc, char *argv[])
>  			fifo = 1;
>  			break;
>  		case 'g':
> -			if (!(argv[optind] && (num_groups = atoi(optarg)) > 0)) {
> +			if ((num_groups = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --groups|-g requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -394,7 +394,7 @@ static void process_options(int argc, char *argv[])
>  		case 'h':
>  			print_usage_exit(0);
>  		case 'l':
> -			if (!(argv[optind] && (loops = atoi(optarg)) > 0)) {
> +			if ((loops = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --loops|-l requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> @@ -403,7 +403,7 @@ static void process_options(int argc, char *argv[])
>  			use_pipes = 1;
>  			break;
>  		case 's':
> -			if (!(argv[optind] && (datasize = atoi(optarg)) > 0)) {
> +			if ((datasize = atoi(optarg)) <= 0) {
>  				fprintf(stderr, "%s: --datasize|-s requires an integer > 0\n", argv[0]);
>  				print_usage_exit(1);
>  			}
> -- 
> 2.18.2
> 
> 

Well, the code doesn't work the way the author intended, that's for sure.
As your patch indicates, you realize the problem is that an unsigned 
variable can never be less than zero, so the check is meaningless. 
However, is changing the data type the right solution, just to make a 
check against something stupid a user might input the correct thing to do? 
It decreases the size of valid input. Maybe that doesn't matter, but then 
could it introduce a new bug somewhere? You've dropped the argv[optind] 
too which also doesn't work the way the author intended, but it was 
probably meant as a check of whether the user provided an argument or not.

What I would rather see if you want to fix this, is a check against the 
user input that doesn't change the datatype. For example, if you treat the 
input as a char, if (optarg[0] == '-') then we can tell the difference 
between a really big number or user input that is stupid or malicious.
If you look in cyclictest, (there could be bugs lurking there too), there 
is an attempt to parse this kind of thing and to check whether there are 
arguments too.

Thanks

John

