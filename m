From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 10/34] cyclictest: use %zd for printing size_t in rt_numa_numa_alloc_onnode()
Date: Mon, 22 May 2017 11:25:16 +0300
Message-ID: <20170522082540.15467-11-tommi.t.rantala@nokia.com>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
        Tommi Rantala <tommi.t.rantala@nokia.com>
To: Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-eopbgr50097.outbound.protection.outlook.com ([40.107.5.97]:43936
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752826AbdEVI0P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:15 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/rt_numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index ec29943..ee25045 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -64,7 +64,7 @@ static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
 	void *stack;
 	stack = numa_alloc_onnode(size, node);
 	if (stack == NULL)
-		fatal("failed to allocate %d bytes on node %d for cpu %d\n",
+		fatal("failed to allocate %zd bytes on node %d for cpu %d\n",
 				size, node, cpu);
 	return stack;
 }
-- 
2.9.3

