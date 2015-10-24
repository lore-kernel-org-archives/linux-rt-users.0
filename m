From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Sat, 24 Oct 2015 19:22:47 +0200
Message-ID: <562BBE67.5010404@autostatic.com>
References: <3671201425478878@web10j.yandex.ru>
 <loom.20150306T043408-818@post.gmane.org>
 <loom.20150309T025355-426@post.gmane.org>
 <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru>
 <loom.20150331T153850-579@post.gmane.org>
 <loom.20150927T172648-968@post.gmane.org> <560B9543.1020106@autostatic.com>
 <loom.20150930T110905-205@post.gmane.org>
 <loom.20151011T141552-925@post.gmane.org> <5624051F.3070903@autostatic.com>
 <loom.20151019T173209-888@post.gmane.org> <5625472E.5030909@autostatic.com>
 <loom.20151024T131507-991@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="enIsVHcu396Bf0g3wD3Ag8AX2R6HdE12H"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from autostatic1.autostatic.cyso.net ([93.94.224.100]:53412 "EHLO
	smtp.autostatic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803AbbJXRW4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 24 Oct 2015 13:22:56 -0400
Received: from [192.168.1.135] (535178DA.cm-6-2b.dynamic.ziggo.nl [83.81.120.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: autostatic)
	by smtp.autostatic.com (Postfix) with ESMTPSA id 5FF90FDB
	for <linux-rt-users@vger.kernel.org>; Sat, 24 Oct 2015 19:22:47 +0200 (CEST)
In-Reply-To: <loom.20151024T131507-991@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--enIsVHcu396Bf0g3wD3Ag8AX2R6HdE12H
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hello Oliver,

On 10/24/2015 01:18 PM, Oliver wrote:
> Ok, I am going to try this.
> Did you use this image:
> http://sjoerd.luon.net/posts/2015/02/debian-jessie-on-rpi2/

No, I installed it myself. Since the Raspberry Pi 2 uses aan ARMv7 CPU
you can install stock Debian on it.

>=20
> I have installed it. It is on 3.18.5
> How did you get to 4.1.7?

I used the official Raspberry Pi Github kernel repository, applied the
RT patchset and then compiled the kernel and modules.

Jeremy





--enIsVHcu396Bf0g3wD3Ag8AX2R6HdE12H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWK75nAAoJEF63J34m6LiUT+0QAIMXxzM62yuhze+8SAoP5SNg
rV1VzQ/SnUbV3ybanmuFlKu2lk1JE0HcIVi8COKUJz8/2ivAYh7s7X/yeXOWB9L7
n3yZ4bCqBu5TxwJxAjluqWIDCut9IYSSz9PELW2oeHzcLrOGynjBA/lUFnO8bnS7
nNxxLsLUCgNLgr4P0Rt6EPDSxxPYTQW/VhmqVX3fe4ih3Zq6opU71KBv8FvyTZ0P
0r8jIaWqfuIK75P831Qq6Bcy5lJuhZs8rz2m1hA+/YHXxrEwhFdYF9xUss4QXjcn
7cf2fep5NOiWlF8rzXQvauvGYEj6KOVYRH/DTmeu3tMfC4Rdw/zcauYtPlF6mgg5
WhFZa8Wq2FR5vRGncDCZv2HNnuJUs6tyLCXVJCXaD0yfXWYhIuTNsK2dqZbPlb1L
A8EfaKrE4/XfXlgYOQSsT4bvGpZbOW/r1J/4HBbkewpT+4PINIM2Lmgf+jdKA3tt
NAjZpKhGwsj3v3k1wOHUNsS+Sp2twMWYMMkPAM/d+rEoNK/WiP2nuHf69CdJkR8p
6vix6MLIzOhwSaKe5LlMulOlBFl94mYngeQ7xXAZE50xJL6XF1OTjJkyj/ASmZCG
3xs882D+w74UtdwPKOuKCQuL/sOTmPQDcnZpMLZ4wnJALzNK9Dq4qWZShK/dg1UP
8BSRUVleiA04OclJG+G+
=ev8i
-----END PGP SIGNATURE-----

--enIsVHcu396Bf0g3wD3Ag8AX2R6HdE12H--
