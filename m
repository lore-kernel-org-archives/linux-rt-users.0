From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH -rt] kvm,rt: change async pagefault code locking for
 rt-preempt
Date: Tue, 29 Mar 2016 18:28:43 +0200
Message-ID: <56FAAD3B.2050606@redhat.com>
References: <20160318142052.0605524d@annuminas.surriel.com>
 <20160329161346.GE13334@linutronix.de> <1459268329.6219.8.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4D2StTe4P33Hawd8uEDppTQQRMnElB7ak"
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com,
	srostedt@redhat.com
To: Rik van Riel <riel@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60998 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757394AbcC2Q2w (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 12:28:52 -0400
In-Reply-To: <1459268329.6219.8.camel@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4D2StTe4P33Hawd8uEDppTQQRMnElB7ak
Content-Type: multipart/mixed; boundary="I57rT1JJ2v8UnQ5WmQjtV8iFp4Oapvndf"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Rik van Riel <riel@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com, srostedt@redhat.com
Message-ID: <56FAAD3B.2050606@redhat.com>
Subject: Re: [PATCH -rt] kvm,rt: change async pagefault code locking for
 rt-preempt
References: <20160318142052.0605524d@annuminas.surriel.com>
 <20160329161346.GE13334@linutronix.de> <1459268329.6219.8.camel@redhat.com>
In-Reply-To: <1459268329.6219.8.camel@redhat.com>

--I57rT1JJ2v8UnQ5WmQjtV8iFp4Oapvndf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/03/2016 18:18, Rik van Riel wrote:
> > In -rt11 I pulled in the swait queue which was in the -tip tree and i=
s
> > now part of v4.6-rc1. So if you could please refresh the patch and
> > resend it then I will be able pick it up for the next -RT release and=

> > the KVM maintainer will be able to pick it up, too.=20
>
> I missed that swait went upstream, but I believe Paulo fixed
> up the patch and has it in the KVM tree already.

Yes, I did.  You'll get Rik's patch for free from Linus's tree. :)

Paolo


--I57rT1JJ2v8UnQ5WmQjtV8iFp4Oapvndf--

--4D2StTe4P33Hawd8uEDppTQQRMnElB7ak
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+q07AAoJEL/70l94x66D2vwH/0orah6K5DC6jvBsxvhDDtTW
LAW5AGq4kNhnbS3gQHvifAyOi84Ju6pOUJzY1bYsMXIVBERQKxo8X1IqBLZulOJ2
RvGBOurWLG+uJHlkWpij0z26JSPpPGRJwOm2BHQSUPH+nD87JM2tfr6ZjrkRhIxi
svEKF+lbWFYIDqzulsBGIESM+IYhzl6cGK446Sw5YBdt8NixAwntMY6EfIDDkhDj
0ebBZSAw+hiRq8KdpT6T0x2t71Cw3msLIU4OfHVpH7SPq/NTApsoOsZrSuCIwsLA
/KzYLK0R1mqGH5B32Z5EuwdPeiNOJ6HuLadPIJqLAh05peNjtELCYOyG+AIDVyc=
=ipqa
-----END PGP SIGNATURE-----

--4D2StTe4P33Hawd8uEDppTQQRMnElB7ak--
