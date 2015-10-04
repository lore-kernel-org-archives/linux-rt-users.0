From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests 0/3] autotools for rt-tests 0.94+
Date: Sun,  4 Oct 2015 12:48:40 +0200
Message-ID: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Henrik Austad <haustad@cisco.com>, Josh Cartwright <joshc@ni.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55314 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363AbbJDK5J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 4 Oct 2015 06:57:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I rebased and improved the conversion from plain-make to autoconf.  The
first two patches should be fine to take even if autotools isn't
considered for now.

=46or the details of the conversion check the commit log of the third
patch. The changes to scripts/do-git-push are hardly tested.

If you have questions or test reports, don't hesitate to contact me.

Uwe Kleine-K=C3=B6nig (3):
  backfire: remove unused header file
  remove several unused Makefiles
  convert build system to autotools

 .gitignore                            |  21 +++
 Makefile                              | 270 --------------------------=
-
 Makefile.am                           | 112 ++++++++++++
 configure.ac                          |  58 ++++++
 m4/.gitignore                         |   5 +
 m4/ax_pthread.m4                      | 332 ++++++++++++++++++++++++++=
++++++++
 scripts/do-git-push                   |   4 +-
 src/backfire/sendme.c                 |   4 +-
 src/backfire/version.h                |   1 -
 src/cyclictest/cyclictest.c           |   7 +-
 src/hackbench/Makefile                |   5 -
 src/pi_tests/Makefile                 |  71 --------
 src/pi_tests/pi_stress.c              |   4 +-
 src/pmqtest/Makefile                  |  16 --
 src/pmqtest/pmqtest.c                 |   4 +-
 src/ptsematest/Makefile               |  16 --
 src/ptsematest/ptsematest.c           |   4 +-
 src/rt-migrate-test/rt-migrate-test.c |   4 +-
 src/signaltest/signaltest.c           |   3 +-
 src/sigwaittest/Makefile              |  17 --
 src/sigwaittest/sigwaittest.c         |   3 +-
 src/svsematest/Makefile               |  16 --
 src/svsematest/svsematest.c           |   4 +-
 23 files changed, 556 insertions(+), 425 deletions(-)
 delete mode 100644 Makefile
 create mode 100644 Makefile.am
 create mode 100644 configure.ac
 create mode 100644 m4/.gitignore
 create mode 100644 m4/ax_pthread.m4
 delete mode 100644 src/backfire/version.h
 delete mode 100644 src/hackbench/Makefile
 delete mode 100644 src/pi_tests/Makefile
 delete mode 100644 src/pmqtest/Makefile
 delete mode 100644 src/ptsematest/Makefile
 delete mode 100644 src/sigwaittest/Makefile
 delete mode 100644 src/svsematest/Makefile

--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
