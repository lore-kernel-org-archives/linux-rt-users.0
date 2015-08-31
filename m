From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 6/9] cyclictest: drop impossible use_fifo conditional
Date: Mon, 31 Aug 2015 11:35:33 -0500
Message-ID: <6eca77cc0906aece69c31603b39a35c5e2f5e3c9.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:37400 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753582AbbHaQfj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:39 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The fifothread is only created when use_fifo is set; having the thread
itself perform a check is redundant and unnecessary.  Drop it.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/cyclictest/cyclictest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index dc754fd..896cdd7 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1773,9 +1773,6 @@ static void *fifothread(void *param)
 	FILE *fp;
 	int i;
 
-	if (use_fifo == 0)
-		return NULL;
