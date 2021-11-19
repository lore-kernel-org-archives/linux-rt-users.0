Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FCAC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD00661A02
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 13:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbhKSNtD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbhKSNtC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 08:49:02 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2666FC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 05:46:01 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id v138so28467420ybb.8
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Nov 2021 05:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rGLY+1ToWG8/IZMwUkUwIHR2+l2973CScqekkdiV1dg=;
        b=hycWCTrx/WzXk/cf8C1YzDpjbb5oCzFFHb71BEzBaSf9vARi08eDJYTbMiOKDdHxKS
         ixrCSQF+N17Sn11bW+i6awCBhoCVk+5VUwG17f/DeWhilof2HQjnC2ZjKV3sd5ey36Df
         lChUj2LdfDA9bJOMq07n+UqnHQLJkB0ITpuCg9EuP0y8GEp6EemPeaZvySfrIgAyJZPg
         QGvuGhm2fZs0qmDsIHSsSmAyqUSkqu3kOhYUWY3r0awhnMFd10kYfgi8LOGj4fUoaLmw
         v4WQTlFBetaBY9IeQPta3CaczfI4sjEDTsgwOZzeTwgaxXy/JH30Khs6dn75u6Pj95f5
         xsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rGLY+1ToWG8/IZMwUkUwIHR2+l2973CScqekkdiV1dg=;
        b=t6i2/27QDNN3LiEeB4WhuwPWk82RGJLNTZ/DE5f1Y1JZCajH5yWZyLDnUG0YTzNIib
         uuOyNB5lKQHHASPsYvTeLMqzjy4A/Lj8CLO0fewA87xHmLOE9hwDnALdI20DTWCNRhmD
         3yBNt3C9ArxRkU8k59BZ8MirAxLlj7esPe8ZfrE6vSHvG9ZQISmjmhEvvBpIn1r4/+8k
         juZx196yPGi1IoGvRNUYvDb997+8FoQqlWDIp8Y8RxQkPtSq2s5dHdD2epLmDwRq4WKh
         LIobqJ6jqwoBSxER7eiHZ//QjXBpun4gnPd9J8TkwAUAp9QG2NJTnq1cbx+Zo07WS8uu
         HX7g==
X-Gm-Message-State: AOAM5315tE7mCF7L/b6RKL74TcDOdglhpQ6MFxxRMFULcfdkKRDaNMgd
        uorrDD9myS2AY/y4BgC/+DSB6XoiCw5tr9r9rqGqMR13
X-Google-Smtp-Source: ABdhPJwJGSf3NFoG5I+AUE6UmRhvoy2MstfQzix3RYTJgDT+VGluQa8rPij5E2t2XlSOfJi62XCHWFCVGKjKySHNFag=
X-Received: by 2002:a25:104:: with SMTP id 4mr35522089ybb.27.1637329560373;
 Fri, 19 Nov 2021 05:46:00 -0800 (PST)
MIME-Version: 1.0
References: <CAKJ14Ne-G77o-m=Ez-7Eoaq55SdvLy+x1-sfVyx4g5qLTrHSJg@mail.gmail.com>
 <20211119114722.yiejgsteghygxep2@linutronix.de> <CAKJ14NeC9HnOSDs3fNYYRA2mQ5dnMwm-rK3qT4cgCVfqZyE6eQ@mail.gmail.com>
