From: "Gary S. Robertson" <gary.robertson@linaro.org>
Subject: [PATCH 2/2] Don't offer --numa option when unavailable
Date: Tue, 25 Mar 2014 18:05:32 -0500
Message-ID: <1395788732-7311-3-git-send-email-gary.robertson@linaro.org>
References: <1395788732-7311-1-git-send-email-gary.robertson@linaro.org>
Cc: "Gary S. Robertson" <gary.robertson@linaro.org>
To: clark.williams@gmail.com, linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yh0-f43.google.com ([209.85.213.43]:55777 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbaCYXG3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 25 Mar 2014 19:06:29 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so1310686yha.2
        for <linux-rt-users@vger.kernel.org>; Tue, 25 Mar 2014 16:06:29 -0700 (PDT)
In-Reply-To: <1395788732-7311-1-git-send-email-gary.robertson@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: "Gary S. Robertson" <gary.robertson@linaro.org>

Signed-off-by: Gary S. Robertson <gary.robertson@linaro.org>
---
 src/cyclictest/cyclictest.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 686a635..4532b19 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -1032,8 +1032,10 @@ static void display_help(int error)
 	       "-T TRACE --tracer=TRACER   set tracing function\n"
 	       "    configured tracers: %s\n"
 	       "-u       --unbuffered      force unbuffered output for live processing\n"
+#ifdef NUMA
 	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
 	       "                           thread data structures allocated from local node\n"
+#endif	/* NUMA */
 	       "-v       --verbose         output values on stdout for statistics\n"
 	       "                           format: n:c:v n=tasknum c=count v=value in us\n"
 	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
-- 
1.7.9.5

