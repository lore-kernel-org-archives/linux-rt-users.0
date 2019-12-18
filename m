Return-Path: <SRS0=Zbf1=2I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA31C43603
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 16:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B92176D
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Dec 2019 16:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRQxg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Dec 2019 11:53:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58206 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfLRQxg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Dec 2019 11:53:36 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ihcZq-0006lg-Bd; Wed, 18 Dec 2019 17:53:34 +0100
Date:   Wed, 18 Dec 2019 17:53:34 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org, lukas.bulwahn@gmail.com
Subject: Re: complete_all() with x waiters in swake_up_all_locked
Message-ID: <20191218165334.k4suur4gzlu62ibs@linutronix.de>
References: <CAJz2qXnHnw7Z9ftb6Oha5_0-R4YfUL+FhVZPNX1KKHyUkP6KNA@mail.gmail.com>
 <20191212171230.ygveclhr5xqurys7@linutronix.de>
 <CAJz2qXnPquUZSeO9SWSmvLKcdhnT96KnD66F-oatdnotYkxS+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJz2qXnPquUZSeO9SWSmvLKcdhnT96KnD66F-oatdnotYkxS+A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-13 11:08:35 [+0200], John Mathew wrote:
> 
> I was able to reproduce the warning on v5.2.21-rt14 which is the
> latest tag on the rt-devel branch.
> Here is my analysis.
> What I see is that in crypto/algboss.c there is a probe being
> scheduled when a notification arrives.
> The probe will run a thread: cryptomgr_probe and wait for its completion.
> The issue arises because a similar module is also issues a wait for
> completion on the exactly same completion object (larval->completion).
> The similar module is:  crypto_larval_wait in linux-rt-devel/crypto/api.c
> It is casting a crypto_larval struct pointer from a crypto_alg struct
> pointer which doesn't seem to have/init a completion object.

It should. container_of() statement would be better.

> So it is actually the cryptomgr_probe thread that actually completes
> both its own and the crypto_larval_wait waits and so the number of
> completions exceeds the limit of 2.
> 
> This looks like an error to me.

Why? So multiple threads request a specific algorithm. This is
synchronized into one request which (once complete) invokes
complete_all() to wake all requesting threads. So this does not sound
bad. 
I compiled and tested the syzkaller testcase but still no luck. Is there
something special to you .config?

> So I created patch in the following email.
> I don't think the issue is with the limit, rather a wrong usage of the
> completion object.

But why is there no other error? Like wrong list usage, uninitialized
spin_lock, etc.?

> > > -John

 Sebastian
