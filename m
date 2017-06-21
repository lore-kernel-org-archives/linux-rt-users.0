From: Allen Martin <amartin@nvidia.com>
Subject: [PATCH 2/3] cyclictest: read back CPU affinity to verify
Date: Wed, 21 Jun 2017 15:25:33 -0700
Message-ID: <20170621222534.24125-3-amartin@nvidia.com>
References: <20170621222534.24125-1-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Allen Martin <amartin@nvidia.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10784 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbdFUWZu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jun 2017 18:25:50 -0400
In-Reply-To: <20170621222534.24125-1-amartin@nvidia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

After setting CPU affinity, read it back to verify it was set
correctly.  Throw a warning on mismatch.  This can happen if affinity
is set to an offline core.

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 src/cyclictest/cyclictest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 0912494426ca..568e52f4b328 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -982,7 +982,7 @@ static void *timerthread(void *param)
 	struct itimerspec tspec;
 	struct thread_stat *stat = par->stats;
 	int stopped = 0;
-	cpu_set_t mask;
+	cpu_set_t mask, mask_verify;
 	pthread_t thread;
 	unsigned long smi_now, smi_old;
 
@@ -997,6 +997,13 @@ static void *timerthread(void *param)
 		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
 			warn("Could not set CPU affinity to CPU #%d\n",
 			     par->cpu);
+		/* read back affinity to verify it was set correctly */
+		if (pthread_getaffinity_np(thread, sizeof(mask), &mask_verify) == -1)
+			warn("Could not get CPU affinity for CPU #%d\n",
+			     par->cpu);
+		if (!CPU_EQUAL(&mask, &mask_verify))
+			warn("CPU affinity was set incorrectly for CPU #%d\n",
+			     par->cpu);
 	}
 
 	interval.tv_sec = par->interval / USEC_PER_SEC;
-- 
2.11.0

