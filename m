From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 0/3] rt-tests patches
Date: Wed, 24 Feb 2010 17:56:11 +0100
Message-ID: <20100224165611.GA22159@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40818 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab0BXQ4M (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2010 11:56:12 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

here come a few changes that I came across while preparing the Debian
package for rt-tests 0.66.

I'll send the patches as a reply to this mail.  They are available in m=
y
repository, too, see below.

There is another problem, namely the symlink $(bindir)/hwlatdetect ->
$(PYLIB)/hwlatdetect.py that get's broken by debhelper.  For now I fixe=
d
it up by just installing hwlatdetect.py directly to $(sbindir)[1], but
this isn't suitable for inclusion.  A proper fix would be to split
hwlatdetect in a module and an small program using the module, but I
didn't come around to do that yet.

The following changes since commit 73d48f4e04684a376b41525bfed030b7671f=
03f7:
  Clark Williams (1):
        version bump to 0.66

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/rt-tests.git for-clark

Uwe Kleine-K=F6nig (3):
      trivial: s/specifed/specified/
      install backfire.c to $(srcdir)/backfire/
      Makefile: don't use temporary files in generation of dependency f=
iles

 Makefile                    |    6 ++----
 src/cyclictest/cyclictest.8 |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

[1]
http://patch-tracker.debian.org/patch/series/view/rt-tests/0.66-1/insta=
ll_hwlatdetect_into_sbindir
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
