From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: 3.14.3-rt5: at91: Crash early at boot
Date: Mon, 16 Mar 2015 19:30:33 +0100
Message-ID: <20150316183033.GH4560@piout.net>
References: <20140613142506.GL3448@lukather>
 <20150217083859.GB26177@linutronix.de>
 <20150316181900.GA4638@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36281 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932670AbbCPSb0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Mar 2015 14:31:26 -0400
Content-Disposition: inline
In-Reply-To: <20150316181900.GA4638@lukather>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Maxime,

On 16/03/2015 at 19:19:00 +0100, Maxime Ripard wrote :
> Hi,
>=20
> On Tue, Feb 17, 2015 at 09:38:59AM +0100, Sebastian Andrzej Siewior w=
rote:
> > * Maxime Ripard | 2014-06-13 16:25:06 [+0200]:
> >=20
> > >Preemptible hierarchical RCU implementation.
> > >NR_IRQS:16 nr_irqs:16 16
> > >Unable to handle kernel NULL pointer dereference at virtual addres=
s 00000000
> > >pgd =3D c0004000
> > >[00000000] *pgd=3D00000000
> > >Internal error: Oops: 5 [#1] PREEMPT ARM
> > >Modules linked in:
> > >CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.3-rt4+ #11
> > >task: c05ecb28 ti: c05e2000 task.ti: c05e2000
> > >PC is at wake_up_process+0x8/0x40
> > >LR is at kthread_create_on_node+0xb0/0x178
> > =E2=80=A6
> > >Do you know what could be the cause of this, or is this any known =
issue?
> >=20
> > No. This is very early in the boot process. I upgrade the at91's ti=
mer
> > patches but have no HW to actually check if this is still working.
>=20
> Do you have a link to these patches?
>=20
The issue has been solved at emtrion but I think the patches were not
sent yet. The issue is that threading the timer IRQs leads to a crash
because kthreadd is not started yet.


--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
