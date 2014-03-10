From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH RT 2/5] a few open coded completions
Date: Mon, 10 Mar 2014 17:52:42 +0000
Message-ID: <1394473962.23624.3.camel@deadeye.wl.decadent.org.uk>
References: <20131211003732.351606520@goodmis.org>
	 <20131211003801.836995968@goodmis.org>
	 <20131211144946.27d82a78@gandalf.local.home>
	 <1394324841.2861.56.camel@deadeye.wl.decadent.org.uk>
	 <20140310102928.7b2a2cfa@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-1h6ZUk1d3cpPangUhxpF"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Corey Minyard <cminyard@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140310102928.7b2a2cfa@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--=-1h6ZUk1d3cpPangUhxpF
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-03-10 at 10:29 -0400, Steven Rostedt wrote:
> On Sun, 09 Mar 2014 00:27:21 +0000
> Ben Hutchings <ben@decadent.org.uk> wrote:
>=20
> > On Wed, 2013-12-11 at 14:49 -0500, Steven Rostedt wrote:
> > > Here's the new patch:
> >=20
> > Doesn't add #includes and doesn't change any types, so of course it
> > doesn't compile.  WTF?
> >=20
>=20
> Hi Ben,
>=20
> This is an old thread. Which kernel did you apply it to. Before I send
> any patch set out, I run a small test (heavy stress test, and also
> compile several different configs). This patch was against 3.10-rt, and
> may have already had the includes needed. I know the original patch
> compiled, but I may not have tested the second patch.
>=20
> Do you need this patch? Or did I miss something for 3.2-rt?

You applied it to 3.2-rt:

commit 916c8d2de3c4759f57426fa3cfee63b491e88939
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon Oct 28 11:50:06 2013 +0100

    swait: Add a few more users

and 3.4-rt, 3.8-rt, 3.10-rt.  So far as I can see, it is broken on all
of those branches, though I only actually tried building 3.2-rt.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.

--=-1h6ZUk1d3cpPangUhxpF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUAUx376ue/yOyVhhEJAQqFcBAAnqnLfR5cutQZljTOhLBwE8oR2/GW3BX/
jtHRqBB44MyVLSfLu2Gg5Samk5fIeGn06L4lvXJFoygpa3SFtBPIZn5RkmD8Q5O5
TO59EAsAfzSe94DLdVM6QIVMsMRHJi3axiTI7Kl6KaLK8cSzBUQRwrKK1IhcRTLl
IiSWm6tpAEbSnq4dseRVgmvsv9jmpPfs25gHahRBqjjAUZvLZqpOk9ozPyiFXIea
g7tawveEe+VtXO2uRdKnYyFxFNgcmsLgMBNhdLrqeT61IPCrg80oT/opa2jv3oyL
2asqbu7oLjWfzRvHZTRwCsZQUjLAWkTEnP/0mxpX+wXn5RtTN1XDZ8a2zA07hfUg
B9E9Ep0YqxTjm7bbcJRKKdww3QVNHA//rYs9vAFy4fR7Rvrb6KmyDhtvCin2xfSA
UpdyqzzWRLu0QPVKjnz+BEaAL+Gi/kY7HJqEJSklKvLKHZoL8+dxw7AoTcPs+ACd
2on+Wg3q4snnBIrom/2Y8uwH0dA/bzXSuHqIqaiX6mAy0Q6qrCmbWTI+Rb5xhdyr
0I5IrBuLFjH9plRq1WMGIC2zIepR9dG1zeXMICrQp2O9ebd8xg+FDdMCW40/x3KF
9Sb0c2VT8lRA1nA+mSUKCcWy7RQqHYVYX3n7UPIktVqhetZjPQnmgRufNAzX12Vk
eEOMngpIerc=
=JJ+I
-----END PGP SIGNATURE-----

--=-1h6ZUk1d3cpPangUhxpF--
