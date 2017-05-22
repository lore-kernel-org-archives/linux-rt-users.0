From: Tommi Rantala <tommi.t.rantala@nokia.com>
Subject: [PATCH 11/34] cyclictest: max_cpus unused in this variant of rt_numa_parse_cpustring()
Date: Mon, 22 May 2017 11:25:17 +0300
Message-ID: <20170522082540.15467-12-tommi.t.rantala@nokia.com>
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
        id S1752735AbdEVI0R (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 04:26:17 -0400
In-Reply-To: <20170522082540.15467-1-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
---
 src/cyclictest/rt_numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index ee25045..457bbd8 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -90,7 +90,7 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
 }
 
 static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
-	int max_cpus)
+	int max_cpus __attribute__((unused)))
 {
 #ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
 					   autotools build. */
-- 
2.9.3

