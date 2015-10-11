From: Jeremy Jongepier <jeremy@autostatic.com>
Subject: Re: 3.18 RT freezes on Raspberry Pi 2
Date: Sun, 11 Oct 2015 19:55:15 +0200
Message-ID: <561AA283.6080302@autostatic.com>
References: <3671201425478878@web10j.yandex.ru>
 <loom.20150306T043408-818@post.gmane.org>
 <loom.20150309T025355-426@post.gmane.org>
 <20150309141038.GC13768@linutronix.de> <3863561427712041@web3j.yandex.ru>
 <loom.20150331T153850-579@post.gmane.org>
 <loom.20150927T172648-968@post.gmane.org> <560B9543.1020106@autostatic.com>
 <loom.20150930T110905-205@post.gmane.org>
 <loom.20151011T141552-925@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="pqUONUL5aB7MpPVFEeQ2SF286tcvTrQp2"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from autostatic1.autostatic.cyso.net ([93.94.224.100]:44507 "EHLO
	smtp.autostatic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbJKRza (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Oct 2015 13:55:30 -0400
Received: from [192.168.1.147] (535178DA.cm-6-2b.dynamic.ziggo.nl [83.81.120.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: autostatic)
	by smtp.autostatic.com (Postfix) with ESMTPSA id A7F85992
	for <linux-rt-users@vger.kernel.org>; Sun, 11 Oct 2015 19:55:16 +0200 (CEST)
In-Reply-To: <loom.20151011T141552-925@post.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pqUONUL5aB7MpPVFEeQ2SF286tcvTrQp2
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On 10/11/2015 02:28 PM, Oliver wrote:
> @ Jeremy,
> If this does no longer happen to you in 4.1.7-rt-8, it must have been f=
ixed
> somewhere else. Any idea where?

Maybe the RPi firmware? When was the last time you ran rpi-update?

Jeremy


--pqUONUL5aB7MpPVFEeQ2SF286tcvTrQp2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJWGqKDAAoJEF63J34m6LiUgu0P/2LlheD6k+by6laEzDDkW0Cm
RGR9Oxp1c2SJF/zZvuBCBXaLAcwSnDgFXU4PudU6Irzv5CMIH3yEXA584gXlKhRQ
VjPyMsLxWbTFyLJMloZ3EHcRcOEsAiUTaGF0WS//enb32W/YvahG+ILBN33MwoXX
lQBfRPMen3pjBPkmInEq1bSbwBEBtJl5bElDP9dHmd226FTRkJv9Q2sEq9SfIBpU
7po91VCqC58nFieaXOxXyBkgMimsEWQGT0Urfw/7q75xl8zT0WTUsljcFinOgAZA
saP56eeNQwmw5xU+VrKn03Bwizbj2xFX6vYGoM53Fq+LroGjHiFyPrBWdEiuDCfA
5otoGby/yJqp6gfKZDyeqBcjGW0BqfFQiaaDewUY9297343LyxwbARx+7ITSSber
qZuFSi8k240b8/exzCEAPTb9PE6fcvzm/2KdR5FFDRKudor4gZwVxnhKS/uz6CaI
QdWWHSdSTnQrliv4yDNmP5VlBbA/ER663LO/tD91IV+5jctFuzUXVN9xO7jpMYAv
ECftZtQ7drUjA9M4EIYJJLhXVkEKFrvWimf3ycDWRsWUhHGBDMRsm/qfwdQKqT0U
Le+LD13cavatjJb5xYPG2IXJYFShDJScrJT95OkyprNVlUNX4RSFpKnsd37fTzDL
96zw1sjWGhAP8B6GEDxO
=B67Q
-----END PGP SIGNATURE-----

--pqUONUL5aB7MpPVFEeQ2SF286tcvTrQp2--
