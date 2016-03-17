From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 1/4] cyclictest: tracing(): check for notrace
Date: Thu, 17 Mar 2016 14:30:14 -0400
Message-ID: <1458239417-31089-2-git-send-email-lcapitulino@redhat.com>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48864 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966562AbcCQSa1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 14:30:27 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 23CC18F316
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 18:30:27 +0000 (UTC)
In-Reply-To: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

If you pass -b and --notrace to cyclictest today, it will
write to tracing_on when -b latency is reached.

Fix this by making tracing() check notrace.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/cyclictest/cyclictest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index f5a67dc..6070457 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -479,6 +479,9 @@ static void tracemark(char *fmt, ...)
 
 static void tracing(int on)
 {
+	if (notrace)
+		return;
+
 	if (on) {
 		switch (kernelversion) {
 		case KV_26_LT18: gettimeofday(0,(struct timezone *)1); break;
@@ -1698,7 +1701,7 @@ static void sighand(int sig)
 	shutdown = 1;
 	if (refresh_on_max)
 		pthread_cond_signal(&refresh_on_max_cond);
-	if (tracelimit && !notrace)
+	if (tracelimit)
 		tracing(0);
 }
 
@@ -2303,7 +2306,7 @@ int main(int argc, char **argv)
 	}
  out:
 	/* ensure that the tracer is stopped */
-	if (tracelimit && !notrace)
+	if (tracelimit)
 		tracing(0);
 
 
-- 
2.1.0

