From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: [PATCH][RT] Dereference pointer to cpu id, not to address of CPUID
Date: Fri, 07 Nov 2008 13:13:27 -0800
Message-ID: <1226092407.5685.7.camel@dd>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <Linux-kernel@vger.kernel.org>, Tony Jones <tonyj@suse.de>
To: RT Users List <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rn-out-0910.google.com ([64.233.170.188]:57973 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbYKGVNd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Nov 2008 16:13:33 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This patch applies to 2.6.25-rt, 2.6.26-rt and 2.6.27-rt


From: Sven-Thorsten Dietrich <sdietrich@suse.de>
Subject: Dereference pointer to cpu id, when evaluating condition.

Without dereferencing, the condition always evaluates to true.

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
---
 mm/slab.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/mm/slab.c
+++ b/mm/slab.c
@@ -2033,7 +2033,7 @@ slab_destroy(struct kmem_cache *cachep,
 	} else {
 		kmem_freepages(cachep, addr);
 		if (OFF_SLAB(cachep)) {
-			if (this_cpu)
+			if (*this_cpu)
 				__cache_free(cachep->slabp_cache, slabp, this_cpu);
 			else
 				kmem_cache_free(cachep->slabp_cache, slabp);


