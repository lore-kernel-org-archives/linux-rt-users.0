Return-Path: <SRS0=wfJr=4B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36431C2BA83
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Feb 2020 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143952082F
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Feb 2020 08:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbgBMIbX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:31:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51137 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgBMIbX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Feb 2020 03:31:23 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j29u5-0005QD-8k; Thu, 13 Feb 2020 09:31:21 +0100
Date:   Thu, 13 Feb 2020 09:31:21 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] crypto: only wait for completion once
Message-ID: <20200213083121.vqbbbufja4uilblo@linutronix.de>
References: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
 <20191231100051.658-1-john.mathew@unikie.com>
 <20200114124732.mbw6lfrajmaxjkce@linutronix.de>
 <CAJz2qXntOC31LcfphJDdotQ2pMZjV8DPECMF-H7dDPWFZbw=VQ@mail.gmail.com>
 <20200211120443.tpb5feweflnjr72i@linutronix.de>
 <CAJz2qXn_bSF5iRKZLVfrMxQXYS8cfOs9GqJtrizzpiAXR4kzAg@mail.gmail.com>
 <20200211155925.ctrtxyxh3pfuo2os@linutronix.de>
 <CAJz2qXk=OXRFV8XGWbh+pMG3CLX6Htkwi+jR635U4sibNaGdxw@mail.gmail.com>
 <20200212170249.xhped3ohjcnwh52s@linutronix.de>
 <CAJz2qXkEZkY9PETja_wFkN26CD1o2J71h-BGhYEmBSDOM6mrSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJz2qXkEZkY9PETja_wFkN26CD1o2J71h-BGhYEmBSDOM6mrSg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-13 08:58:10 [+0200], John Mathew wrote:
> 
> Thats strange. Below are a few questions, hope you can answer so that
> we can check on our side.
> Did you manage to reproduce the original problem :
> https://lore.kernel.org/linux-rt-users/20191218165334.k4suur4gzlu62ibs@linutronix.de/T/#t
> with the config file I send?
Yes.

> Can you share your config file?
That is the config you sent me.

> Which root file system do you use?
Debian Sid

> Which test mode of trcrypt did you use when seeing user not waiting
> for algorithm to become available?
One of those ciphers which were not compiled-in but available as a
module.

> Are you using qemu?
 
Sebastian
