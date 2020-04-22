Return-Path: <SRS0=xzyi=6G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85944C5518B
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Apr 2020 18:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DBE2076E
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Apr 2020 18:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDVSMg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgDVSMg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Apr 2020 14:12:36 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBACC03C1AA;
        Wed, 22 Apr 2020 11:12:35 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jRJrM-0006NN-SH; Wed, 22 Apr 2020 20:12:32 +0200
Date:   Wed, 22 Apr 2020 20:12:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <wagi@monom.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.6.4-rt3
Message-ID: <20200422181232.a33sfm6udmy2zcvy@linutronix.de>
References: <20200416164510.kbrklqahdng5uhij@linutronix.de>
 <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422173359.inlikfugjzsjyyp6@beryllium.lan>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-22 19:33:59 [+0200], Daniel Wagner wrote:
> Hi Sebastian,

Hi Daniel,

> On Thu, Apr 16, 2020 at 06:45:10PM +0200, Sebastian Andrzej Siewior wrote:
> > I'm pleased to announce the v5.6.4-rt3 patch set.
> 
> Finally solved my lab setup issue (NFS wants to use TCP per default now) and
> all looks good. The fallout on rt-tests-migrate was a configuration bug on my
> side. All rt-tests work and pass on my three system (Beaglebone Black 32bit,
> RPi3 64bit and old x86_64 Core2 Duo CPU E8400 box in 64bit mode).

So there is no backtrace of any kind in any configuration (bug or no
bug)?

> The only thing I've observed was higher latency numbers in sigwaittest but
> that could be anything.
> 
> Thanks,
> Daniel

Sebastian
