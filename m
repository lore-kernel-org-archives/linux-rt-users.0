Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E272FC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 17:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB259610A3
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 17:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbhIHRxL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 13:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229614AbhIHRxK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 13:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631123522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iY9Xjx/6YVjPc1i0zKaBCQJEE3D0qOZv//aUvqhg/44=;
        b=ZSsSSvIXOiqA+2MbJ/wsubKonvL0t2w/13TqcsfIBR+8SItdESvE29FoMlTaKZg7abiOse
        HqHBs4uHs1L/9zYjwem0uiBT3T1nn4q8MqlcZQZD34PJliLlwxanx2VlH+uaQZYo0slE+H
        4tu0w3fwH7guaMoaRBsCayLVBpEN3YU=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-2iQuMvdxM7uULx1p0qPrYw-1; Wed, 08 Sep 2021 13:52:00 -0400
X-MC-Unique: 2iQuMvdxM7uULx1p0qPrYw-1
Received: by mail-il1-f198.google.com with SMTP id n4-20020a056e021ba400b0022481cdc803so2271732ili.15
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 10:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iY9Xjx/6YVjPc1i0zKaBCQJEE3D0qOZv//aUvqhg/44=;
        b=M0RHpkOkrQj7AL+o/pJ1mLnjL4/SuUDGVh6p2ED76orOyN3WQ4iN1uxlkmEshDkftz
         HIlNK3Vdj3QO2JfEWyRKxmeBvaXkGSPZwOFSTHtvSlIYJ0++Nk7kbT3JKH1Bhh7Kdh5o
         mbVJGNL+qSg7JZwqKwuhfF/NafAa/r5p3ejf+AMV14vyRLZR8ac+FIf+1LgOY4yGDP8C
         fORztLFTA1JiQA8m6/cYP/ULUqzWJX4S+L/MvEcZDzvduxMyxzFyQpA8WyncrNDE1dqf
         GFRsPc0OcfqsNg7MAoiLfJoZyp2ISvlBVM+MqMB1h7UQQRAtLQZfXStCusQJvKnhpecM
         qtZw==
X-Gm-Message-State: AOAM531VI1/gjDczT0EJ2iWN+zd7ff9UUdhl7BLjHPb612P/jSLxuw6o
        VoWPD6arORGPTOMvZoxw9pYiOR1xGAI8NGv2W3YHhzOluHuWk6ZiyXMtll0dm6G42avh36RGkoB
        oGQwyWSlNqmplmNK+uZ/MGohMRwk=
X-Received: by 2002:a5e:dc0b:: with SMTP id b11mr876514iok.91.1631123519761;
        Wed, 08 Sep 2021 10:51:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyTiPcS5w+oHoVw8CgXsvy99hJOscZyKOdoFj7t12RAUruIXnAaPwdFH9T6QOtXH6/uMt8+0A==
X-Received: by 2002:a5e:dc0b:: with SMTP id b11mr876495iok.91.1631123519474;
        Wed, 08 Sep 2021 10:51:59 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id o11sm1381416ilf.86.2021.09.08.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:51:58 -0700 (PDT)
Date:   Wed, 8 Sep 2021 13:51:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 1/3] oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
Message-ID: <YTj4Pb0peVbzFQQa@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <YTjLaZez4azBeYLI@t490s>
 <dc800f41878a9240cc9b9629ed1a4c1551514fac.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc800f41878a9240cc9b9629ed1a4c1551514fac.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 08, 2021 at 06:30:50PM +0200, nsaenzju@redhat.com wrote:
> Hi Peter, thanks for having a look at this! And sorry in advance for the long
> documentation dump.

It's actually great to reference the documents, thanks for that. I'd appreciate
if you can also add some more explanation into commit message too, may not be
the full copy-paste of the document though, just with the explicit x86/ppc
examples to show this is not for arm-only idea?

Note there's a typo in subject too:

  oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
                                            ^^^ timer

