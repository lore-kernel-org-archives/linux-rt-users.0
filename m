Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAB2C4320A
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077586101A
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242960AbhHZPt3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbhHZPtY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 11:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E16C061757
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Aug 2021 08:48:37 -0700 (PDT)
Date:   Thu, 26 Aug 2021 17:48:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629992914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6u6/CYo01EPxvlL4jC1rk+suqEphxdwfzA+OajGJRZA=;
        b=ybO/tfIsHtNs+aVz/52T748bC+XnBZbVvc0X/FK49j7CVhosmrzkn3To9vYvWzTnaw9i9E
        bHa5mim1ZT9Gz7c7/qnglgkqDZBzXnRYLhHBMZjOeNFdrBb0I+A32NVd74k5u7JSMgtjRQ
        PJHJmRdCAesdp3fNQ5k0wny6xP9gO3wZiLb1JYAGci+yuQppBs398bnsYOB8jAcMFNA/bF
        4yAM5yMYo/fgP8AkXLINxnTH/X3hggrXX/UwYik7F6nSyqIs+tl28GY/LYbUXKmJMqU8yr
        ZehIJj+M7p82aV9mWli2rfPEakzltPdQ2WuOmAZ27urXER5NfmB2eIuy1Qk+cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629992914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6u6/CYo01EPxvlL4jC1rk+suqEphxdwfzA+OajGJRZA=;
        b=oq9oWOfcGtJYfnDqMfwDSidMYLGHy9IGL4ykX+9eQ9jwIAt0Y4PMYebR772+am4oDuWYYD
        TXIu/7VhBg/nv/DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] kcsan: Make it RT aware
Message-ID: <20210826154833.gu45q5hduypwgyce@linutronix.de>
References: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
 <34f1e1dadb2c3d19389427303da6ea53e321e726.camel@gmx.de>
 <86f35f7c-c545-d870-b36e-5d091799f54c@suse.cz>
 <20210826151827.wvsm7civflz62olx@linutronix.de>
 <f6c40d238a1990a4649ec848a67aae88846505ab.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f6c40d238a1990a4649ec848a67aae88846505ab.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-26 17:42:21 [+0200], Mike Galbraith wrote:
> On Thu, 2021-08-26 at 17:18 +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-08-22 19:29:00 [+0200], Vlastimil Babka wrote:
> > > On 8/22/21 6:35 PM, Mike Galbraith wrote:
> > > > On second thought, burn both patches.=C2=A0 Making K[AC]SAN work wi=
th RT
> > > > ain't worth the warts.
> > >
> > > The stackdepot part of kasan patch will be useful at some point.
> > > slub_debug should eventually switch to stackdepot - it almost did in
> > > mainline already. I'll try to remember and dig that part up when
> > > needed.
> > > Thanks.
> >
> > If you want them dropped, sure.
>=20
> If you think they're worth having, feel free.  The kcsan patch I found
> especially icky, and changed it like so, avoiding icky config dependent
> branches while giving myself an ever so tiny excuse for looping ;-)
>=20
> kcsan: Make it RT aware
>=20
> Converting report_filterlist_lock to raw_spinlock_t lets RT report
> problem free, but makes allocations in insert_report_filterlist()
> problematic.  Solve that by taking the lock after allocation.  That
> means all configs must check that the situation didn't change while
> acquiring if we're to avoid ugly config specific branches, but it
> also removes the need for GFP_ATOMIC allocations.
>=20
> Signed-off-by: Mike Galbraith <efault@gmx.de>

I would have to look at this raw lock change now more closely=E2=80=A6

Sebastian
