From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/3] Makefile: don't use temporary files in generation of
	dependency files
Date: Mon, 1 Mar 2010 21:50:49 +0100
Message-ID: <520f0cf11003011250q458e49f4x79be3df05ce8193f@mail.gmail.com>
References: <20100224165611.GA22159@pengutronix.de>
	 <1267030688-12244-3-git-send-email-u.kleine-koenig@pengutronix.de>
	 <520f0cf11003011139v298f7603oe39a70c649875360@mail.gmail.com>
	 <20100301201157.GJ16049@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: =?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f220.google.com ([209.85.219.220]:52627 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0CAUuw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Mar 2010 15:50:52 -0500
Received: by ewy20 with SMTP id 20so1556496ewy.21
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Mar 2010 12:50:51 -0800 (PST)
In-Reply-To: <20100301201157.GJ16049@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2010/3/1 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hey Clark,
>
> I updated my tree to contain John's Acks, so if you want to pull ...
>
> The changelogs are slightly improved since submission and the patch
>
> =A0 =A0 =A0 =A0install backfire.c to $(srcdir)/backfire/
>
> is skipped for now as John didn't understand it (yet).

Well, I would phrase it a tad differently. We're discussing what the
best way is to deliver this, since it doesn't quite fit in to the rest
of the package. However, at least for now,
Acked-by: John Kacur <jkacur@redhat.com>

>
> Best regards
> Uwe
>
> The following changes since commit 73d48f4e04684a376b41525bfed030b767=
1f03f7:
> =A0Clark Williams (1):
> =A0 =A0 =A0 =A0version bump to 0.66
>
> are available in the git repository at:
>
> =A0git://git.pengutronix.de/git/ukl/rt-tests.git for-clark
>
> Uwe Kleine-K=F6nig (3):
> =A0 =A0 =A0trivial: fix typo: "specifed" -> "specified"
> =A0 =A0 =A0Makefile: don't use temporary files in generation of depen=
dency files
> =A0 =A0 =A0rename pip to pip_stress as pip is too general
>
> =A0.gitignore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A02 +-
> =A0Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |=
 =A0 =A09 +++------
> =A0src/cyclictest/cyclictest.8 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0src/include/{pip.h =3D> pip_stress.h} =A0| =A0 =A07 +++----
> =A0src/pi_tests/{pip.c =3D> pip_stress.c} | =A0 10 +++++-----
> =A05 files changed, 13 insertions(+), 17 deletions(-)
> =A0rename src/include/{pip.h =3D> pip_stress.h} (93%)
> =A0rename src/pi_tests/{pip.c =3D> pip_stress.c} (98%)
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
| Uwe Kleine-K=F6nig =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://w=
ww.pengutronix.de/ =A0|
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
