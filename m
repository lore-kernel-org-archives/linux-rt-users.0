Return-Path: <SRS0=v1XI=UX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13C9C43613
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97A520820
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jun 2019 10:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfFXKxo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:53:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:45954 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbfFXKxo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jun 2019 06:53:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 84BD580583; Mon, 24 Jun 2019 12:53:30 +0200 (CEST)
Date:   Mon, 24 Jun 2019 12:53:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, mwhitehe@redhat.com
Subject: Re: PREEMPT_RT_FULL on x86-32 machine
Message-ID: <20190624105340.GA21414@amd>
References: <20190622081954.GA10751@amd>
 <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <2804bc5b-18c1-2793-171c-045c0725a6a7@siemens.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >Is full preemption supposed to work on x86-32 machines?
> >
> >Because it does not work for me. It crashes early in boot, no messages
> >make it to console. Similar configuration for x86-64 boots ok.
> >
>=20
> Maybe you can also tell which version(s) you tried, and in which
> configuration(s), and how the crash looked like.

I wanted to know if the configuration is supposed to work at all
before starting heavy debugging. From your reply I assume that it
should work.

I tried 4.19.13-rt1-cip1 among others. Crash is early in boot, I can
try some early printing...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Qq7QACgkQMOfwapXb+vJyDACeP59RoR7aVylUsn23lBsPwPI+
qlcAoJKBq4fQiNWjs1QKL6ElJCSlVJGi
=oK2q
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
