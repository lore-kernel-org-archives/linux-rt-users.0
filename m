From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 0/4] cyclictest: improve running under trace-cmd
Date: Thu, 25 Feb 2016 11:29:13 -0500
Message-ID: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56559 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760900AbcBYQ3V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 11:29:21 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 2233A5F23
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Feb 2016 16:29:21 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


This is just a repost of my RFC posting with no changes.
I have tested it a bit more and I think it's good
for inclusion.

Original intro:

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
