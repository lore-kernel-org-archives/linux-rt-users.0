Return-Path: <SRS0=w7Cs=7W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6BFC433DF
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F30020734
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Jun 2020 16:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgFIQew (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgFIQew (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Jun 2020 12:34:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29DAC05BD1E;
        Tue,  9 Jun 2020 09:34:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jihD4-0004lD-T6; Tue, 09 Jun 2020 18:34:46 +0200
Date:   Tue, 9 Jun 2020 18:34:46 +0200
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
Message-ID: <20200609163446.efp76qbjzkbtl7nk@linutronix.de>
References: <cover.1587675252.git.zanussi@kernel.org>
 <6d4c92b28c54d8ca687c29043562de943a373547.1587675252.git.zanussi@kernel.org>
 <CAGi-RUKn6k98H5v9kw7je1MChb4+Uq8EGhKO0nuXNMBy9M1_qw@mail.gmail.com>
 <b5026121af44601e4318479194357fdb956982f6.camel@kernel.org>
 <20200609154741.5kesuvl7txz4s3yu@linutronix.de>
 <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e288ef193f743782df48667b6b03122bd025119f.camel@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-06-09 11:17:53 [-0500], Tom Zanussi wrote:
> Hi Sebastian,
Hi Tom,

> I did find a problem with the patch when configured as !SMP since in
> that case the RUN flag is never set (will send a patch for that
> shortly), but that wouldn't be the case here.

How?

| #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT_FULL)
| static inline int tasklet_trylock(struct tasklet_struct *t)
| {
|         return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
| }

I can't tell from the backtrace if he runs with RT or without but I
assumed RT. But yes, for !SMP && !RT it would explain it.

> It would help to be able to reproduce it, but I haven't been able to
> yet.
> 
> Tom
> 
Sebastian
