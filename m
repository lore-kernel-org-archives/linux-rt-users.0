From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] slab: Fix up stable merge of slab init_lock_keys()
Date: Thu, 18 Oct 2012 09:40:01 -0400
Message-ID: <1350567601.19292.69.camel@pippen.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Peter,

There was a little conflict with my merge of 3.4.14 due to the backport
of this patch:

commit 947ca1856a7e60aa6d20536785e6a42dff25aa6e
Author: Michael Wang <wangyun@linux.vnet.ibm.com>
Date:   Wed Sep 5 10:33:18 2012 +0800

    slab: fix the DEADLOCK issue on l3 alien lock

Could you just confirm that my fix is correct.

Thanks,

-- Steve


>From 741c5d3c42ad58b577d0ee602dd1f0bb52b7b92b Mon Sep 17 00:00:00 2001
From: Steven Rostedt <srostedt@redhat.com>
Date: Tue, 16 Oct 2012 17:00:19 -0400
Subject: [PATCH] slab: Fix up stable merge of slab init_lock_keys()

There was a stable fix that moved the init_lock_keys() to after
the enable_cpucache(). But -rt changed this function to
init_cachep_lock_keys(). This moves the init afterwards to
match the stable fix.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/slab.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 119969a..27a194c 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1763,15 +1763,12 @@ void __init kmem_cache_init_late(void)
 	/* 6) resize the head arrays to their final sizes */
 	mutex_lock(&cache_chain_mutex);
 	list_for_each_entry(cachep, &cache_chain, next) {
-		init_cachep_lock_keys(cachep);
 		if (enable_cpucache(cachep, GFP_NOWAIT))
 			BUG();
+		init_cachep_lock_keys(cachep);
 	}
 	mutex_unlock(&cache_chain_mutex);
 
-	/* Annotate slab for lockdep -- annotate the malloc caches */
-	init_lock_keys();
-
 	/* Done! */
 	g_cpucache_up = FULL;
 
-- 
1.7.10.4
