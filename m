From: John Kacur <jkacur@redhat.com>
Subject: signaltest: Check the status of pthread_create
Date: Mon, 5 Oct 2015 16:05:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510051603350.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34737 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910AbbJEOFv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 10:05:51 -0400
Received: by wicfx3 with SMTP id fx3so121718818wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 07:05:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 57ea5d7d17b4e8aea36576e91c02082511a5db87 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 30 Sep 2015 23:09:41 +0200
Subject: [PATCH] signaltest: Check the status of pthread_create

Check the status of pthread_create to help debug signaltest

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/signaltest/signaltest.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
index 791df0e492f9..2ee1929f135b 100644
--- a/src/signaltest/signaltest.c
+++ b/src/signaltest/signaltest.c
@@ -27,6 +27,7 @@
 #include <sys/time.h>
 #include <sys/mman.h>
 
+#include "error.h"
 #include "rt-utils.h"
 
 #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
@@ -316,6 +317,7 @@ int main(int argc, char **argv)
 	struct thread_param *par;
 	struct thread_stat *stat;
 	int i, ret = -1;
+	int status;
 
 	process_options(argc, argv);
 
@@ -366,7 +368,11 @@ int main(int argc, char **argv)
 		stat[i].max = -1000000;
 		stat[i].avg = 0.0;
 		stat[i].threadstarted = 1;
-		pthread_create(&stat[i].thread, NULL, signalthread, &par[i]);
+		status = pthread_create(&stat[i].thread, NULL, signalthread,
+					&par[i]);
+		if (status)
+			fatal("failed to create thread %d: %s\n", i,
+			      strerror(status));
 	}
 
 	while (!shutdown) {
-- 
2.4.3

