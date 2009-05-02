From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: patches for rt-tests
Date: Sat, 2 May 2009 20:50:04 +0200
Message-ID: <20090502185004.GA14150@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53618 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbZEBSuJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 May 2009 14:50:09 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Clark,

I fixed some minor issues of rt-tests that I noticed while packaging it
for Debian.  I would be glad if you took them.  (And if you think they
are worth a 0.39, consider pushing the tag, too (hint hint).)

I will send the patches as a reply to this mail for easier review.

The following changes since commit 1b81d40771d977a3eb36dd4f17b7e87e69e5=
777e:
  Clark Williams (1):
        version bump to 0.38

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/rt-tests.git for-clark

Uwe Kleine-K=F6nig (3):
      escape minus signs in manpages
      signaltest: fix typo in copyright header
      Makefile: don't override DESTDIR, prefix, bindir and mandir

 Makefile                    |    8 ++++----
 src/cyclictest/cyclictest.8 |   14 +++++++-------
 src/pi_tests/pi_stress.8    |   16 ++++++++--------
 src/signaltest/signaltest.c |    2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
