From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 4/4] cyclictest: move redefine of CPUSET back to uclib
Date: Tue,  6 Oct 2015 11:08:23 +0200
Message-ID: <1444122503-8112-4-git-send-email-haustad@cisco.com>
References: <1444122503-8112-1-git-send-email-haustad@cisco.com>
Cc: Henrik Austad <haustad@cisco.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-7.cisco.com ([173.37.142.94]:34697 "EHLO
	alln-iport-7.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbbJFJLd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 05:11:33 -0400
In-Reply-To: <1444122503-8112-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This was mistakenly included in the #ifdef in 88af643971b9 (android:
adjust target for android). Moved back into the correct #ifdef-entry.

Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 src/cyclictest/cyclictest.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index b52cabd..87a2d7e 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -80,6 +80,11 @@ int sched_setaffinity (__pid_t __pid, size_t __cpusetsize,
 	return -EINVAL;
 }
 
+#undef CPU_SET
+#undef CPU_ZERO
+#define CPU_SET(cpu, cpusetp)
+#define CPU_ZERO(cpusetp)
+
 #endif
 
 #ifdef NO_PTHREAD_SETAFFINITY
@@ -89,11 +94,6 @@ static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
     return sched_setaffinity(0, cpusetsize, cpuset);
 }
 
-#undef CPU_SET
-#undef CPU_ZERO
-#define CPU_SET(cpu, cpusetp)
-#define CPU_ZERO(cpusetp)
