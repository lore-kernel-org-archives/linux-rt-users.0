Return-Path: <SRS0=PqXR=UV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE2BC48BE8
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jun 2019 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEAC2089C
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jun 2019 08:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbfFVIT4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:19:56 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37996 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfFVIT4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 22 Jun 2019 04:19:56 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9B4E780641; Sat, 22 Jun 2019 10:19:43 +0200 (CEST)
Date:   Sat, 22 Jun 2019 10:19:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     linux-rt-users@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     mwhitehe@redhat.com
Subject: PREEMPT_RT_FULL on x86-32 machine
Message-ID: <20190622081954.GA10751@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Is full preemption supposed to work on x86-32 machines?

Because it does not work for me. It crashes early in boot, no messages
make it to console. Similar configuration for x86-64 boots ok.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0N5KoACgkQMOfwapXb+vLL3ACfYdFNE/2j8TtFhMdFMIBE3NkQ
ubEAn1cIiuJM7MuSpTMT2zpeBzwVPEQW
=9u/C
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
