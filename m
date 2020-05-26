Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF7AC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 16:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A85320723
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 16:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgEZQov (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgEZQov (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 12:44:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AC6C03E96D
        for <linux-rt-users@vger.kernel.org>; Tue, 26 May 2020 09:44:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdch7-0006il-3R; Tue, 26 May 2020 18:44:49 +0200
Date:   Tue, 26 May 2020 18:44:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [5.4-rt] kdb: push 'bt' command output to console immediately.
Message-ID: <20200526164449.vrytnvdch2l4g4da@linutronix.de>
References: <20200520151613.GA54006@zipoli.concurrent-rt.com>
 <87zha2hb96.fsf@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87zha2hb96.fsf@vostro.fn.ogness.net>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-20 17:33:25 [+0200], John Ogness wrote:
> On 2020-05-20, Joe Korty <joe.korty@concurrent-rt.com> wrote:
> > [5.4-rt] kdb: push 'bt' command output to console immediately.
> >
> > The rt patch for 5.4 and 5.2 broke kdb slightly.  The kdb
> > 'bt' command now prints a single line then returns to the
> > kdb prompt.  There is no stack trace being shown.
> ...
> >
> > I have attached a small patch that Seems To Work.  It
> > taps earlier into printk than the official tap does.
> 
> On LKML a similar patch was recently posted[0]. It would probably be
> better to follow that (patching vprintk_func and using
> KDB_MSGSRC_PRINTK).

Should I do here anything?

> John Ogness

Sebastian
