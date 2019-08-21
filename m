Return-Path: <SRS0=Iani=WR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CED8C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361F42339F
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Aug 2019 13:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbfHUNZ7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:25:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55714 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfHUNZ7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Aug 2019 09:25:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i0Qcc-0004vS-8Y; Wed, 21 Aug 2019 15:25:54 +0200
Date:   Wed, 21 Aug 2019 15:25:54 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alexander Dahl <ada@thorsis.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.2.9-rt3
Message-ID: <20190821132553.gjvya5lu6j2dfyo5@linutronix.de>
References: <20190816153616.fbridfzjkmfg4dnr@linutronix.de>
 <2182739.9IRgZpf3R8@ada>
 <20190820154418.GM3545@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190820154418.GM3545@piout.net>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-20 17:44:18 [+0200], Alexandre Belloni wrote:
> Hi,
Hi,

> On 19/08/2019 13:03:51+0200, Alexander Dahl wrote:
> > Hei hei,
> > 
> > just tried to compile this v5.2.9-rt3 for SAMA5D27-SOM1-EK1 based on 
> > arch/arm/configs/sama5_defconfig and with running oldconfig and selecting 
> > defaults, but that fails if CONFIG_ATMEL_TCB_CLKSRC_USE_SLOW_CLOCK is not set. 
> > 
> > I think this is due to changes for Atmel TCLIB in v5.2 and the not yet adapted 
> > RT patch "clocksource: TCLIB: Allow higher clock rates for clock events", 
> > right?
> 
> Patch clocksource-tclib-allow-higher-clockrates.patch needs to be
> changed so:
> 
> ret = setup_clkevents(tc, best_divisor_idx);
> 
> becomes
> 
> ret = setup_clkevents(&tc, best_divisor_idx);
> 

I will fix that locally.

> Also, I would think clocksource-tclib-add-proper-depend.patch could be
> dropped. Instead, setup_clkevents should use atmel_tcb_divisors. It
> would then be necessary to move its declaration before the function.
> 
> Sebastian, can you take care of that or do you expect a patch? In the
> latter case, do you want a patch for the patch?

For the second part I would appreciate a patch. I can then drop
clocksource-tclib-add-proper-depend.patch if it is not an issue.

Sebastian
