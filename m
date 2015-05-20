From: Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] cyclictest: remove compatibilty hack for old libnuma, repairs "-a" for isolcpus
Date: Wed, 20 May 2015 14:58:31 +0200
Message-ID: <1432126711-18618-1-git-send-email-henning.schild@siemens.com>
References: <20150427125846.1de46037@sluggy>
Cc: John Kacur <jkacur@gmail.com>,
	"Gary S. Robertson" <gary.robertson@linaro.org>,
	Henning Schild <henning.schild@siemens.com>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from goliath.siemens.de ([192.35.17.28]:39950 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbETM61 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 May 2015 08:58:27 -0400
In-Reply-To: <20150427125846.1de46037@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Recent versions of libnuma >=2.0.9 all have numa_parse_cpustring_all(). Not
using this function will make the parser fail if isolcpus are used.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 src/cyclictest/rt_numa.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 06c9420..64516f5 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -92,17 +92,7 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
 static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
 	int max_cpus)
 {
-#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
-					   autotools build. */
 	return numa_parse_cpustring_all(s);
-#else
-	/* We really need numa_parse_cpustring_all(), so we can assign threads
-	 * to cores which are part of an isolcpus set, but early 2.x versions of
-	 * libnuma do not have this function.  A work around should be to run
-	 * your command with e.g. taskset -c 9-15 <command>
-	 */
-	return numa_parse_cpustring((char *)s);
-#endif
 }
 
 static inline void rt_bitmask_free(struct bitmask *mask)
-- 
2.3.6

