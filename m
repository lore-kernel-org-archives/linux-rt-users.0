Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7124CC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BFD120774
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgFIPrs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgFIPrr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 11:47:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFFCC05BD1E;
        Tue,  9 Jun 2020 08:47:47 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jigTV-0003vd-41; Tue, 09 Jun 2020 17:47:41 +0200
Date:   Tue, 9 Jun 2020 17:47:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     Ramon Fried <rfried.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Zhang Xiao <xiao.zhang@windriver.com>
Subject: Re: [PATCH RT 1/2] tasklet: Address a race resulting in
 double-enqueue
Message-ID: <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org>
 <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
 <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
 <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-04 15:51:14 [-0500], Tom Zanussi wrote:
> > 
> > Hi, This patch introduced a regression in our kernel
> > (v4.19.124-rt53-rebase), It occurs when we're jumping to crush kernel
> > using kexec, in the initialization of the emmc driver.
> > I'm still debugging the root cause, but I thought of mentioning this
> > in the mailing list if you have any idea why this could occur.
> > The issue doesn't happen on normal boot, only when I specifically
> > crash the kernel into the crash kernel.
> > Thanks,
> > Ramon.
> 
> I'm not very familiar with crashing the kernel into the crash kernel. 
> Can you explain in enough detail how to set things up to reproduce this
> and how to trigger it?  Does it happen every time? 
> 
> >From looking at the backtrace, it's hitting the WARN_ON() in the
> cmpxchg() loop below, because TASKLET_STATE is just
> TASKLET_STATE_CHAINED.
> 
> It seems that the only way to turn off TASKLET_STATE_CHAINED is via
> this cmpxchg(), but TASKLET_STATE_RUN can be independently turned off
> elsewhere (tasklet_unlock() and tasklet_tryunlock()), so if that
> happens and this loop is hit, you could loop until loops runs out and
> hit this warning.

But clearing TASKLET_STATE_RUN independently happens by the task, that
set it / part of tasklet_schedule().
tasklet_tryunlock() does a cmpxchg() with only the RUN bit so it won't
work if the additional CHAINED bit is set.

The tasklet itself (which may run on another CPU) sets the RUN bit at the
begin and clears it at the end via cmpxchg() together with the CHAINED
bit. 

I've been staring at it for sometime and I don't see how this can
happen.

Sebastian
