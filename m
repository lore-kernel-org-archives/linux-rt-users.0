Return-Path: <SRS0=Yxvf=YL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A38CA9EA0
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 13:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67F5222C5
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Oct 2019 13:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410243AbfJRNPh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Oct 2019 09:15:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56898 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfJRNPh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Oct 2019 09:15:37 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iLS6O-0007ay-VM; Fri, 18 Oct 2019 15:15:33 +0200
Date:   Fri, 18 Oct 2019 15:15:32 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Woojung Huh <woojung.huh@microchip.com>,
        Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Stefan Wahren <wahrenst@gmx.net>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] net: usb: lan78xx: Use phy_mac_interrupt() for interrupt
 handling
Message-ID: <20191018131532.dsfhyiilsi7cy4cm@linutronix.de>
References: <20191018082817.111480-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018082817.111480-1-dwagner@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-10-18 10:28:17 [+0200], Daniel Wagner wrote:
> handle_simple_irq() expect interrupts to be disabled. The USB
> framework is using threaded interrupts, which implies that interrupts
> are re-enabled as soon as it has run.

Without threading interrupts, this is invoked in pure softirq context
since commit ed194d1367698 ("usb: core: remove local_irq_save() around
->complete() handler") where the local_irq_disable() has been removed.

This is probably not a problem because the lock is never observed with
in IRQ context.

Wouldn't handle_nested_irq() work here instead of the simple thingy?

Sebastian
