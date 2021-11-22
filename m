Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDAC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Nov 2021 04:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhKVEJ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Nov 2021 23:09:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229983AbhKVEJ2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Nov 2021 23:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637553982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kj6CybzpWBiHR12Em6aJVbIrzOj70LvvxlVRFAYw9DQ=;
        b=icdamKvV1G2FOkpIDMZhKfh8MnIcldUxLCZQdThRf6+tcxYw/iUMpbaTm8piErEPGRz8cf
        YBwhy/0awq8MfPEhaHbWmVebb3JAfVhAvt5yzWUkdCGsXIiIcntLD6SxX3FYdtQqo59Kky
        yy+K5/2hBikBEA/aqBAOnx2exXqMDS4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-0f2iWVVZNdutJnzeUcRGrA-1; Sun, 21 Nov 2021 23:06:20 -0500
X-MC-Unique: 0f2iWVVZNdutJnzeUcRGrA-1
Received: by mail-qv1-f72.google.com with SMTP id fw10-20020a056214238a00b003c05d328ad2so15498613qvb.2
        for <linux-rt-users@vger.kernel.org>; Sun, 21 Nov 2021 20:06:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Kj6CybzpWBiHR12Em6aJVbIrzOj70LvvxlVRFAYw9DQ=;
        b=DjknLWVFNCwAe5WoOO/k7GLBEz3Zdc486u18cOsgDNGOFrTmDssGesfE/UPh06wQCu
         A063hNqoVHMjTc2IOxHHHA1AabV2GaOkQfxG2ZpGco3END4czKlDDCciP91DMeCSS6hw
         xmXJhNjDjPhN162UvM2TVDtFWQphHx5plCXX0VDvnw968RXjWo2iSA1xF1awVrnueC3G
         BOpV/YAGsErgc18t9xorjVUGIp9MDFplFnuwlRRwfcnp7HbPMDnCSzrJvar/KnDivakI
         2f4qG1fIEu5kvsfXkDQ7MLRg2cGPF4WLGAuISIjDLYiZ9cidbPkk7Y0D1X/K56wtzmUB
         YQmQ==
X-Gm-Message-State: AOAM533zGiM9oBWLK+pNpcBaV3XYXoRcyaJ8zI6Hc2JYc2MV9w2CkqO7
        obMRZ2bZT2pqGAhf1TxlrAUw2POX/N9hlLPd9hayAlN7L+Dqqhwq7qpe0U5+sHIRCW+91Z8f0nZ
        Gu5ga7aEVNYImYSiigKnb3uQoYl4=
X-Received: by 2002:a05:620a:25c7:: with SMTP id y7mr44721581qko.437.1637553980496;
        Sun, 21 Nov 2021 20:06:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygFxNtzY2+oGMy0V7iupiDCZRZv7IYlQ6drt9Wu/Uo6cgWSgDIUq7W0mu2DaUKMmnPjCxwJA==
X-Received: by 2002:a05:620a:25c7:: with SMTP id y7mr44721561qko.437.1637553980278;
        Sun, 21 Nov 2021 20:06:20 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-95.dsl.bell.ca. [174.88.121.95])
        by smtp.gmail.com with ESMTPSA id f12sm3530968qtj.93.2021.11.21.20.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 20:06:20 -0800 (PST)
Date:   Sun, 21 Nov 2021 23:06:18 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Oscar Shiang <oscar0225@livemail.tw>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: cyclictest.8: Remove reference to -n in --system
 in manpage
In-Reply-To: <TYCP286MB19132EF284A2822EB8C64055A19E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <42b5f12c-79a-9a8-e4f8-166ac9c98bc0@redhat.com>
References: <TYCP286MB19132EF284A2822EB8C64055A19E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sun, 21 Nov 2021, Oscar Shiang wrote:

> clock_nanosleep is default now.
> There is no need to use -s with -n.
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
> ---
>  src/cyclictest/cyclictest.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
> index dcae5b8..1cc72e6 100644
> --- a/src/cyclictest/cyclictest.8
> +++ b/src/cyclictest/cyclictest.8
> @@ -137,7 +137,7 @@ Check clock resolution, calling clock_gettime() many times. List of lock_gettime
>  align thread wakeups to the next full second and apply the optional offset.
>  .TP
>  .B \-s, \-\-system
> -Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s in combination with \-n uses the nanosleep syscall and is not restricted to one thread.
> +Use sys_nanosleep and sys_setitimer instead of posix timers. Note, that \-s can only be used with one thread because itimers are per process and not per thread. \-s uses the nanosleep syscall and is not restricted to one thread.
>  .TP
>  .B \\-S, \-\-smp
>  Set options for standard testing on SMP systems. Equivalent to using
> -- 
> 2.25.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

