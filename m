From: Jianxun Zhang <jianxun.zhang@linux.intel.com>
Subject: [PATCH] cyclictest: cannot stop running with '-M' option
Date: Fri, 28 Apr 2017 14:02:09 -0700
Message-ID: <1493413329-115349-1-git-send-email-jianxun.zhang@linux.intel.com>
Cc: Jianxun Zhang <jianxun.zhang@linux.intel.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:6082 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934304AbdD1U5s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Apr 2017 16:57:48 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Most of time having '-M' option causes cyclictest  won't exit after
a duration ('-D') expires, like this quick  command on my machines:

sudo cyclictest  -S -M -D2 -d0

This is because the main thread is blocked on waiting for the next
update of MAX, but the timer thread doesn't signal the main thread
before it quits.

Signed-off-by: Jianxun Zhang <jianxun.zhang@linux.intel.com>
---

The issue may not happen every time, depending on your machine or other parameters fed to cyclictest, but it does quite often on my setup.

 src/cyclictest/cyclictest.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 3f1bef1..36259ea 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1241,6 +1241,17 @@ static void *timerthread(void *param)
 	}
 
 out:
+	if (refresh_on_max) {
+		pthread_mutex_lock(&refresh_on_max_lock);
+		/* We could reach here with both shutdown and allstopped unset (0).
+		 * Set shutdown with synchronization to notify the main
+		 * thread not to be blocked when it should exit.
+		 */
+		shutdown++;
+		pthread_cond_signal(&refresh_on_max_cond);
+		pthread_mutex_unlock(&refresh_on_max_lock);
+	}
+
 	if (par->mode == MODE_CYCLIC)
 		timer_delete(timer);
 
@@ -2512,8 +2523,9 @@ int main(int argc, char **argv)
 
 		if (refresh_on_max) {
 			pthread_mutex_lock(&refresh_on_max_lock);
-			pthread_cond_wait(&refresh_on_max_cond,
-					  &refresh_on_max_lock);
+			if (!shutdown)
+				pthread_cond_wait(&refresh_on_max_cond,
+						&refresh_on_max_lock);
 			pthread_mutex_unlock(&refresh_on_max_lock);
 		}
 	}
@@ -2523,6 +2535,9 @@ int main(int argc, char **argv)
 	shutdown = 1;
 	usleep(50000);
 
+	if (!verbose && !quiet && refresh_on_max)
+		printf("\033[%dB", num_threads + 2);
+
 	if (quiet)
 		quiet = 2;
 	for (i = 0; i < num_threads; i++) {
-- 
2.7.4

