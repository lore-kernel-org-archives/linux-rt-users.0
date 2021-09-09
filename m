Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF3BC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687C8610E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbhIISEz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:04:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237271AbhIISEy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 14:04:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631210624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5pYAatM52WTz5XRoa2PZ7fP4LLZjgJeGYaVLepynG4M=;
        b=XAdZUZHDeFb/+SEA5zdux9S3jvhP//DFG6eiF29/f9VM/lNY6JIxKJ4jJWM9v0xNl+TVrr
        LEqdRZZ4bMD2xya3CoOg1Bb7JVzY4v5f5s3fDerqv2tCGszHO2xNWQk8btvOClr0Ygzbgr
        1o0LqNeXOXNeZEgBcPZzEtAKnAjlLCs=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-TzrrWfgXPu-thcUqxJSGqQ-1; Thu, 09 Sep 2021 14:03:42 -0400
X-MC-Unique: TzrrWfgXPu-thcUqxJSGqQ-1
Received: by mail-io1-f72.google.com with SMTP id s6-20020a5ec646000000b005b7f88ffdd3so2515224ioo.13
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 11:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5pYAatM52WTz5XRoa2PZ7fP4LLZjgJeGYaVLepynG4M=;
        b=3D+WfJDlkghrwNRVOGDCl8T42667Qm0mZOxNGaVBAVdj97nHWMivvPsuldP1MqAbDv
         bi3JYG//O1IX+9M7sQ9J6J3CAOpX92sj6JyfhfnB5hpMfEDp7r7S2P3N3rBmE7f76vxI
         KZOIgTPf4qa5dJ6DFTCXwSiRMZu8BTuksiM2pK7wWbNwcS5xVZZUbEiTc1VVcLS640W0
         of9yq81CysOMcuEaMox4U774PPVRLnWX9k93fmT4RH+BRiRbuQKfObo4BFIo/Q2YQZqI
         eFplCFJb+IjKvaGNqdOuznVkdPjMPCGy8bn5j/ukEspZFoyC0C54spAdxsRcfCPcqIwO
         SYkw==
X-Gm-Message-State: AOAM532scVbmuENmDJzHR7Pp1hg3Vi3pp27UNQEAuw2T9AXuRJfV0bmO
        cSFbwDbHjhcDPI5KiCnDeLdMzTlBLC2rlkVp3qBtU/vSw54NKXtLWnTaUm2Ob4dneDRVTx96pop
        YZ4+fwr9bdM4/Coj+W6E2UEoKfWE=
X-Received: by 2002:a05:6638:419e:: with SMTP id az30mr1014328jab.90.1631210622165;
        Thu, 09 Sep 2021 11:03:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW7iBLhGN9aDIYDpdA7HUiXLPqlV5wAQfU9AdhZPXewnXyF6a6eJK/u6cH4e7Y0eaATyUWpw==
X-Received: by 2002:a05:6638:419e:: with SMTP id az30mr1014311jab.90.1631210621907;
        Thu, 09 Sep 2021 11:03:41 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id f3sm1164822ilu.85.2021.09.09.11.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:03:41 -0700 (PDT)
Date:   Thu, 9 Sep 2021 14:03:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
Message-ID: <YTpMe2+58YxJ0IFM@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <20210908100209.118609-2-nsaenzju@redhat.com>
 <YTj8Qgawnh1xPrDJ@t490s>
 <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 09, 2021 at 12:10:49PM +0200, nsaenzju@redhat.com wrote:
> On Wed, 2021-09-08 at 14:09 -0400, Peter Xu wrote:
> > On Wed, Sep 08, 2021 at 12:02:08PM +0200, Nicolas Saenz Julienne wrote:
> > > The callbacks are based on Linux's implementation:
> > >  - CNTVCT_EL0 provides direct access to the system virtual timer[1].
> > >  - 'yield' serves as a CPU hint with similar semantics as x86's
> > >    'pause'[2].
> > > 
> > > [1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
> > > [2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > > ---
> > >  src/oslat/oslat.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> > > index a4aa5f1..bd155a6 100644
> > > --- a/src/oslat/oslat.c
> > > +++ b/src/oslat/oslat.c
> > > @@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
> > >  {
> > >  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
> > >  }
> > > +# elif defined(__aarch64__)
> > > +#  define relax()          __asm__ __volatile("yield" : : : "memory")
> > > +
> > > +static inline void frc(uint64_t *pval)
> > > +{
> > > +
> > 
> > newline to drop?
> 
> Noted.
> 
> > > +	/*
> > > +	 * This isb() is required to prevent that the counter value
> > > +	 * is speculated.
> > > +	 */
> > > +	__asm__ __volatile__("isb; mrs %0, cntvct_el0" : "=r" (*pval));
> > 
> > I saw that commit 27e11a9fe2e2e added two isbs, one before, one after.  Then
> > commit 77ec462536a1 replaced the 2nd isb into another magic.  This function
> > dropped the 2nd barrier.  Also, the same to compiler barrier "memory" that's
> > gone too.
> > 
> > Is it on purpose to drop them?
> 
> Yes, I removed it on purpose. VDSO's gettimeofday implementation uses a seqlock
> to protect against changes to the counter's properties/state: you want to make
> sure access to the counter register is ordered WRT access to the seqlock
> protecting it. We don't really care for all this, as we trust our counters to
> be stable.

OK, since you've referenced the code, would you mind add these into the commit
message too?

I also don't understand why you explicitly removed the compiler barrier.  IIUC
when without it the compiler could move these instructions to be before/after
other instructions generated in the c code.  That may not really happen in
practise, but just curious why the explicit removal.

-- 
Peter Xu

