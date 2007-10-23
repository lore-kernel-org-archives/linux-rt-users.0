From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix rt preempt slab NUMA freeing
Date: Tue, 23 Oct 2007 19:13:03 +0200
Message-ID: <200710231913.03170.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:36119 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753357AbXJWRNI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2007 13:13:08 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 2A965150F2
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Oct 2007 19:13:07 +0200 (CEST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


When this_cpu changes in the free path node needs to change too.
Otherwise the slab can end up in the wrong node's list and this
eventually leads to WARN_ONs and of course worse NUMA performace.

This patch is likely not complete (the NUMA slab code is *very* hairy), 
but seems to make the make -j128 test survive for at least two hours.

But at least it fixes one case that regularly triggered during 
testing, resulting in slabs in the wrong node lists and triggering
WARN_ONs in slab_put/get_obj

I tried a complete audit of keeping this_cpu/node/slabp in sync when needed, but 
it is very hairy code and I likely missed some cases. This so far
fixes only the simple free path; but it seems to be good enough
to not trigger easily anymore on a NUMA system with memory pressure.

Longer term the only good fix is probably to migrate to slub.
Or disable NUMA slab for PREEMPT_RT (its value has been disputed
in some benchmarks anyways)

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux-2.6.23-rt1/mm/slab.c
===================================================================
--- linux-2.6.23-rt1.orig/mm/slab.c
+++ linux-2.6.23-rt1/mm/slab.c
@@ -1193,7 +1193,7 @@ cache_free_alien(struct kmem_cache *cach
 	struct array_cache *alien = NULL;
 	int node;
 
-	node = numa_node_id();
+	node = cpu_to_node(*this_cpu);
 
 	/*
 	 * Make sure we are not freeing a object from another node to the array
@@ -4194,6 +4194,8 @@ static void cache_reap(struct work_struc
 
 		work_done += reap_alien(searchp, l3, &this_cpu);
 
+		node = cpu_to_node(this_cpu);
+
 		work_done += drain_array(searchp, l3,
 			    cpu_cache_get(searchp, this_cpu), 0, node);
 
