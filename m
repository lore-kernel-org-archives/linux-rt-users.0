From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cyclictest: consider the 4 as the major version
Date: Wed, 20 May 2015 09:02:29 +0200
Message-ID: <1432105349-23681-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-rt-users@vger.kernel.org, C.Emde@osadl.org,
	jkacur@redhat.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58824 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429AbbETHCe (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2015 03:02:34 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Teach cyclictest to recognize the major version 4 which we do have now.
Featurewise it should behave like the 3.0 series

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 src/cyclictest/cyclictest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index c727d54364b1..38525d42c853 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1554,7 +1554,7 @@ static int check_kernel(void)
 			strcpy(functiontracer, "function");
 			strcpy(traceroptions, "trace_options");
 		}
-	} else if (maj == 3) {
+	} else if (maj >= 3) {
 		kv = KV_30;
 		strcpy(functiontracer, "function");
 		strcpy(traceroptions, "trace_options");
-- 
2.1.4

