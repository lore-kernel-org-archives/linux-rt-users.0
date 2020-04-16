Return-Path: <SRS0=egP0=6A=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107B2C2BB85
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 11:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF97421BE5
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Apr 2020 11:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506335AbgDPLeq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506050AbgDPLEx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Apr 2020 07:04:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E158C061A0C;
        Thu, 16 Apr 2020 04:04:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jP2K6-0005gw-Uc; Thu, 16 Apr 2020 13:04:47 +0200
Date:   Thu, 16 Apr 2020 13:04:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT] printk: console must not schedule for drivers
Message-ID: <20200416110446.fjw3yhav73bxxtro@linutronix.de>
References: <20200406212217.2323-1-john.ogness@linutronix.de>
 <20200415163416.r3fce3g5kokm4bub@linutronix.de>
 <87o8rrg864.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87o8rrg864.fsf@vostro.fn.ogness.net>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-16 10:13:23 [+0200], John Ogness wrote:
> > - So before the re-rewrite, console_unlock() set this 0 before
> >   invoking the console drivers so it was always 0. I assume it was
> >   called with disabled interrupts.
> 
> Correct.

le me apply that even if it looks like a fix at the wrong spot. However,
it only affects PREEMPT_VOLUNTARY so…

> John Ogness

Sebastian
