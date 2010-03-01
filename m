From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/3] Makefile: don't use temporary files in generation
	of dependency files
Date: Mon, 1 Mar 2010 21:11:57 +0100
Message-ID: <20100301201157.GJ16049@pengutronix.de>
References: <20100224165611.GA22159@pengutronix.de> <1267030688-12244-3-git-send-email-u.kleine-koenig@pengutronix.de> <520f0cf11003011139v298f7603oe39a70c649875360@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38266 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307Ab0CAU00 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 15:26:26 -0500
Content-Disposition: inline
In-Reply-To: <520f0cf11003011139v298f7603oe39a70c649875360@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Clark,

I updated my tree to contain John's Acks, so if you want to pull ...

The changelogs are slightly improved since submission and the patch=20

	install backfire.c to $(srcdir)/backfire/

is skipped for now as John didn't understand it (yet).

Best regards
Uwe

The following changes since commit 73d48f4e04684a376b41525bfed030b7671f=
03f7:
  Clark Williams (1):
        version bump to 0.66

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/rt-tests.git for-clark

Uwe Kleine-K=F6nig (3):
      trivial: fix typo: "specifed" -> "specified"
      Makefile: don't use temporary files in generation of dependency f=
iles
      rename pip to pip_stress as pip is too general

 .gitignore                           |    2 +-
 Makefile                             |    9 +++------
 src/cyclictest/cyclictest.8          |    2 +-
 src/include/{pip.h =3D> pip_stress.h}  |    7 +++----
 src/pi_tests/{pip.c =3D> pip_stress.c} |   10 +++++-----
 5 files changed, 13 insertions(+), 17 deletions(-)
 rename src/include/{pip.h =3D> pip_stress.h} (93%)
 rename src/pi_tests/{pip.c =3D> pip_stress.c} (98%)

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
