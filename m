From: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: [PATCH 0/4] Add cyclicload testtool support
Date: Thu, 30 Aug 2012 15:26:43 +0530
Message-ID: <1346320607-6691-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <Poonam.Aggrwal@freescale.com>,
	Priyanka Jain <Priyanka.Jain@freescale.com>
To: <jkacur@redhat.com>, <williams@redhat.com>,
	<frank.rowand@am.sony.com>, <linux-rt-users@vger.kernel.org>,
	<dvhart@linux.intel.com>, <Rajan.Srivastava@freescale.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:1444
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307Ab2H3J56 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 Aug 2012 05:57:58 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

*** BLURB HERE ***

Cyclicload test-tool is designed to simulate
load in form of one or two load threads.
It uses cyclictest as its base code.

But as cyclictest and cyclicload are targeted
for different test cases, cyclicload is coded as separate tool.
For easy code maintenance, source code of cyclictest is first
duplicated as cyclicload code and then calibration and load generation
logic has been added above that.
Plan is to move common code to library later on.

Developed against
	git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
	commitID: 857cdd5320ce1f293f5dbcbec79cc8fe22b0bebf

Priyanka Jain (4):
  Add README for cyclicload test tool
  Duplicates cyclictest code as cyclicload
  Add cyclicload calibration & load generation feature
  Add cyclicload manual page

 Makefile                    |    7 +-
 src/cyclicload/README       |  273 ++++++
 src/cyclicload/cyclicload.8 |  206 ++++
 src/cyclicload/cyclicload.c | 2259 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 2744 insertions(+), 1 deletions(-)
 create mode 100644 src/cyclicload/README
 create mode 100644 src/cyclicload/cyclicload.8
 create mode 100644 src/cyclicload/cyclicload.c

-- 
1.7.4.1



