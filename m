From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch] mm/zsmalloc: Use get/put_cpu_light in
 zs_map_object()/zs_unmap_object()
Date: Tue, 22 Mar 2016 11:16:09 +0100
Message-ID: <1458641769.15742.2.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34990 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758413AbcCVKQM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 06:16:12 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so144894571wml.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 03:16:12 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Otherwise, we get a ___might_sleep() splat.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 mm/zsmalloc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1292,7 +1292,7 @@ void *zs_map_object(struct zs_pool *pool
 	class = pool->size_class[class_idx];
 	off = obj_idx_to_offset(page, obj_idx, class->size);
 
-	area = &get_cpu_var(zs_map_area);
+	area = per_cpu_ptr(&zs_map_area, get_cpu_light());
 	area->vm_mm = mm;
 	if (off + class->size <= PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1345,7 +1345,7 @@ void zs_unmap_object(struct zs_pool *poo
 
 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_var(zs_map_area);
+	put_cpu_light();
 	unpin_tag(handle);
 }
 EXPORT_SYMBOL_GPL(zs_unmap_object);
