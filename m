From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] rt-tests: pi_stress: Check whether quiet is set, before taking shutdown_mtx
Date: Thu, 19 Nov 2009 17:35:14 +0100
Message-ID: <1258648515-7566-3-git-send-email-jkacur@redhat.com>
References: <1258648515-7566-1-git-send-email-jkacur@redhat.com>
 <1258648515-7566-2-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42674 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388AbZKSQfN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Nov 2009 11:35:13 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so2597597fxm.21
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Nov 2009 08:35:19 -0800 (PST)
In-Reply-To: <1258648515-7566-2-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Check whether quiet is set, before taking shutdown_mtx
- Add quiet to the help menu.
- Remove unused "signal" from struct options

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 44c8f69..f4b43ed 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -109,8 +109,7 @@ int verbose = 0;
 /* turn on debugging prints */
 int debugging = 0;
 
-/* turn off all prints */
-int quiet = 0;
+int quiet = 0;	/* turn off all prints, default = 0 (off) */
 
 /* prompt to start test */
 int prompt = 0;
@@ -141,7 +140,6 @@ struct option options[] = {
 	{"groups", required_argument, NULL, 'g'},
 	{"inversions", required_argument, NULL, 'i'},
 	{"rr", no_argument, NULL, 'r'},
-	{"signal", no_argument, NULL, 's'},
 	{"uniprocessor", no_argument, NULL, 'u'},
 	{"prompt", no_argument, NULL, 'p'},
 	{"debug", no_argument, NULL, 'd'},
@@ -566,12 +564,12 @@ void *reporter(void *arg)
 		}
 
 		/* check for signaled shutdown */
-		pthread_mutex_lock(&shutdown_mtx);
-		if (shutdown == 0) {
-			if (!quiet) {
+		if (!quiet) {
+			pthread_mutex_lock(&shutdown_mtx);
+			if (shutdown == 0) {
 				fputs(UP_ONE, stdout);
 				printf("Current Inversions: %lu\n",
-				       total_inversions());
+						total_inversions());
 			}
 		}
 		pthread_mutex_unlock(&shutdown_mtx);
@@ -1004,6 +1002,7 @@ void usage(void)
 	printf("usage: pi_stress <options>\n");
 	printf("    options:\n");
 	printf("\t--verbose\t- lots of output\n");
+	printf("\t--quiet\t\t- surpress running output\n");
 	printf
 	    ("\t--duration=<n>- length of the test run in seconds [infinite]\n");
 	printf("\t--groups=<n>\t- set the number of inversion groups [%d]\n",
-- 
1.6.2.5

