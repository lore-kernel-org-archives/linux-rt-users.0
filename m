Return-Path: <SRS0=sIfm=UM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79579C31E45
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3A320896
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Jun 2019 15:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r121hH9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732392AbfFMPJj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:09:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52514 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732356AbfFMN53 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Jun 2019 09:57:29 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so10340953wms.2
        for <linux-rt-users@vger.kernel.org>; Thu, 13 Jun 2019 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LoluabGLsLt1BMZue6zB2DhV2Iv9NHeKGidvhQcFwhU=;
        b=r121hH9Yj30knSPvxF2/XKqUl4sWIyNDvB4Tg7FaN9omRp9AOvWN6LFvk2Qo6ncbQ/
         DtVB/w5P4BYX9UqvCLzANQZ3JbRmctRYBYC66DNRK7kzaXCXX7LStvEn9dHNOPFFZSf5
         HhDJdXGvHcod9y2Q3qeT7dlChglTtbRutMySjzyH8HLp3kQwj9VS6InaEY73YF5gJJ+A
         H/Lhv37Bq9faFmgtQ9z12uA5R0eJSfHt3aEwUhG3qsdjVJdIDTtUU3x1GMHGNA9CrvkS
         3nUJul0bDpTOgJBTCPhbeGthj2IPJV0zcLw5vzxGi1dwIZXBr4xY4DJtxJkytC8Uq+dS
         ePeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=LoluabGLsLt1BMZue6zB2DhV2Iv9NHeKGidvhQcFwhU=;
        b=UdyeI05L/oYGNhZFjcp6XPtXYY57qZRYC5+VEcFZzSx+sWQaiDKjlRnjqA9RtkNClt
         gY4AzVzzkQYEd1D7a7Z6JNFTmcpc2UjCiXYDmkvfMuP+jiOOG9kI0T4pJz5Aki6Ui+yG
         UufuniyKiCHgRcqKUk6n5zRBnYK+OTBIaQ3xcinOApJprG6tzW157qUvjIpGoysXBaOZ
         D2EDpK0MX6/sLkHv9NVRPf5RDEk+F5SCGMxZWprVIrHU167m734lR41CHqSrJe8z/0Sk
         eq71B5e/eVkyFeBRZQECjjJubObfCzEIJUfPAnpasFJ3NUHbsrnGLJa3OXhqE3yogn1y
         4VdQ==
X-Gm-Message-State: APjAAAWT7d3MziFjunxYK4/sbFVa4V8OwBGTC19G9EjgLsLLIcDEhCpW
        5fEUqHOqULNOOq33Gi/oqL4=
X-Google-Smtp-Source: APXvYqwkm0C3+DgkPDbUYjv8e055N3PtC/hf+Fug1mKYrCyXowXfCd2grFs7tLBFn2WYXEEtcWAbLA==
X-Received: by 2002:a1c:b684:: with SMTP id g126mr3889149wmf.176.1560434246745;
        Thu, 13 Jun 2019 06:57:26 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id s10sm3428635wrt.49.2019.06.13.06.57.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 06:57:25 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:57:19 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 03/12] rt-utils: Move parse_time_string()
In-Reply-To: <20190605160617.22987-4-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1906131556490.8187@planxty>
References: <20190605160617.22987-1-wagi@monom.org> <20190605160617.22987-4-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 5 Jun 2019, Daniel Wagner wrote:

> Move parse_time_string() to rt-utils.c so we can re use it.
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/cyclictest/cyclictest.c | 33 ---------------------------------
>  src/include/rt-utils.h      |  2 ++
>  src/lib/rt-utils.c          | 34 ++++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index ed59edefbf97..03d56e4f520c 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -406,39 +406,6 @@ static void enable_trace_mark(void)
>  	open_tracemark_fd();
>  }
>  
> -/*
> - * parse an input value as a base10 value followed by an optional
> - * suffix. The input value is presumed to be in seconds, unless
> - * followed by a modifier suffix: m=minutes, h=hours, d=days
> - *
> - * the return value is a value in seconds
> - */
> -static int parse_time_string(char *val)
> -{
> -	char *end;
> -	int t = strtol(val, &end, 10);
> -	if (end) {
> -		switch (*end) {
> -		case 'm':
> -		case 'M':
> -			t *= 60;
> -			break;
> -
> -		case 'h':
> -		case 'H':
> -			t *= 60*60;
> -			break;
> -
> -		case 'd':
> -		case 'D':
> -			t *= 24*60*60;
> -			break;
> -
> -		}
> -	}
> -	return t;
> -}
> -
>  /*
>   * Raise the soft priority limit up to prio, if that is less than or equal
>   * to the hard limit
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index ef0f6acf4ab5..405fa7855346 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -24,4 +24,6 @@ uint32_t string_to_policy(const char *str);
>  
>  pid_t gettid(void);
>  
> +int parse_time_string(char *val);
> +
>  #endif	/* __RT_UTILS.H */
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index ac6878ccacf1..e1b166afcd6c 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -13,6 +13,7 @@
>  #include <sched.h>
>  #include <stdarg.h>
>  #include <errno.h>
> +#include <ctype.h>
>  #include <fcntl.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> @@ -320,3 +321,36 @@ pid_t gettid(void)
>  {
>  	return syscall(SYS_gettid);
>  }
> +
> +/*
> + * parse an input value as a base10 value followed by an optional
> + * suffix. The input value is presumed to be in seconds, unless
> + * followed by a modifier suffix: m=minutes, h=hours, d=days
> + *
> + * the return value is a value in seconds
> + */
> +int parse_time_string(char *val)
> +{
> +	char *end;
> +	int t = strtol(val, &end, 10);
> +	if (end) {
> +		switch (*end) {
> +		case 'm':
> +		case 'M':
> +			t *= 60;
> +			break;
> +
> +		case 'h':
> +		case 'H':
> +			t *= 60*60;
> +			break;
> +
> +		case 'd':
> +		case 'D':
> +			t *= 24*60*60;
> +			break;
> +
> +		}
> +	}
> +	return t;
> +}
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
