Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A485C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 18:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4333D61041
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 18:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhIHSRU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 14:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233322AbhIHSRU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 14:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631124971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iytigPz3Y85xtbTRaKagrVG/EYermnbNcHKUwuifyxc=;
        b=fp4WI1LVNn5bE1pQ6XqRu1pUjVoRtsP1USyGgBKoLWIT+mikLOaQNaoBoUF5fE1HnlDBNq
        WfM7ROv5x2l6gvbAoXCAN6bGvNLfBfqNoNkuCZiXBTUE7f80M3KTRx0TCBN6I+i/iyy0e/
        6y2u7yW5tVpXkwS1LgL1Bg63dm3lezA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-0OM4AWnCOg2edkdODtnb4Q-1; Wed, 08 Sep 2021 14:16:10 -0400
X-MC-Unique: 0OM4AWnCOg2edkdODtnb4Q-1
Received: by mail-io1-f72.google.com with SMTP id z26-20020a05660200da00b005b86e36a1f4so2445932ioe.15
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 11:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iytigPz3Y85xtbTRaKagrVG/EYermnbNcHKUwuifyxc=;
        b=LPkcIcMAgefx7m6NNPxadd1Z5hQuqSdTsUa56ZkFLVhBYoGO5oxu6hqjQArfhgrYqR
         JYBjrA/hsdHilvY/zV2rUg0IU1K9JX1iO1FlkhWudVv5M13bRlINQ8RE01y/Eqvb16YM
         OD6mgeJVpob3h/xkxSPEzCUPHa3TyX37F5R6XmFC8YAH+3mde/D/c22QrVLO0v/CEBTS
         LNxXGGF2SWhUC1GWK1Iz+6Vg/l6Zh8PAuwVvo0wDh8WJAdesvP/7gytBWH9Z/rwd0csB
         4oAnOSIXFOF/K2wfz7qeThu9bsLuJqvCiR/QHTWkrYzgZXC1d3Z9VlkhQqOEmS+RlKPa
         evdg==
X-Gm-Message-State: AOAM5338PBVrSgFfWV/DynM7CFFX/XIQpqvRndJmaPSYRyZH2V9XnI+f
        1ezLGkoqj20BX3nJFRwZFzL0DTej+Xsv9vlrvR/QsqHAw+Qu+N5MuUmpJ4HP4R9nQzIYQkgWhiF
        yrndQEDEWWH6Ti+iEq2epJjW4tGU=
X-Received: by 2002:a05:6602:218d:: with SMTP id b13mr964726iob.143.1631124969382;
        Wed, 08 Sep 2021 11:16:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4JTdg56EvQA/Z12cYdV0alaWvc7daalGZZzY9T5Xzx/6jrn4jhT3SLlGdvVXcpqp3QgkIpA==
X-Received: by 2002:a05:6602:218d:: with SMTP id b13mr964710iob.143.1631124969074;
        Wed, 08 Sep 2021 11:16:09 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id h1sm1452060iow.12.2021.09.08.11.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 11:16:08 -0700 (PDT)
Date:   Wed, 8 Sep 2021 14:16:06 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 3/3] oslat: Allow for arch specific timer frequency
 measurements
Message-ID: <YTj95hq7BzfWsK2v@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <20210908100209.118609-3-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908100209.118609-3-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 08, 2021 at 12:02:09PM +0200, Nicolas Saenz Julienne wrote:
> Some architectures have special purpose registers to query the system
> timer's frequency. Let's use that when available.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  src/oslat/oslat.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index bd155a6..23ca9b6 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -51,6 +51,9 @@
>  # define atomic_inc(ptr)   __sync_add_and_fetch((ptr), 1)
>  # if defined(__x86_64__)
>  #  define relax()          __asm__ __volatile__("pause" ::: "memory")
> +
> +#define measure_timer_mhz generic_measure_timer_mhz
> +
>  static inline void frc(uint64_t *pval)
>  {
>  	uint32_t low, high;
> @@ -61,12 +64,18 @@ static inline void frc(uint64_t *pval)
>  }
>  # elif defined(__i386__)
>  #  define relax()          __asm__ __volatile__("pause" ::: "memory")
> +
> +#define measure_timer_mhz generic_measure_timer_mhz
> +
>  static inline void frc(uint64_t *pval)
>  {
>  	__asm__ __volatile__("rdtsc" : "=A" (*pval));
>  }
>  # elif defined(__PPC64__)
>  #  define relax()          do { } while (0)
> +
> +#define measure_timer_mhz generic_measure_timer_mhz
> +
>  static inline void frc(uint64_t *pval)
>  {
>  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
> @@ -74,6 +83,15 @@ static inline void frc(uint64_t *pval)
>  # elif defined(__aarch64__)
>  #  define relax()          __asm__ __volatile("yield" : : : "memory")
>  
> +static inline unsigned int measure_timer_mhz(void)
> +{
> +	unsigned int val;
> +
> +	__asm__ __volatile__("mrs %0, cntfrq_el0" : "=r" (val));
> +
> +	return val / 1e6;
> +}
> +
>  static inline void frc(uint64_t *pval)
>  {
>  
> @@ -257,7 +275,7 @@ static cycles_t __measure_timer_hz(void)
>  	return (cycles_t) ((e - s) / sec);
>  }
>  
> -static unsigned int measure_timer_mhz(void)
> +static unsigned int __attribute__((unused)) generic_measure_timer_mhz(void)

This is okay I guess, but does not look nice, as it's marked unused even if
it's used..

How about for any arch that supports a faster version to read the freq, do:

#define measure_timer_mhz_fast
unsigned int measure_timer_mhz_fast(void)
{
    ...
}

Then at entry of measure_timer_mhz():

#ifdef measure_timer_mhz_fast
    return measure_timer_mhz_fast();
#endif

I'm also wondering the diff between the two methods on arm64 and whether
there's a huge difference on the numbers.

Thanks,

-- 
Peter Xu

