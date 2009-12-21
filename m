From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/4] rt-tests: Clean-up - protect rt-utils.h
Date: Mon, 21 Dec 2009 17:19:13 -0600
Message-ID: <20091221171913.5ae81e6d@torg>
References: <1261431950-28500-1-git-send-email-jkacur@redhat.com>
	<1261431950-28500-2-git-send-email-jkacur@redhat.com>
	<1261431950-28500-3-git-send-email-jkacur@redhat.com>
	<1261431950-28500-4-git-send-email-jkacur@redhat.com>
	<4B30002F.3030209@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/zXQC39Xy9oWS0pMUgKX6OTd"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbZLUXTc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Dec 2009 18:19:32 -0500
In-Reply-To: <4B30002F.3030209@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/zXQC39Xy9oWS0pMUgKX6OTd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Dec 2009 00:09:35 +0100
Carsten Emde <Carsten.Emde@osadl.org> wrote:

> On 12/21/2009 10:45 PM, John Kacur wrote:
> > Clean-up: Protect rt-utils.h with #ifndef RT_UTILS_H
> > [..]
> > +#ifndef RT_UTILS.H
> Macro names should only consist of alphanumeric characters and
> underscores, i.e. 'a-z', 'A-Z', '0-9', and '_', and the first character
> should not be a digit.
>=20
>

Yeah, I caught that and also pushed it out of application name space
with two leading underscores.=20

Clark

--Sig_/zXQC39Xy9oWS0pMUgKX6OTd
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkswAnQACgkQHyuj/+TTEp3wTgCfQJLttEIAl3M9J/y5aD+pkXev
kG8AoNOkNxR3MRNDjX+81I8E7PL98yvV
=Vw05
-----END PGP SIGNATURE-----

--Sig_/zXQC39Xy9oWS0pMUgKX6OTd--
