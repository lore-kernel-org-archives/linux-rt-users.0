From: Josh Cartwright <joshc@ni.com>
Subject: Re: acmesystems Arietta (AT91SAM9G25)
Date: Tue, 1 Mar 2016 09:38:33 -0600
Message-ID: <20160301153833.GA1607@jcartwri.amer.corp.natinst.com>
References: <nat4ql$41m$1@ger.gmane.org>
 <20160229081039.GC2613@pengutronix.de>
 <nb1qeg$9mm$1@ger.gmane.org>
 <20160229161826.GD12917@jcartwri.amer.corp.natinst.com>
 <56D52CBB.2020003@sysnux.pf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: linux-rt-users@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Jean-Denis Girard <jd.girard@sysnux.pf>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:39071 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754183AbcCAPis (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 1 Mar 2016 10:38:48 -0500
In-Reply-To: <56D52CBB.2020003@sysnux.pf>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 29, 2016 at 07:46:35PM -1000, Jean-Denis Girard wrote:
> Hello Josh,

Hello,

> Le 29/02/2016 06:18, Josh Cartwright a =E9crit :
> > I think your best bet will be to try to get early console output, with
> > the hope that you can get visibility into what is going wrong.  I'm sure
> > there are many tutorials out there on how to build a kernel with this
> > serial debugging information.  Do a search for DEBUG_LL, earlyprintk,
> > and perhaps earlycon; these are not -rt specific.
>=20
> Thanks for your advice. I managed to obtain earlyprintk, this is what I g=
ot:

Great, this helps a lot.

> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 4.4.3-rt9 (jdg@tiare.sysnux.pf) (gcc version 5.2.1
> 20151104 (Red Hat Cross 5.2.1-4) (GCC) ) #10 PREEMPT RT Mon Feb 29
> 13:01:47 TAHT 2016
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D0005317f
> CPU: VIVT data cache, VIVT instruction cache
> Machine model: Acme Systems Arietta G25
[..]
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
000
> pgd =3D c0004000
> [00000000] *pgd=3D00000000
> Internal error: Oops: 5 [#1] PREEMPT ARM
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper Not tainted 4.4.3-rt9 #10
> Hardware name: Atmel AT91SAM9
> task: c0537dd0 ti: c0534000 task.ti: c0534000
> PC is at try_to_wake_up+0x34/0x228
> LR is at kthread_create_on_node+0x94/0x134
[..]
> [<c0030dfc>] (try_to_wake_up) from [<c002d084>]
> (kthread_create_on_node+0x94/0x134)
> [<c002d084>] (kthread_create_on_node) from [<c0040668>]
> (setup_irq_thread+0x38/0xd4)
> [<c0040668>] (setup_irq_thread) from [<c0041634>] (__setup_irq+0x1a8/0x64=
8)
> [<c0041634>] (__setup_irq) from [<c0041c3c>]
> (request_threaded_irq+0xe4/0x144)
> [<c0041c3c>] (request_threaded_irq) from [<c0520640>]
> (of_at91_pmc_setup+0xe0/0x16c)
> [<c0520640>] (of_at91_pmc_setup) from [<c05202bc>] (of_clk_init+0xf4/0x1b=
8)
> [<c05202bc>] (of_clk_init) from [<c050c108>] (time_init+0x20/0x2c)
> [<c050c108>] (time_init) from [<c050aafc>] (start_kernel+0x248/0x35c)
> [<c050aafc>] (start_kernel) from [<20008048>] (0x20008048)
> Code: e3c3303f e5932004 e2822001 e5832004 (e5902000)
> ---[ end trace 0000000000000001 ]---

This confirms that the problem you are seeing is the same problem
Alexandre and Boris solved in:

   https://www.spinics.net/lists/kernel/msg2172523.html

It doesn't look like it's landed upstream yet (although it's been in
next since last week).

It looks like Alexandre has pushed a tag with these changes (destined
for 4.6) at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git at91-ab-=
4.6-drivers

You can cherry-pick back those top 13 commits and give it a try.

If you can confirm that those changes fix your problem, they should be
considered for cherry-picking into 4.4-rt officially.

  Josh

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW1bd2AAoJEKp7ZBKwQFArlvgIALW3pOA4pYfox1GM9PMRc7DO
X0NP8WHOa4zI9LF50f6AW57F21s66t3q6FgUExDMyYkMdjBPMrLZAXAnHl2etGpg
mb/PGJJwAo9PqwZmhJmHHs0XvoYcObZriU53BItwjZM/0NlYtc8vYvTd1VbEI6Pk
a8iUWTE1rgkfyR+c6MvFfchAMlSZQnohc+5x2YmgJUJl+pGF0wZ4+gzWem8TsBvS
UaRAqGYSFJMBd1Xb7zUMb7m0WvqTdqJwP7e1jlZ69Eh2WGeb3ZZIE4UTmrjHaRWE
4Gw/m7XKazXhn3dldzLC0eRvEd3UdgitDUOR5ENrt5MYzpPBEGx0M/k8M/9E2Pc=
=drDi
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
