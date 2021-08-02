Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F12C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 09:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 902EF61057
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 Aug 2021 09:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhHBJMZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbhHBJMY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 Aug 2021 05:12:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BDAC06175F;
        Mon,  2 Aug 2021 02:12:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627895533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I27DYbxJUYQ+kE3eUIbMjQoSNxzM2tRsRutJFBumFGM=;
        b=gJ/p0xWPKsw2PEeZp4MuDvRWTc37/hTH7Kj/vjplyRpgHkgn+ba5Ev7xa4i5RgWQdBazyG
        mPCixscS8mzjnRgoBSWhcWYjVI176nfEfosRZognczOUqu814JlcNl2DDeJsVRFhTso6gc
        jIvXCJK6JuZTX62HUqnLvLknCT8LMoDUfJxJdBhmvZ+XiwdJ2Jvd5vFTfbNMib8lBlK1MS
        j4EWCgKd6AW02+XO/N8HhVDKthGAW4/GWntaWou0O8GW2uJndgh0rUaLIJTTeEvKunUWIS
        Pw7wp8xRruEaR1yhCCX7mIh9Xj2MYDOfmt8R/jfmEnM+g+YLFx+U2/ltM27nxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627895533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I27DYbxJUYQ+kE3eUIbMjQoSNxzM2tRsRutJFBumFGM=;
        b=QP1qjqahbDJUX/V3ZNeOch/2JkWRsYHEmaI89cY1yU/Fg/V1wIK8aA5r8chTRedkdftZWJ
        Q8Zg115yUGt12mCg==
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: v5.14-rc3-rt1 losing wakeups?
In-Reply-To: <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
References: <20210730110753.jvli6alm63h5lefy@linutronix.de>
 <2ae27233ab091d09a7d1e971a47144b40dd51fa0.camel@gmx.de>
 <87pmuzsf1p.ffs@tglx>
 <6fce881efc3d8c24a5172528fe1f46ec2ddc0607.camel@gmx.de>
 <ed1d5f9ec17a5b8d758c234562dad47cfc872ed8.camel@gmx.de>
Date:   Mon, 02 Aug 2021 11:12:12 +0200
Message-ID: <87k0l42osz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Mike,

On Sun, Aug 01 2021 at 17:14, Mike Galbraith wrote:

> On Sun, 2021-08-01 at 05:36 +0200, Mike Galbraith wrote:
>> On Fri, 2021-07-30 at 22:49 +0200, Thomas Gleixner wrote:
>> > >
>> > > First symptom is KDE/Plasma's task manager going comatose.=C2=A0 Not=
ice soon
>> >
>> > KDE/Plasma points at the new fangled rtmutex based ww_mutex from
>> > Peter.
>>
>> Seems not.=C2=A0 When booting KVM box with nomodeset, there's exactly one
>> early boot ww_mutex lock/unlock, ancient history at the failure point.
>
> As you've probably already surmised given it isn't the ww_mutex bits,
> it's the wake_q bits.  Apply the below, 5.14-rt ceases to fail.  Take
> perfectly healthy 5.13-rt, apply those bits, and it instantly begins
> failing as 5.14-rt had been.

now staring at it makes it pretty obvious. When I picked up Peter's
patch I thought about it briefly and then ignored my doubts :(

>  /* RT mutex specific wake_q wrappers */
> -static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *w=
qh,
> +static __always_inline void rt_mutex_wake_q_add(struct rt_mutex_wake_q_h=
ead *wqh,
>  						struct rt_mutex_waiter *w)
>  {
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state !=3D TASK_NORMAL) {
> -		wake_q_add(&wqh->rt_head, w->task);
> +		get_task_struct(w->task);
> +		wqh->rtlock_task =3D w->task;

This is the key. With the original asymmetric version the wake_q_add for
wake_state !=3D TASK_NORMAL is storing the task unconditionally in
wqh->rtlock_task.

With that wake_q_add() we end up with the following situation:

Some code, e.g. futex does:

     wake_q_add(..., task)

which links task->wake_q->next is !NULL. Ergo the wake_q_add() in the
rtmutex code bails out. Same the other way round if the rtmutex side
queues first then the second - regular wakeup - will not be queued.

There's two ways to fix that:

  1) Go back to my original version

  2) Add another wake_q head to task_struct

#2 is overkill IMO simply because the rtlock wait is not subject to
multiple wakeups.

Thanks a lot Mike for tracking this down!

Thanks,

        tglx
