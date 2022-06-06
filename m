Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C11DC43334
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Jun 2022 07:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiFFH5Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Jun 2022 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiFFH5Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Jun 2022 03:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F2A310569
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Jun 2022 00:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654502241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFzWbbGOAuDoE6lidNFOJzN0ibGR06rBCInXD94lxCQ=;
        b=BFQ3/KiQkGxfuTHt9UTtJRQ2Kmz+oFAbrwftI/cpqXvczeBnuUsDQa359PfwczW4vOYLGK
        g8J1qPRWANxpYN/8+glRiEcNi+/JNfxjJIPXyvLnTECD9QSnR3qVXioWin5S8PRtxbLKQ7
        ojZdx0fSP+Ycqd+BpXbdABLO1eAZn7o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-FtJUn7uoMPOqd5Gszg2ftQ-1; Mon, 06 Jun 2022 03:57:18 -0400
X-MC-Unique: FtJUn7uoMPOqd5Gszg2ftQ-1
Received: by mail-ed1-f69.google.com with SMTP id x8-20020a056402414800b0042d8498f50aso10043699eda.23
        for <linux-rt-users@vger.kernel.org>; Mon, 06 Jun 2022 00:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NFzWbbGOAuDoE6lidNFOJzN0ibGR06rBCInXD94lxCQ=;
        b=512BdfVO1ZN4zPPD5ugJ7DWhEEmoRfWxphaEkTTqQM0cw10lVMZzBiM6JUN8qhYZKv
         Fe8rI32ZguOzcl4Mt8FH9+1wwlPDlhB31tGGhcdiIalWRiySqru7n8S4Ss8Y5X2sIya8
         ucpgh+w8J9Jb/bPCvItaHZIZ9sg40iN+Mn4Vzo2CXAVGIRNJDM8STH4LfYHCa4nnpsc1
         GZcoRzJlAoGCPtwYhiVoxwD7zUmzkMR+MJ+XC+2kbC13/yKpS50A3glMyvj/ig4XLgZh
         MD6/xABJ6HuTuoDj1sj1oTGRx0MR5xQNm+5OBRyRaV7byZM8YJgEHsiAGLhoBTcsk5B2
         /k5Q==
X-Gm-Message-State: AOAM531S+zCaIMp/sORUB5GyAbh/DoLTwb1bTtU+B+iaZFJwG1+ZFmMu
        k8cqcs1Nh9EG5I1YjOvr+rX8Mu4qFQR6dJOXf/k63V58YpZgwaOQH8OzWAUmXO4747OeB7bYvXP
        zNRuknro4JW7l8/qf2nE4+FnUUEE=
X-Received: by 2002:a17:907:608b:b0:711:623e:b344 with SMTP id ht11-20020a170907608b00b00711623eb344mr7827860ejc.230.1654502237402;
        Mon, 06 Jun 2022 00:57:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxj2RFSIdjaxc5acpawDGLZ7PsugMj2KomIGsOmjJuDTwW63CJozVgUHCLK92kxlcHt1k5kcg==
X-Received: by 2002:a17:907:608b:b0:711:623e:b344 with SMTP id ht11-20020a170907608b00b00711623eb344mr7827850ejc.230.1654502237129;
        Mon, 06 Jun 2022 00:57:17 -0700 (PDT)
Received: from [192.168.0.198] (host-95-248-229-226.retail.telecomitalia.it. [95.248.229.226])
        by smtp.gmail.com with ESMTPSA id p19-20020a056402155300b0042617ba638esm8128127edx.24.2022.06.06.00.57.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 00:57:16 -0700 (PDT)
Message-ID: <e5371317-6a37-f4fc-9f06-e1a9d871f6f8@redhat.com>
Date:   Mon, 6 Jun 2022 09:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [Question] SCHED_DEADLINE behavior when HRTICK_DL is disabled
Content-Language: en-US
To:     Sharan Turlapati <shatur.linuxrt@gmail.com>,
        linux-rt-users@vger.kernel.org
References: <9ae1d599-4514-9c22-f5a0-7176ffe98820@gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <9ae1d599-4514-9c22-f5a0-7176ffe98820@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 6/6/22 09:08, Sharan Turlapati wrote:
> I had a question about the task admit policy of SCHED_DEADLINE tasks when
> runtimes are in the submillisecond range (which we come across quite often in RT
> ) and HRTICK is disabled.
> 
> For the kernel to be able to keep track of task runtimes in the microsecond
> range, I notice that it uses HRTICK_DL.
> 
> If HRTICK is disabled or not supported, the kernel still admits tasks with
> runtimes in the microseconds range, and but since now we're relying on the
> scheduler tick (which is in the order of milliseconds), these tasks overshoot
> their runtime and end up getting penalized which result in their deadlines being
> pushed out.
> 
> My question is, if the kernel cannot reliably track the runtimes in the
> submillisecond range without HRTICK being enabled, should it not reject these
> tasks first up? something along these lines -
> 
>  ---
>  kernel/sched/deadline.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fb4255ae0b2c..0d46ae0c92ec 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2916,6 +2916,21 @@ bool __checkparam_dl(const struct sched_attr *attr)
>      if (attr->sched_runtime < (1ULL << DL_SCALE))
>          return false;
> 
> +    /*
> +     * If sched_runtime < 1ms, then ensure that hrtick is
> +     * is supported/enabled.
> +     */
> +#ifdef CONFIG_SCHED_HRTICK
> +    if (attr->sched_runtime < NSEC_PER_MSEC)
> +    {
> +        if (!sched_feat(HRTICK_DL))
> +            return false;
> +    }
> +#else
> +    if (attr->sched_runtime < NSEC_PER_MSEC)
> +        return false;
> +#endif
> +

This is not complete as it ignores the tasks where the runtime is not "round" on
milliseconds.

But then the problem becomes worse: to be precise in the milliseconds for
throttling, the task would have to be always dispatched at the "clock tick" to
be precisely accounted for.

Thus, this is not the way to go.

As it is now, the admission control tries to avoid problems, not to provide
guarantees. The user should be aware of this, likewise, of other factors that
impact this lack of precision: for example, preempt disable
sections/non-preemptive kernel...

--- Daniel

