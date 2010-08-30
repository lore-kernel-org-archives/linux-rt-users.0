From: Tim Blechmann <tim@klingt.org>
Subject: [PATCH] perf: provide kmap_atomic_direct for !CONFIG_HIGHMEM
Date: Mon, 30 Aug 2010 12:20:19 +0200
Message-ID: <8df2d360ce2f1b88d50e0929528f011d50dc1ce5.1283163601.git.tim@klingt.org>
Cc: Tim Blechmann <tim@klingt.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.klingt.org ([86.59.21.178]:50376 "EHLO klingt.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754997Ab0H3K1X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 30 Aug 2010 06:27:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

ddeca6231cbdebd0fa0f1bac816f1e1e6eae485b doesn't compile, if CONFIG_HIGHMEM
is not enabled, because kmap_atomic_direct and kunmap_atomic_direct are
undefined.

Signed-off-by: Tim Blechmann <tim@klingt.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/highmem.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ab2cc20..ceb4f2e 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -65,8 +65,10 @@ static inline void *kmap_atomic(struct page *page, enum km_type idx)
 	return page_address(page);
 }
 #define kmap_atomic_prot(page, idx, prot)	kmap_atomic(page, idx)
+#define kmap_atomic_direct(page, idx)		kmap_atomic(page, idx)
 
 #define kunmap_atomic(addr, idx)	do { pagefault_enable(); } while (0)
+#define kunmap_atomic_direct(page, idx)	kunmap_atomic(page, idx)
 #define kmap_atomic_pfn(pfn, idx)	kmap_atomic(pfn_to_page(pfn), (idx))
 #define kmap_atomic_to_page(ptr)	virt_to_page(ptr)
 
-- 
1.7.0.4

