From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 4/9] signaltest: drop unused tsnorm()
Date: Mon, 31 Aug 2015 11:35:31 -0500
Message-ID: <ce9b5fb3e680b9a355142dd91d54ce1fb02ae664.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:44392 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753516AbbHaQfj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:39 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

tsnorm() is not used at all in signaltest.  Remove it.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/signaltest/signaltest.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 9454a26..c6d1cfd 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -69,14 +69,6 @@ static int shutdown;
 static int tracelimit = 0;
 static int oldtrace = 0;
 
-static inline void tsnorm(struct timespec *ts)
-{
-	while (ts->tv_nsec >= NSEC_PER_SEC) {
-		ts->tv_nsec -= NSEC_PER_SEC;
-		ts->tv_sec++;
-	}
-}
