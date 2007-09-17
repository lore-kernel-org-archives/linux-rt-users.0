From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix alternate_node_alloc() on RT kernel
Date: Mon, 17 Sep 2007 15:36:59 +0200
Message-ID: <200709171536.59367.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57461 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753504AbXIQNhD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Sep 2007 09:37:03 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


__do_cache_allow/alternate_node_alloc() need to pass the this_cpu variable from
the caller to cache_grow(); otherwise the slab lock for the wrong CPU
can be released when a task switches CPUs inside cache_grow().

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.23-rc4-rt1/mm/slab.c
===================================================================
--- linux-2.6.23-rc4-rt1.orig/mm/slab.c
+++ linux-2.6.23-rc4-rt1/mm/slab.c
@@ -1070,7 +1070,7 @@ cache_free_alien(struct kmem_cache *cach
 }
 
 static inline void *alternate_node_alloc(struct kmem_cache *cachep,
-		gfp_t flags)
+		gfp_t flags, int *this_cpu)
 {
 	return NULL;
 }
@@ -1085,7 +1085,7 @@ static inline void *____cache_alloc_node
 
 static void *____cache_alloc_node(struct kmem_cache *cachep, gfp_t flags,
 				int nodeid, int *this_cpu);
-static void *alternate_node_alloc(struct kmem_cache *, gfp_t);
+static void *alternate_node_alloc(struct kmem_cache *, gfp_t, int *);
 
 static struct array_cache **alloc_alien_cache(int node, int limit)
 {
@@ -3308,9 +3308,10 @@ ____cache_alloc(struct kmem_cache *cache
  * If we are in_interrupt, then process context, including cpusets and
  * mempolicy, may not apply and should not be used for allocation policy.
  */
-static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags)
+static void *alternate_node_alloc(struct kmem_cache *cachep, gfp_t flags,
+				int *this_cpu)
 {
-	int nid_alloc, nid_here, this_cpu = raw_smp_processor_id();
+	int nid_alloc, nid_here;
 
 	if (in_interrupt() || (flags & __GFP_THISNODE))
 		return NULL;
@@ -3320,7 +3321,7 @@ static void *alternate_node_alloc(struct
 	else if (current->mempolicy)
 		nid_alloc = slab_node(current->mempolicy);
 	if (nid_alloc != nid_here)
-		return ____cache_alloc_node(cachep, flags, nid_alloc, &this_cpu);
+		return ____cache_alloc_node(cachep, flags, nid_alloc, this_cpu);
 	return NULL;
 }
 
@@ -3533,7 +3534,7 @@ __do_cache_alloc(struct kmem_cache *cach
 	void *objp;
 
 	if (unlikely(current->flags & (PF_SPREAD_SLAB | PF_MEMPOLICY))) {
-		objp = alternate_node_alloc(cache, flags);
+		objp = alternate_node_alloc(cache, flags, this_cpu);
 		if (objp)
 			goto out;
 	}
