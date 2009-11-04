From: Clark Williams <williams@redhat.com>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 16:44:13 -0600
Message-ID: <20091104164413.3aff479c@torg>
References: <hcs6dr$235$1@ger.gmane.org>
	<5bdc1c8b0911040743h7e4eaa08w97ac8287b806b54f@mail.gmail.com>
	<4AF1A327.3040103@klingt.org>
	<20091104171412.GB1702@opentech.at>
	<4AF1BAB9.5080104@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/LOfj972bbxRHDbPpM4zAR8l"; protocol="application/pgp-signature"
Cc: Nicholas Mc Guire <der.herr@hofr.at>, y@opentech.at,
	Mark Knecht <markknecht@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22975 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932730AbZKDWo3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 17:44:29 -0500
In-Reply-To: <4AF1BAB9.5080104@klingt.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/LOfj972bbxRHDbPpM4zAR8l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 04 Nov 2009 18:32:41 +0100
Tim Blechmann <tim@klingt.org> wrote:

> >> well, if i understand the rt howto correctly, _no_ disc access is
> >> allowed, neither from rt nor from non-rt threads, since it may produce
> >> page faults, which introduce latencies ...
> >=20
> > I would be supprised if the rt howto states that page-faults in non-rt
> > threads is a critical problem - that would not significantly impact RT
> > performance - atelast not the worst case - it will (as every other syst=
em
> > load) impact the average case. so having a non-rt thread reading disk-f=
iles
> > to a buffer and a rt-thread processing this buffer should be perfectly =
fine.
>=20
> that is what i thought for years ... but according to [1] a page fault
> in an rt process freezes the entire process with both rt and non-rt
> threads until the page fault is handled ...
>=20

No, we need to get that fixed in the wiki. It may have been the case
that the entire process was frozen while a fault was being handled, but
I don't believe that is the case now. If you're in a thread on core0
and a sibling thread on core1 faults, you shouldn't be impacted unless
you're trying to reference the same memory.=20

Clark

--Sig_/LOfj972bbxRHDbPpM4zAR8l
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkryA8AACgkQHyuj/+TTEp0rEgCcD8EXObK22smMhwF2fTJCWckW
cMgAnA1lzVEkL4jgZYf5XoF9v49IRJ/M
=REBI
-----END PGP SIGNATURE-----

--Sig_/LOfj972bbxRHDbPpM4zAR8l--
