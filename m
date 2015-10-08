From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] rt-tests-v0.95
Date: Thu, 8 Oct 2015 21:14:15 +0200
Message-ID: <20151008191415.GS3982@pengutronix.de>
References: <alpine.LFD.2.20.1510071533540.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44921 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbbJHTOR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Oct 2015 15:14:17 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1510071533540.14006@riemann>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

[stripping lkml from recipents, guessing they are not that interested i=
n
general in this conversion]

On Wed, Oct 07, 2015 at 03:53:19PM +0200, John Kacur wrote:
> I've pushed a branch for new development, so you can start sending us=
 your=20
> patches, and bug reports.
>=20
> branch: devel/v0.96
I rebased my autoconf conversion on top of this branch. It's available
at

	git://git.pengutronix.de/git/ukl/rt-tests.git convert-to-autoconf

=2E If you want to give that a try and report success or about things I=
've
broken, that would be great.

One thing that is definitely missing is that for bionic all programs ar=
e
tried to be build. Still doing

	make cyclictest

there should work fine.

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
