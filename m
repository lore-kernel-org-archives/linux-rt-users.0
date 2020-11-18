Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C825DC64E7C
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B1E2467A
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 21:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GoanLaYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgKRVAH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 16:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgKRVAG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 16:00:06 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43631C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:00:06 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id y197so3276316qkb.7
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 13:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=8vdJVuu0/NsskU3E7Nszd9j9LqmNg/KyhqHmHwcNjeo=;
        b=GoanLaYfsIVHflIW0+u4AZ0WLJlhA3fSrsOmkuevkp+HVSF+my1oAE/4MTU2IBgcVr
         PTKYbzxF5AEFtCZgxEImzL20bHIwAG60UppQFT/ossE0h+xYkbwc9aMJF94m4FnWirvB
         OxwSopWbfrnXJ4L2hLyhFf1DTXAvfNesqhkSNjuOtcEDa09Aez3SAVDlZqucdrscJJwl
         5/virFKPj0Y4jyBjIXKayRXPFPaaXhXbGtymkAMh89gNVd7QlwoOPJ3F1jO/Vv3lfQyX
         NUPAvyCD9T1zJG2AINVsMABiUciPXqnucakp2yft5jSq0dAyWrJGeHm6Upcn7K2Ej40X
         jVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=8vdJVuu0/NsskU3E7Nszd9j9LqmNg/KyhqHmHwcNjeo=;
        b=aB6J4qvKVQL3Y/WZNWqJwUfvea9JRdGZjbOUQGY8PmgfKeTQwmohAPTCAlnm2vWcxb
         xmGAAzoJjLzwzH2L2cBAdHuomPL3V4ARpBhUASqiSlFLOkzFj1cC4+kCrjSHv23YLURO
         AVAtga0G0hY3mWFNOuk2TjXK7Kyr64WB+BiHK2PUvU8fDIMEdeoPPwcL+QOIhHE3NCQZ
         zABiv0ljW/xst6M2a2iiKlY1zBn7nYUTOWbtVuIQPIh0usAOdmnI/ip+nfkFT/g0637r
         5vywFJDk+KkznMTKN7bbb6a8++sKMPE3CO003RQHee3uWSZNoeK/OQxlTkW+Th1K+Vae
         ePHg==
X-Gm-Message-State: AOAM533LHk+YpdZwEesF1zocrZRkbQ4koWY6Sbt+wf/HS+Rfsd0y+6kS
        45AzqzdeIw5ZPyf2Pxo60Ak=
X-Google-Smtp-Source: ABdhPJznC0HT/BNcATX8B42h/X6VSkfWa5yBRZJr//zWBXH8gIwBMwBqHU0tAeP78pDqzkwIgKKwJA==
X-Received: by 2002:a37:809:: with SMTP id 9mr7003899qki.191.1605733205574;
        Wed, 18 Nov 2020 13:00:05 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id n93sm16554456qtd.7.2020.11.18.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 13:00:05 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 16:00:04 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 2/6] oslat: Use string parser utilies
In-Reply-To: <20201113210910.21807-3-dwagner@suse.de>
Message-ID: <7d51cc60-b9ca-63f8-fc5c-4dbacaf8b02a@redhat.com>
References: <20201113210910.21807-1-dwagner@suse.de> <20201113210910.21807-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 13 Nov 2020, Daniel Wagner wrote:

> Use available parse_time_string() instead locally implemented
> version. While at it move the mem parser helper to the global utility
> header.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/oslat/oslat.c | 67 ++---------------------------------------------
>  1 file changed, 2 insertions(+), 65 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 0018c472e0c1..b2aa15001be2 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -572,69 +572,6 @@ static int parse_cpu_list(char *cpu_list, cpu_set_t *cpu_set)
>  	return n_cores;
>  }
>  
> -static int parse_runtime(const char *str)
> -{
> -	char *endptr;
> -	int v = strtol(str, &endptr, 10);
> -
> -	if (!*endptr)
> -		return v;
> -
> -	switch (*endptr) {
> -	case 'd':
> -	case 'D':
> -		/* Days */
> -		v *= 24;
> -	case 'h':
> -	case 'H':
> -		/* Hours */
> -		v *= 60;
> -	case 'm':
> -	case 'M':
> -		/* Minutes */
> -		v *= 60;
> -	case 's':
> -	case 'S':
> -		/* Seconds */
> -		break;
> -	default:
> -		printf("Unknown runtime suffix: %s\n", endptr);
> -		v = 0;
> -		break;
> -	}
> -
> -	return v;
> -}
> -
> -static int parse_mem_size(char *str, uint64_t *val)
> -{
> -	char *endptr;
> -	int v = strtol(str, &endptr, 10);
> -
> -	if (!*endptr)
> -		return v;
> -
> -	switch (*endptr) {
> -	case 'g':
> -	case 'G':
> -		v *= 1024;
> -	case 'm':
> -	case 'M':
> -		v *= 1024;
> -	case 'k':
> -	case 'K':
> -		v *= 1024;
> -	case 'b':
> -	case 'B':
> -		break;
> -	default:
> -		return -1;
> -	}
> -
> -	*val = v;
> -
> -	return 0;
> -}
>  
>  static int workload_select(char *name)
>  {
> @@ -702,7 +639,7 @@ static void parse_options(int argc, char *argv[])
>  			}
>  			break;
>  		case 'D':
> -			g.runtime = parse_runtime(optarg);
> +			g.runtime = parse_time_string(optarg);
>  			if (!g.runtime) {
>  				printf("Illegal runtime: %s\n", optarg);
>  				exit(1);
> @@ -736,7 +673,7 @@ static void parse_options(int argc, char *argv[])
>  			}
>  			break;
>  		case 'm':
> -			if (parse_mem_size(optarg, &g.workload_mem_size)) {
> +			if (parse_mem_string(optarg, &g.workload_mem_size)) {
>  				printf("Unknown workload memory size '%s'.\n\n", optarg);
>  				exit(1);
>  			}
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
