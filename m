From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH v2 0/4] cyclictest: improve running under trace-cmd
Date: Thu, 17 Mar 2016 14:30:13 -0400
Message-ID: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59273 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964784AbcCQSaZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 14:30:25 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id C2E94627C0
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 18:30:24 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


In short, this series allows you to run cyclictest under
trace-cmd and still get trace marks when the latency
specified with -b is execeded. More details in patch 4/4.

o v2

 - rebase against current master

Luiz Capitulino (4):
  cyclictest: tracing(): check for notrace
  cyclictest: move debugfs init code to its own function
  cyclictest: move tracemark_fd handling to its own function
  cyclictest: add --tracemark option

 src/cyclictest/cyclictest.c | 62 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

-- 
2.1.0
