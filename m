From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] mm/slub: close possible memory-leak in
 kmem_cache_alloc_bulk()
Date: Wed, 13 Dec 2017 15:05:55 +0100
Message-ID: <20171213140555.s4hzg3igtjfgaueh@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Davydov <vdavydov@virtuozzo.com>, linux-mm@kvack.org
To: linux-rt-users@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:35665 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbdLMOF7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Dec 2017 09:05:59 -0500
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Under certain circumstances we could leak elements which were moved to
the local "to_free" list. The damage is limited since I can't find any
users here.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Jesper: There are no users of kmem_cache_alloc_bulk() and kfree_bulk().
Only kmem_cache_free_bulk() is used since it was introduced. Do you
think that it would make sense to remove those?

 mm/slub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/slub.c b/mm/slub.c
index ffd2fa0f415e..9053e929ce9d 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3240,6 +3240,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return i;
 error:
 	local_irq_enable();
+	free_delayed(&to_free);
 	slab_post_alloc_hook(s, flags, i, p);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
-- 
2.15.1

