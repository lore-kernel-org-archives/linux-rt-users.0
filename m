From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/6] rt_numa.h: Suppress discards 'const' qualifier warning
Date: Thu, 14 Aug 2014 18:18:06 +0200
Message-ID: <1408033090-24866-3-git-send-email-jkacur@redhat.com>
References: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:58390 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaHNQSY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Aug 2014 12:18:24 -0400
Received: by mail-we0-f179.google.com with SMTP id u57so1292448wes.24
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Aug 2014 09:18:21 -0700 (PDT)
In-Reply-To: <1408033090-24866-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In rt-tests we try to use const where appropriate for read-only, but
we need to tell the compiler we are intentionally discarding const
when calling library functions that expect char *

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index e64c44635380..60a143721da1 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -101,7 +101,7 @@ static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
 	 * libnuma do not have this function.  A work around should be to run
 	 * your command with e.g. taskset -c 9-15 <command>
 	 */
-	return numa_parse_cpustring(s);
+	return numa_parse_cpustring((char *)s);
 #endif
 }
 
-- 
1.8.1.4

