From: Bhavesh Davda <bhavesh@vmware.com>
Subject: [PATCH 3/3] cyclictest: Print histogram overflow instances only if asked for
Date: Wed, 19 Dec 2012 12:00:33 -0800
Message-ID: <1355947233-31451-4-git-send-email-bhavesh@vmware.com>
References: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Cc: frank.rowand@am.sony.com, jkacur@redhat.com,
	Bhavesh Davda <bhavesh@vmware.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:49508 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922Ab2LSUA4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 15:00:56 -0500
In-Reply-To: <1355947233-31451-1-git-send-email-bhavesh@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

By default (if -g is not specified), of_max is zero. Don't print histogram
overflow instances in that case.

Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
---
 src/cyclictest/cyclictest.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b27f7dc..74c56a6 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1476,14 +1476,16 @@ static void print_hist(struct thread_param *par[], int nthreads)
 		printf(" %05lu", alloverflows);
 	printf("\n");
 
-	printf("# Histogram Overflow: time (sec), thread\n");
-	for (i = 0; i < nthreads; i++) {
-		for (j = 0; j < par[i]->stats->num_outliers; j++) {
-			struct timespec diff;
-			diff.tv_sec  = par[i]->stats->outliers[j].tv_sec  - test_start.tv_sec;
-			diff.tv_nsec = par[i]->stats->outliers[j].tv_nsec - test_start.tv_nsec;
-			tsnorm2(&diff);
-			printf("%ld.%09ld %d\n", diff.tv_sec, diff.tv_nsec, i);
+	if (of_max > 0) {
+		printf("# Histogram Overflow: time (sec), thread\n");
+		for (i = 0; i < nthreads; i++) {
+			for (j = 0; j < par[i]->stats->num_outliers; j++) {
+				struct timespec diff;
+				diff.tv_sec  = par[i]->stats->outliers[j].tv_sec  - test_start.tv_sec;
+				diff.tv_nsec = par[i]->stats->outliers[j].tv_nsec - test_start.tv_nsec;
+				tsnorm2(&diff);
+				printf("%ld.%09ld %d\n", diff.tv_sec, diff.tv_nsec, i);
+			}
 		}
 	}
 }
-- 
1.7.4.1

