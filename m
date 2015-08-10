From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.4.108-rt136
Date: Mon, 10 Aug 2015 10:36:28 -0400
Message-ID: <20150810103628.6662544c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.4.108-rt136 stable release.


You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.4-rt
  Head SHA1: 32c06eee4342e13020d746cd4f925bc3398f9b6f


Or to build 3.4.108-rt136 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.4.108.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/patch-3.4.108-rt136.patch.xz



You can also build from 3.4.108-rt135 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.4/incr/patch-3.4.108-rt135-rt136.patch.xz



Enjoy,

-- Steve


Changes from v3.4.108-rt135:

---

Steven Rostedt (1):
      xfs: Disable percpu SB on PREEMPT_RT_FULL

Steven Rostedt (Red Hat) (1):
      Linux 3.4.108-rt136

Thomas Gleixner (1):
      mm/slub: move slab initialization into irq enabled region

----
 fs/xfs/xfs_linux.h |  2 +-
 localversion-rt    |  2 +-
 mm/slub.c          | 77 ++++++++++++++++++++++++++----------------------------
 3 files changed, 39 insertions(+), 42 deletions(-)
---------------------------
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index 828662f70d64..13d86a8dae43 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -97,7 +97,7 @@
 /*
  * Feature macros (disable/enable)
  */
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT_RT_FULL)
 #define HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
 #else
 #undef  HAVE_PERCPU_SB	/* per cpu superblock counters are a 2.6 feature */
diff --git a/localversion-rt b/localversion-rt
index e3026053f01e..f824f53c19ea 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt135
+-rt136
diff --git a/mm/slub.c b/mm/slub.c
index aff06374dd5c..9308c8a2865b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1266,6 +1266,14 @@ static inline void slab_free_hook(struct kmem_cache *s, void *x) {}
 
 #endif /* CONFIG_SLUB_DEBUG */
 
+static void setup_object(struct kmem_cache *s, struct page *page,
+				void *object)
+{
+	setup_object_debug(s, page, object);
+	if (unlikely(s->ctor))
+		s->ctor(object);
+}
+
 /*
  * Slab allocation and freeing
  */
@@ -1287,6 +1295,8 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	struct page *page;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
+	void *start, *last, *p;
+	int idx, order;
 
 	flags &= gfp_allowed_mask;
 
@@ -1309,17 +1319,11 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Try a lower order alloc if possible
 		 */
 		page = alloc_slab_page(flags, node, oo);
-
-		if (page)
-			stat(s, ORDER_FALLBACK);
+		if (unlikely(!page))
+			goto out;
+		stat(s, ORDER_FALLBACK);
 	}
 
-	if (flags & __GFP_WAIT)
-		local_irq_disable();
-
-	if (!page)
-		return NULL;
-
 	if (kmemcheck_enabled
 		&& !(s->flags & (SLAB_NOTRACK | DEBUG_DEFAULT_FLAGS))) {
 		int pages = 1 << oo_order(oo);
@@ -1337,37 +1341,6 @@ static struct page *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	}
 
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
-	void *last;
-	void *p;
-
-	BUG_ON(flags & GFP_SLAB_BUG_MASK);
-
-	page = allocate_slab(s,
-		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
-	if (!page)
-		goto out;
-
-	inc_slabs_node(s, page_to_nid(page), page->objects);
 	page->slab = s;
 	page->flags |= 1 << PG_slab;
 
@@ -1388,10 +1361,34 @@ static struct page *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 	page->freelist = start;
 	page->inuse = page->objects;
 	page->frozen = 1;
+
 out:
+	if (flags & __GFP_WAIT)
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
