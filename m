Return-Path: <SRS0=GyRq=5E=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0331C4332E
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 23:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3992076C
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Mar 2020 23:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCSXWc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Mar 2020 19:22:32 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43782 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCSXWc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Mar 2020 19:22:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1910A1C0320; Fri, 20 Mar 2020 00:22:30 +0100 (CET)
Date:   Fri, 20 Mar 2020 00:22:25 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        ben.hutchings@codethink.co.uk, Chris.Paterson2@renesas.com,
        bigeasy@linutronix.de
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: 4.19.106-rt44 -- boot problems with irqwork: push most work into
 softirq context
Message-ID: <20200319232225.GA7878@duo.ucw.cz>
References: <20200228170837.3fe8bb57@gandalf.local.home>
 <20200319214835.GA29781@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20200319214835.GA29781@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu 2020-03-19 22:48:35, Pavel Machek wrote:
> Hi!
>=20
> > I'm pleased to announce the 4.19.106-rt44 stable release.
> >=20
> >=20
> > This release is just an update to the new stable 4.19.106 version
> > and no RT specific changes have been made.
> >=20
> >=20
> > You can get this release via the git tree at:
> >=20
> >   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> >=20
> >   branch: v4.19-rt
> >   Head SHA1: 0f2960c75dd68d339f0aff2935f51652b5625fbf
>=20
> This brought some problems for me. de0-nano board now fails to boot in
> cca 50% of cases if I move these patches on top of -cip tree.
>=20
> This is example of failed job:
>=20
> https://lava.ciplatform.org/scheduler/job/13037
>=20
> de0-nano is 32-bit arm, should be based on Altera SoCFPGA if I understand
> things correctly.
>=20
> "fc9f4631a290 irqwork: push most work into softirq context" touches
> area of the panic above. I tried to revert it on top of the full
> series, and tests passed twice so far...

Test passed 7 times now. So yes, reverting this fixes de0-nano
boot. Any ideas what might be wrong?

I'll be running it few more times.

https://gitlab.com/cip-project/cip-kernel/linux-cip/pipelines/127953471

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXnP+sQAKCRAw5/Bqldv6
8o9IAJ9jvIADInaCXP9F/avhH2UBquZc1wCZAZUJP58ybTLpilfer1ebbkOX5Qg=
=mlYB
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
