From: John Kacur <jkacur@redhat.com>
Subject: [PATCH][rt-tests] Revert changes to rt-migrate-test for exit(1)
Date: Thu, 24 Mar 2016 15:28:24 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603241525570.8641@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: lcapitulino@redhat.com
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35503 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbcCXO2m (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 24 Mar 2016 10:28:42 -0400
Received: by mail-wm0-f52.google.com with SMTP id l68so238937255wml.0
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2016 07:28:42 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 607dc3627ab7ff28a116c5bb09058aabddf10f27 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Thu, 24 Mar 2016 15:21:54 +0100
Subject: [PATCH] Revert changes to rt-migrate-test for exit(1)

Commit 3290f8412a4562adbc05b38d8e5212090e41587e changed
exit(-1) to exit(1) for many programs in rt-tests for consistency.

rt-migrate-test needs tri-state exit statuses, because of the way
some existing bash scripts consume it's results.

This could no-doubt be improved in the future, and there are some
inconsistencies in the exit statuses in this program alone, but as they
are not urgent to fix, and the current fix makes things worse, reverting
this for now.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index e18beca816aa..d7b68ddac3e5 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -138,7 +138,7 @@ static void perr(char *fmt, ...)
 
 	perror(buffer);
 	fflush(stderr);
-	exit(1);
+	exit(-1);
 }
 
 static void print_progress_bar(int percent)
@@ -226,6 +226,7 @@ static void parse_options (int argc, char *argv[])
 			break;
 		}
 	}
+
 }
 
 static unsigned long long get_time(void)
@@ -603,7 +604,7 @@ int main (int argc, char **argv)
 			exit(1);
 	}
 	if (check < 0)
-		exit(1);
+		exit(-1);
 	else
 		exit(0);
 
-- 
2.4.3

