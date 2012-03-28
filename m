From: Clark Williams <williams@redhat.com>
Subject: Re: Determining latest stable release.
Date: Wed, 28 Mar 2012 14:00:22 -0500
Message-ID: <20120328140022.2998bfbc@redhat.com>
References: <CAOHJ0jTVxzgfBK=GSEr14YrpFZEqFE_qDqftaUgGWDgm344NNg@mail.gmail.com>
	<CAOHJ0jQphT30v-y1HMiHYOnFVumovkccCV43mDJjBx=fko=GUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/n.pIYnpsoQ7loFG/Fo_L1ZR"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: Robert Barrows <Robert.Barrows@metriainnovation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:17875 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab2C1TAq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 28 Mar 2012 15:00:46 -0400
In-Reply-To: <CAOHJ0jQphT30v-y1HMiHYOnFVumovkccCV43mDJjBx=fko=GUg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/n.pIYnpsoQ7loFG/Fo_L1ZR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Mar 2012 15:59:31 -0500
Robert Barrows <Robert.Barrows@metriainnovation.com> wrote:

> Does the PREEMPT_RT patch have a method of determining latest stable
> release?
>=20
> I notice that 3.0.35 goes up to rt44 was declared a stable release but
> so was rt43
> Now 3.2.12 goes up to rt22, and that was updated March 23rd with 3.0.35-r=
t44.
>=20
> Is there a reason to think that=C2=A03.0.35-rt44 is more stable than=C2=
=A03.2.12-rt22?
> The real question=C2=A0is: is there a rule of thumb on how you would choo=
se
> a rt patched kernel for a production machine?
>=20
> Thanks.
>=20
> -Robb Barrows
> --
>

The stuff that Steven releases is the stable series, while Thomas
does the devel releases. So if you're not looking for the latest and
greatest, I'd stick to what Steven releases.

Clark

--Sig_/n.pIYnpsoQ7loFG/Fo_L1ZR
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk9zX8YACgkQHyuj/+TTEp2MpgCg1KozzhxIFPDDYYP6hOKO9Qpg
pUEAoLWZMpi7tGk5mZrXSnonq05qdmsG
=jC3p
-----END PGP SIGNATURE-----

--Sig_/n.pIYnpsoQ7loFG/Fo_L1ZR--
