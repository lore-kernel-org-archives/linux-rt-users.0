From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: I/O operations priority in RTOS
Date: Sun, 05 Jun 2011 11:44:53 +0200
Message-ID: <4DEB5015.7070601@web.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69FFE98731176D4A21E4AC5A"
Cc: Armin Steinhoff <armin@steinhoff.de>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:45529 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734Ab1FEJoz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 05:44:55 -0400
In-Reply-To: <20110605092854.GA7576@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69FFE98731176D4A21E4AC5A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-05 11:28, Nicholas Mc Guire wrote:
> On Sun, 05 Jun 2011, Armin Steinhoff wrote:
>=20
>> Nicholas Mc Guire wrote:
>>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>>
>>>> Hello,
>>>> I'm studying how to develop drivers in a real time OS and how do the=
y
>>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.=

>>>> I would like to know the priority when executing open(), read(), wri=
te()
>>>> and close() operations.
>>>> In my example the thread which is using the driver runs with 10 RTPR=
IO,
>>>> but I don't know what happens in kernel context with the priority wh=
en
>>>> running the I/O operations.
>>>> Thank you for your help, I don't know where to learn about this.
>>>>
>>> []
>>> Also when using bottom half mechanisms you need to take into account =
the
>>> priority of the kernel thread that manages the defered work items, so=

>>> rt-drivers may have a different structure than normal drivers.
>>
>> That's the reason why I prefer UIO based user space drivers !
>>
> ...and how to resolve DMA ? if DMA were resolved cleanly I would agree.=


Regarding that limitation, there is some hope: "next-generation" UIO is
called VFIO. Useful for exclusively assigning virtual PCI functions of
network adapters etc. to user space stacks or hypervisors like QEMU/KVM
(for device pass-through). But it's not mainline yet. And it obviously
requires an IOMMU.

But the key point remains: "exclusively". Anything else cannot be
modeled efficiently via UIO or VFIO.

Jan


--------------enig69FFE98731176D4A21E4AC5A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3rUBUACgkQitSsb3rl5xTz7QCfYRptp4jvCpds8qFUQCPPSsxy
EMwAnRYrgyWbBgOO2Kf6YO9eA5RuziwN
=F1nK
-----END PGP SIGNATURE-----

--------------enig69FFE98731176D4A21E4AC5A--
