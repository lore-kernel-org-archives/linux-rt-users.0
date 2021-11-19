Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64269C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 12:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4127F61A89
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 12:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhKSMWy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 07:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbhKSMWx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 07:22:53 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BEAC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 04:19:52 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j77so7077489ybg.6
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 04:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gZiBdVP0nZO8ZK5kPZeyqXbyH3azms0lTZjL+nuoFXE=;
        b=Qo4h6QbFmQHf7On+DNxZK22rDjqR1rwUzYMj4Zgkv4eD/Ke2VFd/U5U99cj5mXboty
         XrVPsrvhlT2FeLkSkVzY/K0f7nkQJqPRbE3ngc/5qn2en88dK2REnO5FypCt69dhfs12
         cpzZTUtOIVRtJTjqekYtVW7/bljkpN/e0Wop0x2E3qr88fUDeVWBrsD0sL1rS5Xw9cmE
         w+LSZoWdvsWVAtB+51xM6AEAAeJidhgUhuke6HmzsnkvtvLFx1VHq4rkMA6cqvdCsz7J
         0eVfkZI6fyumPx0+qyF4f2NsNBxQUMJcA8nBacmq9rGj5Qo2FXdtxt3cdWZiKvUP1lVt
         wx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gZiBdVP0nZO8ZK5kPZeyqXbyH3azms0lTZjL+nuoFXE=;
        b=Z1oSePBTY6oLL8RcpeDYfMF6KU7pN/AGgBJEIcGKKLocC6DICEZtLKzDalh4+kqmpa
         190g5rBT1/DpLs3WmGWqLq8JTNzXVpsvyg0se8rJZJK8Fd5TZIRy/rHsJPohPjsm9MTN
         dkiNQr8pKJIzirkTUxhX0n49PhTtqgF7fbTVyoTHbzgSEoHGz5IXkp8lFu8+75DvJTC8
         X2cUFukHVsldd5168kxn2OHe0ZC9HBQiSJKfiOYhBiADbAF8E5Mfl3hkT1cMGmQWUex/
         3HQX3x52FmE8cBXTuuWjCZBoX3etA8i1+SLsKYqHB9G5s6uDO+aM2d6iDjjcml69JzcV
         MMMQ==
X-Gm-Message-State: AOAM53117BswlvYghxL3gMS1fQfPzz0HO32gwuZErcGkfDQWfkwgeYHn
        j9hRwlS7TYyIcheF2KWU58toNOuWB3VhN0mkApd52DeUktY=
X-Google-Smtp-Source: ABdhPJzC2YgemIjSSGvmFOETF2jBfti6jX7E5y8fxTvxsdVpX739CvRAX1Tv9O9MPl9SxhgjzA3+tBFXm8Odx9G1Am8=
X-Received: by 2002:a25:2089:: with SMTP id g131mr37960528ybg.321.1637324391410;
 Fri, 19 Nov 2021 04:19:51 -0800 (PST)
MIME-Version: 1.0
References: <CAKJ14Ne-G77o-m=Ez-7Eoaq55SdvLy+x1-sfVyx4g5qLTrHSJg@mail.gmail.com>
 <20211119114722.yiejgsteghygxep2@linutronix.de>
In-Reply-To: <20211119114722.yiejgsteghygxep2@linutronix.de>
From:   Andreas Glatz <andi.glatz@gmail.com>
Date:   Fri, 19 Nov 2021 12:19:40 +0000
Message-ID: <CAKJ14NeC9HnOSDs3fNYYRA2mQ5dnMwm-rK3qT4cgCVfqZyE6eQ@mail.gmail.com>
Subject: Re: Q: Possible reason(s) for BUG in rt_spin_lock_slowlock_locked()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 19, 2021 at 11:47 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2021-11-19 10:39:20 [+0000], Andreas Glatz wrote:
> > Hi
> Hi,
>
> > I patched 4.19.100 with rt41 patch set and we ported the Micrel
> > ksz8462_h Ethernet driver. The driver has one threaded IRQ triggered
> > by the interrupt from the ksz8462 chip and two workers, one for
> > gathering MIBs and one for checking the link status. Everything
> > seemingly ran ok for quite some time. However, yesterday I noticed
> > that the IRQ thread died in rt_spin_lock_slowlock_locked() as per
> > stacktrace below at:
> >
> > 0xc0af82f8 is in rt_spin_lock_slowlock_locked
> > (/usr/src/kernel/kernel/locking/rtmutex.c:1105).
> > 1100 * unconditionally. We might have to fix that up:
> > 1101 */
> > 1102 fixup_rt_mutex_waiters(lock);
> > 1103
> > 1104 BUG_ON(rt_mutex_has_waiters(lock) && waiter =3D=3D rt_mutex_top_wa=
iter(lock));
> > 1105 BUG_ON(!RB_EMPTY_NODE(&waiter->tree_entry));
> > 1106 }
> > 1107
> > 1108 static void noinline __sched rt_spin_lock_slowlock(struct rt_mutex=
 *lock)
> > 1109 {
> >
> > In the jtag debugger I see that at the same time the other two
> > kthreads are waiting on the spinlock that's held by the IRQ thread
> > that died on two of the four CPU cores of the i.MX6q.
> >
> > Any ideas what might cause this and how to fix it?
>
> So the lock owner exploded in BUG_ON() and every lock attempt will fail
> since the slow-path is forced and the wait_lock is still acquired.
>
> The BUG_ON() statement suggest that the thread is enqueued as waiter but
> shouldn't since it obtained the lock. From your backtrace:

Right... any idea for investigating why this might be? I assume a
particular IRQ thread should be unique in the system? Maybe it didn't
release the lock the last time it ran?

>
> | Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
> =E2=80=A6
> | CPU: 0 PID: 1457 Comm: irq/77-ksz8462_ Tainted: G  W  O      4.19.100-r=
t41 #1
> =E2=80=A6
> | Process irq/77-ksz8462_ (pid: 1457, stack limit =3D 0x968e9d88)
> | [<c0af82f8>] (rt_spin_lock_slowlock_locked) from [<c0af8384>] (rt_spin_=
lock_slowlock+0x64/0x94)
> | [<c0af8384>] (rt_spin_lock_slowlock) from [<c0afab28>] (rt_spin_lock+0x=
7c/0x84)
> | [<c0afab28>] (rt_spin_lock) from [<bf1c4418>] (ks_irq+0x48/0x540 [ksz84=
62_h])
> | [<bf1c4418>] (ks_irq [ksz8462_h]) from [<c01933f0>] (irq_forced_thread_=
fn+0x30/0xa8)
>
> The confusing part is that you use sleeping locks but the banner says
> PREEMPT instead of PREEMPT_RT.
> Any chance that you don't have PREEMPT_RT_FULL enabled?

I just checked the .config as well as /proc/version and it seems to be
enabled... so yes, this is strange - thanks for pointing this out.

# cat /proc/version
Linux version 4.19.100-rt41 (oe-user@oe-host) (gcc version 8.3.0
(GCC)) #1 SMP PREEMPT RT Mon Nov 1 15:30:04 UTC 2021

>
> > Many thanks and regards,
> >
> > Andreas
> >
> Sebastian
