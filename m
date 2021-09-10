Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216E5C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014B5611C8
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 12:19:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbhIJMU4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 08:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232876AbhIJMUz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 08:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631276384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=voPn/0Ny/yagnDx0j+1ZOVeDH0UCFJ39TkXdOTQoAlE=;
        b=NcNeK60CeB5L4hQsuHKMWDM75A39VVPr5qvlB77TTDgPMFO1ststdXggjn/KXJBpUkqtvd
        NJF2ujn7DuSZ1ejH79G5pCvBcV0cYZifhstev8Ey3ajFpqH0ipbSgQdMYRpdxP9yxijhlh
        kCcW0QRVXDZSDqcy1ghbIYee6e8koBQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-21LGWmZkPSeDIdB4k0-PMA-1; Fri, 10 Sep 2021 08:19:43 -0400
X-MC-Unique: 21LGWmZkPSeDIdB4k0-PMA-1
Received: by mail-wm1-f72.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so844343wmj.8
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Sep 2021 05:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=voPn/0Ny/yagnDx0j+1ZOVeDH0UCFJ39TkXdOTQoAlE=;
        b=gNEs2NAGiPamOzSbM2NQy+/yTMGn5fpPfBf4R4AfjRUXrekrXv7Ec6y8A6Ry5zWgLX
         rQY9iMuevG1pu4as53rMv5PlK9j8DT3DJ3hBHx61zaTk78s43gyBmQyhnD/zND1ZQ9FC
         mubjMfvQSKZiTiazRriueJ9VKiFrVWJPWmmXSGqCkQlNERqg71IllhjPvL7iEiA4E0/V
         R+tG/ckegnuL1znnVRA2piOZJ1ALYVlVFtmOH9yPdapU8GEHxsIxu4RC3IUxXQDTC9P4
         YVDJGQDyA7phjTelgKaFhjnM90dhPt81t65zwk+mDLa1pzgzEhfQ9rPHlhGifSOUWGt5
         Ec7Q==
X-Gm-Message-State: AOAM533/jH+Rf33pL64DsNG2m+xSmH4KPYDbA8BqxFI0+28itVtf6zLD
        fRptC2eYh4xIS/mA+BBWZn1YumkSgQhh67+3zQkiO41KLVHXXuP1YhUK/kKalU48UbJOGSyiJsL
        eF41MaGd6LBZz2f4iK3rxkLt14/M=
X-Received: by 2002:a1c:9a85:: with SMTP id c127mr7998817wme.111.1631276381869;
        Fri, 10 Sep 2021 05:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzB9gOCzYhIXkhzV+XQDH6XlRJBSDOvVYFn4wVpEZUat28prnq9+8+x7eAtPfuSXvgTymmIjg==
X-Received: by 2002:a1c:9a85:: with SMTP id c127mr7998799wme.111.1631276381677;
        Fri, 10 Sep 2021 05:19:41 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7? ([2a0c:5a80:1f0d:6700:7eb9:ffb3:3868:81d7])
        by smtp.gmail.com with ESMTPSA id f5sm4127863wmb.47.2021.09.10.05.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 05:19:41 -0700 (PDT)
Message-ID: <6a2eba408dc4260a47c1acfe743474bb39aa93bd.camel@redhat.com>
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
From:   nsaenzju@redhat.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Fri, 10 Sep 2021 14:19:40 +0200
In-Reply-To: <YTpMe2+58YxJ0IFM@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
         <20210908100209.118609-2-nsaenzju@redhat.com> <YTj8Qgawnh1xPrDJ@t490s>
         <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
         <YTpMe2+58YxJ0IFM@t490s>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-09-09 at 14:03 -0400, Peter Xu wrote:
> On Thu, Sep 09, 2021 at 12:10:49PM +0200, nsaenzju@redhat.com wrote:
> > On Wed, 2021-09-08 at 14:09 -0400, Peter Xu wrote:
> > > On Wed, Sep 08, 2021 at 12:02:08PM +0200, Nicolas Saenz Julienne wrote:
> > > > The callbacks are based on Linux's implementation:
> > > >  - CNTVCT_EL0 provides direct access to the system virtual timer[1].
> > > >  - 'yield' serves as a CPU hint with similar semantics as x86's
> > > >    'pause'[2].
> > > > 
> > > > [1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
> > > > [2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
> > > > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > > > ---
> > > >  src/oslat/oslat.c | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > > 
> > > > diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> > > > index a4aa5f1..bd155a6 100644
> > > > --- a/src/oslat/oslat.c
> > > > +++ b/src/oslat/oslat.c
> > > > @@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
> > > >  {
> > > >  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
> > > >  }
> > > > +# elif defined(__aarch64__)
> > > > +#  define relax()          __asm__ __volatile("yield" : : : "memory")
> > > > +
> > > > +static inline void frc(uint64_t *pval)
> > > > +{
> > > > +
> > > 
> > > newline to drop?
> > 
> > Noted.
> > 
> > > > +	/*
> > > > +	 * This isb() is required to prevent that the counter value
> > > > +	 * is speculated.
> > > > +	 */
> > > > +	__asm__ __volatile__("isb; mrs %0, cntvct_el0" : "=r" (*pval));
> > > 
> > > I saw that commit 27e11a9fe2e2e added two isbs, one before, one after.  Then
> > > commit 77ec462536a1 replaced the 2nd isb into another magic.  This function
> > > dropped the 2nd barrier.  Also, the same to compiler barrier "memory" that's
> > > gone too.
> > > 
> > > Is it on purpose to drop them?
> > 
> > Yes, I removed it on purpose. VDSO's gettimeofday implementation uses a seqlock
> > to protect against changes to the counter's properties/state: you want to make
> > sure access to the counter register is ordered WRT access to the seqlock
> > protecting it. We don't really care for all this, as we trust our counters to
> > be stable.
> 
> OK, since you've referenced the code, would you mind add these into the commit
> message too?

Will do!

> I also don't understand why you explicitly removed the compiler barrier.  IIUC
> when without it the compiler could move these instructions to be before/after
> other instructions generated in the c code.  That may not really happen in
> practise, but just curious why the explicit removal.

I removed it too as I see no justification for it. There is nothing, except for
the actual timestamp values (which are safe as they come from an mrs), that
could suffer from the compiler prefetching the value, or reordering accesses.
I'll add a comment on the commit message.

-- 
Nicolás Sáenz

