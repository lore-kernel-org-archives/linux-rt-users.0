Return-Path: <SRS0=fwOa=AZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F57C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 18:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E1A2071B
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 18:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgGNSfP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:35:15 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48932 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGNSfP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jul 2020 14:35:15 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 634131C0BD5; Tue, 14 Jul 2020 20:35:13 +0200 (CEST)
Date:   Tue, 14 Jul 2020 20:35:12 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.19.132-rt59
Message-ID: <20200714183512.GA18816@duo.ucw.cz>
References: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

>=20
> I'm pleased to announce the 4.19.132-rt59 stable release.
>=20
> This release is just an update to the new stable 4.19.132
> version and no RT specific changes have been made.
>=20
> You can get this release via the git tree at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>=20
>   branch: v4.19-rt
>   Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe
>=20
> Or to build 4.19.132-rt59 directly, the following patches should be
> applied:

Thanks a lot.

But now I am confused, I completely missed announcements for
v4.19.127-rt55 to v4.19.131-rt58.

And for example -rt56 is not listed in

https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/4.19/older/sha=
256sums.asc

=2E..aha, and the versions do not have signed tags, either:

pavel@amd:~/cip/k$ git show v4.19.131-rt58
fatal: ambiguous argument 'v4.19.131-rt58': unknown revision or path not in=
 the working tree.

Is that because they were created just as quick steps towards -rt59?

Best regards,
							Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXw364AAKCRAw5/Bqldv6
8rOPAJ9qkGbTCIP1F9HTh+ef752cxTiLZACcCjVOsvnHNrg5exKcv5zgou5X9Xc=
=QjTP
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
