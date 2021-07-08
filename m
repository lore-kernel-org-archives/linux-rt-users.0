Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A12EC07E96
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 19:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21B0B61434
	for <linux-rt-users@archiver.kernel.org>; Thu,  8 Jul 2021 19:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhGHTyR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jul 2021 15:54:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27986 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230254AbhGHTyP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jul 2021 15:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625773892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1+vii0YHImgoIpHeaIuVKqDTF2st44x70+RC5rAnmXI=;
        b=NJx+YORLvDI+igGC08+gTRS22PVlQElP1aEL+JsZE1N5u8CGl8EUa02pUp5RhVTsLj/tAG
        /ZSitRKujlIjth1pPLJblez5yL7LiRF6Omy3l8Q2/Dkn55J65ynAC0UspVdgpmgIkte1wQ
        eFMk2XQJMED7Gio5Sa/hJKUR5LuoL48=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-VVo7gv4zM3OE39jRCH41tA-1; Thu, 08 Jul 2021 15:51:31 -0400
X-MC-Unique: VVo7gv4zM3OE39jRCH41tA-1
Received: by mail-io1-f69.google.com with SMTP id e24-20020a5d8e180000b02904dd8a55bbd7so4833406iod.12
        for <linux-rt-users@vger.kernel.org>; Thu, 08 Jul 2021 12:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1+vii0YHImgoIpHeaIuVKqDTF2st44x70+RC5rAnmXI=;
        b=cDEg74etKvlxvQu+PXdtPs4M3H+0mm67X4zxH8vsqUiwbyjWuMDB/p1JfVSP1w+pr3
         31YzC/VNWXYIobuPxACkkTViTGwu4axFCgYbRFLPkuxVZDgb5/gxZYH6WFqNOqyZtDJI
         Qt3zN9Nat0Gla1ANipIPSIrnUoKJQB37KFC9B4lkfkC0nVRtr5oNep2VTV/IG2F38pYo
         Ot0P77yZtdn9ze4YkdiXfeef/Kc19Sv2gQ4v/ZlpM17LajgDTV8BIAE4w6laO/9HCevB
         63QRQN0Em2OQDNY7U0xo2RSzsrBja17GlJLI2D7suxfX7Pk14xrMIc69z4qRcz2YUlgY
         ppSg==
X-Gm-Message-State: AOAM53222rhn3eWydQLtYP6ksK3b4xq7pAvwlRLvKVFazuo52e7R5b4I
        Il+1VFh7nlsiGpkin2hcKhejBo5+PyBfeKe/rX7NMZsyReSU1mbZf+4YapIrN0yvdDElOuP4Crz
        lDeRSFNuMeIPD1AeINNrU1N2vbOo=
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr24752929ilt.57.1625773890521;
        Thu, 08 Jul 2021 12:51:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvVx1FcdBilivyA1x4Tw6DOwXVsHn9wv6hZGZVtI5a6FcCBtgsHxuB2XNkvtL+BwBSRtT58w==
X-Received: by 2002:a05:6e02:921:: with SMTP id o1mr24752913ilt.57.1625773890261;
        Thu, 08 Jul 2021 12:51:30 -0700 (PDT)
Received: from halaneylaptop (068-184-200-203.res.spectrum.com. [68.184.200.203])
        by smtp.gmail.com with ESMTPSA id b25sm1718259ios.36.2021.07.08.12.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 12:51:29 -0700 (PDT)
Date:   Thu, 8 Jul 2021 14:51:25 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, Chunyu Hu <chuhu@redhat.com>
Subject: Re: [RT PATCH] locking/rwsem-rt: Remove might_sleep() in __up_read()
Message-ID: <20210708195125.zxqsxy5bpccgxb2n@halaneylaptop>
References: <20210406221952.50399-1-ahalaney@redhat.com>
 <20210426164229.mbrsrjpmmhp7ehna@halaneylaptop>
 <877dkoud19.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dkoud19.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Apr 26, 2021 at 08:16:34PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 26 2021 at 11:42, Andrew Halaney wrote:
> > On Tue, Apr 06, 2021 at 05:19:52PM -0500, Andrew Halaney wrote:
> >> There's no chance of sleeping here, the reader is giving up the
> >> lock and possibly waking up the writer who is waiting on it.
> >> 
> >> Reported-by: Chunyu Hu <chuhu@redhat.com>
> >> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> >> ---
> >> Hello,
> >> 
> >> I ran into a warning caused by this, and I think the warning is
> >> incorrect. Please let me know if I'm wrong!
> >> I'm working off of linux-5.12.y-rt, but this applies cleanly to older
> >> stable branches as well.
> >> 
> >> Thanks,
> >> Andrew
> >> 
> >>  kernel/locking/rwsem-rt.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >> 
> >> diff --git a/kernel/locking/rwsem-rt.c b/kernel/locking/rwsem-rt.c
> >> index 274172d5bb3a..b61edc4dcb73 100644
> >> --- a/kernel/locking/rwsem-rt.c
> >> +++ b/kernel/locking/rwsem-rt.c
> >> @@ -198,7 +198,6 @@ void __up_read(struct rw_semaphore *sem)
> >>  	if (!atomic_dec_and_test(&sem->readers))
> >>  		return;
> >>  
> >> -	might_sleep();
> >>  	raw_spin_lock_irq(&m->wait_lock);
> >>  	/*
> >>  	 * Wake the writer, i.e. the rtmutex owner. It might release the
> >> -- 
> >> 2.30.2
> >
> > Just a gentle follow up, any feedback?
> 
> Looks correct. Will go into the next rt-release.
> 
> Thanks,
> 
>         tglx
> 

Hi Thomas,

I see a new release (v5.13-rt1) was created, and with it rwsem
was overhauled entirely making this patch pointless for linux-rt-devel.

That being said, it's a little unclear to me how RT only patches
make their way to the maintained branches over in linux-stable-rt.
I think it should be applied to:
 v4.9-rt
 v4.14-rt
 v4.19-rt
 v5.4-rt
 v5.10-rt
to remove the incorrect warning, unless those branches plan to backport
the latest RT patchset with the new rwsem implementation. Is there a
proper way for me signal that?

Thanks,
Andrew

