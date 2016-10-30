From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 2/5] zsmalloc: turn that get_cpu_light() into a local_lock()
Date: Sun, 30 Oct 2016 12:46:37 -0400
Message-ID: <20161030164647.225923598@goodmis.org>
References: <20161030164635.444929710@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932482AbcJ3Qqv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 30 Oct 2016 12:46:51 -0400
Content-Disposition: inline; filename=0002-zsmalloc-turn-that-get_cpu_light-into-a-local_lock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.1.35-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

We might get preempted, grab the same ressource again and then corrupt
the memory.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/zsmalloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index e819dffd142c..873d9bdb94fd 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -68,6 +68,7 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/zpool.h>
+#include <linux/locallock.h>
 
 /*
  * This must be power of 2 and greater than of equal to sizeof(link_free).
@@ -398,6 +399,7 @@ static unsigned int get_maxobj_per_zspage(int size, int pages_per_zspage)
 
 /* per-cpu VM mapping areas for zspage accesses that cross page boundaries */
 static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_LOCAL_IRQ_LOCK(zs_map_area_lock);
 
 static int is_first_page(struct page *page)
 {
@@ -1289,7 +1291,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
+	area = &get_locked_var(zs_map_area_lock, zs_map_area);
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1342,7 +1344,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_light();
+	put_locked_var(zs_map_area_lock, zs_map_area);
 	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
-- 
2.9.3


