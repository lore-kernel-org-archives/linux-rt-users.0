From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Tue, 1 Mar 2016 17:00:05 +0100
Message-ID: <20160301160005.GB23985@piout.net>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de>
 <nb1qeg$9mm$1@ger.gmane.org>
 <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
 <56D52CBB.2020003@sysnux.pf>
 <20160301153833.GA1607@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jean-Denis Girard <jd.girard@sysnux.pf>,
	linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40217 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753885AbcCAQAJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Mar 2016 11:00:09 -0500
Content-Disposition: inline
In-Reply-To: <20160301153833.GA1607@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On 01/03/2016 at 09:38:33 -0600, Josh Cartwright wrote :
> On Mon, Feb 29, 2016 at 07:46:35PM -1000, Jean-Denis Girard wrote:
> > Hello Josh,
>=20
> Hello,
>=20
> > Le 29/02/2016 06:18, Josh Cartwright a =E9crit :
> > > I think your best bet will be to try to get early console output,=
 with
> > > the hope that you can get visibility into what is going wrong.  I=
'm sure
> > > there are many tutorials out there on how to build a kernel with =
this
> > > serial debugging information.  Do a search for DEBUG_LL, earlypri=
ntk,
> > > and perhaps earlycon; these are not -rt specific.
> >=20
> > Thanks for your advice. I managed to obtain earlyprintk, this is wh=
at I got:
>=20
> Great, this helps a lot.
>=20
> > Uncompressing Linux... done, booting the kernel.
> > Booting Linux on physical CPU 0x0
> > Linux version 4.4.3-rt9 (jdg@tiare.sysnux.pf) (gcc version 5.2.1
> > 20151104 (Red Hat Cross 5.2.1-4) (GCC) ) #10 PREEMPT RT Mon Feb 29
> > 13:01:47 TAHT 2016
> > CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D0005317f
> > CPU: VIVT data cache, VIVT instruction cache
> > Machine model: Acme Systems Arietta G25
> [..]
> > Unable to handle kernel NULL pointer dereference at virtual address=
 00000000
> > pgd =3D c0004000
> > [00000000] *pgd=3D00000000
> > Internal error: Oops: 5 [#1] PREEMPT ARM
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.3-rt9 #10
> > Hardware name: Atmel AT91SAM9
> > task: c0537dd0 ti: c0534000 task.ti: c0534000
> > PC is at try_to_wake_up+0x34/0x228
> > LR is at kthread_create_on_node+0x94/0x134
> [..]
> > [<c0030dfc>] (try_to_wake_up) from [<c002d084>]
> > (kthread_create_on_node+0x94/0x134)
> > [<c002d084>] (kthread_create_on_node) from [<c0040668>]
> > (setup_irq_thread+0x38/0xd4)
> > [<c0040668>] (setup_irq_thread) from [<c0041634>] (__setup_irq+0x1a=
8/0x648)
> > [<c0041634>] (__setup_irq) from [<c0041c3c>]
> > (request_threaded_irq+0xe4/0x144)
> > [<c0041c3c>] (request_threaded_irq) from [<c0520640>]
> > (of_at91_pmc_setup+0xe0/0x16c)
> > [<c0520640>] (of_at91_pmc_setup) from [<c05202bc>] (of_clk_init+0xf=
4/0x1b8)
> > [<c05202bc>] (of_clk_init) from [<c050c108>] (time_init+0x20/0x2c)
> > [<c050c108>] (time_init) from [<c050aafc>] (start_kernel+0x248/0x35=
c)
> > [<c050aafc>] (start_kernel) from [<20008048>] (0x20008048)
> > Code: e3c3303f e5932004 e2822001 e5832004 (e5902000)
> > ---[ end trace 0000000000000001 ]---
>=20
> This confirms that the problem you are seeing is the same problem
> Alexandre and Boris solved in:
>=20
>    https://www.spinics.net/lists/kernel/msg2172523.html
>=20
> It doesn't look like it's landed upstream yet (although it's been in
> next since last week).
>=20
> It looks like Alexandre has pushed a tag with these changes (destined
> for 4.6) at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git at=
91-ab-4.6-drivers
>=20
> You can cherry-pick back those top 13 commits and give it a try.
>=20
> If you can confirm that those changes fix your problem, they should b=
e
> considered for cherry-picking into 4.4-rt officially.
>=20

I also have that branch for preempt-rt on at91:

https://github.com/alexandrebelloni/linux/tree/at91-rt

I'll make sure my changes will land in the next -rt releases but I had
to make sure which version will land in the mainline first.



--=20
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
