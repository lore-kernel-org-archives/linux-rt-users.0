From: Clark Williams <williams@redhat.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sun, 19 Sep 2010 10:49:16 -0500
Message-ID: <20100919104916.63967cc4@riff>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
	<AANLkTint6iHc6DPeEVpKd0ER0XsYMDK=0yiekHGkWtWF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/CyM9KWtGNgRQBKH7FDHj5Du"; protocol="application/pgp-signature"
Cc: Daniel James <daniel@64studio.com>, John Kacur <jkacur@redhat.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52766 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab0ISPtk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Sep 2010 11:49:40 -0400
In-Reply-To: <AANLkTint6iHc6DPeEVpKd0ER0XsYMDK=0yiekHGkWtWF@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/CyM9KWtGNgRQBKH7FDHj5Du
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 18 Sep 2010 15:24:18 -0400
jordan <triplesquarednine@gmail.com> wrote:

> > Being a release or two behind the bleeding edge is no bad thing for that
> > type of user either - if (for instance) 2.6.31-rt works fine in a
> > production audio system, there's no big hurry to change it and
> > potentially break stuff. For that sort of user, high availability is
> > much more important than squeezing every last drop of performance out of
> > the hardware.
>=20
> true enough. 2.6.32 and 2.6.33 are much nicer though...

I'll second this sentiment. We were going to to release a new realtime
kernel with the .31 series, but testing showed that it had some
significant regressions in terms of event response time and in overall
throughput, so we held off. The .33 series is much better in those
regards and that's what we'll be going out with in our next release.=20

>=20
> > In audio recording, we're potentially capturing once-in-a-lifetime or
> > one-time-ever events, particularly since the industry focus has shifted
> > from the studio to the live stage - whether TV, stadium or festival,
> > that's where the artists are making their living these days. Even
> > festivals run to tight schedules, with only 15 minutes allowed to switch
> > between acts, including moving all the gear and repatching it. You can't
> > ask the band to go and get a beer while you recompile your kernel :-)
>=20
> Ideally, no one would ever be compiling the kernel at a show, lol. I
> know I never would! lol....that's hilarious.
> You do that stuff on your own time!  Artists have always made their
> money live, and through merchandise. Record sales go into the Label's
> pockets for the most part.
>=20

Heh. I haven't actually compiled a kernel on stage, but a friend of
mine reworked a play's audio track 20 minutes before curtain when the
Windows box ate it's disk; he booted up his Linux laptop and ran the
sound sequencer program in a QEMU instance. I think I'd rather rebuild
a kernel under the gun :).


--Sig_/CyM9KWtGNgRQBKH7FDHj5Du
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAkyWMQAACgkQHyuj/+TTEp0dfgCg1f8ikY0j+IcThOWIyFmNB9Vp
N78AnRZSEyfHln6EKiTzaXAB74OzfBoo
=y81Y
-----END PGP SIGNATURE-----

--Sig_/CyM9KWtGNgRQBKH7FDHj5Du--
