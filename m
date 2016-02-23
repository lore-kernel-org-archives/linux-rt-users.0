From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [RFC 0/4] cyclictest: improve running under trace-cmd
Date: Tue, 23 Feb 2016 14:43:49 -0500
Message-ID: <1456256633-17639-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318AbcBWTn6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Feb 2016 14:43:58 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id E45FD302482
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2016 19:43:57 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


In short, this series allows you to run cyclictest under
trace-cmd and still get trace marks when the latency
specified with -b is execeded. More details in patch 4/4.

This series is RFC because I'm not completely sure this
is the right thing to do. I'm wondering if we shouldn't
ditch all tracing support from cyclictest...

Luiz Capitulino (4):
  cyclictest: tracing(): check for notrace
  cyclictest: move debugfs init code to its own function
  cyclictest: move tracemark_fd handling to its own function
  cyclictest: add --tracemark option

 src/cyclictest/cyclictest.c | 62 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 15 deletions(-)

-- 
2.1.0
