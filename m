From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 06 Jun 2011 01:00:15 +0200
Message-ID: <4DEC0A7F.7090207@web.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <20110605092854.GA7576@opentech.at> <4DEB5015.7070601@web.de> <20110605222954.GA13340@opentech.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig642E0FFCF81D018AB9DF8EC3"
Cc: Armin Steinhoff <armin@steinhoff.de>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate03.web.de ([217.72.192.234]:49473 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373Ab1FEXA2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 19:00:28 -0400
In-Reply-To: <20110605222954.GA13340@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig642E0FFCF81D018AB9DF8EC3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-06 00:29, Nicholas Mc Guire wrote:
> On Sun, 05 Jun 2011, Jan Kiszka wrote:
>=20
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
>>>>>> I would like to know the priority when executing open(), read(), w=
rite()
>>>>>> and close() operations.
>>>>>> In my example the thread which is using the driver runs with 10 RT=
PRIO,
>>>>>> but I don't know what happens in kernel context with the priority =
when
>>>>>> running the I/O operations.
>>>>>> Thank you for your help, I don't know where to learn about this.
>>>>>>
>>>>> []
>>>>> Also when using bottom half mechanisms you need to take into accoun=
t the
>>>>> priority of the kernel thread that manages the defered work items, =
so
>>>>> rt-drivers may have a different structure than normal drivers.
>>>>
>>>> That's the reason why I prefer UIO based user space drivers !
>>>>
>>> ...and how to resolve DMA ? if DMA were resolved cleanly I would agre=
e.
>>
>> Regarding that limitation, there is some hope: "next-generation" UIO i=
s
>> called VFIO. Useful for exclusively assigning virtual PCI functions of=

>> network adapters etc. to user space stacks or hypervisors like QEMU/KV=
M
>> (for device pass-through). But it's not mainline yet. And it obviously=

>> requires an IOMMU.
>>
>> But the key point remains: "exclusively". Anything else cannot be
>> modeled efficiently via UIO or VFIO.
>>
> for many RT apps that is an acceptable limit - in fact sometimes a requ=
irement - having dynamic access and handling this at runtime is not neces=
sarily an advantage for rt. Giving guarantees on timing for non-exclusive=
 access in the general case would probably need to be based on a priority=
 access model any way (i.e. running non-RT network traffic on a RT-link a=
s "rt-idle" bandwidth usage - but full shared access at runtime would be =
very hard, if not impossible, to model at the device interface level with=
out breaking RT properties. So I think its legitimate to keep it out of t=
he device all together and let the user apps have a non-rt fight about ac=
cess...

There are good examples - in the RT domain - for both models. Sharing a
device does not necessarily mean making things dynamic or even
unpredictable.

>=20
> Any pointers to VFIO ?

E.g. http://thread.gmane.org/gmane.linux.kernel.pci/10088

Jan


--------------enig642E0FFCF81D018AB9DF8EC3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3sCoUACgkQitSsb3rl5xREQwCeMBBRskjdHs/5vLKSJLbSw+vy
99sAoIxCS6rZ3X20Dmj0chVH438k2VOB
=9GuR
-----END PGP SIGNATURE-----

--------------enig642E0FFCF81D018AB9DF8EC3--
