Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F5C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C4D6102A
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 11:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242308AbhHZLya (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 07:54:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhHZLya (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 07:54:30 -0400
Date:   Thu, 26 Aug 2021 13:53:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629978822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzSHXovWOy07GY16PKEq30/8tac2aCHWFtSmVjaSxJ8=;
        b=N3yHKWZFq4YkcrBx2Rvo0bPOJCoWQ9BWCgRcaoZ8mivSRAoiGL8u6m3whyJT0h12awQH4N
        N/ihO25lj0ldHDRq1gOwI0vD2RFen9N1w/VfBAyNPTYRnKVFoM+8VnSeakCRGMHWNkSqtO
        xxTMgFT998JZpxAsM/LIpj58OweKtvdrnBCBuWIfX0zj3LkE5bx/7D2xUFM8UWj6AkF6Z1
        RkQaDFGuK+oWvPdw68f7BAlK2WgOoZrcXQebJtRr3Llz8h6M2IQ+i5D4deM9fqz5Jw2HP8
        qGyOVRpM3aEszdBu3gkDBf1A6p+1vQOO/dIuF4m3ZETb7NqQbmrxNiuZ/fmC3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629978822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tzSHXovWOy07GY16PKEq30/8tac2aCHWFtSmVjaSxJ8=;
        b=v9r7oG4wtsyMDzJKGetxr/jQP6zCIGJuUFUxCvz2WUnPXMS9qtzKa/+S8zC3z4j598C3UV
        IRIB8EHV/39gipAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair
 in PREEMPT_RT
Message-ID: <20210826115340.jzm3dicvporgrelp@linutronix.de>
References: <20210825132754.GA895675@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210825132754.GA895675@lothringen>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-25 15:27:54 [+0200], Frederic Weisbecker wrote:
> Hi,
> 
> Ok the patch is gross but at least this lets me start a discussion
> about the issue.
> 
> ---
> From d9d66d650b3dac8947a34464dd2e0b546a8c6b63 Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Wed, 25 Aug 2021 14:24:54 +0200
> Subject: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair in PREEMPT_RT
> 
> The eventpoll lock has been converted to an rwlock some time ago with:
> 
> 	a218cc491420 (epoll: use rwlock in order to reduce ep_poll
> 					callback() contention)
> 
> Unfortunately this can result in scenarios where a high priority caller
> of epoll_wait() need to wait for the completion of lower priority wakers.
> 
> The typical scenario is:
> 
> 1) epoll_wait() waits and sleeps for new events in the ep_poll() loop.
> 
> 2) new events arrive in ep_poll_callback(), the waiter is awaken while
>    ep->lock is read-acquired.
> 
> 3) The high priority waiter preempts the waker but it can't acquire the
>    write lock in epoll_wait() so it blocks waiting for the low prio waker
>    without priority inheritance.
> 
> I guess making readlock writer fair is still not the plan so all I can
> propose is to make that rwlock build-conditional.

It is writer fair in a sense that once a writer attempts to acquire the
lock no new reader are allowed in.
What you want is that the writer pi-boosts each reader which is what is
not done (multi reader boost). Long ago there was an attempt to make
this happen (I think with rwsem) but it turned out to be problematic.
There was a workaround by only allowing one reader and doing PI as
usual.
This was then dropped because multi-reader became a must have thing for
other reasons and in the meantime the lack of pi-boosting wasn't that
*problematic* anymore. The problematic user converted in the meantime to
RCU having the reading side lockless and the writer had a regular lock.

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Sebastian
