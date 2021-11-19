Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A327BC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC9E60F9B
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbhKSLPt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhKSLPs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 06:15:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4494AC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 03:12:47 -0800 (PST)
Date:   Fri, 19 Nov 2021 12:12:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637320365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPZqlwaknfZTZqR+OztoD5se7LIDcuoNlyHO/+nm+JQ=;
        b=hzx5TRf71wRn193Da03+z3wqwmnog2eEOJs3J+JRzFovQouY2ID8ugC3RxT+05sy8mRPAr
        QkJeL9No40b8vQ+V252+/qXSjipiIuzDUWXpAN72sV/sOj2JsGClL5/6OAzBwx1XCJueIw
        /7EJ8+oklimreifO3XnYcjkXXA7B4fteUZDGlAf220pvpchUEthzwjcOcHm4lyP65Vky8c
        xf+mivd0Dxrir8IHWH4I6phrp6RFo/wied0uk/CtMoJ1Epl8MbpUX7PQORJYp/fXZ7/YFX
        /avi4KzlxVn9CR3ACSrPi0hayUD3Kn9iXyPlqU5FR2SohWE4Yor17SIIFhTrLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637320365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aPZqlwaknfZTZqR+OztoD5se7LIDcuoNlyHO/+nm+JQ=;
        b=i/8zY9q3Sb3G9ACjOD44RjfHz87k52K1TWb5qohfjXYkEdG4l3NntCi3q7XMu8vWipIUQr
        f9CYvY+L+JlgzzDw==
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     'Vlastimil Babka' <vbabka@suse.cz>, linux-rt-users@vger.kernel.org,
        'Thomas Gleixner' <tglx@linutronix.de>
Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-rt21
Message-ID: <20211119111244.mvs6fzopktmtht6v@linutronix.de>
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
 <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
 <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
 <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
 <20211112140045.p4bybe4uxy7xwj4i@linutronix.de>
 <5057a47c-dcdd-5420-9e09-7ade50553dd0@suse.cz>
 <20211116094251.7nux2fwjn55pt5m5@linutronix.de>
 <022001d7daef$bc333370$34999a50$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <022001d7daef$bc333370$34999a50$@samsung.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-16 22:42:01 [+0900], Chanho Park wrote:
> Hi,
Hi,

> > On 2021-11-16 10:37:22 [+0100], Vlastimil Babka wrote:
> > > On 11/12/21 15:00, 'Sebastian Andrzej Siewior' wrote:
> > > > On 2021-11-05 10:41:40 [+0900], Chanho Park wrote:
> > > >> Hi,
> > > > Hi,
> > > >
> > > >> I checked the same test on my aarch64 target. I'll do more
> > > >> realistic benchmark such as compile bench.
> > > >>
> > > >> <5.10.73-rt54 aarch64>
> > > >> root@euto-v9-sadk:~# hackbench -l 10000
> > > >> Time: 24.994
> > > >>
> > > >> <5.15.0-rt17 aarch64 w/o CONFIG_SLUB_CPU_PARTIAL>
> > > >> root@euto-v9-sadk:~# hackbench -l 10000
> > > >> Time: 31.372
> > > >>
> > > >> <5.15.0-rt17 aarch64 w/ CONFIG_SLUB_CPU_PARTIAL>
> > > >> root@euto-v9-sadk:~# hackbench -l 10000
> > > >> Time: 35.269
> > > >
> > > > The last two are equal, is that on purporse?
> > >
> > > I see the first of last two is without SLUB_CPU_PARTIAL and the second
> > > with SLUB_CPU_PARTIAL, so not equal?
> > 
> > indeed. I didn't notice the missing o. Thanks!.
> 
> Sorry for this confusion.
> 
> > 
> > > > Any feedback on v5.14-rc3-rt1 and v5.14-rc3-rt2? v5.13-rt1 should be
> > > > identical to you 5.10 numbers.
> 
> I got below value on v5.14-rc3-rt1.
> 
> <5.14.0-rc3-rt1 aarch64>
> Time: 35.948

So this matches your v5.15 numbers with CONFIG_SLUB_CPU_PARTIAL. In
v5.14-rc3-rt2 adaptive spinning was introduced. Based on these numbers
it makes no difference for you.

> Unfortunately, I've got below panic on v5.13-rt1. I stacked same patches for my board both v5.13-rt1 and v514-rc3-rt1.

Yes, good.

> Best Regards,
> Chanho Park

Sebastian
