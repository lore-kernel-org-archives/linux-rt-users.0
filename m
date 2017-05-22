From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 01/34] rt-utils: add cpus_online() helper
Date: Mon, 22 May 2017 11:25:07 +0300
Message-ID: <20170522082540.15467-2-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:7993
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752735AbdEVIZ6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:25:58 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add a helper function cpus_online() that returns the count of online CPUs.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/include/rt-utils.h |  1 +
 src/lib/rt-utils.c     | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
index ef0f6ac..d744ded 100644
--- a/src/include/rt-utils.h
+++ b/src/include/rt-utils.h
@@ -23,5 +23,6 @@ const char *policy_to_string(int policy);
 uint32_t string_to_policy(const char *str);
 
 pid_t gettid(void);
+long cpus_online(void);
 
 #endif	/* __RT_UTILS.H */
diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
index ac6878c..0b1fc1e 100644
--- a/src/lib/rt-utils.c
+++ b/src/lib/rt-utils.c
@@ -320,3 +320,15 @@ pid_t gettid(void)
 {
 	return syscall(SYS_gettid);
 }
+
+long cpus_online(void)
+{
+	long cpus = sysconf(_SC_NPROCESSORS_ONLN);
+
+	if (cpus <= 0)
+		err_msg_n(errno,
+			"WARN: sysconf(_SC_NPROCESSORS_ONLN) returned %ld",
+			cpus);
+
+	return cpus;
+}
-- 
2.9.3

