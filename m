From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 0/4] rt-tests: minor fixes
Date: Wed, 24 Feb 2016 15:49:37 -0500
Message-ID: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: williams@redhat.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755313AbcBXUto (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 15:49:44 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id C61F9C00B8F1
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2016 20:49:43 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I've found these little things while reading the code and
building rt-tests. They are all minor, but I'm sending
them anyways.

Luiz Capitulino (4):
  pip_stress: drop unused variable
  rt-migrate-test: fix return code
  don't use exit(-1) for failures
  cyclictest: initialize 'stop' early

 src/cyclictest/cyclictest.c           |  4 +++-
 src/pi_tests/pi_stress.c              |  2 +-
 src/pi_tests/pip_stress.c             |  7 +++----
 src/rt-migrate-test/rt-migrate-test.c | 12 ++++++------
 src/signaltest/signaltest.c           |  2 +-
 5 files changed, 14 insertions(+), 13 deletions(-)

-- 
2.1.0
