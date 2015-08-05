From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/7] mm/slub: move slab initialization into irq enabled region
Date: Tue, 04 Aug 2015 21:18:28 -0400
Message-ID: <20150805011852.582403660@goodmis.org>
References: <20150805011826.881627614@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-mm-slub-move-slab-initialization-into-irq-enabled-re.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.18-rt16-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Initializing a new slab can introduce rather large latencies because most
of the initialization runs always with interrupts disabled.

There is no point in doing so.  The newly allocated slab is not visible
yet, so there is no reason to protect it against concurrent alloc/free.

Move the expensive parts of the initialization into allocate_slab(), so
for all allocations with GFP_WAIT set, interrupts are enabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/slub.c | 79 ++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 534609a0326a..e48bca049f21 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1279,6 +1279,13 @@ static inline void slab_free_hook(struct kmem_cache *s, void *x)
 		debug_check_no_obj_freed(x, s->object_size);
 }
 
+static void setup_object(struct kmem_cache *s, struct page *page,
+				void *object)
+{
+	setup_object_debug(s, page, object);
+	if (unlikely(s->ctor))
+		s->ctor(object);
+}
 /*
  * Slab allocation and freeing
  */
@@ -1310,6 +1317,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
 	bool enableirqs;
+	void *start, *p;
+	int idx, order;
 
 	flags &= gfp_allowed_mask;
 
@@ -1337,13 +1346,13 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Try a lower order alloc if possible
 		 */
 		page = alloc_slab_page(s, alloc_gfp, node, oo);
-
-		if (page)
-			stat(s, ORDER_FALLBACK);
+		if (unlikely(!page))
+			goto out;
+		stat(s, ORDER_FALLBACK);
 	}
 
-	if (kmemcheck_enabled && page
-		&& !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
+	if (kmemcheck_enabled &&
+	    !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
 		int pages = 1 << oo_order(oo);
 
 		kmemcheck_alloc_shadow(page, oo_order(oo), alloc_gfp, node);
@@ -1358,45 +1367,9 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 			kmemcheck_mark_unallocated_pages(page, pages);
 	}
 
-	if (enableirqs)
-		local_irq_disable();
-	if (!page)
-		return NULL;
-
 	page->objects = oo_objects(oo);
-	mod_zone_page_state(page_zone(page),
-		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
-		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
-		1 << oo_order(oo));
-
-	return page;
-}
-
-static void setup_object(struct kmem_cache *s, struct page *page,
-				void *object)
-{
-	setup_object_debug(s, page, object);
-	if (unlikely(s->ctor))
-		s->ctor(object);
-}
-
-static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
-{
-	struct page *page;
-	void *start;
-	void *p;
-	int order;
-	int idx;
-
-	BUG_ON(flags & GFP_SLAB_BUG_MASK);
-
-	page = allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-	if (!page)
-		goto out;
 
 	order = compound_order(page);
-	inc_slabs_node(s, page_to_nid(page), page->objects);
 	page->slab_cache = s;
 	__SetPageSlab(page);
 	if (page->pfmemalloc)
@@ -1418,10 +1391,34 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->freelist = start;
 	page->inuse = page->objects;
 	page->frozen = 1;
+
 out:
+	if (enableirqs)
+		local_irq_disable();
+	if (!page)
+		return NULL;
+
+	mod_zone_page_state(page_zone(page),
+		(s->flags & SLAB_RECLAIM_ACCOUNT) ?
+		NR_SLAB_RECLAIMABLE : NR_SLAB_UNRECLAIMABLE,
+		1 << oo_order(oo));
+
+	inc_slabs_node(s, page_to_nid(page), page->objects);
+
 	return page;
 }
 
+static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
+{
+	if (unlikely(flags & GFP_SLAB_BUG_MASK)) {
+		pr_emerg("gfp: %u\n", flags & GFP_SLAB_BUG_MASK);
+		BUG();
+	}
+
+	return allocate_slab(s,
+		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
+}
+
 static void __free_slab(struct kmem_cache *s, struct page *page)
 {
 	int order = compound_order(page);
-- 
2.1.4
