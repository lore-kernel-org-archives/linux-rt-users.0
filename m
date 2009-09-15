From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] A few more miscellaneous clean-ups.
Date: Tue, 15 Sep 2009 10:25:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909151023580.4591@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:64181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241AbZIOIZB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 15 Sep 2009 04:25:01 -0400
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8F8P5bf006152
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2009 04:25:05 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From b5a062ad7668587f7bd53b7aea9bc9cea6034165 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 15 Sep 2009 10:12:00 +0200
Subject: [PATCH] A few more miscellaneous clean-ups.

---
 src/pi_tests/pi_stress.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index c250d47..83e5727 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -216,7 +216,7 @@ struct group_parameters {
 
 } *groups;
 
-// /* of consecutive watchdog hits before quitting */
+/* of consecutive watchdog hits before quitting */
 #define WATCHDOG_LIMIT 5
 
 /* number of online processors */
@@ -257,7 +257,7 @@ main (int argc, char **argv)
 	int core;
 	int nthreads;
 
-	/* Make sure we see all message, even those on stdout.  */
+	/* Make sure we see all messages, even those on stdout.  */
 	setvbuf (stdout, NULL, _IONBF, 0);
 
 	/* get the number of processors */
@@ -640,7 +640,7 @@ low_priority(void *arg)
 
 	for(;;) {
 		/*
-		 * We can't set the 'loop' boolean here, because some flags
+		 * We can't set the 'loop' boolean here, because some threads
 		 * may have already reached the loop_barr
 		 */
 		if (!unbounded && (p->total >= p->inversions)) {
-- 
1.6.0.6

