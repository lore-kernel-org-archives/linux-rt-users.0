Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6489C432BE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 10:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9134460EBC
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 10:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbhH0KIf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 06:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbhH0KIe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 06:08:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31722C061757;
        Fri, 27 Aug 2021 03:07:46 -0700 (PDT)
Date:   Fri, 27 Aug 2021 12:07:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630058863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cc35sKISqhF/PZW6jwmgPX34aVtQAZz0l7o2CbMds0g=;
        b=m5dGI+IUwlgOGfaGgR2DCTWLk64VkjCIW8A4t7B6iHGIX82lrJ+GjzEn4Fn/YxY9RWjCCk
        VEGtdLSOu0vJBpa3yt+ojONar+M/bInm6xdAXccBfQV1v5tAgFc8h33IEmTliThPfr56iy
        JMOw0sS/BB3VeCHePkMPAsznN3bq88AmvwzJQHwiu47kWXViMYnHR9EF/weOTvQiuruCK3
        n9XpMwlmogiWmxDfDR6WEajvUEpxjEWlqRIyQ5/cJSEdJ1SIOrLdmoM2YiSUdwCuzzVyQ0
        BNoruwT7FVYRx4T8ZQRmGWybeRTU7oUD07DztKZBKKWnG7Xr/tau0v714STcyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630058863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cc35sKISqhF/PZW6jwmgPX34aVtQAZz0l7o2CbMds0g=;
        b=+jEhqma0HMQd8/5g6bJvBkmLV9LPMhsLA6D0T4MdCDfDIVf9CSO9Fs8RhqxoM0cunEPtzr
        QLLDRenaKYHO8iBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC PATCH -RT] epoll: Fix eventpoll read-lock not writer-fair
 in PREEMPT_RT
Message-ID: <20210827100742.naifk7js3ukpp3f2@linutronix.de>
References: <20210825132754.GA895675@lothringen>
 <20210826115340.jzm3dicvporgrelp@linutronix.de>
 <87v93srltf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87v93srltf.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-26 22:36:04 [+0206], John Ogness wrote:
> On 2021-08-26, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > On 2021-08-25 15:27:54 [+0200], Frederic Weisbecker wrote:
=E2=80=A6
> >> I guess making readlock writer fair is still not the plan so all I can
> >> propose is to make that rwlock build-conditional.
=E2=80=A6
> > It is writer fair in a sense that once a writer attempts to acquire
> > the lock no new reader are allowed in.
> >
> > What you want is that the writer pi-boosts each reader which is what
> > is not done (multi reader boost). Long ago there was an attempt to
> > make this happen (I think with rwsem) but it turned out to be
> > problematic.  There was a workaround by only allowing one reader and
> > doing PI as usual.
>=20
> This patch is essentially forcing that exact workaround for eventpoll.

Frederic ended the mail with "readlock is not writer fair" so I
explained that it is and he means something else and this is not not
coming. I also suggested between the lines that he might try to move
the reader side to RCU.

> John Ogness

Sebastian
