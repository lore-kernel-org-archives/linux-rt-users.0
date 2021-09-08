Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20459C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 18:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BA761131
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhIHSKV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43958 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhIHSKU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 14:10:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631124551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/j4q6wtvqGkwiOTTCvShqHWyOB+pUUWKGgP9RbxGqQE=;
        b=XUbMpRuOncsRJiJuqzwxQGCff0CJr1/7Zumq14hOXjsEF8M/agilkq0ARd0zYc/ZWLKHB8
        +kfZiTWjJGsySFI8ji7PRCM+/5tigMqxe6+Cv9zfm6OWIu95vVe2KUQth5GJexb1wTxXcw
        eOYwg21qJm3axDBF2QMEUEsqnj9RRMc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-ePEMAno4NpigbwybqjgFfA-1; Wed, 08 Sep 2021 14:09:10 -0400
X-MC-Unique: ePEMAno4NpigbwybqjgFfA-1
Received: by mail-il1-f199.google.com with SMTP id d4-20020a923604000000b0022a2b065b0aso2332366ila.11
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 11:09:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/j4q6wtvqGkwiOTTCvShqHWyOB+pUUWKGgP9RbxGqQE=;
        b=Y0KCt01cZMj9QCJr1YRsoOe02mVNF9DOc9vdJebpdWnrhuAE3YJ13EVjFYiLp/L+Rw
         KBWK1/rt1Krnx0U0h1cP1F8HgnHj6dKfpYR9oDnSU/hiOQX8wpKcu1eRzOOEt+I2V+lp
         dGn9HOKjTZ+X83FC5dULBCKvxSCp82iFIsgoGllAfblEpIpA0M3Z3+ZyXq64zpdbQwPF
         1MDUckhELs2EE6xzqGV8MaUP7WB3EuSe0+kkneNEU0I7YWgMUavT1+0NYvpkeitYl0MV
         Eu5Z0HX9a07d6U1cK62+Yn2JSjQiuQi2EryIwJL0yI9wxhiXOM2d5owWdudKqe5bMzaX
         y7tQ==
X-Gm-Message-State: AOAM533pETXqb2MPEqZ9nig8SE3QfX7WELJSy7JMK3vBL2QIkGc/9AM7
        dzihBplJbokEhovmPuu6bj/EpQ04a9toGmfoue40I/GkMDkqTKEwTjiZsQfzqKKYQCR1PuiGwYL
        WKo+tPPQ64aIXCY0vsPZOZ70eWzI=
X-Received: by 2002:a05:6e02:104b:: with SMTP id p11mr892462ilj.21.1631124549038;
        Wed, 08 Sep 2021 11:09:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwd25P78jXeeWeYh6cP8PnIa8Ea5pDmCFKeThEsUh3gP2bsoYMU9o6YgJ06Ul+6nmnOFtaFng==
X-Received: by 2002:a05:6e02:104b:: with SMTP id p11mr892447ilj.21.1631124548762;
        Wed, 08 Sep 2021 11:09:08 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id c10sm1450998ilq.77.2021.09.08.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:09:08 -0700 (PDT)
Date:   Wed, 8 Sep 2021 14:09:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
Message-ID: <YTj8Qgawnh1xPrDJ@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <20210908100209.118609-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908100209.118609-2-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 08, 2021 at 12:02:08PM +0200, Nicolas Saenz Julienne wrote:
> The callbacks are based on Linux's implementation:
>  - CNTVCT_EL0 provides direct access to the system virtual timer[1].
>  - 'yield' serves as a CPU hint with similar semantics as x86's
>    'pause'[2].
> 
> [1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
> [2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  src/oslat/oslat.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index a4aa5f1..bd155a6 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
>  {
>  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
>  }
> +# elif defined(__aarch64__)
> +#  define relax()          __asm__ __volatile("yield" : : : "memory")
> +
> +static inline void frc(uint64_t *pval)
> +{
> +

newline to drop?

> +	/*
> +	 * This isb() is required to prevent that the counter value
> +	 * is speculated.
> +	 */
> +	__asm__ __volatile__("isb; mrs %0, cntvct_el0" : "=r" (*pval));

I saw that commit 27e11a9fe2e2e added two isbs, one before, one after.  Then
commit 77ec462536a1 replaced the 2nd isb into another magic.  This function
dropped the 2nd barrier.  Also, the same to compiler barrier "memory" that's
gone too.

Is it on purpose to drop them?

No experience on arm, so just raise this up.  Thanks,

> +
> +}
>  # else
>  #  define relax()          do { } while (0)
>  #  define frc(x)
> -- 
> 2.31.1
> 

-- 
Peter Xu

