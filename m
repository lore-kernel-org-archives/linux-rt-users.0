From: Clark Williams <williams@redhat.com>
Subject: Re: About update-server-info of rt-tests git tree
Date: Mon, 24 Aug 2009 09:09:38 -0500
Message-ID: <20090824090938.376cff39@torg>
References: <1251073539.2153.61.camel@centos51>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/3ot3849DmmFGHxuRr8+MBJ9"; protocol="application/pgp-signature"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: leemgs1@gmail.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752525AbZHXOJm (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 24 Aug 2009 10:09:42 -0400
In-Reply-To: <1251073539.2153.61.camel@centos51>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/3ot3849DmmFGHxuRr8+MBJ9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Aug 2009 09:25:39 +0900
GeunSik Lim <leemgs1@gmail.com> wrote:

>=20
>=20
> Dear Clarks ,=20
>=20
> I have one favor for you.=20
> As you know, Some developers often use http protocol(80) without git prot=
ocol(9418)=20
> because of firewall problems. Recently, I used " git clone" command with =
http protocol.=20
> But, I can not get rt-tests v0.50.
>=20
> This is a history.=20
> fedora11$> git clone http://www.kernel.org/pub/scm/linux/kernel/git/clrkw=
llms/rt-tests.git
> fedora11$> cd rt-tests
> fedora11$> git tag
> v0.18
> v0.19
> v0.20
> v0.21
> v0.22
> v0.23
> v0.24
> v0.25
> v0.26
> v0.27
>=20
> Please, Can you run below command for http protocol users?=20
> e.g) git update-server-info [enter]
>=20
>

I logged in and ran:

$ git --bare update-server-info

Hopefully that will do the trick. Please let me know if it doesn't.

Thanks,
Clark


--Sig_/3ot3849DmmFGHxuRr8+MBJ9
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEARECAAYFAkqSnyYACgkQHyuj/+TTEp0CAgCfaUgRfaWbEQItLDrBkPVxEiGJ
W+4AoMpFChrBWCcM8eiBDQ57VyA6Tbs1
=Js5G
-----END PGP SIGNATURE-----

--Sig_/3ot3849DmmFGHxuRr8+MBJ9--
