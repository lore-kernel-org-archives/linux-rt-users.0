From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/6] mm: remove free_unmap_vmap_area_addr
Date: Tue, 18 Oct 2016 08:56:09 +0200
Message-ID: <1476773771-11470-5-git-send-email-hch@lst.de>
References: <1476773771-11470-1-git-send-email-hch@lst.de>
Cc: joelaf@google.com,
	jszhang@marvell.com,
	chris@chris-wilson.co.uk,
	joaodias@google.com,
	linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: akpm@linux-foundation.org
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1476773771-11470-1-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Just inline it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 8cedfa0..2af2921 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -717,16 +717,6 @@ static struct vmap_area *find_vmap_area(unsigned long addr)
 	return va;
 }
 
-static void free_unmap_vmap_area_addr(unsigned long addr)
-{
-	struct vmap_area *va;
-
-	va = find_vmap_area(addr);
-	BUG_ON(!va);
-	free_unmap_vmap_area(va);
-}
-
-
 /*** Per cpu kva allocator ***/
 
 /*
@@ -1090,6 +1080,7 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 {
 	unsigned long size = (unsigned long)count << PAGE_SHIFT;
 	unsigned long addr = (unsigned long)mem;
+	struct vmap_area *va;
 
 	might_sleep();
 	BUG_ON(!addr);
@@ -1100,10 +1091,14 @@ void vm_unmap_ram(const void *mem, unsigned int count)
 	debug_check_no_locks_freed(mem, size);
 	vmap_debug_free_range(addr, addr+size);
 
-	if (likely(count <= VMAP_MAX_ALLOC))
+	if (likely(count <= VMAP_MAX_ALLOC)) {
 		vb_free(mem, size);
-	else
-		free_unmap_vmap_area_addr(addr);
+		return;
+	}
+
+	va = find_vmap_area(addr);
+	BUG_ON(!va);
+	free_unmap_vmap_area(va);
 }
 EXPORT_SYMBOL(vm_unmap_ram);
 
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
