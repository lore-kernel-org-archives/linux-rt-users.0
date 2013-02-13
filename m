From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 10/12] slub: Use correct cpu_slab on dead cpu
Date: Wed, 13 Feb 2013 17:13:49 +0100
Message-ID: <1360772031-27186-11-git-send-email-bigeasy@linutronix.de>
References: <1360772031-27186-1-git-send-email-bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Carsten Emde <C.Emde@osadl.org>,
	Christoph Lameter <cl@linux.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360772031-27186-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Christoph Lameter <cl@linux.com>

Pass a kmem_cache_cpu pointer into unfreeze partials so that a different
kmem_cache_cpu structure than the local one can be specified.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Christoph Lameter <cl@linux.com>
[bigeasy@linutronix: remove unused n2]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/slub.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 634aabc..f788e7e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1879,11 +1879,15 @@ static void deactivate_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 	}
 }
 
-/* Unfreeze all the cpu partial slabs */
-static void unfreeze_partials(struct kmem_cache *s)
+/*
+ * Unfreeze all the cpu partial slabs.
+ *
+ * This function must be called with interrupt disabled.
+ */
+static void unfreeze_partials(struct kmem_cache *s,
+		struct kmem_cache_cpu *c)
 {
 	struct kmem_cache_node *n = NULL;
-	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
 	struct page *page, *discard_page = NULL;
 
 	while ((page = c->partial)) {
@@ -1989,7 +1993,7 @@ int put_cpu_partial(struct kmem_cache *s, struct page *page, int drain)
 				 * set to the per node partial list.
 				 */
 				local_irq_save(flags);
-				unfreeze_partials(s);
+				unfreeze_partials(s, this_cpu_ptr(s->cpu_slab));
 				local_irq_restore(flags);
 				pobjects = 0;
 				pages = 0;
@@ -2027,7 +2031,7 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 		if (c->page)
 			flush_slab(s, c);
 
-		unfreeze_partials(s);
+		unfreeze_partials(s, c);
 	}
 }
 
-- 
1.7.10.4
