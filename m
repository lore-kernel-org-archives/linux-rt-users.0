Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17809C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014156108B
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 18:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhIMSkK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229613AbhIMSkJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 14:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631558333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uF0kRKKhWN6NhGXpFSCDkvtUOYZ8+Kmf3q1tKg0p9YU=;
        b=XXZERx4Wo4geLjLl5sQheny8zCHr/KvCyy47Q9GJxSEtfQ+vLXqyFqnw0SfxQs3JKjahk1
        BzztB/0n1g9wmhgY0hff5yM3i5CmB9qsOEmnsqCmDCPfAYi17rO7GZBZ1TdwWODhmp5Qd0
        g0b0egC9a5rdo/WU97LfoA7bvU0sdQA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-QiOAuwMJPSu5HltAG8r7XA-1; Mon, 13 Sep 2021 14:38:52 -0400
X-MC-Unique: QiOAuwMJPSu5HltAG8r7XA-1
Received: by mail-io1-f72.google.com with SMTP id w7-20020a5e9707000000b005c3adb2571fso14581066ioj.3
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 11:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=uF0kRKKhWN6NhGXpFSCDkvtUOYZ8+Kmf3q1tKg0p9YU=;
        b=HbC+gnGfzXrNPJmxWnV55c0r1q24F5CopqmjJ1NLEiSMZ70j7yCUp2usPFF4bWyaTV
         /Y5UBI/cjgLVaE6yP5jpcHv9zVQ0XQTqhB0XD4nc33T56sPA4VBainaNUmh2w0ca2ST4
         S8gY+6JIgYUY56U/DohpYq7NAXVsVTNabtU1IP8Pc608ZCQd5rS/uJXi0wzAqkd/AQ04
         oe79C+jr7DGa1qgyS7e+GCk08K10iQgdfR4Mjq+Fymx4POb4CwmO/mEINBhqxtJpEi7D
         +aKtXjC4E5fpfSFZnkHfoteSApq5VJyJJ2bcmYMLcpLvOAtr/u4max/GXg/h+q1NnbAm
         SDAA==
X-Gm-Message-State: AOAM5307khe9X5bFe1Ixnb4S5E8iScwaT/2aBobx44He6HlErs6LjFdf
        2gQGWE5k1KHOL/IMSgNUymAzmlrF+ozcgCsP8cn9DR+nWvum4ruCk70+TqsS3U2Jbxvnhif7Bv0
        GO1cAQa06j6XNt+4k/QajwpEaHro=
X-Received: by 2002:a05:6e02:8a7:: with SMTP id a7mr9628700ilt.246.1631558331609;
        Mon, 13 Sep 2021 11:38:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn+bD1c2gYyEvZ4lxcQMfQdhTy0kmiTe7Nckww/8h4xYmc9WLlyhbv+Ij2SVmThCnO5kmOdw==
X-Received: by 2002:a05:6e02:8a7:: with SMTP id a7mr9628693ilt.246.1631558331477;
        Mon, 13 Sep 2021 11:38:51 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t25sm4973425ioh.51.2021.09.13.11.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:38:51 -0700 (PDT)
Date:   Mon, 13 Sep 2021 14:38:50 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH v2 2/3] oslat: Add aarch64 support
In-Reply-To: <20210913083908.48408-2-nsaenzju@redhat.com>
Message-ID: <7b2942f3-2868-b424-ab8a-2cb2215720a3@redhat.com>
References: <20210913083908.48408-1-nsaenzju@redhat.com> <20210913083908.48408-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Sep 2021, Nicolas Saenz Julienne wrote:

> The callbacks are based on Linux's implementation:
>  - CNTVCT_EL0 provides direct access to the system virtual timer[1].
>  - 'yield' serves as a CPU hint with similar semantics as x86's
>    'pause'[2].
> 
> In contrast with the kernel's implementation, there isn't a need for
> isb() after reading CNTVCT_EL0,  this is only needed in-kernel as the
> register read has to be ordered with a subsequent locking operation.
> 
> [1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
> [2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> --
> 
> Changes since v1:
>  - Code cleanup
>  - Add compiler barriers
> 
>  src/oslat/oslat.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 33cccd3..c90ec1a 100644
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
> +	/*
> +	 * This isb() is required to prevent that the counter value
> +	 * is speculated.
> +	 */
> +	__asm__ __volatile__("isb" : : : "memory");
> +	__asm__ __volatile__("mrs %0, cntvct_el0" : "=r" (*pval) :: "memory");
> +
> +}
>  # else
>  #  define relax()          do { } while (0)
>  #  define frc(x)
> -- 
> 2.31.1
> 
> 
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: John Kacur <jkacur@redhat.com>

