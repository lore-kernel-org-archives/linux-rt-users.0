From: Allen Martin <amartin@nvidia.com>
Subject: [PATCH 1/3] Android: add pthread_getaffinity_np()
Date: Wed, 21 Jun 2017 15:25:32 -0700
Message-ID: <20170621222534.24125-2-amartin@nvidia.com>
References: <20170621222534.24125-1-amartin@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Allen Martin <amartin@nvidia.com>
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13274 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdFUWZt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Jun 2017 18:25:49 -0400
In-Reply-To: <20170621222534.24125-1-amartin@nvidia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Add pthread_getaffinity_np() wrapper for Android

Signed-off-by: Allen Martin <amartin@nvidia.com>
---
 src/include/bionic.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/include/bionic.h b/src/include/bionic.h
index 54f9c54b0824..04a04de5fd1a 100644
--- a/src/include/bionic.h
+++ b/src/include/bionic.h
@@ -37,6 +37,12 @@ static inline int pthread_setaffinity_np(pthread_t thread, size_t cpusetsize,
     return sched_setaffinity(0, cpusetsize, cpuset);
 }
 
+static inline int pthread_getaffinity_np(pthread_t thread, size_t cpusetsize,
+                                         cpu_set_t *cpuset)
+{
+    return sched_getaffinity(0, cpusetsize, cpuset);
+}
+
 #endif	/* PTHREAD_BIONIC */
 
 #endif /* BIONIC_H */
-- 
2.11.0

