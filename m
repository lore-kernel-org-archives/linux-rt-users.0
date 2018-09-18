Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:54988 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729998AbeIRXsz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Sep 2018 19:48:55 -0400
From: Julia Cartwright <julia@ni.com>
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
Date: Tue, 18 Sep 2018 18:14:39 +0000
Message-ID: <20180918181437.GR8562@jcartwri.amer.corp.natinst.com>
References: <73d0tbdjqz.fsf@pengutronix.de>
In-Reply-To: <73d0tbdjqz.fsf@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8FD5B3E13F88494EB2B77531F7966B0B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Christophe Leroy <christophe.leroy@c-s.fr>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Tue, Sep 18, 2018 at 03:21:08PM +0200, Steffen Trumtrar wrote:
>=20
> Hi all!
>=20
> I'm seeing an issue with the dw_wdt watchdog on the SoCFPGA ARM platform
> with the latest linux-rt v4.18.5-rt4. Actually I seem to have the same
> problem, that these patches try to fix:
>=20
>  38a1222ae4f364d5bd5221fe305dbb0889f45d15
>  Author:     Christophe Leroy <christophe.leroy@c-s.fr>
>  AuthorDate: Fri Dec 8 11:18:35 2017 +0100
>  Commit:     Wim Van Sebroeck <wim@iguana.be>
>  CommitDate: Thu Dec 28 20:45:57 2017 +0100
>=20
>  Follows:    v4.15-rc3 (345)
>  Precedes:   v4.16-rc1 (13997)
>=20
>  watchdog: core: make sure the watchdog worker always works
>=20
>  When running a command like 'chrt -f 50 dd if=3D/dev/zero  of=3D/dev/nul=
l',
>  the watchdog_worker fails to service the HW watchdog and the
>  HW watchdog fires long before the watchdog soft timeout.
>=20
>  At the moment, the watchdog_worker is invoked as a delayed work.
>  Delayed works are handled by non realtime kernel threads. The
>  WQ_HIGHPRI flag only increases the niceness of that threads.
>=20
>  This patch replaces the delayed work logic by kthread delayed  work,
>  and sets the associated kernel task to SCHED_FIFO with the  highest
>  priority, in order to ensure that the watchdog worker will run  as
>  soon as possible.
>=20
>=20
>  1ff688209e2ed23f699269b9733993e2ce123fd2
>  Author:     Christophe Leroy <christophe.leroy@c-s.fr>
>  AuthorDate: Thu Jan 18 12:11:21 2018 +0100
>  Commit:     Wim Van Sebroeck <wim@iguana.be>
>  CommitDate: Sun Jan 21 12:44:59 2018 +0100
>=20
>  Follows:    v4.15-rc3 (349)
>  Precedes:   v4.16-rc1 (13993)
>=20
>  watchdog: core: make sure the watchdog_worker is not deferred
>=20
>  commit 4cd13c21b207e ("softirq: Let ksoftirqd do its job") has  the
>  effect of deferring timer handling in case of high CPU load,  hence
>  delaying the delayed work allthought the worker is running which
>  high realtime priority.
>=20
>  As hrtimers are not managed by softirqs, this patch replaces the
>  delayed work by a plain work and uses an hrtimer to schedule  that work.

These above two commits are trying very hard to ensure timely wakeup and
execution of the watchdogd thread.  First by moving moving to kthread
delayed work, and secondly to vanilla kthread work + hardirq.

This is sufficient on mainline, because hardirq expiry fns are
unconditionally executed in hardirq context.  With PREEMPT_RT_FULL,
however, the hrtimer expiry functions are executed in softirq context
unless explicitly opted out.

...meaning that w/ PREEMPT_RT_FULL the expiry (and therefore the
watchdogd wakeup) may be indefinitely starved if there are runnable RT
tasks of higher priority than the softirq callback thread (ktimersoftd @
SCHED_FIFO 1 by default).

This is an inversion.

One possible solution is to opt-out of the hrtimer softirq deferral by
making use of the HRTIMER_MODE_HARD, however, the expiry function will
need to be vetted for use in hardirq context w/ PREEMPT_RT_FULL.  From a
cursory glance at the kthread_worker locking, it is not hardirq safe. :-\

   Julia
