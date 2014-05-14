From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#746232: 3.2.57-rt: rcu_preempt detected stalls at boot
Date: Wed, 14 May 2014 21:15:53 +0100
Message-ID: <1400098553.2647.26.camel@deadeye.wl.decadent.org.uk>
References: <20140513074539.GJ12328@oktetlabs.ru>
	 <53739824.2080007@windriver.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-RY2ph8EyIdR0A6KCqEAK"
Cc: linux-rt-users@vger.kernel.org, 746232@bugs.debian.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	"Alexandra N. Kossovsky" <Alexandra.Kossovsky@oktetlabs.ru>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44471 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751156AbaENUQR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 14 May 2014 16:16:17 -0400
In-Reply-To: <53739824.2080007@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--=-RY2ph8EyIdR0A6KCqEAK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2014-05-14 at 12:21 -0400, Paul Gortmaker wrote:
> On 14-05-13 03:45 AM, Alexandra N. Kossovsky wrote:
> > Hello.
> >=20
> > One of my computers fails to boot with 3.2.57-rt kernel, i686.
> > The kernel is the Debian one: linux-image-3.2.0-4-rt-686-pae, version
> > 3.2.57-3.  Same non-rt kernel boots fine.  All newer -rt kernels (I've
> > tried kernels starting from 3.6) boot fine.
> > You can find some details of the hardware in
> > https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D746232,
> > including lspci output and full kernel output.
>=20
> One of the more recent additions was to ensure RCU_BOOST was
> auto selected via Kconfig dependencies.  It might not have
> been present in 3.2.57-rt; not sure w/o checking what debian
> has in there.  But you might want to check the .config you
> have to see whether it is on or off, and try enabling it.
[...]

$ grep RCU_BOOST /usr/src/linux-headers-3.2.0-4-rt-686-pae/.config
# CONFIG_RCU_BOOST is not set

Sasha, could you try enabling this?  (Instructions for rebuilding the
package are at
<http://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-common-off=
icial>, or you could take the source and rt patch from linux-source-3.2 and=
 then use 'make deb-pkg'.)

Ben.

--=20
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camu=
s

--=-RY2ph8EyIdR0A6KCqEAK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUAU3PPBOe/yOyVhhEJAQrAFQ//XEhEGl12ABjh1asXfgg34iagbe5dOtOQ
q1WLDowIe32J8mpklhAVxEAKQwdrrf67xaKG9viiIjo8Py60hmY2wVSmq+COAXmk
CICYyzhHMEy4dCtKtwH5dHrhw6RI82tP+O5A4PXforpfNQNl1PMdHXNxBKDh+mfd
cZGXP3buAOg4T5xM6FphB/dhS5Mh6b77foo/oPYX4+sQj4SJuumFvZ+S3FbzPTd4
R4kKT6muHf34htqZwTuNR4nFtKoAzhZckcGwD4wogQCR1WkuTBet01d2Ktvy1NHB
9bPHRlpOxOVpsG7iZ5o8luj+ViCMcho6eFuv2ds0f5UAYXv0u3mxwv0kNiLdgBod
2qex4X7vDbiy/YLAxxGI/jI/+pm0NZtVl2LEJyG/0I5/+BdrJRSamacyDCMbSKaf
B/WT2/LBUh4TF2TbT1a+83Af2rufNZA1fMvo+Qp+txDXEKDN/Q/Kwfo7BiiBavWo
9OUuBdXypggoQdbqgLSy2whPkN2D1/4PelqLyXD0pg3kbUQDwlGtG586eTCPwWJ1
rCCrD0CG5ywsKodrAxv6j/8uKmz2QdeCzoxnMxnYX5i6wPvmFLKF/wOheJYZFOcu
eJab9lC85qDbmLZ4nc/w9B7tqdjbXP/Ef7Ubj6Zrs+PWu9za6bIRfFvTy4k2XHRN
dnf34Pd0s1g=
=eXhl
-----END PGP SIGNATURE-----

--=-RY2ph8EyIdR0A6KCqEAK--
