Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE61C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 17:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA67160F58
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Aug 2021 17:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhHTRxm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 13:53:42 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58284 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234977AbhHTRxl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Aug 2021 13:53:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2E5F11C0B81; Fri, 20 Aug 2021 19:53:02 +0200 (CEST)
Date:   Fri, 20 Aug 2021 19:53:01 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.277-rt224
Message-ID: <20210820175301.GA4791@amd>
References: <162762714720.5121.4789079771844033633@beryllium.lan>
 <20210820104328.GA30359@amd>
 <20210820110716.zmh7te5dvmndssgm@carbon.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20210820110716.zmh7te5dvmndssgm@carbon.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Sorry for the long delay. I was refactoring and improving my test
> > > setup which took a bit longer than I expected. I switched from a
> > > Debian based rootfs to an Tumbleweed based one, for obvious
> > > reasons. Anyway, this should not matter at all.
> >=20
> > A bit late thanks for the release, BTW. We are maintaining -cip-rt
> > based kernels, and were getting worried :-).
>=20
> Sorry about that. I should have send out a note earlier. Anyway, I'll
> plan to work on the next update soon. There are a few futex changes
> which collide. It's going to be interesting.

FYI we are on 2 month cycle for -cip-rt, so we are still fine for a
while. We had trouble coordinating matching -cip and -rt releases, but
we decided to adjust -cip cycle to match -rt, so that should be solved.

> BTW, as you certainly are aware, the v4.4 kernel is EOL soon. As I
> understand the CIP is going to take over the maintenance. So I assume
> you are going to care of the -rt version as well?

We are aware, but I don't think we decided what will happen at that
point (and I can't really speak for the project). We plan to maintain
-cip and -cip-rt variants till 2027:

https://wiki.linuxfoundation.org/civilinfrastructureplatform/start

Taking over -stable and -stable-rt maintainance, too, is something
that may make sense (and we probably will be considered), but it is
likely CIP Technical Steering Committee's (=E2=80=9CTSC=E2=80=9D) decision.

https://www.cip-project.org/about/charter

Actually, your input may be important here. If you (or SuSE or someone
else) can put some resources into 4.4-rt after February 2022, that
would be good to know.

Best regards,
								Pavel
(Again I don't speak for the project)
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEf6/0ACgkQMOfwapXb+vKr9QCfSMKU8lyWcYmPMt3No2qwvl0U
FBQAnj1yxubb6hjWegdwFNTFP+Czhlo2
=oB7E
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
