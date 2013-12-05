From: Pavel Vasilyev <pavel@pavlinux.ru>
Subject: Re: Solving Nvidia (blob) latency spikes + convert (nvidia's) semaphores
 into mutexes patches for 331.20 [patches and links provided]
Date: Fri, 06 Dec 2013 03:04:29 +0400
Message-ID: <52A1067D.8070009@pavlinux.ru>
References: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com>
Reply-To: pavel@pavlinux.ru
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="unFWOMw4V8wQSpRxgTX6HJrksPKKgO2pi"
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from imp02.mtu.ru ([62.5.255.19]:58504 "EHLO imp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab3LEXEp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 18:04:45 -0500
In-Reply-To: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--unFWOMw4V8wQSpRxgTX6HJrksPKKgO2pi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

06.12.2013 01:20, jordan =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> Hey list,
>=20
> I have been experimenting with the nvidia blob, monitoring behavior /
> latencies, etc. Through some experimentation, googling/research and
> looking over previous nvidia-rt/compat patches from all over the
> interwebs; I've put together a few patches for the latest
> nvidia-331.20 driver.=20


1. Blob after 325.xx.xx does not compile and does not work with our RT pa=
tches!
2. Nvidia developers specifically inserted function WBINVD to slowly work=
? :)
3. SFENCE need on SMP systems. Although, delay in 1000 nanoseconds - it's=
 awful
4. Do you really think, that mutex_lock/unlock more realtime than up/down=
?


--=20

                                                         Pavel.


--unFWOMw4V8wQSpRxgTX6HJrksPKKgO2pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJSoQZ+AAoJEPtok08Dny2h0aYP/3GO76Z8/aGORoTjvWgWp0ue
xMNcN2FQzqYuDCgCtCGqWVFuSvRIap2MR5m/3BeyyCnACfClkSHXLkqjN8YqpxKi
L2gR7Q3WoNkalKSixTC7mzgen9aguQ18VOnY6vrHB/vsnh2osKpterFhXY5Jp8gT
xBtWOSKx3iIK/HImUsg9f/bDCUedptY1C9tFqkMWsZetsGk0334o0cfRsbwVXYCf
Ekq4TZIoF2G9IdUZDMdlnpK+uz8X6Q/R61ZLu+UkcWFPO5sVXIBnvNL5/UeAx63F
CMQNqgVq2P2eoJGiBoG5p0BDSk+vVnw36qZdOCLRoVO6XnBS81t1cmpCugKqUVFf
qI9ehJCRa44oFrJKSOhtFSugETQw7/FwyoTKH0FsYi2BR9Qjb5m6bZ+asHkOhkzI
MNLoPEQQHGwGXmdxy2lkEc8TYc4rl3+5Ah04LU6Cl8D9lo1AQX+OkxMplaTTLss3
4OSyAeOh4JB7n3Bj5hMDnkbICz7YdQjlnfPUUTsPQVXrdSxbWpz+rcoNlzJXtuf7
r/bsmnI3s93mpKgCuBGW19gUH/NjQUcUKe8zpEYKMExKSLJmTrdSR1dDqXIPxlaL
uBcwIygCf/9NXRGgNxeEi3REs18U9QUFj35BMx8DfTqh8gjGInamLAR9N8IpgQFF
oGnyjV2kZfyYv2+BM8Ae
=nFx0
-----END PGP SIGNATURE-----

--unFWOMw4V8wQSpRxgTX6HJrksPKKgO2pi--
