From: Josh Cartwright <joshc@ni.com>
Subject: Re: [PATCH rt-tests 0/4] build tweaks and a bug fix
Date: Fri, 28 Aug 2015 13:11:32 -0500
Message-ID: <20150828181132.GD9309@jcartwri.amer.corp.natinst.com>
References: <cover.1440720422.git.joshc@ni.com>
 <20150828175400.GB33809@vmdeb7>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>,
	Robert Yang <liezhi.yang@windriver.com>,
	Kai Kang <kai.kang@windriver.com>,
	"Song.Li" <Song.Li@windriver.com>,
	Jesse Zhang <sen.zhang@windriver.com>
To: Darren Hart <dvhart@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:37322 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752361AbbH1SL5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Aug 2015 14:11:57 -0400
In-Reply-To: <20150828175400.GB33809@vmdeb7>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2015 at 10:54:00AM -0700, Darren Hart wrote:
> On Thu, Aug 27, 2015 at 07:19:47PM -0500, Josh Cartwright wrote:
> > Hey John, Clark-
> >=20
> > This series has a few minor rt-tests tweaks that make it a bit easier t=
o build
> > and package rt-tests for the bizarro build demands in the embedded spac=
e.  With
> > a bug fix thrown in for good measure.
> >=20
> > The first patch breaks the assumption that build host =3D=3D target; th=
e second
> > patch allows a packager to more easily split hwlatdetect into a separate
> > package.  (Both of these patches are unchanged since Darren's original
> > submission in 2012[1]).
>=20
> Yikes, did I not submit those to rt-tests? If not, shame on me!

Oh, you did!  The linked submission was to linux-rt-users.  Looks like
the patches just fell through the cracks.

[..]
> > Darren Hart (2):
> >   rt-tests: Allow for user-specified PYLIB
> >   rt-tests: Break out install_hwlatdetect
> >=20
>=20
> Re-Acked, thanks Josh.

Thanks!

  Josh

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV4KRQAAoJEKp7ZBKwQFArohkH/0+KGrySBG7GowNHdXG5P7Hg
mYv04SViq+gmdIwv56S974BhM3hmAWl0BUhttmmCBtV87gKFJ27u8OwxiGNCxD1k
F63UDZB10+yswgYVh48MM9q1k0CAi4W47gWHIfbvENkXa7EHuAYlTbYxtVPG05/p
HsZLZVfqs6x8OsxCvKQy4A2uBmccp9KkoxpLPSW+4hf3RC2E2qeHq8R0tF6cAY9e
X+ZpejQ7iSrE6i7g4XPwOWu+VlSmrKQ+BdY2zFlxzrMv44fXb5J/nXzUrHRoFeke
Mu624zxTnCImWbAEPy9WRuxGmgIE2t0GtJYYZE7MMOy6iVdL/6US7Y1j5uXlCGE=
=K3rU
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
