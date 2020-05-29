Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848D4C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 14:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D2CA20776
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2OsH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 10:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgE2OsH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 10:48:07 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4220EC03E969;
        Fri, 29 May 2020 07:48:07 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jegIn-00070i-Hl; Fri, 29 May 2020 16:48:05 +0200
Date:   Fri, 29 May 2020 16:48:05 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org
Subject: Re: linux-rt stall on imx6dl on patch-5.4.22-rt13.patch
Message-ID: <20200529144805.i3j3zx76r4nvjxth@linutronix.de>
References: <CAOf5uw=DU4KdLXt=VEU+Uv3+W3jUMXE393FO3_v2smScR6Xf-Q@mail.gmail.com>
 <20200529133107.y65eta5btvgpk6pu@linutronix.de>
 <CAOf5uwmQnX8SNOxD71mwcxc5Q4hKXo1VqnMbaSArNg0SmE5dqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOf5uwmQnX8SNOxD71mwcxc5Q4hKXo1VqnMbaSArNg0SmE5dqA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-29 15:46:46 [+0200], Michael Nazzareno Trimarchi wrote:
> Hi
Hi,

> No, I'm not surprised but my answer to them was not enough. Right now
> they are executing some bench.

Oh yeah? Tell them to think about what they want to test and then make a
proper test for it. Not just randomly piecing together commands from the
internet and complaining about the results, that were not understood.

> Best
> Michael

Sebastian