> 
> On Wed, 2021-09-08 at 10:40 -0400, Peter Xu wrote:
> > Hello, Nicolas,
> > 
> > On Wed, Sep 08, 2021 at 12:02:07PM +0200, Nicolas Saenz Julienne wrote:
> > > 'cpu_mhz' in oslat actually represents the frequency at which the high
> > > frequency timer we measure with ticks. There is no need for it to match
> > > the CPU frequency, nor will do on all supported architectures. So rename
> > > it to 'timer_mhz' in order to better match reality.
> > 
> > But right now "cpu_mhz" is indeed the cpu frequency per mhz, isn't it?  As I
> > believe that's how "time stamp counter" defined on x86. :)
> 
> Sadly I don't think this is really the case. In some cases TSC might match
> CPU's base frequency, but it depends on the processor family and other
> factors[1]. Also, the same applies for PPC64[2].
> 
> My reading is that, in general, we are only safe to assume we're getting a
> constant monotonically increasing timer unrelated from CPU's actual frequency.
> 
> > I don't know what's the corresponding register for aarch64 to read the
> > processor clock cycles out, I did a quick google and it tells me PMCCNTR, but
> > I've no solid idea.  Or do you mean for some reason we can't read that info out
> > from aarch64?
> 
> Sadly PMCCNTR isn't available at Exception Level 0 (user-space) and AFAIU we're
> stuck with CNTVCT_EL0.

Fair enough.

Though I still think the name "timer" is vague - timer normally means to me
that there's a setup+invoke procedure, and there can be overhead.  While all
these monotonically increasing registers (either real or virtual) should not
have those, we just read some counter out.

How about "clock_[m]hz"?  It does not necessarily to be a property of the
processor, but it's indeed a clock at least in electronics terms.

Thanks,

> 
> Regards,
> Nicolas
> 
> [1] Intel TRM Vol 3B, 17.17 Time Stamp Counter
> 
> Processor families increment the time-stamp counter differently:
> 
> • For Pentium M processors (family [06H], models [09H, 0DH]); for Pentium 4
>   processors, Intel Xeon processors (family [0FH], models [00H, 01H, or 02H]);
>   and for P6 family processors: the time-stamp counter increments with every
>   internal processor clock cycle. The internal processor clock cycle is
>   determined by the current core-clock to bus-clock ratio. Intel® SpeedStep®
>   technology transitions may also impact the processor clock.
> 
> • For Pentium 4 processors, Intel Xeon processors (family [0FH], models [03H
>   and higher]); for Intel Core Solo and Intel Core Duo processors (family [06H],
>   model [0EH]); for the Intel Xeon processor 5100 series and Intel Core 2 Duo
>   processors (family [06H], model [0FH]); for Intel Core 2 and Intel Xeon
>   processors (family [06H], DisplayModel [17H]); for Intel Atom processors
>   (family [06H], DisplayModel [1CH]): the time-stamp counter increments at a
>   constant rate. That rate may be set by the maximum core-clock to bus-clock
>   ratio of the processor or may be set by the maximum resolved frequency at which
>   the processor is booted. The maximum resolved frequency may differ from the
>   processor base frequency, see Section 18.7.2 for more detail. On certain
>   processors, the TSC frequency may not be the same as the frequency in the brand
>   string. The specific processor configuration determines the behavior. Constant
>   TSC behavior ensures that the duration of each clock tick is uniform and
>   supports the use of the TSC as a wall clock timer even if the processor core
>   changes frequency. This is the architectural behavior moving forward.
> 
> The specific processor configuration determines the behavior. Constant TSC
> behavior ensures that the duration of each clock tick is uniform and supports
> the use of the TSC as a wall clock timer even if the processor core changes
> frequency. This is the architectural behavior moving forward.
> 
> [2] From __ppc_get_timebase() manpages: The Time Base Register is a 64-bit
> register provided by Power Architecture processors. It stores a monotonically
> incremented value that is updated at a system-dependent frequency that may be
> different from the processor frequency.
> 
> Note that glibc's __ppc_get_timebase() and oslat's ppc frc() implementations
> are the same:
> https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/powerpc/sys/platform/ppc.h;h=8b0a66de1b93a56e3edf56c31a0c1505d7a8fc08;hb=HEAD#l27
> 

-- 
Peter Xu

