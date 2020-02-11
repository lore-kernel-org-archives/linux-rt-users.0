Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900FC352A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172AB20714
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 15:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgBKP71 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:59:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46716 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgBKP71 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 10:59:27 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j1Xwb-00048j-DT; Tue, 11 Feb 2020 16:59:25 +0100
Date:   Tue, 11 Feb 2020 16:59:25 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
Message-ID: <20200211155925.ctrtxyxh3pfuo2os@linutronix.de>
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com>
 <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
 <20200211120443.tpb5feweflnjr72i@linutronix.de>
 <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-11 17:52:44 [+0200], John Mathew wrote:
> > crypto/tcrypt.c
> I ran the module in a loop with mode ranging from 0..200. The output
> is the same (tcrypt: all tests passed ) with and without my patch.

Try one of the modes which are not built-in but provided by a module.
And the module must not be loaded before starting the test.

Sebastian
