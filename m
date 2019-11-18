Return-Path: <SRS0=mQuZ=ZK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED3EC432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Nov 2019 19:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BB322304
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Nov 2019 19:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="osVGdZga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRTYd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:24:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40340 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfKRTYd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Nov 2019 14:24:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id f3so549747wmc.5
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Nov 2019 11:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zqVVY5j5PqT7Vc1Zg5Y7PR86aVSvb4IE8aKM6F2pLts=;
        b=osVGdZgav9J/sc8wZffth51bq6jPvaktkVOly4GMtYFN6E9csLv35ZmF0zrwV6obln
         3TJCMhwiw0VTj/RjvTI+aIutzKG4AnCz5l0eH0XQFkjTDXzwz3VlPwrXgHeEfCihr2vw
         TD+jjnaZvEY/B2OCuIWqBqmEvJO52iw8+QjsKfc3b2AzEXPQxHWFLmig/z8FN9cxnZaz
         EpWgM//e8+2sLNYso/XDdQ9/bAkSAebJbqJiWIUxjA6FubvhLefia8TK+9KqyzxWbLwh
         7uq2kYuQzqCFxH974yuqWOwuxBom0V4VvmXgk9CTKEfMYtwmYJs3pdu5SHxd2ohdgmAg
         FlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=zqVVY5j5PqT7Vc1Zg5Y7PR86aVSvb4IE8aKM6F2pLts=;
        b=n7z8rXdvxYsi9ev3Et3f8z3C3F06Nd4LEagtuQ6UMKMdgixtLwXh8gyJWhivihWsez
         z2edvilNf6xrpyfe5GY/tMjSzNBLXfK3DYLG3jeQqr1K+pTJoXQws71FeYgpF0eIhi8t
         6X3Vtqp3vA9xBF4Z+CUoZ8vyoxp/Ce4yxlSENr8JJxetrZAXmI2upYFYm/FqrZEbduK8
         /GS/MrEMyIzYawHIjP81oZbB5KUtelkaEPgH8CcO0N04iHUmTZqZ/XEVmQu15bRD8o7t
         Mmi/G9eRF3vLqRQAkzxrQY4/jRC6DQUslNRPtc+t9izTey/FuPJg8KEeJQRbuaT58dex
         zqpQ==
X-Gm-Message-State: APjAAAVxS/rFMLhtFNhkUGRQhfJXxtmb2gRY2FNUG4P4tJWeLJR9Imqv
        5rzNdcjH3VJQ9AkIQbBUJ8kJpSMXfnk=
X-Google-Smtp-Source: APXvYqwigdykCfRiR7DU/6HPtRVsSi9kLsiwvPXu7jdTJpUzsCgPgpH44d30CQbuI/dF1y7lZ8QWfQ==
X-Received: by 2002:a7b:ca51:: with SMTP id m17mr860966wml.110.1574105067138;
        Mon, 18 Nov 2019 11:24:27 -0800 (PST)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id a5sm23656458wrv.56.2019.11.18.11.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:24:26 -0800 (PST)
Date:   Mon, 18 Nov 2019 20:24:18 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@debian.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] cyclictest: fix typos
In-Reply-To: <20191117214038.28094-1-ukleinek@debian.org>
Message-ID: <alpine.LFD.2.21.1911182023570.30318@planxty>
References: <20191117214038.28094-1-ukleinek@debian.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-476924899-1574105066=:30318"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-476924899-1574105066=:30318
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT



On Sun, 17 Nov 2019, Uwe Kleine-König wrote:

> The called function is called clock_gettime with "only" two t as can be
> seen tree lines above. Also there was a wrong r in useful.
> ---
>  src/cyclictest/cyclictest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 6be0525822ca..bca028fedffd 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -802,7 +802,7 @@ static void *timerthread(void *param)
>  		ret = clock_gettime(par->clock, &now);
>  		if (ret != 0) {
>  			if (ret != EINTR)
> -				warn("clock_getttime() failed. errno: %d\n",
> +				warn("clock_gettime() failed. errno: %d\n",
>  				     errno);
>  			goto out;
>  		}
> @@ -964,7 +964,7 @@ static void display_help(int error)
>  	       "			   but will not drain your battery so quickly\n"
>  	       "-m       --mlockall        lock current and future memory allocations\n"
>  	       "-M       --refresh_on_max  delay updating the screen until a new max\n"
> -	       "			   latency is hit. Userful for low bandwidth.\n"
> +	       "			   latency is hit. Useful for low bandwidth.\n"
>  	       "-N       --nsecs           print results in ns instead of us (default us)\n"
>  	       "-o RED   --oscope=RED      oscilloscope mode, reduce verbose output by RED\n"
>  	       "-p PRIO  --priority=PRIO   priority of highest prio thread\n"
> -- 
> 2.24.0
> 
> 

Signed-off-by: John Kacur@redhat.com
---1463804494-476924899-1574105066=:30318--
