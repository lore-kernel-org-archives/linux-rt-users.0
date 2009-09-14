From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/6] pi_stress clean-ups, fix hang.
Date: Mon, 14 Sep 2009 16:35:32 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0909141634440.4675@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: williams@redhat.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3905 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbZINOfd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 10:35:33 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8EEZaXN021536
	for <linux-rt-users@vger.kernel.org>; Mon, 14 Sep 2009 10:35:36 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From fdd16e7dc65be18cffbba2bc731c49f8ddd780d7 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 2 Sep 2009 15:31:01 +0200
Subject: [PATCH] Simplify the logic by using the info function

For verbose printing we can make use of the info function, instead of
complicated the logic with if (!quiet)
---
 src/pi_tests/pi_stress.c |   30 ++++++++++++------------------
 1 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index b8db281..2a409cc 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -414,8 +414,7 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 		CPU_ZERO(test_mask);
 		CPU_SET(0, admin_mask);
 		CPU_SET(0, test_mask);
-		if (!quiet)
-			printf("admin and test threads running on one processor\n");
+		info("admin and test threads running on one processor\n");
 		return SUCCESS;
 	}
 
@@ -442,21 +441,20 @@ set_cpu_affinity(cpu_set_t *test_mask, cpu_set_t *admin_mask)
 		error("set_cpu_affinity: setting CPU affinity mask: 0x%x\n", status);
 		return FAILURE;
 	}
-	if (!quiet)
-		printf("Admin thread running on processor: %d\n", i);
+	info("Admin thread running on processor: %d\n", i);
 
 	/* Set test affinity so that tests run on the non-admin processors */
 	CPU_ZERO(test_mask);
 	for (i = admin_proc+1; i < num_processors; i++)
 		CPU_SET(i, test_mask);
 	
-	if (!quiet) {
-		if (admin_proc+1 == num_processors -1)
-			printf("Test threads running on processor: %ld\n", num_processors-1);
-		else
-			printf("Test threads running on processors:  %d-%d\n", 
-			       admin_proc+1, (int)num_processors-1);
-	}
+	if (admin_proc+1 == num_processors -1)
+		info("Test threads running on processor: %ld\n",
+				num_processors-1);
+	else
+		info("Test threads running on processors:  %d-%d\n", 
+				admin_proc+1, (int)num_processors-1);
+
 	return SUCCESS;
 }
 
@@ -543,9 +541,7 @@ reporter(void *arg)
 	}
 
 	debug("reporter: starting report loop\n");
-
-	if (!quiet)
-		printf("Press Control-C to stop test\nCurrent Inversions: \n");
+	info("Press Control-C to stop test\nCurrent Inversions: \n");
 
 	while (shutdown == 0) {
 		// wait for our reporting interval
@@ -565,16 +561,14 @@ reporter(void *arg)
 
 		// if we specified a duration, see if it has expired
 		if (end && time(NULL) > end) {
-			if (!quiet)
-				printf("duration reached (%d seconds)\n", duration);
+			info("duration reached (%d seconds)\n", duration);
 			cleanup();
 			continue;
 		}
 
 		// check for a pending SIGINT
 		if (pending_interrupt()) {
-			if (!quiet)
-				printf("Keyboard Interrupt!\n");
+			info("Keyboard Interrupt!\n");
 			break;
 		}
 
-- 
1.6.0.6

