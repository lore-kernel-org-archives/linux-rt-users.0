From: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc - Initialize the irq radix tree earlier
Date: Thu, 31 Jul 2008 22:58:24 +1000
Message-ID: <1217509104.19050.11.camel@localhost>
References: <1217497241-10685-1-git-send-email-sebastien.dugue@bull.net>
	 <1217497241-10685-2-git-send-email-sebastien.dugue@bull.net>
	 <1217504456.9817.22.camel@localhost>  <20080731140002.31bbe4a0@bull.net>
Reply-To: michael@ellerman.id.au
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/PYGH8pS+8+pC2i4MU4z"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, benh@kernel.crashing.org,
	paulus@samba.org, jean-pierre.dion@bull.net,
	gilles.carry@ext.bull.net, tinytim@us.ibm.com, tglx@linutronix.de,
	rostedt@goodmis.org
To: Sebastien Dugue <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:36486 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750848AbYGaM6a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jul 2008 08:58:30 -0400
In-Reply-To: <20080731140002.31bbe4a0@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-/PYGH8pS+8+pC2i4MU4z
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-07-31 at 14:00 +0200, Sebastien Dugue wrote:
> On Thu, 31 Jul 2008 21:40:56 +1000 Michael Ellerman <michael@ellerman.id.=
au> wrote:
> >=20
> > This boot ordering stuff is pretty hairy, so I might have missed
> > something, but this is how the code is ordered AFAICT:
> > =EF=BB=BF
> > start_kernel()
> > 	init_IRQ()
> > 	...
> > 	local_irq_enable()
> > 	...
> > 	rest_init()
> > 		kernel_thread()
> > 			kernel_init()
> > 				smp_prepare_cpus()
> > 					smp_xics_probe()	(via smp_ops->probe())
> >=20
> >=20
> > What's stopping us from taking an irq between local_irq_enable() and
> > smp_xics_probe() ?  Is it just that no one's request_irq()'ed them yet?
>=20
>   It's hairy, I agree, but as you've mentioned no one has done a request_=
irq()
> at that point. The first one to do it is smp_xics_probe() for the IPI.

Hmm, I don't think that's strong enough. I can trivially cause irqs to
fire during a kexec reboot just by mashing the keyboard.

And during a kdump boot all sorts of stuff could be firing. Even during
a clean boot, from firmware, I don't think we can guarantee that
nothing's going to fire.

.. after a bit of testing ..

It seems it actually works (sort of).=20

xics_remap_irq() calls irq_radix_revmap_lookup(), which calls:

ptr =3D radix_tree_lookup(&host->revmap_data.tree, hwirq);

And because =EF=BB=BFhost->revmap_data.tree was zalloc'ed we trip on the fi=
rst
check here:



cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-/PYGH8pS+8+pC2i4MU4z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIkbbwdSjSd0sB4dIRAnL8AJ0U6V/hgMyz63PAXyleQFBUyt5PowCeN+MS
aW9sJwt87wxn3x89zotwskk=
=waH1
-----END PGP SIGNATURE-----

--=-/PYGH8pS+8+pC2i4MU4z--

