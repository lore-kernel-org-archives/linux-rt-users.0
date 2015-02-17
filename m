From: Boris Egorov <egorov@linux.com>
Subject: [PATCH v2 2/2] rt-migrate-test: use variables instead of macros
Date: Tue, 17 Feb 2015 23:43:59 +0600
Message-ID: <8bb365bacb11b6ff073af82723df36fc60c6ba53.1424194150.git.egorov@linux.com>
References: <5476FAF2.1060702@linux.com>
 <cover.1424194150.git.egorov@linux.com>
Cc: clark.williams@gmail.com, jkacur@redhat.com, bigeasy@linutronix.de,
	Boris Egorov <egorov@linux.com>
To: 716237@bugs.debian.org, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38535 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbbBQRoU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 12:44:20 -0500
Received: by lbiz11 with SMTP id z11so5929453lbi.5
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 09:44:19 -0800 (PST)
In-Reply-To: <cover.1424194150.git.egorov@linux.com>
In-Reply-To: <cover.1424194150.git.egorov@linux.com>
References: <cover.1424194150.git.egorov@linux.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

By default, static variables run_interval and interval assigned to
macros with corresponding uppercase name, RUN_INTERVAL and INTERVAL.
Later in code we should only use these variables to properly handle
options passed by user.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 711d8a4..cf682fe 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -334,7 +334,7 @@ static unsigned long busy_loop(unsigned long long start_time)
 	do {
 		l++;
 		time = get_time();
-	} while ((time - start_time) < RUN_INTERVAL);
+	} while ((time - start_time) < run_interval);
 
 	return l;
 }
@@ -539,8 +539,8 @@ int main (int argc, char **argv)
 		
 
 
-	intv.tv_sec = nano2sec(INTERVAL);
-	intv.tv_nsec = INTERVAL % sec2nano(1);
+	intv.tv_sec = nano2sec(interval);
+	intv.tv_nsec = interval % sec2nano(1);
 
 	print_progress_bar(0);
 
-- 
2.1.4

