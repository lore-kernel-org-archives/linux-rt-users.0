Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC28C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Dec 2021 19:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhLHTvb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Dec 2021 14:51:31 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:53454 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhLHTvb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Dec 2021 14:51:31 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C3FD01C0B77; Wed,  8 Dec 2021 20:47:57 +0100 (CET)
Date:   Wed, 8 Dec 2021 20:47:56 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     Pavel Machek <pavel@denx.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [ANNOUNCE] 5.10.83-rt58
Message-ID: <20211208194756.GA4909@duo.ucw.cz>
References: <YalDQe/lyXqAxB0K@uudg.org>
 <20211208144231.GA323@amd>
 <CAD8J--8kORPik0q_L3+D0WStMh5oVfo8fVau3z5uJrU6v+hPyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <CAD8J--8kORPik0q_L3+D0WStMh5oVfo8fVau3z5uJrU6v+hPyw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > I'm pleased to announce the 5.10.83-rt58 stable release.
> > >
> > > This release is just an update to the new stable 5.10.83
> > > version and no RT specific changes have been made.
> >
> > Thank you. CIP project started doing 5.10.X based releases, and we
> > include -rt tree, too. To make my job tiny bit easier, would it be
> > possible to CC: pavel@denx.de on release announcemnts?
>=20
> I am adding you to the list of default recipients for the announce
> emails.

Thank you!

> Would you like to receive notifications for the
> (RT-specific)
> RC releases too? We use the RC release as a staging area to review
> RT-only patches, either backported from newer RT kernels or fixing
> bugs specific to that version.

Thanks for an offer but that will not be neccessary.

Best regards,
								Pavel

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYbEL7AAKCRAw5/Bqldv6
8kLVAJ9zKB+7e6uQiKuXA0OkDRTk0n/TDgCgjcScVuPhRkpChQNVYcATKnmqz2Y=
=0oy1
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
