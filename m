From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH v2 0/3] rt-tests: minor fixes
Date: Thu, 17 Mar 2016 14:29:02 -0400
Message-ID: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40625 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964832AbcCQS3K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 14:29:10 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id CF3FC7F0B5
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 18:29:09 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I've found these little things while reading the code and
building rt-tests. They are all minor, but I'm sending
them anyways.

o v2

 - rebase on top of current master
 - drop already merged patch

Luiz Capitulino (3):
  rt-migrate-test: fix return code
  don't use exit(-1) for failures
  cyclictest: initialize 'stop' early

 src/cyclictest/cyclictest.c           | 4 +++-
 src/pi_tests/pi_stress.c              | 2 +-
 src/pi_tests/pip_stress.c             | 6 +++---
 src/rt-migrate-test/rt-migrate-test.c | 9 ++++-----
 src/signaltest/signaltest.c           | 2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.1.0
