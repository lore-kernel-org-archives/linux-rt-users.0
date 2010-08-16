From: Jeremy Brown <jhbrown@repinvariant.com>
Subject: Re: Trouble booting PREEMPT_RT kernel on ARM platform, 2.6.33
Date: Mon, 16 Aug 2010 10:44:13 -0700
Message-ID: <AANLkTingaupTO5S9vFAb2TMpT2S7v409Cx3Mknt8CXiL@mail.gmail.com>
References: <AANLkTilabvtaFnJKo8RKOfgP98F2rre4YQ8BF-o-uz92@mail.gmail.com>
	<4C469FF9.1040607@linux.vnet.ibm.com>
	<alpine.LFD.2.00.1007221842000.2616@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36096 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790Ab0HPRoO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Aug 2010 13:44:14 -0400
Received: by ewy23 with SMTP id 23so2518534ewy.19
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2010 10:44:13 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1007221842000.2616@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Whoops, trying this again without HTML, sorry for any double-sends:

On Thu, Jul 22, 2010 at 9:44 AM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
>
> On Wed, 21 Jul 2010, gowrishankar wrote:
>
> > On Wednesday 21 July 2010 03:56 AM, Jeremy Brown wrote:
> > > We're trying to get a PREEMPT_RT kernel running on a BeagleBoard =
C4
> > > (OMAP3 Arm architecture). =A0We're using kernel version 2.6.33, w=
ith
> > >
> > 2.6.33 ! not 2.6.33.6 ???
> > > patches from
> > > patch-2.6.33.6-rt26.gz
> > >
> > > On boot, we start seeing messages of this form:
> > >
> > > ----
> > > [ 4528.227294] BUG: sleeping function called from invalid context=
 at
> > > kernel/rtmutex.c:684
> > > [ 4528.227294] pcnt: 1 0 in_atomic(): 1, irqs_disabled(): 128, pi=
d:
> > > 223, name: modprobe
> > > [ 4528.227355] [<c0044490>] (unwind_backtrace+0x0/0xe8) from
> > > [<c04cb4e4>] (rt_spin_lock+0x30/0x5c)
> > > [ 4528.227386] [<c04cb4e4>] (rt_spin_lock+0x30/0x5c) from [<c032e=
3b0>]
> > > (twl4030_sih_set_type+0x3c/0xac)
> > >
> > sleeping spin lock is called while preempt/interrupt is disabled.
> >
> > Can you try the below patch ?
> >
> > Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
> >
> > Index: linux-2.6.33.6-rt26/drivers/mfd/twl4030-irq.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- linux-2.6.33.6-rt26.orig/drivers/mfd/twl4030-irq.c =A0 =A02010-=
07-21
> > 12:40:42.000000000 +0530
> > +++ linux-2.6.33.6-rt26/drivers/mfd/twl4030-irq.c =A0 =A02010-07-21
> > 12:41:16.000000000 +0530
> > @@ -633,14 +633,14 @@
> > =A0 =A0 =A0if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RI=
SING))
> > =A0 =A0 =A0 =A0 =A0return -EINVAL;
> >
> > - =A0 =A0spin_lock_irqsave(&sih_agent_lock, flags);
> > + =A0 =A0raw_spin_lock_irqsave(&sih_agent_lock, flags);
> > =A0 =A0 =A0if ((desc->status & IRQ_TYPE_SENSE_MASK) !=3D trigger) {
> > =A0 =A0 =A0 =A0 =A0desc->status &=3D ~IRQ_TYPE_SENSE_MASK;
> > =A0 =A0 =A0 =A0 =A0desc->status |=3D trigger;
> > =A0 =A0 =A0 =A0 =A0sih->edge_change |=3D BIT(irq - sih->irq_base);
> > =A0 =A0 =A0 =A0 =A0queue_work(wq, &sih->edge_work);
> > =A0 =A0 =A0}
> > - =A0 =A0spin_unlock_irqrestore(&sih_agent_lock, flags);
> > + =A0 =A0raw_spin_unlock_irqrestore(&sih_agent_lock, flags);
>
> Nope, that's not going to fly. First it does not compile and second
> you trigger the same problem in queue_work() which is called inside
> that section. That needs a bit more work, will have a look. (/me
> mentions, that todo list is already overly full, so do not expect
> wonders).

Hi, Thomas.  Has this has risen to the top of your todo queue?   If
not, we're going to start poking at it here; any thoughts, advice,
and/or pointers to reference material would be greatly appreciated.

If we're fortunate enough to get things working, we'll certainly send
patches to this list.

Thanks,
Jeremy

> Thanks,
>
> =A0 =A0 =A0 =A0tglx
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
