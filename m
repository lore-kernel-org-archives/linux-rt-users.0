From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/2] rt-tests: Housekeeping
Date: Fri, 13 May 2016 15:11:51 +0200
Message-ID: <1463145113-9025-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36413 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbcEMNMI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 13 May 2016 09:12:08 -0400
Received: by mail-wm0-f54.google.com with SMTP id n129so22203431wmn.1
        for <linux-rt-users@vger.kernel.org>; Fri, 13 May 2016 06:12:06 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Just doing a little housekeeping before releasing rt-tests-1.0

John Kacur (2):
  rt-tests: Add missing option to hwlatdetect man page
  rt-tests: Housekeeping fix some spelling errors.

 src/backfire/sendme.8         |  2 +-
 src/hwlatdetect/hwlatdetect.8 | 12 ++++++++----
 src/pi_tests/pi_stress.8      |  2 +-
 src/pmqtest/pmqtest.8         |  4 ++--
 src/ptsematest/ptsematest.8   |  6 +++---
 src/signaltest/signaltest.8   |  2 +-
 src/sigwaittest/sigwaittest.8 |  8 ++++----
 src/svsematest/svsematest.8   |  6 +++---
 8 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.4.11

