From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 7/9] cyclictest: fail if use_fifo && thread creation failed
Date: Mon, 31 Aug 2015 11:35:34 -0500
Message-ID: <73a350e379f58fc06c879a6389dec78cb18ca3c7.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44395 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753666AbbHaQfk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:40 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/cyclictest/cyclictest.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 896cdd7..2c44f8e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2058,8 +2058,11 @@ int main(int argc, char **argv)
 			fatal("failed to create thread %d: %s\n", i, strerror(status));
 
 	}
-	if (use_fifo)
+	if (use_fifo) {
 		status = pthread_create(&fifo_threadid, NULL, fifothread, NULL);
+		if (status)
+			fatal("failed to create fifo thread: %s\n", strerror(status));
+	}
 
 	while (!shutdown) {
 		char lavg[256];
-- 
2.5.0

