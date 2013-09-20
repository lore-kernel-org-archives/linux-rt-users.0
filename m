From: minyard@acm.org
Subject: [PATCH] slab+rt: Don't free locks twice in cpuup_canceled
Date: Fri, 20 Sep 2013 13:02:29 -0500
Message-ID: <1379700149-16400-1-git-send-email-minyard@acm.org>
Cc: Corey Minyard <cminyard@cavium.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from vms173023pub.verizon.net ([206.46.173.23]:39008 "EHLO
	vms173023pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab3ITTEF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Sep 2013 15:04:05 -0400
Received: from wf-rch.minyard.home ([unknown] [173.57.145.124])
 by vms173023.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MTF001JORHTW2O1@vms173023.mailsrvcs.net> for
 linux-rt-users@vger.kernel.org; Fri, 20 Sep 2013 13:03:30 -0500 (CDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@cavium.com>
---
 mm/slab.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 494274e..0a3d6d3 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1270,7 +1270,6 @@ static void __cpuinit cpuup_canceled(long cpu)
 			free_block(cachep, nc->entry, nc->avail, node);
 
 		if (!cpumask_empty(mask)) {
-			local_spin_unlock_irq(slab_lock, &n->list_lock);
 			unlock_l3_and_free_delayed(&n->list_lock);
 			goto free_array_cache;
 		}
@@ -1285,7 +1284,6 @@ static void __cpuinit cpuup_canceled(long cpu)
 		alien = n->alien;
 		n->alien = NULL;
 
-		local_spin_unlock_irq(slab_lock, &n->list_lock);
 		unlock_l3_and_free_delayed(&n->list_lock);
 
 		kfree(shared);
-- 
1.8.3.1

