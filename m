Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FB8C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 14:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8E861211
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 14:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhKSOWQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 09:22:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbhKSOWP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 09:22:15 -0500
Date:   Fri, 19 Nov 2021 15:19:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637331553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58cRXFnjYpNMYaeWtNiHO/6EZ/KDAO5zqO2UpYG2YYU=;
        b=J8erdmSF147kW5aSPqC6b2MdZOKVxNoyXKOw5E3n335Y7vUaGc+WxJHecIAkaObVIV41iI
        k0GDJmRtc32ujVpyU2J6rONCaSwcjV4nhpZsiB0RFvAINfsPbkxwyUoqw7xSFOj+GtkSAH
        KcCdMoAWX+nRLoEfH8LcKIcAFPRZGzi+P83ax0aouL4fwHBaZUg/J4KdNP2nd4CvAB2+Ow
        b5VyNd5+oMyKDLOckxMn7BpAvlRyw+BBfTDLNOT3aN/Q3ERQrRqmfEHye3Nv6slMe1r1Ym
        eTuOyO/q4g2y49B6+CDreqzSeFcHwqTNMKqWlgIFS+U3XOp9yARQ8nxegeUNCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637331553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=58cRXFnjYpNMYaeWtNiHO/6EZ/KDAO5zqO2UpYG2YYU=;
        b=3ZKQZWNln3Zcnc9gy2H1fHY7VesgGeUb7zbXYXu0B38lNSc5nuR9SjSNJeKH23k5hmdb/V
        wFODGQD6LxqRiKAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andreas Glatz <andi.glatz@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Q: Possible reason(s) for BUG in rt_spin_lock_slowlock_locked()
Message-ID: <20211119141911.sjereqlt7atzchee@linutronix.de>
References: <CAKJ14Ne-G77o-m=Ez-7Eoaq55SdvLy+x1-sfVyx4g5qLTrHSJg@mail.gmail.com>
 <20211119114722.yiejgsteghygxep2@linutronix.de>
 <CAKJ14NeC9HnOSDs3fNYYRA2mQ5dnMwm-rK3qT4cgCVfqZyE6eQ@mail.gmail.com>
 <CAKJ14NdDgpm6itQ7c6hp74ybULxztUoiTeS0ePBdU9yGKMJs+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKJ14NdDgpm6itQ7c6hp74ybULxztUoiTeS0ePBdU9yGKMJs+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-19 13:45:49 [+0000], Andreas Glatz wrote:
> > > > In the jtag debugger I see that at the same time the other two
> > > > kthreads are waiting on the spinlock that's held by the IRQ thread
> > > > that died on two of the four CPU cores of the i.MX6q.
> > > >
> > > > Any ideas what might cause this and how to fix it?
> > >
> > > So the lock owner exploded in BUG_ON() and every lock attempt will fa=
il
> > > since the slow-path is forced and the wait_lock is still acquired.
> > >
> > > The BUG_ON() statement suggest that the thread is enqueued as waiter =
but
> > > shouldn't since it obtained the lock. From your backtrace:
> >
> > Right... any idea for investigating why this might be? I assume a
> > particular IRQ thread should be unique in the system? Maybe it didn't
> > release the lock the last time it ran?
>=20
> I found an instance where we did not unlock the spinlock before
> returning from a function :( I'll test again...

Try to enable LOCKDEP with LOCK-proving, schedule-while-atomic and such.
Lockdep should warn you if you attempt return to userland with locks
held.

> > > The confusing part is that you use sleeping locks but the banner says
> > > PREEMPT instead of PREEMPT_RT.
> > > Any chance that you don't have PREEMPT_RT_FULL enabled?
> >
> > I just checked the .config as well as /proc/version and it seems to be
> > enabled... so yes, this is strange - thanks for pointing this out.
> >
> > # cat /proc/version
> > Linux version 4.19.100-rt41 (oe-user@oe-host) (gcc version 8.3.0
> > (GCC)) #1 SMP PREEMPT RT Mon Nov 1 15:30:04 UTC 2021

If that is there, maybe it is missing the ARM specific output=E2=80=A6

> > > > Many thanks and regards,
> > > >
> > > > Andreas

Sebastian
