From: David Sommerseth <davids@redhat.com>
Subject: [PATCH 0/4] Minor rt-tests updates
Date: Tue, 22 Dec 2009 16:47:34 +0100
Message-ID: <1261496858-12744-1-git-send-email-davids@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com,
	David Sommerseth <davids@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14648 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445AbZLVPrk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Dec 2009 10:47:40 -0500
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBMFle33029509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2009 10:47:40 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Several minor updates cleaning up arguments and man page.

David Sommerseth (4):
  Fixed missing parsing of short arguments in classic_pi
  Missing parsing of --mlockall in signaltest
  Added --help screen info about -M / --refresh-on-max in cyclictest
  Updated man page to reflect --refresh-on-max argument name change

 src/cyclictest/cyclictest.8 |    2 +-
 src/cyclictest/cyclictest.c |    3 ++-
 src/pi_tests/classic_pi.c   |    2 +-
 src/signaltest/signaltest.c |    1 +
 4 files changed, 5 insertions(+), 3 deletions(-)

