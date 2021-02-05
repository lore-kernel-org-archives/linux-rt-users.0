Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D7C433E6
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Feb 2021 11:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A93E64F8C
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Feb 2021 11:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhBELam (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Feb 2021 06:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhBEL1W (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Feb 2021 06:27:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B0AC0613D6
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Feb 2021 03:26:41 -0800 (PST)
Date:   Fri, 5 Feb 2021 12:26:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612524400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ueGmdvz3ioHRE0UmAFIZj/SnSpCrX/9dlN34TMpvV0=;
        b=ngHlRBQsZ7W7twI/SyGq2iRmAJ99VR5ounbqPAIO1UssSrWzWr+wMcl1s0rFIgewWpk/Jb
        kaC1OZXC2rl+CcFHl00pZ8BbKEzSNljec04pnjY7nWbnW6Z1+H9qoWiOTSI0B2qRfsEVDq
        nNquLEtW64YrkJsfuO6CLNdP2rqxjqMRt2LSqURfUxp1MqUDelaRXfnJc2j2IQtvekjPQD
        wdA5HxBTj990uYGL7ty6edjH+CcjRBYXoW31dKuqGKvWtetAIAazDc/1y6UkJhn/5ooiP8
        tX/2CTk8UBQRW00CcX04F7qqWP7GrEvh+ApsDwgVqTu50GxYkyemtV1sfhKIbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612524400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ueGmdvz3ioHRE0UmAFIZj/SnSpCrX/9dlN34TMpvV0=;
        b=nb7z/uyYMgpoffX7RWQ6m8JAjR4w4RzvI9D0VOqXy4s+mIrrMVCiPJtb7NcJCGixKp7s9N
        J6bYyBi3tRRlntCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Runge <dave@sleepmap.de>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <20210205112638.xuduvuefy3auycht@linutronix.de>
References: <YBVG/PG7syFIUBno@hmbx>
 <20210201083441.ocucdvdrv37goz2s@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210201083441.ocucdvdrv37goz2s@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-01 09:34:41 [+0100], To David Runge wrote:
> + firewire maintainer
>=20
> On 2021-01-30 12:46:04 [+0100], David Runge wrote:
> > On 2021-01-29 18:04:14 (+0100), Sebastian Andrzej Siewior wrote:
> > > I don't see anything wrong. There is small difference in timing and
> > > then the RT version does not do a thing while !RT keeps reseting=E2=
=80=A6
> > > Could you try non-RT with the
> > > 	threadirqs
> > >=20
> > > option?
> >=20
> > Yes, (sorry for not including that earlier D:) that fails the same way
> > as the realtime kernel:
> > https://pkgbuild.com/~dvzrv/bugs/2021/01/linux-5.4.91-kernel_threadirqs=
=2Elog
>=20
> Could be specific to the chip or the ohci driver. Either way, the problem
> are the threaded interrupts.

David, could you please try a v5.10 kernel with threadirqs? I've been
just told that it works there on a ppc64 box.

> > Best,
> >=20
> > David

Sebastian
