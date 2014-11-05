From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 7/9] rt-utils: Add helper to parse/print scheduling policies
Date: Wed,  5 Nov 2014 10:09:43 +0100
Message-ID: <1415178585-3192-8-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52828 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753488AbaKEJJw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:52 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/include/rt-utils.h |  5 +++++
 src/lib/rt-utils.c     | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 4a7d01f..37f46c8 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -1,6 +1,8 @@
 #ifndef __RT_UTILS_H
 #define __RT_UTILS_H
 
+#include <stdint.h>
+
 #define _STR(x) #x
 #define STR(x) _STR(x)
 #define MAX_PATH 256
@@ -17,4 +19,7 @@ int event_disable(char *event);
 int event_enable_all(void);
 int event_disable_all(void);
 
+const char *policy_to_string(int policy);
+uint32_t string_to_policy(const char *str);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index f4da4b3..df522fe 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include "rt-utils.h"
+#include "rt-sched.h"
 #include "error.h"
 
 static char debugfileprefix[MAX_PATH];
@@ -273,3 +274,40 @@ int check_privs(void)
 	return sched_setscheduler(0, policy, &old_param);
 }
 
+const char *policy_to_string(int policy)
+{
+	switch (policy) {
+	case SCHED_OTHER:
+		return "SCHED_OTHER";
+	case SCHED_FIFO:
+		return "SCHED_FIFO";
+	case SCHED_RR:
+		return "SCHED_RR";
+	case SCHED_BATCH:
+		return "SCHED_BATCH";
+	case SCHED_IDLE:
+		return "SCHED_IDLE";
+	case SCHED_DEADLINE:
+		return "SCHED_DEADLINE";
+	}
+
+	return "unknown";
+}
+
+uint32_t string_to_policy(const char *str)
+{
+	if (!strcmp(str, "other"))
+		return SCHED_OTHER;
+	else if (!strcmp(str, "fifo"))
+		return SCHED_FIFO;
+	else if (!strcmp(str, "rr"))
+		return SCHED_RR;
+	else if (!strcmp(str, "batch"))
+		return SCHED_BATCH;
+	else if (!strcmp(str, "idle"))
+		return SCHED_IDLE;
+	else if (!strcmp(str, "deadline"))
+		return SCHED_DEADLINE;
+
+	return 0;
+}
-- 
1.9.3

