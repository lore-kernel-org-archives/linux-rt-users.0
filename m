From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/15] mm/zsmalloc: Use get/put_cpu_light in
 zs_map_object()/zs_unmap_object()
Date: Tue, 12 Jul 2016 10:29:09 -0400
Message-ID: <20160712142918.954436441@goodmis.org>
References: <20160712142907.636678217@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-mm-zsmalloc-Use-get-put_cpu_light-in-zs_map_object-z.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.18.36-rt38-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

Otherwise, we get a ___might_sleep() splat.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 mm/zsmalloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 839a48c3ca27..1db2077e38f7 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1127,7 +1127,7 @@ void *zs_map_object(struct zs_pool *pool, unsigned long handle,
 	class = &pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = &get_cpu_var(zs_map_area);
+	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1173,7 +1173,7 @@ void zs_unmap_object(struct zs_pool *pool, unsigned long handle)
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_var(zs_map_area);
+	put_cpu_light();
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
 
-- 
2.8.1
