From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: Solving Nvidia (blob) latency spikes + convert (nvidia's) semaphores
 into mutexes patches for 331.20 [patches and links provided]
Date: Fri, 06 Dec 2013 05:01:44 +0400
Message-ID: <52A121F8.7010607@pavlinux.ru>
References: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com> <52A1067D.8070009@pavlinux.ru> <CAOcfFMwQ1-QOOFeLqWD8zNuCfQ9gELsqK8Zq69Zb=+EMzVKd4A@mail.gmail.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JxaTpDeEkqeXXk7CmsLXaRtiP7McXwNTV"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:56696 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751150Ab3LFBB5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 20:01:57 -0500
In-Reply-To: <CAOcfFMwQ1-QOOFeLqWD8zNuCfQ9gELsqK8Zq69Zb=+EMzVKd4A@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JxaTpDeEkqeXXk7CmsLXaRtiP7McXwNTV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

06.12.2013 03:43, jordan =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 1. Blob after 325.xx.xx does not compile and does not work with our RT=
 patches!
>=20
> Sure it does.
>=20
> make IGNORE_PREEMPT_RT_PRESENCE=3D1

Wow, I did not know, thanks. I until on 319.xx

>=20
>> 3. SFENCE need on SMP systems. Although, delay in 1000 nanoseconds - i=
t's awful
> Would you care to goto into more detail on this?=20

https://www.kernel.org/doc/Documentation/memory-barriers.txt

--=20

                                                         Pavel.


--JxaTpDeEkqeXXk7CmsLXaRtiP7McXwNTV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJSoSH4AAoJEPtok08Dny2hvIAP/RKNFASbKsndLqMyznOUL+dV
t10awYmJRLVcH0flJe/hQlWxS8JVdUF45mIKrOp2RlY8Y2IfxcLmoriMVFLNt1uo
ZdAFYE+N7kIjPmSH/O7Y5WFft52BRWO4Mc7gtWsacqUCuSXaZn5WYYo+AcE7uds9
VbbAI3g3X5nhrcpCtBKR//s51C2f29A98wX1o6nV1gRSOaxfjJQa/cqnK/TIM+cp
SuOwmZo444kjLJv2TEayTiFQ1Uzge/hPqTjLQvDu3DEewTGTuo5OEMPsTYc769RB
OEVJ+/24PjGhTbuQ+ZKnDrJRwx5C77mSORzrtw9UBueVj5gqcVRnJwiqr8RDGPq4
IieQVgaCXWEt6Ql7qswa0QpYBrunSdP4YvioxsGEe0oNUc+RNIN1KzrZSCi68gsR
SfXUTgXHoMcJ4xzbHrudI+yF3vxD67EjghvtTgAoeuVT/OgwoWlWpERdCJZhNSt8
jnTTvJNbyLB/lOxSWZ5/o/zvFP6eUJzhocv4rjGPy+530YmaWMqTXKMtDCWIob4G
N2ktgb2fVI/c5IKMXXdDu4J71OrxGMxWT9JHDZt9asPx/8vh+xzuOfqWEYswEoJf
8MyEQutqnfNGLlSknVMtD+Pri0H38gC2/8Y75SRdI4cUmGailLqUcOujR2eI8qtL
rosMRPPwBJiFlYMORQZB
=Dpuo
-----END PGP SIGNATURE-----

--JxaTpDeEkqeXXk7CmsLXaRtiP7McXwNTV--
