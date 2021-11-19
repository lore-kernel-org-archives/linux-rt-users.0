Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8AFC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7006D61A8C
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhKSLu1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:50:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSLu1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 06:50:27 -0500
Date:   Fri, 19 Nov 2021 12:47:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637322444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8z0jQhBeH1XMcM2POGiUDu1svkFTUUa0yx0h4zF18g=;
        b=stzsyJYGLs8n8R117NZpVzj6Om032jH1ZjjeyQ/dVNK63JrMCk3jY2XZr7D13Ckb1GSFMS
        +R199IE/r9sXJuOKvrVaDx6MjDQjbUbkbO3QX0M2NnVDK5Dlqlg3d1neb/kiXrNiFz4BoU
        4lpsCK/g6OrP8R4/5gwcYKDA/GhwD7JQK/Jc5UI1Js6bugSITph3BCU2N2M3c5t/FyxPiR
        3Sxly9FxDVgJZzW3hxnVc6YOsTZjiGZFux/PzKF9Sp74vgG8nkTixr88y5s0mhyvZ2MlZb
        jzCLDuSw1y7RIS9IElCrv1LM3L2pn7dTyku/ooCfJP8uC0jTvnMntjmmfmotEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637322444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8z0jQhBeH1XMcM2POGiUDu1svkFTUUa0yx0h4zF18g=;
        b=vWr9Kf65tTteAZbz2ksgZ+oK+YPrLfpvvNgu33EgEPzkbYiNB03+Ggdsympw5R0v++4Ov7
        pAfMp/nBwxBd8aBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andreas Glatz <andi.glatz@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Q: Possible reason(s) for BUG in rt_spin_lock_slowlock_locked()
Message-ID: <20211119114722.yiejgsteghygxep2@linutronix.de>
References: <CAKJ14Ne-G77o-m=Ez-7Eoaq55SdvLy+x1-sfVyx4g5qLTrHSJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKJ14Ne-G77o-m=Ez-7Eoaq55SdvLy+x1-sfVyx4g5qLTrHSJg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-19 10:39:20 [+0000], Andreas Glatz wrote:
> Hi
Hi,

> I patched 4.19.100 with rt41 patch set and we ported the Micrel
> ksz8462_h Ethernet driver. The driver has one threaded IRQ triggered
> by the interrupt from the ksz8462 chip and two workers, one for
> gathering MIBs and one for checking the link status. Everything
> seemingly ran ok for quite some time. However, yesterday I noticed
> that the IRQ thread died in rt_spin_lock_slowlock_locked() as per
> stacktrace below at:
>=20
> 0xc0af82f8 is in rt_spin_lock_slowlock_locked
> (/usr/src/kernel/kernel/locking/rtmutex.c:1105).
> 1100 * unconditionally. We might have to fix that up:
> 1101 */
> 1102 fixup_rt_mutex_waiters(lock);
> 1103
> 1104 BUG_ON(rt_mutex_has_waiters(lock) && waiter =3D=3D rt_mutex_top_wait=
er(lock));
> 1105 BUG_ON(!RB_EMPTY_NODE(&waiter->tree_entry));
> 1106 }
> 1107
> 1108 static void noinline __sched rt_spin_lock_slowlock(struct rt_mutex *=
lock)
> 1109 {
>=20
> In the jtag debugger I see that at the same time the other two
> kthreads are waiting on the spinlock that's held by the IRQ thread
> that died on two of the four CPU cores of the i.MX6q.
>=20
> Any ideas what might cause this and how to fix it?

So the lock owner exploded in BUG_ON() and every lock attempt will fail
since the slow-path is forced and the wait_lock is still acquired.

The BUG_ON() statement suggest that the thread is enqueued as waiter but
shouldn't since it obtained the lock. From your backtrace:

| Internal error: Oops - undefined instruction: 0 [#1] PREEMPT SMP ARM
=E2=80=A6
| CPU: 0 PID: 1457 Comm: irq/77-ksz8462_ Tainted: G  W  O      4.19.100-rt4=
1 #1
=E2=80=A6
| Process irq/77-ksz8462_ (pid: 1457, stack limit =3D 0x968e9d88)
| [<c0af82f8>] (rt_spin_lock_slowlock_locked) from [<c0af8384>] (rt_spin_lo=
ck_slowlock+0x64/0x94)
| [<c0af8384>] (rt_spin_lock_slowlock) from [<c0afab28>] (rt_spin_lock+0x7c=
/0x84)
| [<c0afab28>] (rt_spin_lock) from [<bf1c4418>] (ks_irq+0x48/0x540 [ksz8462=
_h])
| [<bf1c4418>] (ks_irq [ksz8462_h]) from [<c01933f0>] (irq_forced_thread_fn=
+0x30/0xa8)

The confusing part is that you use sleeping locks but the banner says
PREEMPT instead of PREEMPT_RT.
Any chance that you don't have PREEMPT_RT_FULL enabled?

> Many thanks and regards,
>=20
> Andreas
>=20
Sebastian
