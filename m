From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/7] mm: remove free_unmap_vmap_area_noflush
Date: Sat, 22 Oct 2016 17:17:14 +0200
Message-ID: <1477149440-12478-2-git-send-email-hch@lst.de>
References: <1477149440-12478-1-git-send-email-hch@lst.de>
Cc: joelaf@google.com,
	jszhang@marvell.com,
	chris@chris-wilson.co.uk,
	joaodias@google.com,
	linux-mm@kvack.org,
	linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: akpm@linux-foundation.org
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1477149440-12478-1-git-send-email-hch@lst.de>
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Just inline it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Jisheng Zhang <jszhang@marvell.com>
---
 mm/vmalloc.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f2481cb..45de736 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -711,22 +711,13 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 }
 
 /*
- * Free and unmap a vmap area, caller ensuring flush_cache_vunmap had been
- * called for the correct range previously.
- */
-static void free_unmap_vmap_area_noflush(struct vmap_area *va)
-{
-	unmap_vmap_area(va);
-	free_vmap_area_noflush(va);
-}
-
-/*
  * Free and unmap a vmap area
  */
 static void free_unmap_vmap_area(struct vmap_area *va)
 {
 	flush_cache_vunmap(va->va_start, va->va_end);
-	free_unmap_vmap_area_noflush(va);
+	unmap_vmap_area(va);
+	free_vmap_area_noflush(va);
 }
 
 static struct vmap_area *find_vmap_area(unsigned long addr)
-- 
2.1.4

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
