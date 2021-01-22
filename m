Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF8DC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A896E23AA3
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 14:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbhAVOKH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 09:10:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54444 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbhAVOIH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 09:08:07 -0500
Date:   Fri, 22 Jan 2021 15:07:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611324445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goKE0np0gdaVbFZknb7K+GcD9My3+G10shVfpaGbs6g=;
        b=bgp1md6dW/H072Uqlu032tJHbE8ApxsLl4vkaHyoLLtilZ2O9KgkT7WXpq78nBmM1gARAn
        Z+zID+iRq3IdqvUD70Qzl3ZemaavnEBbk9rdSW6WdQ/P+kgxNV4T57EqkJW47YPsZ6ZLww
        VlFJw9RRT5qWMpSX4FFwtgWPxE6UnyZDAUOlq2thZcB1DxHZcLxe022TvXh0Sqd89ClQm5
        21P6dQfkjF7xp8YgNB2u28VoeFOQaehZt2u3BP4K3vHlMsMC7fPW8BhtLNhdJFvwCpT39s
        4Sy65BE4A2XMev1yk2wfBt1PUgpC6IHFFb7OE9tWV08FgrL/ZhV9ll1eapOVnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611324445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=goKE0np0gdaVbFZknb7K+GcD9My3+G10shVfpaGbs6g=;
        b=QY9BKQATi4+rFD2FkmsKvRhpZ4v3qenER6z1QA0Cb5Mk0BwqmW9kP6aVigi78fUUiPvACf
        ZbkDiH/PxiyaFABg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sebastien Laveze <sebastien.laveze@oss.nxp.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: timerfd performances
Message-ID: <20210122140724.zddf5oxkvn3lv7rt@linutronix.de>
References: <e4c83482f22059647c546f202470d05e142134bc.camel@oss.nxp.com>
 <20210122123057.72aeag672rh3omcw@linutronix.de>
 <0374b95d874d2525f4f354de600b62d369068017.camel@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0374b95d874d2525f4f354de600b62d369068017.camel@oss.nxp.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-01-22 14:23:06 [+0100], Sebastien Laveze wrote:
> On Fri, 2021-01-22 at 13:30 +0100, Sebastian Andrzej Siewior wrote:
> > Splitting the timer-wakeups back into ktimersoftd would look like
> > helping. But note that all timer wake ups would happen there - even the
> > accumulated case where we have to wake 100 tasks at once. This would
> > then probably ask for split on SCHED_OTHER vs RT tasks like it is done
> > for clock_nanosleep().
> I didn't know there was a difference in the wakeup mechanism when using
> clock_nanosleep if the task was RT or not but that makes sense indeed.
> (just looking at __hrtimer_init_sleeper)
> 
> So basically, if re-introduced, the ktimersoftd (with a RT priority by
> default) would only handle the wakeup of RT tasks ? Other non-RT
> POSIX/timerfd users would still be woken-up by ksoftirqd ?

On top of my head, yes. There might be a better way. Using one thread at
prio 1 would mix the wakeup of all threads with various priorities. This
is not a problem for clock_nanosleep() because it can be woken up
directly from the hardirq.

> Thx,
> Seb

Sebastian
