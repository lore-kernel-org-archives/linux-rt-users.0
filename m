From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/2] Debian's rt-tests patches
Date: Thu, 1 Jul 2010 07:24:30 +0200
Message-ID: <20100701052430.GB28535@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37112 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0GAFYc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Jul 2010 01:24:32 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

here come two patches I use for packaging rt-tests for Debian.  Actuall=
y
I have two more patches[*1*], but one of them is Debian specific
and the other one installs hwlatdetect to /usr/sbin instead of
/usr/lib/pythonX.Y/site-packages + a symlink as this confuses debhelper=
=2E
Maybe the right approach is to install a script to /usr/sbin that just
does

	exec python -m hwlatdetect

?!  Another thing I do in the Debian packages is using dkms for buildin=
g
the backfire kernel module at install time.  I don't know how this
works with Redhat's Linux distributions though.

I'll send the two patches that I think are ready for you to include as =
a
reply to this mail.  Diffstat, shortlog and an URL to pull these two ar=
e
included below.

Best regards
Uwe

[*1*] see http://patch-tracker.debian.org/package/rt-tests/0.71-1

The following changes since commit 886d26833d637ab778023626a158061e4eb9=
c5d0:

  version bump to 0.72 (2010-06-25 16:16:46 -0500)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/rt-tests.git for-clark

Uwe Kleine-K=F6nig (2):
      modernize backfire's Makefile
      install backfire's Makefile

 Makefile              |    1 +
 src/backfire/Makefile |   21 ++++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

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
