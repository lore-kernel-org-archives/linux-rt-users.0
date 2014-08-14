From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/6] lib: Rework err_msg_n to output strerror after message
Date: Thu, 14 Aug 2014 18:18:05 +0200
Message-ID: <1408033090-24866-2-git-send-email-jkacur@redhat.com>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:42672 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaHNQS0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:18:26 -0400
Received: by mail-wg0-f49.google.com with SMTP id k14so1288261wgh.20
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:18:20 -0700 (PDT)
In-Reply-To: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Outputting the message first followed by the strerror makes
the error messages more readable.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.c | 4 ++--
 src/lib/error.c             | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 4547831fedc9..01dfc75fd70c 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -669,7 +669,7 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
 	err = getrlimit(RLIMIT_RTPRIO, &rlim);
 	if (err) {
 		err = errno;
-		err_msg_n(err, "WARN: getrlimit failed\n");
+		err_msg_n(err, "WARN: getrlimit failed");
 		return err;
 	}
 
@@ -681,7 +681,7 @@ static int raise_soft_prio(int policy, const struct sched_param *param)
 		err = setrlimit(RLIMIT_RTPRIO, &rlim);
 		if (err) {
 			err = errno;
-			err_msg_n(err, "WARN: setrlimit failed\n");
+			err_msg_n(err, "WARN: setrlimit failed");
 			/* return err; */
 		}
 	} else {
diff --git a/src/lib/error.c b/src/lib/error.c
index 1b5de5dabeaf..5eb63527659c 100644
--- a/src/lib/error.c
+++ b/src/lib/error.c
@@ -79,8 +79,8 @@ void fatal(char *fmt, ...)
 
 void err_doit(int err, const char *fmt, va_list ap)
 {
-	if (err)
-		fprintf(stderr, "%s\n", strerror(err));
 	vfprintf(stderr, fmt, ap);
+	if (err)
+		fprintf(stderr, ": %s\n", strerror(err));
 	return;
 }
-- 
1.8.1.4

