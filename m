From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 06 Jun 2011 22:48:21 +0200
Message-ID: <4DED3D15.5020506@web.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at> <4DEB5015.7070601@web.de> <4DEC84C6.4090702@steinhoff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig63DCB6EAD811860A3D3B54CC"
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:59118 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab1FFUsX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jun 2011 16:48:23 -0400
In-Reply-To: <4DEC84C6.4090702@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig63DCB6EAD811860A3D3B54CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-06 09:41, Armin Steinhoff wrote:
> Jan Kiszka wrote:
>> On 2011-06-05 11:28, Nicholas Mc Guire wrote:
>>> On Sun, 05 Jun 2011, Armin Steinhoff wrote:
>>>
>>>> Nicholas Mc Guire wrote:
>>>>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>>>>
>>>>>> Hello,
>>>>>> I'm studying how to develop drivers in a real time OS and how do t=
hey
>>>>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installe=
d.
>>>>>> I would like to know the priority when executing open(), read(),
>>>>>> write()
>>>>>> and close() operations.
>>>>>> In my example the thread which is using the driver runs with 10
>>>>>> RTPRIO,
>>>>>> but I don't know what happens in kernel context with the priority
>>>>>> when
>>>>>> running the I/O operations.
>>>>>> Thank you for your help, I don't know where to learn about this.
>>>>>>
>>>>> []
>>>>> Also when using bottom half mechanisms you need to take into
>>>>> account the
>>>>> priority of the kernel thread that manages the defered work items, =
so
>>>>> rt-drivers may have a different structure than normal drivers.
>>>> That's the reason why I prefer UIO based user space drivers !
>>>>
>>> ...and how to resolve DMA ? if DMA were resolved cleanly I would agre=
e.
>> Regarding that limitation, there is some hope: "next-generation" UIO i=
s
>> called VFIO.
>=20
> I found in a posting about VFIO that  " ioctls are used for all the
> basic interactions"  ... that means VFIO works with a lot of context
> switches.

That mostly refers to configuring VFIO devices (just check the code when
in doubt).

One exception is EIO. VFIO works generically, without any device
specific kernel stubs. So legacy interrupts are first generically
masked, then reported to user space to do the device specific handling,
and then ack'ed by user space via an IOCTL to remove the mask again. But
that only matters for legacy INTx, not for MSI[-X].

> That's not the case with UIO.  So why should VFIO be a mainline approac=
h
> or next generation UIO at all?

Because it is promising to solve the DMA challenge without totally
ignoring security (in contrast to uio-dma). And because it already has
two major use cases (high-speed user space networking and virtualization)=
=2E

Conceptually, VFIO should be able to cover most of those scenarios that
UIO currently addresses. But UIO is kernel ABI and wouldn't go away even
if VFIO was able to completely replace it.

Jan


--------------enig63DCB6EAD811860A3D3B54CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3tPRYACgkQitSsb3rl5xQVAgCgg/GTstnfcc25v7GfKbzdqPeR
jF4AnRgOd1FiU08ULneQrkNLxSHbu2nS
=Npsp
-----END PGP SIGNATURE-----

--------------enig63DCB6EAD811860A3D3B54CC--
