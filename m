Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307FCC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Oct 2021 08:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14580610CF
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Oct 2021 08:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhJ1ItZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1ItY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Oct 2021 04:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46501C061570;
        Thu, 28 Oct 2021 01:46:57 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:46:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635410815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8973S67dMEKktlppNBcsVgkRwKXuyLUhRChxtrzBCGk=;
        b=bcOPNXOmYOgFZ6rppiXsHb+B6+oRRemedMmSyIl/MeQV48Ak4gTxVXTTHPUF5v2qzImW5f
        /Kbo4kwXDgSJAn/6Qg4NL24X5d+YDDmxIizngE/n6Xr43uK3pe0utb8T8C5ol0tWJV3Bng
        xN1CV+qnXaBwnFSKep8DEKuF9Sjzttyz3C6KWPcCkXFcM97q40wzmUcMGbvbSnMP3Wl31d
        kDb07TdbHCT8kPQ11Hk6ypkN+jhp8Szf97aQTMeUn/fLCGljS/Ium/2QVlAoeUJT/UkVZM
        57umS64+FUQ4gG3ndKKqPK1gVjhe8bql0m/X7M+ccFxfqTv/eESwXvBhesYxAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635410815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8973S67dMEKktlppNBcsVgkRwKXuyLUhRChxtrzBCGk=;
        b=zw6bzhZTlIXXzGHl/p4caJeewKxOP5dqirHfaz98zGpgWphuYAPUgFIhDYQOW/owFm4OGx
        G4zqgk6wTHTCURDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ronny Meeus <ronny.meeus@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Unbounded priority inversion while assigning tasks into cgroups.
Message-ID: <20211028084654.bgtvnibvqnz2o5rh@linutronix.de>
References: <CAMJ=MEd9WuGA0MN+n0rGD6T+sgd=yciTmeEW9TjRjNXt+cF=qQ@mail.gmail.com>
 <20211027165800.md2gxbsku4avqjgt@linutronix.de>
 <CAMJ=MEfkQ9VaphaNS_qbWMOANo7P6h2Ln6iYg4JLWbWzxp85mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMJ=MEfkQ9VaphaNS_qbWMOANo7P6h2Ln6iYg4JLWbWzxp85mA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-27 22:54:33 [+0200], Ronny Meeus wrote:
> > From a looking at percpu_rw_semaphore implementation, no new readers are
> > allowed as long as there is a writer pending. The writer has
> > (unfortunately) to wait until all readers are out. But then I doubt that
> > this takes up to two minutes for all existing readers to leave the
> > critical section.
> >
> 
> The readers can be running at low priority while there can be other threads
> with a medium priority will consume the complete cpu. So the low prio
> readers are just waiting to be scheduled and by that also block the high
> prio thread.

Hmm. So you have say, 5 reads stuck in the RW semaphore while preempted
be medium tasks and high-prio writer is then stuck on semaphore, waiting
for the MED tasks to finish so the low-prio threads can leave the
criticial section?

> Looking at v4.9.84, at least the RT implementation of rw_semaphore
> > allows new readers if a writer is pending. So this could be culprit as
> > you would have to wait until all reader are gone and the writer needs to
> > grab the lock before another reader shows up. But then this shouldn't be
> > the case for the generic implementation and new reader should wait until
> > the writer got its chance.
> >
> 
> So what do you suggest for the v4.9 kernel as a solution? Move to the RT
> version of the rw_semaphore and hope for the best?

I don't think it will help. Based on what you wrote above it appears
that the problem is that the readers are preempted and are not leaving
the critical section soon enough.

How many CPUs do you have? Maybe using a rtmutex here and allowing only
one reader at a time isn't that bad in your case. With one CPU for
instance, there isn't much space for multiple readers I guess.

Sebastian
