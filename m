From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt-tests 2/3] rt-migrate-test: remove space before \n
Date: Mon,  5 Oct 2015 21:05:16 +0200
Message-ID: <1444071917-1450-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: williams@redhat.com
To: linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arcturus.kleine-koenig.org ([78.47.169.190]:55413 "EHLO
	arcturus.kleine-koenig.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751409AbbJETF2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 15:05:28 -0400
In-Reply-To: <1444071917-1450-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This fixes a checkpatch warning

	WARNING: unnecessary whitespace before a quoted newline
---
 src/rt-migrate-test/rt-migrate-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 85a78dab7403..d7b68ddac3e5 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -178,7 +178,7 @@ static void usage(char **argv)
 	printf("%s %1.2f\n", p, VERSION);
 	printf("Usage:\n"
 	       "%s <options> nr_tasks\n\n"
-	       "-p prio --prio  prio        base priority to start RT tasks with (2) \n"
+	       "-p prio --prio  prio        base priority to start RT tasks with (2)\n"
 	       "-r time --run-time time     Run time (ms) to busy loop the threads (20)\n"
 	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
 	       "-m time --maxerr time       Max allowed error (microsecs)\n"
-- 
2.1.4

