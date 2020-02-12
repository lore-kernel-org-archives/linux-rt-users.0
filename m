Return-Path: <SRS0=WKTr=4A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DE9C2BA83
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 17:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6718C20658
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Feb 2020 17:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgBLRCw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Feb 2020 12:02:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgBLRCv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Feb 2020 12:02:51 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j1vPV-0000xL-S2; Wed, 12 Feb 2020 18:02:49 +0100
Date:   Wed, 12 Feb 2020 18:02:49 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
Message-ID: <20200212170249.xhped3ohjcnwh52s@linutronix.de>
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com>
 <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
 <20200211120443.tpb5feweflnjr72i@linutronix.de>
 <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
 <20200211155925.ctrtxyxh3pfuo2os@linutronix.de>
 <CAJz2qXk=OXRFV8XGWbh+pMG3CLX6Htkwi+jR635U4sibNaGdxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJz2qXk=OXRFV8XGWbh+pMG3CLX6Htkwi+jR635U4sibNaGdxw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-12 14:55:29 [+0200], John Mathew wrote:
> On Tue, Feb 11, 2020 at 5:59 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2020-02-11 17:52:44 [+0200], John Mathew wrote:
> > > > crypto/tcrypt.c
> > > I ran the module in a loop with mode ranging from 0..200. The output
> > > is the same (tcrypt: all tests passed ) with and without my patch.
> >
> > Try one of the modes which are not built-in but provided by a module.
> > And the module must not be loaded before starting the test.
> 
> I tried the mode 26 which tests the "anubis" module. The module is
> loaded dynamically after starting the test.
> Using traces in the code i confirmed that the algo lookup and tfm
> creation works fine.
> alg_test returns 0.

Something isn't right. So when I took a look at it then the patch then
every user that waited for a module to be loaded did not wait for the
algorithm to become available but returned with an error instead.
Now I'm curious why I had a regression here but you don't.

Sebastian
