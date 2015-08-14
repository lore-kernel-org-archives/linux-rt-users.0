From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] Fix VERSION in rt-migrate-test
Date: Fri, 14 Aug 2015 13:48:27 +0100
Message-ID: <1439556507-28759-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34631 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934AbbHNMsb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Aug 2015 08:48:31 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 5150FA49F8
	for <linux-rt-users@vger.kernel.org>; Fri, 14 Aug 2015 12:48:31 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Change VERSION_STRING to VERSION to get the same version number as the
  the rest of the suite

- Assume that VERSION is defined, instead of replacing it with a
  nonsensical number

- Print the help option in the usage() function

Reported-by: DIXLOR <dixlor@gmail.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index fc6fd81ba9ca..430e992fc066 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -47,10 +47,6 @@
 
 #define gettid() syscall(__NR_gettid)
 
-#ifndef VERSION_STRING
-#define VERSION_STRING 0.3
-#endif
