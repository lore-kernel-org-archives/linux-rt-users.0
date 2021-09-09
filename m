Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6975C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 10:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6DD0611BD
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 10:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhIIKME (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 06:12:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32281 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229995AbhIIKMD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 06:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631182253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7KzhSJCwL8gcG9WRduk58Ixdxl9AWR1h0tDOxSQVVY=;
        b=a7XaqgCzUr/FLek60A1OGeEYzHm1l+kXrZPy1VmtBOhoJPAQ2VG9e3Mqeftro+lRrJxCQ9
        Hw/iDT5CUGMp+0X469ZlJfIW6f/dq2Kf2tL7G8+Y/qIsNH++mHHgpdR2wqN2iXmhDah4GW
        j8xMclw3qdICbzDpUU9caMJ96UfJK/U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-IMkuOOgpOLaOHCubiA1abw-1; Thu, 09 Sep 2021 06:10:52 -0400
X-MC-Unique: IMkuOOgpOLaOHCubiA1abw-1
Received: by mail-wr1-f69.google.com with SMTP id d10-20020adffbca000000b00157bc86d94eso344195wrs.20
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 03:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=L7KzhSJCwL8gcG9WRduk58Ixdxl9AWR1h0tDOxSQVVY=;
        b=mvUMtir9lCixHVxsDvf8r3+xv8Oeg1MOCq2SL6yY0GNGEsRAqxoaFLWpZ9oFlT+Sdo
         3tkwWQJt28Uf6cO7nSexi1WosFm0XqvCOOtMkhOggi2Rw8EuEkjHEsEQA+/8obpi8V0L
         GMB+IAn2knEzvr7BA1+j431Qb4PkYa0P8odRz8LA372hKw4JWB1AWbfTP/RThSD8IPgp
         iGQqFCYle7A0CKgbLKfhrKYEcISPa54zC8PfGi/LwJc2QGT32jy672Ht1dpQm3ASVT1G
         S0N5jOC20H1iw/Osshv92X/jBRhGX4sEg7WLgcZWhCp9ZwQZ6Ufc9aD3QbFz1+q4lXUd
         LIYw==
X-Gm-Message-State: AOAM532pHrOcnzlUwql/uKrhFq1EyDYPQCs85LgGbnwpMr0ctlUOKEvK
        nTKBsryUX8MePf55EkaaKDJsit09sI3XzCkQh+mWnjZ4Rv1TbCUlf0LBoPccExVv13G2Z6BjHuO
        4vuG5MBBlenV9CP2on1QPU31azl4=
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr2571118wrs.437.1631182251184;
        Thu, 09 Sep 2021 03:10:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsiodXUqbv5a6DLAl1KkfmMcyvxxcjoqOcsW6kAj15+kNHnjteCJ75Rjs0zPlWmt4keBXesg==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr2571098wrs.437.1631182251001;
        Thu, 09 Sep 2021 03:10:51 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3811:7600:8004:a383:c7c9:7f11? ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id m184sm1205735wmm.3.2021.09.09.03.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 03:10:50 -0700 (PDT)
Message-ID: <466f7d726df2dfec8ac83a9d3f603439e3cec1b1.camel@redhat.com>
Subject: Re: [PATCH 2/3] oslat: Add aarch64 support
From:   nsaenzju@redhat.com
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Date:   Thu, 09 Sep 2021 12:10:49 +0200
In-Reply-To: <YTj8Qgawnh1xPrDJ@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
         <20210908100209.118609-2-nsaenzju@redhat.com> <YTj8Qgawnh1xPrDJ@t490s>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2021-09-08 at 14:09 -0400, Peter Xu wrote:
> On Wed, Sep 08, 2021 at 12:02:08PM +0200, Nicolas Saenz Julienne wrote:
> > The callbacks are based on Linux's implementation:
> >  - CNTVCT_EL0 provides direct access to the system virtual timer[1].
> >  - 'yield' serves as a CPU hint with similar semantics as x86's
> >    'pause'[2].
> > 
> > [1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
> > [2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> > ---
> >  src/oslat/oslat.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> > index a4aa5f1..bd155a6 100644
> > --- a/src/oslat/oslat.c
> > +++ b/src/oslat/oslat.c
> > @@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
> >  {
> >  	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
> >  }
> > +# elif defined(__aarch64__)
> > +#  define relax()          __asm__ __volatile("yield" : : : "memory")
> > +
> > +static inline void frc(uint64_t *pval)
> > +{
> > +
> 
> newline to drop?

Noted.

> > +	/*
> > +	 * This isb() is required to prevent that the counter value
> > +	 * is speculated.
> > +	 */
> > +	__asm__ __volatile__("isb; mrs %0, cntvct_el0" : "=r" (*pval));
> 
> I saw that commit 27e11a9fe2e2e added two isbs, one before, one after.  Then
> commit 77ec462536a1 replaced the 2nd isb into another magic.  This function
> dropped the 2nd barrier.  Also, the same to compiler barrier "memory" that's
> gone too.
> 
> Is it on purpose to drop them?

Yes, I removed it on purpose. VDSO's gettimeofday implementation uses a seqlock
to protect against changes to the counter's properties/state: you want to make
sure access to the counter register is ordered WRT access to the seqlock
protecting it. We don't really care for all this, as we trust our counters to
be stable.

-- 
Nicolás Sáenz

