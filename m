Return-Path: <SRS0=RNtb=7C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F93C433E1
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733E32072C
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 May 2020 15:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgETPd2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 20 May 2020 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgETPd1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 May 2020 11:33:27 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A4C061A0E
        for <linux-rt-users@vger.kernel.org>; Wed, 20 May 2020 08:33:27 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jbQik-0004Mt-2T; Wed, 20 May 2020 17:33:26 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [5.4-rt] kdb: push 'bt' command output to console immediately.
References: <20200520151613.GA54006@zipoli.concurrent-rt.com>
Date:   Wed, 20 May 2020 17:33:25 +0200
In-Reply-To: <20200520151613.GA54006@zipoli.concurrent-rt.com> (Joe Korty's
        message of "Wed, 20 May 2020 11:16:14 -0400")
Message-ID: <87zha2hb96.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-20, Joe Korty <joe.korty@concurrent-rt.com> wrote:
> [5.4-rt] kdb: push 'bt' command output to console immediately.
>
> The rt patch for 5.4 and 5.2 broke kdb slightly.  The kdb
> 'bt' command now prints a single line then returns to the
> kdb prompt.  There is no stack trace being shown.
...
>
> I have attached a small patch that Seems To Work.  It
> taps earlier into printk than the official tap does.

On LKML a similar patch was recently posted[0]. It would probably be
better to follow that (patching vprintk_func and using
KDB_MSGSRC_PRINTK).

John Ogness

[0] https://lkml.kernel.org/r/20200520102233.GC3464@linux-b0ei
