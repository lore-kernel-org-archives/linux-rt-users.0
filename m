From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/22] net/core: protect users of napi_alloc_cache against reentrance
Date: Wed, 02 Mar 2016 10:09:04 -0500
Message-ID: <20160302151111.049865653@goodmis.org>
References: <20160302150859.204542604@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55209 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754708AbcCBPLT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Mar 2016 10:11:19 -0500
Content-Disposition: inline; filename=0005-net-core-protect-users-of-napi_alloc_cache-against-r.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.15-rt18-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On -RT the code running in BH can not be moved to another CPU so CPU
local variable remain local. However the code can be preempted
and another task may enter BH accessing the same CPU using the same
napi_alloc_cache variable.
This patch ensures that each user of napi_alloc_cache uses a local lock.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 net/core/skbuff.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 36c138197f37..df293d45e0cd 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -358,6 +358,7 @@ struct netdev_alloc_cache {
 static DEFINE_PER_CPU(struct netdev_alloc_cache, netdev_alloc_cache);
 static DEFINE_PER_CPU(struct netdev_alloc_cache, napi_alloc_cache);
 static DEFINE_LOCAL_IRQ_LOCK(netdev_alloc_lock);
+static DEFINE_LOCAL_IRQ_LOCK(napi_alloc_cache_lock);
 
 static struct page *__page_frag_refill(struct netdev_alloc_cache *nc,
 				       gfp_t gfp_mask)
@@ -456,7 +457,12 @@ EXPORT_SYMBOL(netdev_alloc_frag);
 
 static void *__napi_alloc_frag(unsigned int fragsz, gfp_t gfp_mask)
 {
-	return __alloc_page_frag(&napi_alloc_cache, fragsz, gfp_mask);
+	void *data;
+
+	local_lock(napi_alloc_cache_lock);
+	data = __alloc_page_frag(&napi_alloc_cache, fragsz, gfp_mask);
+	local_unlock(napi_alloc_cache_lock);
+	return data;
 }
 
 void *napi_alloc_frag(unsigned int fragsz)
-- 
2.7.0


