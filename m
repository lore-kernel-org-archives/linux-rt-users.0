From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: I/O operations priority in RTOS
Date: Sun, 05 Jun 2011 11:25:43 +0200
Message-ID: <4DEB4B97.9030005@web.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C7E8DAA52B1364594CCC058"
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:60622 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755596Ab1FEJZp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 05:25:45 -0400
In-Reply-To: <4DEB427F.9020104@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C7E8DAA52B1364594CCC058
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-05 10:46, Armin Steinhoff wrote:
> Nicholas Mc Guire wrote:
>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>
>>> Hello,
>>> I'm studying how to develop drivers in a real time OS and how do they=

>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed.
>>> I would like to know the priority when executing open(), read(), writ=
e()
>>> and close() operations.
>>> In my example the thread which is using the driver runs with 10 RTPRI=
O,
>>> but I don't know what happens in kernel context with the priority whe=
n
>>> running the I/O operations.
>>> Thank you for your help, I don't know where to learn about this.
>>>
>> []
>> Also when using bottom half mechanisms you need to take into account t=
he
>> priority of the kernel thread that manages the defered work items, so
>> rt-drivers may have a different structure than normal drivers.
>=20
> That's the reason why I prefer UIO based user space drivers !

=2E..which are forced to use threaded IRQs over -rt as well.

Taking threaded IRQs out of the picture, bottom-half mechanisms usually
come into play when dispatch workload that cannot be assigned to a
specific user context is significant. But then UIO is the wrong approach
anyway as it doesn't match well the requirements of multi-user device
interfaces.

Jan


--------------enig3C7E8DAA52B1364594CCC058
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3rS5cACgkQitSsb3rl5xQWPACfcLmPIOQ8nTZHiLFQPdqY/AV+
dd4An3jDjCmztKX8JEIaVVKzq6F/TPs1
=x4nq
-----END PGP SIGNATURE-----

--------------enig3C7E8DAA52B1364594CCC058--
