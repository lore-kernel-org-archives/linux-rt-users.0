From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3.10-rt] slab: nodelist is now just node
Date: Tue, 8 Oct 2013 14:31:33 -0400
Message-ID: <1381257093-6992-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:63830 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab3JHSbo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 14:31:44 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The rt patch "mm-slab-more-lock-breaks.patch" adds some operations
looking for nodelist, but mainline commit 6a67368c36e2c0c2578ba62f
("slab: Rename nodelists to node") means that the old naming is
out of date and breaks compiles, even for !RT_FULL

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Should be squished into mm-slab-wrap-functions.patch]

 mm/slab.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index b242b50..7349569 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1239,11 +1239,11 @@ static int init_cache_node_node(int node)
 			cachep->node[node] = n;
 		}
 
-		local_spin_lock_irq(slab_lock, &cachep->nodelists[node]->list_lock);
+		local_spin_lock_irq(slab_lock, &cachep->node[node]->list_lock);
 		cachep->node[node]->free_limit =
 			(1 + nr_cpus_node(node)) *
 			cachep->batchcount + cachep->num;
-		local_spin_unlock_irq(slab_lock, &cachep->nodelists[node]->list_lock);
+		local_spin_unlock_irq(slab_lock, &cachep->node[node]->list_lock);
 	}
 	return 0;
 }
@@ -4064,7 +4064,7 @@ static int __do_tune_cpucache(struct kmem_cache *cachep, int limit,
 				    &cachep->node[cpu_to_mem(i)]->list_lock);
 		free_block(cachep, ccold->entry, ccold->avail, cpu_to_mem(i));
 
-		unlock_l3_and_free_delayed(&cachep->nodelists[cpu_to_mem(i)]->list_lock);
+		unlock_l3_and_free_delayed(&cachep->node[cpu_to_mem(i)]->list_lock);
 		kfree(ccold);
 	}
 	kfree(new);
-- 
1.8.1.2

