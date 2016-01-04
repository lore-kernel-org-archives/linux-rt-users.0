From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a
 value
Date: Mon, 4 Jan 2016 17:25:07 +0100
Message-ID: <20160104162507.GE28361@pengutronix.de>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
 <20160104133903.GG92593@unpythonic.net>
 <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff Epler <jepler@unpythonic.net>, williams@redhat.com,
	jkacur@redhat.com, linux-rt-users@vger.kernel.org
To: Khem Raj <raj.khem@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:53004 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371AbcADQZP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2016 11:25:15 -0500
Content-Disposition: inline
In-Reply-To: <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 04, 2016 at 08:20:01AM -0800, Khem Raj wrote:
>=20
> > On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> wrot=
e:
> >=20
> > I believe the patch does not have the desired effect, because make(=
1)
> > always sets CC automatically:
> >=20
> > $ cat raj.mk
> > CROSS_COMPILE=3Dx86_64-linux-gnu-
> > CC?=3D$(CROSS_COMPILE)gcc
> > .PHONY: default
> > default:
> > 	@echo CC=3D$(CC)
> > $ make -f raj.mk
> > CC=3Dcc
> >=20
> > With your patch, those who specify CROSS_COMPILE, or for whom gcc a=
nd cc
> > are different, will get different (worse) behavior.
>=20
> Right. I think if CC was used as such with out constructing out of CR=
OSS_COMPILE
> in Makefile then my issue would be fixed too. However this would mean=
 that cross compiling users
> now have to pass CC =3D <cross-compiler> themselves instead of CROSS_=
COMPILE prefix. Is that
> acceptable ?

You could play with something like:

ifeq($(origin CC),default)
CC=3D$(CROSS_COMPILE)gcc
endif

but not sure I'd like the result. If you asked me, I'd drop all that
CROSS_COMPILE stuff.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
