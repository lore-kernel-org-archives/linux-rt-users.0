From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sun, 26 Jul 2009 16:34:24 +0200
Message-ID: <4A6C6970.6060200@web.de>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6B1C15.6090608@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC5021320DFD58FA505E1E549"
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Avi Kivity <avi@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:37554 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbZGZOee (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 10:34:34 -0400
In-Reply-To: <4A6B1C15.6090608@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC5021320DFD58FA505E1E549
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>> Jan (who is now patching his guest to avoid wbinvd where possible)
>>
>>   =20
>=20
> Is there ever a case where it is required?  What about under a
> hypervisor (i.e. check the hypervisor enabled bit).
>=20

Reminds me of the discussion in '07 when I first stumbled over this :) :
Yes, the bochs bios could safely skip the wbinvd in qemu mode. But that
won't safe us from Linux and - far more problematic - Windows or any
binary-only guest which think they have to issue it.

One may the close eyes, fire up the guest and then start the
time-critical host application in the hope that the guest remains calm
as long as it's up and running. But, well...

Jan


--------------enigC5021320DFD58FA505E1E549
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpsaXgACgkQniDOoMHTA+lxywCdEPFBbu7U72cNlYNYha3km5VC
LEcAn21PorR9knudVQWKNIKAfT7tBTLF
=VLl6
-----END PGP SIGNATURE-----

--------------enigC5021320DFD58FA505E1E549--
