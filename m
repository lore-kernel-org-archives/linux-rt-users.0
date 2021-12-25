Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB40C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 Dec 2021 16:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhLYQ6z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 25 Dec 2021 11:58:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229914AbhLYQ6z (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 25 Dec 2021 11:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640451534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zM9g1KIdjyzUbUJ7u9e0tSY0HDcWC9xTH+no9Z9M1DA=;
        b=VbNxce1p2DX0gpcJc7a+nfTy78i5vy7JjujlQrI9PIKKJLhssuDh/uGLwTFl5da6rfg+Ef
        7AVHgYv4CXspmvFTmzTPsk+KMI//08Fs1kv2IV22nVVwLLmKzslYy7+YU5s9QMlOCN4+Tf
        1e0qgQF1lQiqwyrUuOC+maBQOtulBc4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-xRBBDSwROgKP7t1t6kkwBg-1; Sat, 25 Dec 2021 11:58:53 -0500
X-MC-Unique: xRBBDSwROgKP7t1t6kkwBg-1
Received: by mail-qv1-f70.google.com with SMTP id fq14-20020a056214258e00b004112371dccaso9216890qvb.0
        for <linux-rt-users@vger.kernel.org>; Sat, 25 Dec 2021 08:58:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=zM9g1KIdjyzUbUJ7u9e0tSY0HDcWC9xTH+no9Z9M1DA=;
        b=oE3AXrvMptpc5BxPH56HLdfOLSKqpRm27zTl1Mo2gbNnXEV4cM/xM8UuhS9oWJhsFY
         N/IsZq0EaBWoeXKQ1X1qIKVWxSI45YDnFF+IJA3gDvnt5mTs56L3SY4G2rpAs7xXGIRC
         Rmy0PGKGcaDimQbVisANjnkpALDTUs/NW8VROleirjlgSOL3/FFuH06+1cGFXbbFts7k
         I8qFZiJiPZkGp0X8crGD1ycX1L3JvD7JJXaYTNshgIpqDSxtkmNZ6tTOOhecOHGKW/0M
         J+a3W8z17p9WFL8adNqk/neEuwj/AVOx10sRRu2nvwHXuwk857Kl4ftUvVDJp3+O3g3w
         IsBA==
X-Gm-Message-State: AOAM533o1L8nbzr3SRiOswJuhzGoFokU5NtUM8RhFpJ2HDzrswWrQ82v
        RjNLaei8pwAKPjYfrETjuav7vMdHBvIkjBL9piz+UxcPOXObuDG2rX4vzdvQYp9AXJgj5Vh+ifJ
        KJw6HwaPDdzclB7IOdN4ys5mq8pk=
X-Received: by 2002:a37:4015:: with SMTP id n21mr7486838qka.524.1640451532683;
        Sat, 25 Dec 2021 08:58:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPtjSN/TagN+Hn1+J50TGyXhO3RquPn0q6+731IGhTyqoA7dkRYYO0uAJPPzTT6abbK0rOFQ==
X-Received: by 2002:a37:4015:: with SMTP id n21mr7486834qka.524.1640451532455;
        Sat, 25 Dec 2021 08:58:52 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-130.dsl.bell.ca. [174.88.120.130])
        by smtp.gmail.com with ESMTPSA id w14sm9845273qkp.54.2021.12.25.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 08:58:52 -0800 (PST)
Date:   Sat, 25 Dec 2021 11:58:51 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     Oscar Shiang <oscar0225@livemail.tw>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-numa: Correct the comment of numa_initialize()
In-Reply-To: <YcSdzd3jmjV/rxBB@linutronix.de>
Message-ID: <fdfe2f7-c4f8-b8fc-c31d-ab2190c262b@redhat.com>
References: <TYCP286MB1913AD6234046FE1CF1D3877A17E9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM> <YcSdzd3jmjV/rxBB@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 23 Dec 2021, Sebastian Andrzej Siewior wrote:

> On 2021-12-23 22:01:07 [+0800], Oscar Shiang wrote:
> > --- a/src/lib/rt-numa.c
> > +++ b/src/lib/rt-numa.c
> > @@ -15,7 +15,7 @@
> >  
> >  /*
> >   * numa_available() must be called before any other calls to the numa library
> > - * returns 0 if numa is available, or 1 if numa is not available
> > + * returns 1 if numa is available, or 0 if numa is not available
> >   */
> 
> To quote the man page:
> 
>        Before  any  other  calls  in this library can be used numa_available()
>        must be called. If it returns -1, all other functions in  this  library
>        are undefined.
> 
> Based on that, neither 0 nor 1 is defined.
> 
> Sebastian
> 

Right, but the numa_initialize function is meant to wrap that in such a 
way that we only call numa_available once, and then subsequent calls will 
return 1 (or true) for numa is available or 0 (false) if it is not 
available. This wrapper could probably be omitted, but it's supposed 
to make the code more readable.

This still isn't entirely cleaned up after this functionality 
was removed during the JSON stuff that mistakenly assumed numa is always 
available at runtime. (it might not be for example on some embedded 
platforms). In some case there might still be paths through the code that 
don't call non-numa versions of the functions when numa is not available.
It's on my list to fix.

John

