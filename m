Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767BCC432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 20:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5074C61027
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 20:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbhHZUa4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhHZUaz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 16:30:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC227C061757;
        Thu, 26 Aug 2021 13:30:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630009805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8UXnJqPBl9bMR7bNHfiVLEP7x645Ey89EezN1ntlwU=;
        b=VBDa1tFsXe3DqTVCacj049KMyZFprQiq4GNZQNzWOCZRh2mgNzkNX0rQpbNqCcFAJx3bQ/
        FodfJMXO3kwXbcOm70JewzN3eD33hey2tKLu6ZmYflB54tAunBXxXcagF8S8SucSoMv+X7
        QnvXDU6T2EsJUtz7+cBI456GbZef4JbcGLz4Yq7/7fLTfqHwmkPW4zrj/wwZm+wwZDIfr9
        Czlx6bo745bb0Sr2hZhSc1AUK20REbNLHHIj4Fd7noyTbe6c2fKcMmXjIRggq/baAYqcSQ
        jlnT0Z9iCwkgrdQpcfmAobZYrGmVPJg+C0M2Ixs16TGYtR9JQ3AJ8iPedkCVbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630009805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h8UXnJqPBl9bMR7bNHfiVLEP7x645Ey89EezN1ntlwU=;
        b=lFhSfpUR+uySctN+5nkUrDE69qo5W5DZ2G3nUJtNFcALX+aeVlnapEIcok/XVCRN62Fsmz
        sif3Vhs4lRee6bDA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair in PREEMPT_RT
In-Reply-To: <20210826115340.jzm3dicvporgrelp@linutronix.de>
References: <20210825132754.GA895675@lothringen> <20210826115340.jzm3dicvporgrelp@linutronix.de>
Date:   Thu, 26 Aug 2021 22:36:04 +0206
Message-ID: <87v93srltf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-26, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2021-08-25 15:27:54 [+0200], Frederic Weisbecker wrote:
>> Hi,
>> 
>> Ok the patch is gross but at least this lets me start a discussion
>> about the issue.
>> 
>> ---
>> From d9d66d650b3dac8947a34464dd2e0b546a8c6b63 Mon Sep 17 00:00:00 2001
>> From: Frederic Weisbecker <frederic@kernel.org>
>> Date: Wed, 25 Aug 2021 14:24:54 +0200
>> Subject: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair in PREEMPT_RT
>> 
>> The eventpoll lock has been converted to an rwlock some time ago with:
>> 
>> 	a218cc491420 (epoll: use rwlock in order to reduce ep_poll
>> 					callback() contention)
>> 
>> Unfortunately this can result in scenarios where a high priority caller
>> of epoll_wait() need to wait for the completion of lower priority wakers.
>> 
>> The typical scenario is:
>> 
>> 1) epoll_wait() waits and sleeps for new events in the ep_poll() loop.
>> 
>> 2) new events arrive in ep_poll_callback(), the waiter is awaken while
>>    ep->lock is read-acquired.
>> 
>> 3) The high priority waiter preempts the waker but it can't acquire the
>>    write lock in epoll_wait() so it blocks waiting for the low prio waker
>>    without priority inheritance.
>> 
>> I guess making readlock writer fair is still not the plan so all I can
>> propose is to make that rwlock build-conditional.
>
> It is writer fair in a sense that once a writer attempts to acquire
> the lock no new reader are allowed in.
>
> What you want is that the writer pi-boosts each reader which is what
> is not done (multi reader boost). Long ago there was an attempt to
> make this happen (I think with rwsem) but it turned out to be
> problematic.  There was a workaround by only allowing one reader and
> doing PI as usual.

This patch is essentially forcing that exact workaround for eventpoll.

John Ogness
