From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch v2 ] mm/zs_malloc: Fix bit spinlock replacement
Date: Wed, 19 Oct 2016 17:50:38 +0200
Message-ID: <1476892238.3975.1.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
         <1476587883.1538.12.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32769 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S945761AbcJSPum (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Oct 2016 11:50:42 -0400
In-Reply-To: <1476587883.1538.12.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Do not alter HANDLE_SIZE, memory corruption ensues.  The handle is
a pointer, allocate space for the struct it points to and align it
ZS_ALIGN.  Also, when accessing the struct, mask HANDLE_PIN_BIT.

v2: mutex is only needed for PREEMPT_RT_FULL, with PREEMPT_RT_RTB,
preemption is disabled when we take it...

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 mm/zsmalloc.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -71,18 +71,20 @@
 #define ZS_MAX_ZSPAGE_ORDER 2
 #define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
 
-#ifdef CONFIG_PREEMPT_RT_BASE
+#define ZS_HANDLE_SIZE (sizeof(unsigned long))
+
+#ifdef CONFIG_PREEMPT_RT_FULL
 
 struct zsmalloc_handle {
 	unsigned long addr;
 	struct mutex lock;
 };
 
-#define ZS_HANDLE_SIZE (sizeof(struct zsmalloc_handle))
+#define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
 
 #else
 
-#define ZS_HANDLE_SIZE (sizeof(unsigned long))
+#define ZS_HANDLE_ALLOC_SIZE ZS_HANDLE_SIZE
 #endif
 
 /*
@@ -339,8 +341,9 @@ static void SetZsPageMovable(struct zs_p
 
 static int create_cache(struct zs_pool *pool)
 {
-	pool->handle_cachep = kmem_cache_create("zs_handle", ZS_HANDLE_SIZE,
-					0, 0, NULL);
+	pool->handle_cachep = kmem_cache_create("zs_handle",
+						ZS_HANDLE_ALLOC_SIZE,
+						ZS_ALIGN, 0, NULL);
 	if (!pool->handle_cachep)
 		return 1;
 
@@ -367,7 +370,7 @@ static unsigned long cache_alloc_handle(
 
 	p = kmem_cache_alloc(pool->handle_cachep,
 			     gfp & ~(__GFP_HIGHMEM|__GFP_MOVABLE));
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	if (p) {
 		struct zsmalloc_handle *zh = p;
 
@@ -377,10 +380,10 @@ static unsigned long cache_alloc_handle(
 	return (unsigned long)p;
 }
 
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 static struct zsmalloc_handle *zs_get_pure_handle(unsigned long handle)
 {
-	return (void *)(handle &~((1 << OBJ_TAG_BITS) - 1));
+	return (void *)(handle & ~BIT(HANDLE_PIN_BIT));
 }
 #endif
 
@@ -402,7 +405,7 @@ static void cache_free_zspage(struct zs_
 
 static void record_obj(unsigned long handle, unsigned long obj)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	WRITE_ONCE(zh->addr, obj);
@@ -937,7 +940,7 @@ static unsigned long location_to_obj(str
 
 static unsigned long handle_to_obj(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return zh->addr;
@@ -957,7 +960,7 @@ static unsigned long obj_to_head(struct
 
 static inline int testpin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_is_locked(&zh->lock);
@@ -968,7 +971,7 @@ static inline int testpin_tag(unsigned l
 
 static inline int trypin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_trylock(&zh->lock);
@@ -979,7 +982,7 @@ static inline int trypin_tag(unsigned lo
 
 static void pin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_lock(&zh->lock);
@@ -990,7 +993,7 @@ static void pin_tag(unsigned long handle
 
 static void unpin_tag(unsigned long handle)
 {
-#ifdef CONFIG_PREEMPT_RT_BASE
+#ifdef CONFIG_PREEMPT_RT_FULL
 	struct zsmalloc_handle *zh = zs_get_pure_handle(handle);
 
 	return mutex_unlock(&zh->lock);
