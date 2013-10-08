From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v3.10-rt] slab: make kmem_cache_node's list_lock conditionally raw
Date: Tue, 8 Oct 2013 14:55:09 -0400
Message-ID: <1381258509-7420-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39491 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3JHSzd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Oct 2013 14:55:33 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The RT patch "mm-disable-slab-on-rt.patch" unconditionally
converts kmem_cache_node's list_lock into a raw lock.  As
of mainline commit ca34956b804b7554fc4e88826773380d9d5122a8
("slab: Common definition for kmem_cache_node") the definition
is shared -- but slab.c still thinks the lock is non raw.

At the moment SLAB depends on !RT_FULL, however with the lock
being raw for !RT_FULL, we can't build the SLAB + !RT_FULL
combination because of the above.  So only convert the lock if
SLAB is not enabled.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[Should be squished into mm-disable-slab-on-rt.patch ]

 mm/slab.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 2e6c8b7..fc3c097 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -247,7 +247,11 @@ static inline struct kmem_cache *cache_from_obj(struct kmem_cache *s, void *x)
  * The slab lists for all objects.
  */
 struct kmem_cache_node {
+#ifdef CONFIG_SLAB
+	spinlock_t list_lock;
+#else
 	raw_spinlock_t list_lock;
+#endif
 
 #ifdef CONFIG_SLAB
 	struct list_head slabs_partial;	/* partial list first, better asm code */
-- 
1.8.1.2

