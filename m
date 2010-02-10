From: Clark Williams <williams@redhat.com>
Subject: Re: Tweak Latency on Intel ATOM
Date: Wed, 10 Feb 2010 16:38:18 -0600
Message-ID: <20100210163818.7f54ec3a@torg>
References: <loom.20100209T081421-234@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/cJiXX8kbK9RK3BYsmMkOpnm"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Max Miller <mxmr@gmx.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753911Ab0BJWi2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Feb 2010 17:38:28 -0500
In-Reply-To: <loom.20100209T081421-234@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/cJiXX8kbK9RK3BYsmMkOpnm
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Feb 2010 07:41:58 +0000 (UTC)
Max Miller <mxmr@gmx.net> wrote:

> Hello,
>=20
> im am using the PREEMPT-RT patch on linux 2.6.29.6. It runs on a MSI965GSE
> industial board with Intel ATOM CPU (N270, 1,6GHz) and i945GSE Northbridg=
e.=20
>=20
> I got about 45=B5s as maximum and 13=B5s as average latency when hyperthr=
eading is
> disabled. With enabled Hyperthreading the maximum latency increses to abo=
ut
> 100=B5s. I measured the latency with cyclictest.=20
>=20
> What can i do to get better maximum latency? Can I do somthing in the ker=
nel
> configuration or are there some kernel bootoptions? Or is it still imposs=
ible
> with this CPU to get better results?
>=20
> Thanks in advance,
> Max Miller=20
>=20
>

Make sure you turn off any power management settings in the BIOS and
turn off the irqbalance and cpuspeed services on the Linux side.

What cyclictest command are you using to measure latency?

Clark

--Sig_/cJiXX8kbK9RK3BYsmMkOpnm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAktzNV0ACgkQHyuj/+TTEp39nQCfcQL/IOYRCJ8uIZuQ2xKNOzxc
YCoAoIrP2kZLWCs6QTqUSy2SDiOdCDn0
=orF7
-----END PGP SIGNATURE-----

--Sig_/cJiXX8kbK9RK3BYsmMkOpnm--