In-Reply-To: <CAKJ14NeC9HnOSDs3fNYYRA2mQ5dnMwm-rK3qT4cgCVfqZyE6eQ@mail.gmail.com>
From:   Andreas Glatz <andi.glatz@gmail.com>
Date:   Fri, 19 Nov 2021 13:45:49 +0000
Message-ID: <CAKJ14NdDgpm6itQ7c6hp74ybULxztUoiTeS0ePBdU9yGKMJs+g@mail.gmail.com>
Subject: Re: Q: Possible reason(s) for BUG in rt_spin_lock_slowlock_locked()
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Nov 19, 2021 at 12:19 PM Andreas Glatz <andi.glatz@gmail.com> wrote=
:
>
> On Fri, Nov 19, 2021 at 11:47 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2021-11-19 10:39:20 [+0000], Andreas Glatz wrote:
> > > Hi
> > Hi,
> >
> > > I patched 4.19.100 with rt41 patch set and we ported the Micrel
> > > ksz8462_h Ethernet driver. The driver has one threaded IRQ triggered
> > > by the interrupt from the ksz8462 chip and two workers, one for
> > > gathering MIBs and one for checking the link status. Everything
> > > seemingly ran ok for quite some time. However, yesterday I noticed
> > > that the IRQ thread died in rt_spin_lock_slowlock_locked() as per
> > > stacktrace below at:
> > >
> > > 0xc0af82f8 is in rt_spin_lock_slowlock_locked
> > > (/usr/src/kernel/kernel/locking/rtmutex.c:1105).
> > > 1100 * unconditionally. We might have to fix that up:
> > > 1101 */
> > > 1102 fixup_rt_mutex_waiters(lock);
> > > 1103
> > > 1104 BUG_ON(rt_mutex_has_waiters(lock) && waiter =3D=3D rt_mutex_top_=
waiter(lock));
> > > 1105 BUG_ON(!RB_EMPTY_NODE(&waiter->tree_entry));
> > > 1106 }
> > > 1107
> > > 1108 static void noinline __sched rt_spin_lock_slowlock(struct rt_mut=
ex *lock)
> > > 1109 {
> > >
> > > In the jtag debugger I see that at the same time the other two
> > > kthreads are waiting on the spinlock that's held by the IRQ thread
> > > that died on two of the four CPU cores of the i.MX6q.
> > >
> > > Any ideas what might cause this and how to fix it?
> >
> > So the lock owner exploded in BUG_ON() and every lock attempt will fail
> > since the slow-path is forced and the wait_lock is still acquired.
> >
> > The BUG_ON() statement suggest that the thread is enqueued as waiter bu=
t
> > shouldn't since it obtained the lock. From your backtrace:
>
> Right... any idea for investigating why this might be? I assume a
> particular IRQ thread should be unique in the system? Maybe it didn't
> release the lock the last time it ran?

I found an instance where we did not unlock the spinlock before
returning from a function :( I'll test again...

>
> >
> > | Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
> > =E2=80=A6
> > | CPU: 0 PID: 1457 Comm: irq/77-ksz8462_ Tainted: G  W  O      4.19.100=
-rt41 #1
> > =E2=80=A6
> > | Process irq/77-ksz8462_ (pid: 1457, stack limit =3D 0x968e9d88)
> > | [<c0af82f8>] (rt_spin_lock_slowlock_locked) from [<c0af8384>] (rt_spi=
n_lock_slowlock+0x64/0x94)
> > | [<c0af8384>] (rt_spin_lock_slowlock) from [<c0afab28>] (rt_spin_lock+=
0x7c/0x84)
> > | [<c0afab28>] (rt_spin_lock) from [<bf1c4418>] (ks_irq+0x48/0x540 [ksz=
8462_h])
> > | [<bf1c4418>] (ks_irq [ksz8462_h]) from [<c01933f0>] (irq_forced_threa=
d_fn+0x30/0xa8)
> >
> > The confusing part is that you use sleeping locks but the banner says
> > PREEMPT instead of PREEMPT_RT.
> > Any chance that you don't have PREEMPT_RT_FULL enabled?
>
> I just checked the .config as well as /proc/version and it seems to be
> enabled... so yes, this is strange - thanks for pointing this out.
>
> # cat /proc/version
> Linux version 4.19.100-rt41 (oe-user@oe-host) (gcc version 8.3.0
> (GCC)) #1 SMP PREEMPT RT Mon Nov 1 15:30:04 UTC 2021
>
> >
> > > Many thanks and regards,
> > >
> > > Andreas
> > >
> > Sebastian
