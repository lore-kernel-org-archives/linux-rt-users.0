From: John Kacur <jkacur@redhat.com>
Subject: [PATCH]Fix minor grammar mistake in the help output
Date: Tue, 3 Mar 2015 14:48:50 +0100 (CET)
Message-ID: <alpine.LFD.2.10.1503031442080.5674@riemann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:40342 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbbCCNtH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Mar 2015 08:49:07 -0500
Received: by wghl18 with SMTP id l18so40089217wgh.7
        for <linux-rt-users@vger.kernel.org>; Tue, 03 Mar 2015 05:49:05 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From ddc409343e19cb2bbc75869a18cbf9b8a5343f31 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Tue, 3 Mar 2015 14:17:57 +0100
Subject: [PATCH] Fix minor grammar mistake in the help output

Change "quick" to quicker, so the help message reads
-c    --check               Stop if lower prio task is quicker than
higher (off)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 67e1e6c82fe4..fc6fd81ba9ca 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -186,7 +186,7 @@ static void usage(char **argv)
 	       "-s time --sleep-time time   Sleep time (ms) between intervals (100)\n"
 	       "-m time --maxerr time       Max allowed error (microsecs)\n"
 	       "-l loops --loops loops      Number of iterations to run (50)\n"
-	       "-c    --check               Stop if lower prio task is quick than higher (off)\n"
+	       "-c    --check               Stop if lower prio task is quicker than higher (off)\n"
 	       "  () above are defaults \n",
 		p);
 	exit(0);
-- 
1.8.3.1


