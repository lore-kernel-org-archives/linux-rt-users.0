From: Julia Cartwright <julia@ni.com>
Subject: Re: Intel real-time Linux production kernel
Date: Fri, 2 Jun 2017 13:50:16 -0500
Message-ID: <20170602185015.GB31147@jcartwri.amer.corp.natinst.com>
References: <D5D6254030DBC644B6EE58B333BFBB1E9D673203@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        "Sapra, Rajesh" <rajesh.sapra@intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
To: "Hindman, Gavin" <gavin.hindman@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:59995 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751007AbdFBSuS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2017 14:50:18 -0400
Content-Disposition: inline
In-Reply-To: <D5D6254030DBC644B6EE58B333BFBB1E9D673203@ORSMSX101.amr.corp.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 02, 2017 at 06:15:31PM +0000, Hindman, Gavin wrote:
> Hello everyone,
>=20
> I wanted to make you all aware that Intel is now maintaining a
> preempt_rt enabled version of our 4.9LTS production kernel located
> here: https://github.com/01org/linux-intel-4.9/wiki  Support is fairly
> new, and doesn't extend much beyond integrating preempt_rt at this
> point, but this is where we will host real-time related optimized
> kernel configs for Intel platforms, and feature back-ports, etc. as
> those emerge.

Hey Gavin-

Is there a reason why the "real-time related optimized kernel configs"
don't make their home in an upstream RT release?

I recall speaking with Thomas at the RTLWS in Graz about whether or not
the rt-devel tree should hold rt-enabled/optimized configs, to which he
said: "patches welcome".

Thanks,

   Julia

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAlkxs2cACgkQjNrC4UVN
dG9DrwgAmNfhiuaRDfPHsvuGc0k3NSImp6ZOA1BtNYT6YmO9ONdhGWGXt7Lzvth2
Mjw09fkrCEo2vYOnH2gUWYZ65JJOWqPh0EBGgYnBzgV3TRXvUN2eDL0VVQQUtpdU
8+Vz1IsLFvjdpOOqYfG4HmhXoNzTI0vQEQab3DqNMoiC2/3qtlH+piYzrEQgvodQ
C3WOMAo/LOb61xSdyqVos7NQUZoAPEKLhNJ3s7ekj7t48AejiDsPtmeoE6c7dSQ2
iknnqnsTSvFks3xflQcGSpmLsL2WgVatd1LghA8LRimbNbqG2hbcKQM3gYcVm9qA
Oi5159JxCFz8Dv8GZlb+n1V02Dx/2Q==
=Vm7D
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
