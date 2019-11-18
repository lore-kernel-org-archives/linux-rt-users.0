Return-Path: <SRS0=mQuZ=ZK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EA5C432C0
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Nov 2019 19:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A0122304
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Nov 2019 19:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFSO8Q0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKRT0I (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Nov 2019 14:26:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40604 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKRT0I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Nov 2019 14:26:08 -0500
Received: by mail-wm1-f68.google.com with SMTP id f3so555562wmc.5
        for <linux-rt-users@vger.kernel.org>; Mon, 18 Nov 2019 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kx2aeaW/JXoY5IDkAFq8ZkBBeR5HOrvwDu9oUDhPsXU=;
        b=PFSO8Q0BZAPiZFp0hAEQHQNlXK8B7F0PAQ8mYG8OGlhsEaxpzIHfzOwfwJjb7Q6OzJ
         Ag7+uDTXfaUwurgEUf2SX4g3RGZjuO7i6AxdsunJPFiXSIsM/5RhBd23WiQJ2dLg038E
         Sj/S5ztsGy2SqAm2bOrpJ/N+hGPAZE8i7zZXdMfXKi7VmjgEN2WdS28/SS32W1keb+7s
         uDYdfGzdb/Gh9luWrDVpVHroRttWRci67tYlpJYkZdf694ZNM5UMjA4E7Y8q1fqC3mAM
         /OSa2y/SmPjJAb4hIVvw+3jopKFjPOdllUUPwjJy9eUL4SddywN+FhcjbC3T9pbggEkQ
         1u5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=kx2aeaW/JXoY5IDkAFq8ZkBBeR5HOrvwDu9oUDhPsXU=;
        b=QZDr6UE5LGiWUDleHo7hrWxJ4sLcCJ3gN5LVB5J6iv5h1bgEpEnGjsHvZNhDmDmHo1
         oOe/QqMnWmHrZR9mHb+4F/ECw+owh1j7bVahOmvz1guDwUIsbVg6b8V/aOyZ4UfyiIYn
         +yjh1ZriYM4FD2xaHU1Rry1tgrsDpE3Nc7GsqamYfD6qL/7TU2GsRcDWTfBHTpr1FbB8
         zjSymt6pkRoBKyr4ywEiQgnaXo6YWvaV3+CIOKEm9LefDvAIRUX6tlj0DnNgF+9nd239
         iC7kIS80frgmRMVVzYyfBWihEInybfF/gPWJldoFNFRaEBmRvOzBZeh/kAbwlRkMFmwh
         sGiw==
X-Gm-Message-State: APjAAAV3EjVNmsefRoEKQ+rIwL6LFFxmbaW8N6AOpxJEE64eg6UHIJtI
        OwKo3siOvVsh9q1B+j3wQrw=
X-Google-Smtp-Source: APXvYqw91VLXrecf8uVX5IS04/enAYqLublAp6i58D7ajF0ZUZgIIpzdpqYSEBDQC4bNvip18KJvag==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr941030wmj.20.1574105166457;
        Mon, 18 Nov 2019 11:26:06 -0800 (PST)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id u26sm404415wmj.9.2019.11.18.11.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 11:26:05 -0800 (PST)
Date:   Mon, 18 Nov 2019 20:26:02 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <ukleinek@debian.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests] cyclictest: fix typos
In-Reply-To: <20191117214038.28094-1-ukleinek@debian.org>
Message-ID: <alpine.LFD.2.21.1911182025450.30318@planxty>
References: <20191117214038.28094-1-ukleinek@debian.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1730636893-1574105165=:30318"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1730636893-1574105165=:30318
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

Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-1730636893-1574105165=:30318--
