From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 4/7] Add the following new tests - ptsematest -
 sigwaittest - svsematest - sendme
Date: Tue, 15 Dec 2009 08:41:56 -0600
Message-ID: <20091215084156.660f3b26@torg>
References: <1260806336-4691-1-git-send-email-jkacur@redhat.com>
	<1260806336-4691-2-git-send-email-jkacur@redhat.com>
	<1260806336-4691-3-git-send-email-jkacur@redhat.com>
	<1260806336-4691-4-git-send-email-jkacur@redhat.com>
	<1260806336-4691-5-git-send-email-jkacur@redhat.com>
	<4B26E524.7010602@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/iu4mp01KBRmBHtsJLYIxrQE"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Carsten Emde <c.emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62216 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbZLOOmR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Dec 2009 09:42:17 -0500
In-Reply-To: <4B26E524.7010602@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/iu4mp01KBRmBHtsJLYIxrQE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I've already fixed that after pulling John's branch. I'll push a 0.57
version of rt-tests with all these changes in just a bit.

Clark

On Tue, 15 Dec 2009 02:23:48 +0100
Carsten Emde <c.emde@osadl.org> wrote:

> John,
>=20
> thanks a lot for taking care of the new tests.
>=20
> By some reason, the spec file was not included in the patch. This
> patch is needed to prevent the rpm build from finding installed
> but unpackaged files.
>=20
>=20
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
>=20
> --- rt-tests.spec-in-orig       2009-12-15 02:15:36.724746547 +0100
> +++ rt-tests.spec-in    2009-12-15 02:16:51.320459770 +0100
> @@ -36,10 +36,20 @@
>  /usr/bin/signaltest
>  /usr/bin/hwlatdetect
>  /usr/bin/rt-migrate-test
> +/usr/bin/ptsematest
> +/usr/bin/sendme
> +/usr/bin/sigwaittest
> +/usr/bin/svsematest
> +
>  %doc
>  /usr/share/man/man8/cyclictest.8.gz
>  /usr/share/man/man8/pi_stress.8.gz
>  /usr/share/man/man8/hwlatdetect.8.gz
> +/usr/share/man/man4/backfire.4.gz
> +/usr/share/man/man8/ptsematest.8.gz
> +/usr/share/man/man8/sendme.8.gz
> +/usr/share/man/man8/sigwaittest.8.gz
> +/usr/share/man/man8/svsematest.8.gz
> =20
>  %changelog
>  * Thu Dec 10 2009 Clark Williams <williams@redhat.com> - 0.56-1

--Sig_/iu4mp01KBRmBHtsJLYIxrQE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAksnoDgACgkQHyuj/+TTEp006gCgq5rW64TFuH9qCHTaV33LS1TM
uHkAoIKwNs5JOplp5Ge0HA1HDcvufOs7
=LsMf
-----END PGP SIGNATURE-----

--Sig_/iu4mp01KBRmBHtsJLYIxrQE--
