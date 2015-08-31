From: Josh Cartwright <joshc@ni.com>
Subject: [PATCH rt-tests 5/9] cyclictest: use correct type when allocating cpu bitmask size
Date: Mon, 31 Aug 2015 11:35:32 -0500
Message-ID: <d84777ffa73511c9343c2ebc71573f56a788e743.1441038216.git.joshc@ni.com>
References: <cover.1441038216.git.joshc@ni.com>
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod2.natinst.com ([130.164.80.23]:37405 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753668AbbHaQfk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 31 Aug 2015 12:35:40 -0400
In-Reply-To: <cover.1441038216.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On any sane platform sizeof(long) == sizeof(unsigned long), so this
does not actually fix a real bug, but the code should at least be
consistent.

Signed-off-by: Josh Cartwright <joshc@ni.com>
---
 src/cyclictest/rt_numa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index caa80e6..9da9fd8 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -229,7 +229,7 @@ static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
 			 * max_cpus bits */
 			int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
 
-			mask->maskp = calloc(nlongs, sizeof(long));
+			mask->maskp = calloc(nlongs, sizeof(unsigned long));
 			if (mask->maskp) {
 				mask->maskp[cpu/BITS_PER_LONG] |=
 					(1UL << (cpu % BITS_PER_LONG));
-- 
2.5.0

