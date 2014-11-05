From: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [RFC v0 8/9] rt-utils: Add gettid()
Date: Wed,  5 Nov 2014 10:09:44 +0100
Message-ID: <1415178585-3192-9-git-send-email-daniel.wagner@bmw-carit.de>
References: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Cc: linux-rt-users@vger.kernel.org,
	Daniel Wagner <daniel.wagner@bmw-carit.de>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.bmw-carit.de ([62.245.222.98]:52827 "EHLO
	linuxmail.bmw-carit.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751438AbaKEJJw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Nov 2014 04:09:52 -0500
In-Reply-To: <1415178585-3192-1-git-send-email-daniel.wagner@bmw-carit.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We still lack a gettid implemenation from libc.

Signed-off-by: Daniel Wagner <daniel.wagner@bmw-carit.de>
---
 src/include/rt-utils.h | 2 ++
 src/lib/rt-utils.c     | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index 37f46c8..ef0f6ac 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -22,4 +22,6 @@ int event_disable_all(void);
 const char *policy_to_string(int policy);
 uint32_t string_to_policy(const char *str);
 
+pid_t gettid(void);
+
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index df522fe..3882d23 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -16,6 +16,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
+#include <sys/syscall.h> /* For SYS_gettid definitions */
 #include "rt-utils.h"
 #include "rt-sched.h"
 #include "error.h"
@@ -311,3 +312,8 @@ uint32_t string_to_policy(const char *str)
 
 	return 0;
 }
+
+pid_t gettid(void)
+{
+	return syscall(SYS_gettid);
+}
-- 
1.9.3

