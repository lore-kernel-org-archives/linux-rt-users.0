From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: BUG - "scheduling while atomic" on a irq handler (s3c-mci)
Date: Wed, 9 May 2012 19:49:31 +0200
Message-ID: <20120509174931.GB31844@pengutronix.de>
References: <CAEOomG9NEoQKqp=pMx0NpzGaFpHBimALwhemnZL4F-8g7XURkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Christophe Huriaux <c.huriaux@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50279 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758335Ab2EIRtd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 May 2012 13:49:33 -0400
Content-Disposition: inline
In-Reply-To: <CAEOomG9NEoQKqp=pMx0NpzGaFpHBimALwhemnZL4F-8g7XURkA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Christophe,

On Wed, May 09, 2012 at 04:07:13PM +0200, Christophe Huriaux wrote:
>    I am facing a problem while trying to run a rt-patched 3.2.y kerne=
l
> with PREEMPT_RT_FULL on a mini2440 board (ARM based s3c2440 SoC) :
> whilst a vanilla kernel (with PREEMPT_LL) works like a charm,
> PREEMPT_RTB and PREEMPT_RT_FULL makes the MMC/SD driver  (s3cmci)
> hang, which result in the kernel waiting indefinitely for the root fs
> to mount.
>=20
>   I think that the IRQ handling of the driver is somehow disturbed by
> the changes made by the RT patch. When using PREEMPT_RTB I can see th=
e
> following message in the console :
>=20
> BUG: scheduling while atomic: irq/37-s3c-mci/253/0x00000102
> Modules linked in:
> Function entered at [<c000e90c>] from [<c029f478>]
> Function entered at [<c029f478>] from [<c029fc3c>]
> Function entered at [<c029fc3c>] from [<c00559c0>]
> Function entered at [<c00559c0>] from [<c01dd4c8>]
> Function entered at [<c01dd4c8>] from [<c0024a0c>]
> Function entered at [<c0024a0c>] from [<c0024d9c>]
> Function entered at [<c0024d9c>] from [<c0024fe8>]
> Function entered at [<c0024fe8>] from [<c0025140>]
> Function entered at [<c0025140>] from [<c00549f0>]
> Function entered at [<c00549f0>] from [<c00547c4>]
> Function entered at [<c00547c4>] from [<c0039954>]
> Function entered at [<c0039954>] from [<c000a120>]

If you enable CONFIG_KALLSYMS you get a more usable backtrace.
Alternatively you can use

	$CROSS_COMPILE-addr2line -e vmlinux 0xc000e90c

to get the file and line that resulted in the code at that address.

>   When I run the kernel under Qemu, debug through gdb and put a
> breakpoint on unwind_backtace the details of the previous backtrace i=
s
> :
>=20
> #0  unwind_backtrace (regs=3D0x0, tsk=3D0x0) at arch/arm/kernel/unwin=
d.c:409
> #1  0xc029f478 in schedule_debug (prev=3D<optimized out>) at kernel/s=
ched.c:4357
> #2  __schedule () at kernel/sched.c:4537
> #3  0xc029fc3c in schedule () at kernel/sched.c:4625
> #4  0xc00559c0 in synchronize_irq (irq=3D<optimized out>) at
> kernel/irq/manage.c:73
> Backtrace stopped: previous frame inner to this frame (corrupt stack?=
)
>=20
>   I don't see the "bug" message with PREEMPT_RT_FULL, the kernel just
> hang waiting for the rootfs. The problem did not occur in the 2.6.y
> tree AFAIK.
My guess is that for PREEMPT_RT_FULL the printk just doesn't make it to
your console driver because the data would only be given to it when the
atomic block is done.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
