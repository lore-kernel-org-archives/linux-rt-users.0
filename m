Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5314C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 10:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BFC6115B
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 10:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbhIIKab (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:30:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232519AbhIIKaa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 06:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631183360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/2dMcc8N+VMI54iZPGY5dzsB5FoXwrFEWVNThsJnkM=;
        b=NXvjRaQfd/YJ5poQbwpKJkqgr3CLkAuEFSpHNNq0XAZveCAQGCu7z50do8pfc51GRYDjyl
        kLV2BGiyQFcyLORIeOc5oCch51mtXvHmTG92HfikAwVSTXpqC4DDfhXhjBZiJi41NHx6yS
        mGDGP1i86rcoN/tVsPiVPVxAZT5W88Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-uihsgHqXM16_YW0GnO0qlA-1; Thu, 09 Sep 2021 06:29:19 -0400
X-MC-Unique: uihsgHqXM16_YW0GnO0qlA-1
Received: by mail-wm1-f69.google.com with SMTP id x10-20020a7bc76a000000b002f8cba3fd65so676687wmk.2
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 03:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=3/2dMcc8N+VMI54iZPGY5dzsB5FoXwrFEWVNThsJnkM=;
        b=SUPU2CUY0jb/E4E6wZx8wyVN2GvVrAvSUIWOJ8Gabd1MhH0YQXRiiRQh+Y5813yRBY
         3eBbzeictUY62yQRJdDxrQjLOzjsQ0/FK0f49KeLWs7+axyoygv63hOjBEPH6ECN1gBv
         PqWgEiMkA0TiGd2RNs0u4fH25A8pWrd0X07t8Q+qloyyTvwhk4fYzSy8a8U1CZ1wTnaI
         drO0265VNZLv6mCxUm0mWFz+c68EY13OVankaAAOBCgV4WkgPFsOYo5IHFQAvV85Ws7C
         iwFOONpTwXz9zM82bQWl3HQeKfk/oj+CKj5NuXCd31OMxTQzVmnUrNK/AsH5E630rMNt
         TwTg==
X-Gm-Message-State: AOAM5335fdomi1opz+InRPFJkztczaJeXFkIHIy/uvp7HFU+p5yY1/76
        HJEDXBMAe2ad7AbLzlb3OnaAbcQOdi+EctrttG5V1kPFGjEyWyJa38MAZzgrgQsnZK+0oprAvTK
        d3HYDB3T+IJFGyjQgxim0cvjHUB0=
X-Received: by 2002:a5d:5919:: with SMTP id v25mr2677612wrd.32.1631183358083;
        Thu, 09 Sep 2021 03:29:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzKaEHItf2Q78YR/cCNMwv6b1i26weN/AYMcZas4aYMaVlnw42LsP0KzVWzamYkV973X9rUUg==
X-Received: by 2002:a5d:5919:: with SMTP id v25mr2677602wrd.32.1631183357892;
        Thu, 09 Sep 2021 03:29:17 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3811:7600:8004:a383:c7c9:7f11? ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id a12sm1234351wmm.42.2021.09.09.03.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:29:17 -0700 (PDT)
Message-ID: <2518d9f959f16de10229a67e4917699f8605d947.camel@redhat.com>
Subject: Re: [PATCH 3/3] oslat: Allow for arch specific timer frequency
 measurements
From:   nsaenzju@redhat.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Thu, 09 Sep 2021 12:29:17 +0200
In-Reply-To: <YTj95hq7BzfWsK2v@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
         <20210908100209.118609-3-nsaenzju@redhat.com> <YTj95hq7BzfWsK2v@t490s>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2021-09-08 at 14:16 -0400, Peter Xu wrote:
> On Wed, Sep 08, 2021 at 12:02:09PM +0200, Nicolas Saenz Julienne wrote:
> > Some architectures have special purpose registers to query the system
> > timer's frequency. Let's use that when available.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > ---
> >  src/oslat/oslat.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > 
> > diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> > index bd155a6..23ca9b6 100644
> > --- a/src/oslat/oslat.c
> > +++ b/src/oslat/oslat.c
> > @@ -51,6 +51,9 @@
> >  # define atomic_inc(ptr)   __sync_add_and_fetch((ptr), 1)
> >  # if defined(__x86_64__)
> >  #  define relax()          __asm__ __volatile__("pause" ::: "memory")
> > +
> > +#define measure_timer_mhz generic_measure_timer_mhz
> > +
> >  static inline void frc(uint64_t *pval)
> >  {
> >  	uint32_t low, high;
> > @@ -61,12 +64,18 @@ static inline void frc(uint64_t *pval)
> >  }
> >  # elif defined(__i386__)
> >  #  define relax()          __asm__ __volatile__("pause" ::: "memory")
> > +
> > +#define measure_timer_mhz generic_measure_timer_mhz
> > +
> >  static inline void frc(uint64_t *pval)
> >  {
> >  	__asm__ __volatile__("rdtsc" : "=A" (*pval));
> >  }
> >  # elif defined(__PPC64__)
> >  #  define relax()          do { } while (0)
> > +
> > +#define measure_timer_mhz generic_measure_timer_mhz
> > +
> >  static inline void frc(uint64_t *pval)
> >  {
> >  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
> > @@ -74,6 +83,15 @@ static inline void frc(uint64_t *pval)
> >  # elif defined(__aarch64__)
> >  #  define relax()          __asm__ __volatile("yield" : : : "memory")
> >  
> > +static inline unsigned int measure_timer_mhz(void)
> > +{
> > +	unsigned int val;
> > +
> > +	__asm__ __volatile__("mrs %0, cntfrq_el0" : "=r" (val));
> > +
> > +	return val / 1e6;
> > +}
> > +
> >  static inline void frc(uint64_t *pval)
> >  {
> >  
> > @@ -257,7 +275,7 @@ static cycles_t __measure_timer_hz(void)
> >  	return (cycles_t) ((e - s) / sec);
> >  }
> >  
> > -static unsigned int measure_timer_mhz(void)
> > +static unsigned int __attribute__((unused)) generic_measure_timer_mhz(void)
> 
> This is okay I guess, but does not look nice, as it's marked unused even if
> it's used..

Yes the compiler attribute naming is unfortunate. That's why the kernel renamed
it to '__maybe_unused'.

> How about for any arch that supports a faster version to read the freq, do:
> 
> #define measure_timer_mhz_fast
> unsigned int measure_timer_mhz_fast(void)
> {
>     ...
> }
> 
> Then at entry of measure_timer_mhz():
> 
> #ifdef measure_timer_mhz_fast
>     return measure_timer_mhz_fast();
> #endif

Sounds good to me.

> I'm also wondering the diff between the two methods on arm64 and whether
> there's a huge difference on the numbers.

There isn't much, after rounding the end result in MHz is the same regardless
of the method used. IIUC, gettimeoftheday() uses the frequency register's value
to scale the counter measurements. So it makes sense for the results to be
coherent.

I figured it's cleaner to get the data from the source instead of inferring it
with extra math.

-- 
Nicolás Sáenz

