From: Clark Williams <williams@redhat.com>
Subject: Re: swait question
Date: Tue, 23 Feb 2016 08:36:08 -0600
Message-ID: <20160223083608.61f69ad9@sluggy.hsv.redhat.com>
References: <56CC0355.6010200@monom.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/M+WEUeIq0FpLhPC8emq8282"; protocol="application/pgp-signature"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Daniel Wagner <wagi@monom.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52396 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbcBWOgO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Feb 2016 09:36:14 -0500
In-Reply-To: <56CC0355.6010200@monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/M+WEUeIq0FpLhPC8emq8282
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Feb 2016 07:59:33 +0100
Daniel Wagner <wagi@monom.org> wrote:

> Hi Clark,
>=20
> Sorry, I seem to be offline when you are online and vice verse.

No worries, that's what email is for.=20

>=20
> To your question: you need to drop the original swait patches from the
> -rt tree before applying the new version. Last time I tried it it worked
> without bigger problems.
>

I actually dropped only a couple of the patches; I kept completions and sim=
ple work queues, although I had to tweak them a bit.=20

My only problem now is that suspend/resume locked up (was trying it on my l=
aptop). It's entirely possible that I horked something up in the port, so I=
'll poke at it a bit more before yelling for help :).

=20
> Sebastian would you mind integrating the new version of the swait
> patches? I guess it doesn't hurt to give them a some testing via the -rt
> tree.
>=20
>

Btw, when I ported the latest (v8 I think?) to RT, I moved work-simple.[ch]=
 to swork.[ch] to keep things consistent. Sebastian, if you want me to push=
 what I did up to my k.o. git tree, I'll do so.=20

Clark

--Sig_/M+WEUeIq0FpLhPC8emq8282
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWzG5YAAoJEOI5asVwYXLrWu0QALD+NRhGY3ATMwl48EhRl/PM
aHq9569ilmA2gUqi9ro9TmORfvOLwgww5/TDhgPdYetIj8+/9l5+3di9F1QXDnCT
ntbiYCbIBcMfl8v2lZzscMqLFKNdD9qPxzohmSxpE0CoblRQMcIdKFFSnIw8S87t
R5AIi7xHglXevCXz6rS9twMWFkNMz26rPxQsYilA9xz8IUQ9G1WS/XQps11VqMN/
lNhnnxxvXd1MyeUsxixjNksaSWRWlDnUn0VbVTAxn8igXiMZbi8ydti+t02cem9U
uthb0LWKdVyeQkYrFCzD/AyqJjEFgzu+GlAcuHrlESZvrC2XppcWqvl9WAiS/n0s
/m0pDV302/W3Z0JE2wCbgPRein3Kn5L/9/BDZTc557PeJ5sq0oiIcFkBg5TbI42/
GNmR0OGX1tENn7MZz6FdS5EoULUM9dQHzClILjyPpgBMRXYkEDM6FLwdEVspIc4G
QbHTuqA1qdR3y4QiydrSRCAV9DAgaoIFRY+gqCsHXZ8h5bptR5aqPJGbYc+9A5vZ
5mvEaouAylKOGGgLUDX9/WqxXeKDLpifEy6PDpByoz1fjXlE8AdLjL+NX1gMaLXQ
IdrTyLogEmvRLywM9xoUpQlcCDT0jIBuJtDVbxPgqRrWSloaINbJj2/0wpo7kMHk
AAkQLh1ldRjypVDOTHL8
=FZhz
-----END PGP SIGNATURE-----

--Sig_/M+WEUeIq0FpLhPC8emq8282--
