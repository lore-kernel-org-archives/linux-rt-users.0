From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/6] cyclictest: Always print an err message if write of 0 to cpu-dma_latency fails
Date: Thu, 14 Aug 2014 18:18:07 +0200
Message-ID: <1408033090-24866-4-git-send-email-jkacur@redhat.com>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35791 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbaHNQSX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:18:23 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so1301505wgh.27
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:18:22 -0700 (PDT)
In-Reply-To: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In set_latency_target() there are some paths that don't print an error
message even when a write of 0 to /dev/cpu_dma_latency fails.

This patch does the following
- always print an error message if the write to /dev/cpu_dma_latency
fails
- Fix the error check with the write call. (a return of 0 or -1 indicate
 problems
- rename ret to err since this function is void and returns no value
- use err_msg_n instead of printf (which also prints to stderr)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 01dfc75fd70c..64f1764681b0 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -233,20 +233,30 @@ static int32_t latency_target_value = 0;
 static void set_latency_target(void)
 {
 	struct stat s;
-	int ret;
+	int err;
 
-	if (stat("/dev/cpu_dma_latency", &s) == 0) {
-		latency_target_fd = open("/dev/cpu_dma_latency", O_RDWR);
-		if (latency_target_fd == -1)
-			return;
-		ret = write(latency_target_fd, &latency_target_value, 4);
-		if (ret == 0) {
-			printf("# error setting cpu_dma_latency to %d!: %s\n", latency_target_value, strerror(errno));
-			close(latency_target_fd);
-			return;
-		}
-		printf("# /dev/cpu_dma_latency set to %dus\n", latency_target_value);
+	errno = 0;
+	err = stat("/dev/cpu_dma_latency", &s);
+	if (err == -1) {
+		err_msg_n(errno, "WARN: stat /dev/cpu_dma_latency failed");
+		return;
+	}
+
+	errno = 0;
+	latency_target_fd = open("/dev/cpu_dma_latency", O_RDWR);
+	if (latency_target_fd == -1) {
+		err_msg_n(errno, "WARN: open /dev/cpu_dma_latency");
+		return;
+	}
+
+	errno = 0;
+	err = write(latency_target_fd, &latency_target_value, 4);
+	if (err < 1) {
+		err_msg_n(errno, "# error setting cpu_dma_latency to %d!", latency_target_value);
+		close(latency_target_fd);
+		return;
 	}
+	printf("# /dev/cpu_dma_latency set to %dus\n", latency_target_value);
 }
 
 
-- 
1.8.1.4

