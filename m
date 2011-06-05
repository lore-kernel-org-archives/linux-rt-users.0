From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: I/O operations priority in RTOS
Date: Mon, 06 Jun 2011 01:09:23 +0200
Message-ID: <4DEC0CA3.2070806@web.de>
References: <4DEA1BA9.7020303@unican.es> <4DEA1F22.6000603@unican.es> <20110604234214.GA30640@opentech.at> <4DEB427F.9020104@steinhoff.de> <4DEB4B97.9030005@web.de> <4DEC05A7.7060306@steinhoff.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig89452ED1ECE3374E090181F9"
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:55920 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756498Ab1FEXKg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Jun 2011 19:10:36 -0400
In-Reply-To: <4DEC05A7.7060306@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89452ED1ECE3374E090181F9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-06-06 00:39, Armin Steinhoff wrote:
> Jan Kiszka wrote:
>> On 2011-06-05 10:46, Armin Steinhoff wrote:
>>> Nicholas Mc Guire wrote:
>>>> On Sat, 04 Jun 2011, Monica Puig-Pey wrote:
>>>>
>>>>> Hello,
>>>>> I'm studying how to develop drivers in a real time OS and how do th=
ey
>>>>> work. I'm using  Ubuntu 10.04 with the 2.6.31-11-rt patch installed=
=2E
>>>>> I would like to know the priority when executing open(), read(),
>>>>> write()
>>>>> and close() operations.
>>>>> In my example the thread which is using the driver runs with 10
>>>>> RTPRIO,
>>>>> but I don't know what happens in kernel context with the priority w=
hen
>>>>> running the I/O operations.
>>>>> Thank you for your help, I don't know where to learn about this.
>>>>>
>>>> []
>>>> Also when using bottom half mechanisms you need to take into account=

>>>> the
>>>> priority of the kernel thread that manages the defered work items, s=
o
>>>> rt-drivers may have a different structure than normal drivers.
>>> That's the reason why I prefer UIO based user space drivers !
>> ...which are forced to use threaded IRQs over -rt as well.
>=20
> What's wrong with that approach? You have an ISR in the kernel module
> and an interrupt thread at user space.

Under -rt, you have an ISR kernel thread in addition to whatever threads
you create in user space. I thought your point about UIO was avoiding
the need to worry about priorities, but maybe I misunderstood this.

> Seem OK for me since a long time with QNX :)
>> Taking threaded IRQs out of the picture, bottom-half mechanisms usuall=
y
>> come into play when dispatch workload that cannot be assigned to a
>> specific user context is significant. But then UIO is the wrong approa=
ch
>> anyway as it doesn't match well the requirements of multi-user device
>> interfaces.
>   Support of multi-user device interfaces at user space is just a desig=
n
> issue ... I use this concept since a long time with QNX :)

There is always a tradeoff. IIRC, even QNX is no pure microkernel
anymore when it comes to performance sensitive services that are shared
between many processes. And Linux is no pure monolithic kernel anymore
when it comes to easily implementing user space file systems or
exclusively assigning devices to processes.

Jan


--------------enig89452ED1ECE3374E090181F9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk3sDKMACgkQitSsb3rl5xT/7ACgrvIietHfGy/51V57QAnCyTZL
v3UAn2uSOpufLwsqI5sBqDWFYT/mlGrc
=T/9+
-----END PGP SIGNATURE-----

--------------enig89452ED1ECE3374E090181F9--
