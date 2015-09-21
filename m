From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 0/6]  RFC v2: add support for tilegx and (partial) android support to rt-test
Date: Mon, 21 Sep 2015 17:27:22 +0200
Message-ID: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-6.cisco.com ([173.37.142.93]:61554 "EHLO
	alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbIUP3a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:30 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Take 2 on the series for adding cross-compile support to tilegx and 64
bit arm android to rt-test.

v2:
- drop patch for numa_on_available call
- change how makefile calls rebuild (thanks Josh!)
- Rebased onto v0.94-devel

v1:
So this is an attempt to consolidate some of the changes we've added to
rt-test to use rt-test. It adds support for TileGx, and a subset of the
binaries for android (cyclictest and hackbench to be precise).

They will probably need some more work, any feedback is welcome

Henrik Austad (6):
  Add CROSS_COMPILE-switch to CC and AR
  Add syscall-number for sched_(gs)etattr() for tile
  Add a rebuild-switch to Makefile
  Fix compile-warnings
  Makefile: add librttest to rt-migrate-test
  android: adjust target for android

 Makefile                              | 38 ++++++++++++++++++++++--
 src/backfire/sendme.c                 |  8 +++--
 src/cyclictest/cyclictest.c           | 55 ++++++++++++++++++++++++++++-------
 src/include/rt-sched.h                |  5 ++++
 src/pmqtest/pmqtest.c                 |  3 +-
 src/ptsematest/ptsematest.c           |  3 +-
 src/rt-migrate-test/rt-migrate-test.c |  5 ++--
 src/signaltest/signaltest.c           | 25 +++++++++-------
 src/sigwaittest/sigwaittest.c         |  8 +++--
 src/svsematest/svsematest.c           |  9 ++++--
 10 files changed, 125 insertions(+), 34 deletions(-)

-- 
1.9.1

