From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/10] mm: add vfree_atomic()
Date: Fri, 18 Nov 2016 14:03:50 +0100
Message-ID: <1479474236-4139-5-git-send-email-hch@lst.de>
References: <1479474236-4139-1-git-send-email-hch@lst.de>
Cc: aryabinin@virtuozzo.com,
	joelaf@google.com,
	jszhang@marvell.com,
	chris@chris-wilson.co.uk,
	joaodias@google.com,
	linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
To: akpm@linux-foundation.org
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1479474236-4139-1-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

We are going to use sleeping lock for freeing vmap. However some
vfree() users want to free memory from atomic (but not from interrupt)
context. For this we add vfree_atomic() - deferred variation of vfree()
which can be used in any atomic context (except NMIs).

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 36 ++++++++++++++++++++++++++++++------
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 3d9d786..d68edff 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -82,6 +82,7 @@ extern void *__vmalloc_node_range(unsigned long size, unsigned long align,
 			const void *caller);
 
 extern void vfree(const void *addr);
+extern void vfree_atomic(const void *addr);
 
 extern void *vmap(struct page **pages, unsigned int count,
 			unsigned long flags, pgprot_t prot);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a4e2cec..80f3fae 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1486,7 +1486,33 @@ static void __vunmap(const void *addr, int deallocate_pages)
 	kfree(area);
 	return;
 }
- 
+
+static inline void __vfree_deferred(const void *addr)
+{
+	struct vfree_deferred *p = this_cpu_ptr(&vfree_deferred);
+
+	if (llist_add((struct llist_node *)addr, &p->list))
+		schedule_work(&p->wq);
+}
+
+/**
+ *	vfree_atomic  -  release memory allocated by vmalloc()
+ *	@addr:		memory base address
+ *
+ *	This one is just like vfree() but can be called in any atomic context
+ *	except NMIs.
+ */
+void vfree_atomic(const void *addr)
+{
+	BUG_ON(in_nmi());
+
+	kmemleak_free(addr);
+
+	if (!addr)
+		return;
+	__vfree_deferred(addr);
+}
+
 /**
  *	vfree  -  release memory allocated by vmalloc()
  *	@addr:		memory base address
@@ -1509,11 +1535,9 @@ void vfree(const void *addr)
 
 	if (!addr)
 		return;
-	if (unlikely(in_interrupt())) {
-		struct vfree_deferred *p = this_cpu_ptr(&vfree_deferred);
-		if (llist_add((struct llist_node *)addr, &p->list))
-			schedule_work(&p->wq);
-	} else
+	if (unlikely(in_interrupt()))
+		__vfree_deferred(addr);
+	else
 		__vunmap(addr, 1);
 }
 EXPORT_SYMBOL(vfree);
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
