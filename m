From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 0/7] RFC v1: add support for tilegx and (partial) android support to rt-test
Date: Fri, 18 Sep 2015 18:52:43 +0200
Message-ID: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-4.cisco.com ([173.38.203.54]:8280 "EHLO
	aer-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbbIRRE1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 13:04:27 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

So this is an attempt to consolidate some of the changes we've added to
rt-test to use rt-test. It adds support for TileGx, and a subset of the
binaries for android (cyclictest and hackbench to be precise).

They will probably need some more work, any feedback is welcome

Henrik Austad (7):
  Add CROSS_COMPILE-switch to CC and AR
  Add syscall-number for sched_(gs)etattr() for tile
  Add a rebuild-switch to Makefile
  Fix compile-warnings
  Makefile: add librttest to rt-migrate-test
  rt_test.h: add numa_available() for !NUMA
  android: adjust target for android

 Makefile                              | 37 ++++++++++++++++++++++--
 src/backfire/sendme.c                 |  8 ++++--
 src/cyclictest/cyclictest.c           | 53 ++++++++++++++++++++++++++++-------
 src/cyclictest/rt_numa.h              |  1 +
 src/include/rt-sched.h                |  5 ++++
 src/pmqtest/pmqtest.c                 |  3 +-
 src/ptsematest/ptsematest.c           |  3 +-
 src/rt-migrate-test/rt-migrate-test.c |  5 ++--
 src/signaltest/signaltest.c           | 25 ++++++++++-------
 src/sigwaittest/sigwaittest.c         |  8 ++++--
 src/svsematest/svsematest.c           |  9 ++++--
 11 files changed, 125 insertions(+), 32 deletions(-)

-- 
1.9.1

