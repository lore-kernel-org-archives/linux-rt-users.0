Return-Path: <SRS0=DPdF=YP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64199CA9EB9
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Oct 2019 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 400252084B
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Oct 2019 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571765662;
	bh=YSjJ4F590dYovNyfbb2k7y3t56m687ezX83hs9dGR30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=t0YBXaWORle8SFpxOBdZ3U3ZCKJNmlK6BU0CVTAeoFxGgVXMacTjbA4BsSEIf3Fdg
	 gNQgoovTTJgt9WHMeS/cZmCbrjD2qLC2GmSjg7gKL/iCUe2lu72ulkCXOhj2DSINPV
	 ildxtijXSwjBTFSTbmzQLMaizarh7g1WesmUhLB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfJVReR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:34:17 -0400
Received: from inca-roads.misterjones.org ([213.251.177.50]:52165 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727309AbfJVReR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Oct 2019 13:34:17 -0400
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:AES256-GCM-SHA384:256)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iMy2u-00030U-T5; Tue, 22 Oct 2019 19:34:13 +0200
Date:   Tue, 22 Oct 2019 18:34:11 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Woojung Huh <woojung.huh@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Stefan Wahren <wahrenst@gmx.net>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] net: usb: lan78xx: Use phy_mac_interrupt() for
 interrupt handling
Message-ID: <20191022183411.0e9a7bdc@why>
In-Reply-To: <20191022101747.001b6d06@cakuba.netronome.com>
References: <20191018082817.111480-1-dwagner@suse.de>
        <20191018131532.dsfhyiilsi7cy4cm@linutronix.de>
        <20191022101747.001b6d06@cakuba.netronome.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: jakub.kicinski@netronome.com, dwagner@suse.de, bigeasy@linutronix.de, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org, woojung.huh@microchip.com, andrew@lunn.ch, wahrenst@gmx.net, Jisheng.Zhang@synaptics.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 22 Oct 2019 10:17:47 -0700
Jakub Kicinski <jakub.kicinski@netronome.com> wrote:

> On Fri, 18 Oct 2019 15:15:32 +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-10-18 10:28:17 [+0200], Daniel Wagner wrote:  
> > > handle_simple_irq() expect interrupts to be disabled. The USB
> > > framework is using threaded interrupts, which implies that interrupts
> > > are re-enabled as soon as it has run.    
> > 
> > Without threading interrupts, this is invoked in pure softirq context
> > since commit ed194d1367698 ("usb: core: remove local_irq_save() around  
> > ->complete() handler") where the local_irq_disable() has been removed.    
> > 
> > This is probably not a problem because the lock is never observed with
> > in IRQ context.
> > 
> > Wouldn't handle_nested_irq() work here instead of the simple thingy?  
> 
> Daniel could you try this suggestion? Would it work?
> 
> I'm not sure we are at the stage yet where "doesn't work on -rt" is
> sufficient reason to revert a working upstream patch. Please correct 
> me if I'm wrong.

But that's the thing: it doesn't work at all, RT or not (it spits an
awful warning). See the various reports Daniel linked to. Maintainers
have been completely unresponsive, and the RPI folks have their own out
of tree hack, I believe (which probably reverts to the previous,
working situation where the driver uses polling for some of its PHY
handling business).

Sebastian's suggestion is definitely worth trying if you have the HW
though.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
