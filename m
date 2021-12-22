Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A008EC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Dec 2021 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241535AbhLVPpN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Dec 2021 10:45:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233016AbhLVPpM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Dec 2021 10:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640187912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i23ORseos/c3A6ZBYaSI04neYd4imjzDs5ZEFtOMTd8=;
        b=gQwZRk7XjNjkWnWmwkr83wN76Ekia6WzgKqM5LA+xttd1RBrIfVl8E1+LYaShWVlWEcX36
        qV2fX1s8hClGfKWsBfYbiINnLjvMuheMgI4qJ5WaoH8l3V2QCITR96ljgCv2ZxRVWvqX0i
        o6k4GoheG7aGvQB0zCa2nsTjgElQLPg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385--95ELEuiPrq2LfNPcwx_iw-1; Wed, 22 Dec 2021 10:45:11 -0500
X-MC-Unique: -95ELEuiPrq2LfNPcwx_iw-1
Received: by mail-qk1-f197.google.com with SMTP id c1-20020a05620a0ce100b00468060d41ecso2001984qkj.19
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Dec 2021 07:45:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=i23ORseos/c3A6ZBYaSI04neYd4imjzDs5ZEFtOMTd8=;
        b=1wacEVvo55Ojy56x5tV/GyNawpi9Payi3qhK3AQXa/tEXHmCPpZDv7HQgJQM5KLF6s
         H0eUriqKDE6dUo7joYgkiBlIjReRW80XX4Yyi+T0hGZ53hPcDXuBgLYeOvqVO8qXnrNw
         MIpOJoJxqvX6Wgh4r1TPQi6kCK6B+ybJ4UO3j+bXZbTtU5GPfZqnsdjcN8c7ViZHrrfh
         7fWrouEqkObU1H/8Z0mbekV/xiwwTQ7Tfy8pQbXCaLwspn6uMswm8nsiL6e3BX5xMSMz
         GXCxnDXlcjlJS82ZRdNAD5l9bqN2sm2siJHh79wXQx+mfiTTyjm9sGunwfQiWwoIdCO2
         7lcA==
X-Gm-Message-State: AOAM533KWCXzQT9FanO/NJktrdHmQQPyS1lP8Qvl7FtrDuTyO8Yxqp4w
        ZZj1oHEvFRUASgNwMxIbJ6h3ToMMlVuYPP7pXaSMDAoxPJvTYC6lxfw2vZBp+EKnUgrhjP0sMe/
        /n9OiyyZK9PUUJ4O170TcRPFqBmY=
X-Received: by 2002:a05:622a:8d:: with SMTP id o13mr2548157qtw.574.1640187910479;
        Wed, 22 Dec 2021 07:45:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw58U85enAzws88zvRYzWBmNoXHZQ9LzpvzDg7R3nBYQponE8VQVnDQ5ybpI75g25oFlG+7EA==
X-Received: by 2002:a05:622a:8d:: with SMTP id o13mr2548147qtw.574.1640187910293;
        Wed, 22 Dec 2021 07:45:10 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-130.dsl.bell.ca. [174.88.120.130])
        by smtp.gmail.com with ESMTPSA id f18sm2247120qko.34.2021.12.22.07.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 07:45:09 -0800 (PST)
Date:   Wed, 22 Dec 2021 10:45:08 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Oscar Shiang <oscar0225@livemail.tw>
cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH] rt-numa: Fix the value to check in numa_initialize()
In-Reply-To: <TYCP286MB1913E08DE65A54E19F3286F3A17D9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <edf1dff-ec8-c42b-d1c-8fba1b96d36d@redhat.com>
References: <TYCP286MB1913E08DE65A54E19F3286F3A17D9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 22 Dec 2021, Oscar Shiang wrote:

> According to numa(3) [1], all numa functions are undefined if
> numa_available() returns -1.
> 
> Thus numa_initialize() should not return 0, which indicates
> libnuma is available, if numa_available() returns -1. It should
> return 1 instead.
> 
> [1]: https://man7.org/linux/man-pages/man3/numa.3.html
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
> ---
>  src/lib/rt-numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index bb0121a..47a643e 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -25,7 +25,7 @@ int numa_initialize(void)
>  	if (is_initialized == 1)
>  		return numa;
>  
> -	if (numa_available() != -1)
> +	if (numa_available() == -1)
>  		numa = 1;
>  
>  	is_initialized = 1;
> -- 
> 2.25.1
> 
> 

No, it looks to me like the code is correct but the comment is incorrect.
If you submit a patch fixing the comment, I'll apply it.

Thanks

John

