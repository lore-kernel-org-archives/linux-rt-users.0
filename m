Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FB1C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33EE64D9F
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhBRPy2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:54:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51666 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbhBRMef (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 07:34:35 -0500
Date:   Thu, 18 Feb 2021 13:33:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613651620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOEH20L6xujzHKVRizb4ijEd34jPwPdVlAorPC3Xni0=;
        b=P4PdjvgBQRJ0ZjGyPPSbuHO92vT6Rwh3qHOM/9pRzNgXopgK+2F9XP3GKjnEdRZkzI4wv/
        Y9qwWQD4G5dy90DuYQMae5lnM3PLOgJVN5wORW/RBDqPK1VSypgFJBya8l7lJ9bXMp5U9J
        tYIhTtXV3IjN2uMc5YwdSkKnHgyLZCrlIie2hcU5t5PNWyJEJgK6cs66O7/Fxy/AC0gGHq
        yLgF8SoBOJWesmPaVRydnFJF+pfAD3EaCvcMS20z4F+weOkxUH6EtnIMez0C/9czPspMoN
        KEuyYRQEJZ2wdcTbH4IXzIwF3ZaQfHSHZBfRYNfT+iRrTKgvRO3UcsP5/7SLJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613651620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOEH20L6xujzHKVRizb4ijEd34jPwPdVlAorPC3Xni0=;
        b=0BCyI9UVYraNsFZHiIy20Ae4rhLLDJyVd3mdqmem25j4JRJw/91/Ap1HKvS/OqnTjghyAi
        6ZOhPQehALNU0tBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Kegl Rohit <keglrohit@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: 5.4.y softirq processing
Message-ID: <20210218123338.3xgaoqv2ukoktq2k@linutronix.de>
References: <CAMeyCbgqzz5MqOM-yXNxdcRSYquK4BtcmvFR6aug29Dgd0YGmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMeyCbgqzz5MqOM-yXNxdcRSYquK4BtcmvFR6aug29Dgd0YGmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-15 16:04:00 [+0100], Kegl Rohit wrote:
> Hello!
Hi,

> May i ask some questions of the current state of softirq processing
> with PREEMPT_RT.
> 
> In 4.19.173-rt72 timer softirq processing is split into its own thread
> ktimersoftd.
> patches\0124-softirq-split-timer-softirqs-out-of-ksoftirqd.patch
> This timer split existed for years.
> 
> Since 5.0.19 its gone because of a softirq rework.
> 6f6ba7715a91877cf5fd2b357db3799baa331d9b
> 
> I only found this info about it:
> https://lwn.net/ml/linux-rt-users/CAFzL-7tzwnBEnt_q2f0BPSAO3To_Zaxt4bLtfzKVOiyJTua45g@mail.gmail.com/
> https://lwn.net/Articles/789761/
> Can anyone give me a more detailed / simpler explanation why it was removed?

The split was done to allow the ksoftirqd run at a non-RT prio. This was
needed for other reasons.
With the softirq-rework we managed NAPI and its overloading part to work
like it does in mainline.
The timer thread was killed because there should not be anything
important that still relies on it. The problem is also that if you
outsource the timer callbacks to its own thread with RT priority that it
will process every timer wakeup at this priority.

> Others are also effected by this change:
> https://www.spinics.net/lists/linux-rt-users/msg23051.html

This behaviour aligns with mainline. If ksoftirqd is busy then it will
take over any new softirq.

> https://bugzilla.redhat.com/show_bug.cgi?id=1303733
> 
> For our application it was necessary to increase the processing
> priority of timer tasks by setting the ktimersoftd priority higher
> than the ksoftirqd.
> Now this is not possible anymore.
> Does a method to increase timer task processing over the other not so
> important ksoftirqd workloads still exist?

There may be different timer here. A clock_nanosleep() from a RT task
will fire "immediately". A clock_nanosleep() from a non-RT task will be
deferred to ksoftirqd. Other timer, that need a sleeping lock, will be
processed in ksoftirqd. There might be a kposixtimer thread in v5.4
dealing with some of the posix timer.

What kind of timers do you have?

> Another way to gain a lot more control over different system
> components would be this patch, which split every softirq in its own
> kthread.
> https://lore.kernel.org/patchwork/patch/513177/
> This patch is very outdated and I am not able to port it.
> 
> Do I miss something?

Having a thread per softirq looked like a good idea but it wasn't
*that* good. There is the additional task-switch overhead which is
visible especially on smaller boxes. The order of processing the
softirqs is also somehow important but this are mostly details.

> Is there any way to set different priorities for each softirq as of 5.4.y-rt?
> e.g. to reduce the priority of NET_RX_SOFTIRQ / BLOCK_SOFTIRQ
> Control over NET_RX_SOFTIRQ would help in network flood situations.

Nope, everything is sort of mixed.
The NET_RX_SOFTIRQ should be running after the end of the threaded
interrupt of the NIC ends (at RT prio 50). Should the NET_RX part
overload the system (a network flood) then it will continue in
ksoftirqd. It will also continue in ksoftirqd if something else woke the
thread (like the timer wakeup).
The NAPI callback should cleanup a certain amount packets and if
something is pending it will continue later to do more. Each time the
softirqs are processed it will start at the first one which means it
should process TIMER_SOFTIRQ before continuing with NET_RX_SOFTIRQ.

> Thanks in advance!

Sebastian
