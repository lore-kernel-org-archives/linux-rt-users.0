From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: [patch ]mm/zs_malloc: Fix bit spinlock replacement
Date: Sun, 16 Oct 2016 05:18:03 +0200
Message-ID: <1476587883.1538.12.camel@gmail.com>
References: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33716 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755286AbcJPDSI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 15 Oct 2016 23:18:08 -0400
In-Reply-To: <20161006085228.jl6rpszdp5c2p2nr@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Do not alter HANDLE_SIZE, memory corruption ensues.  The handle is
a pointer, allocate space for the struct it points to and align it
ZS_ALIGN.  Also, when accessing the struct, mask HANDLE_PIN_BIT.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 mm/zsmalloc.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -71,6 +71,8 @@
 #define ZS_MAX_ZSPAGE_ORDER 2
 #define ZS_MAX_PAGES_PER_ZSPAGE (_AC(1, UL) << ZS_MAX_ZSPAGE_ORDER)
 
+#define ZS_HANDLE_SIZE (sizeof(unsigned long))
+
 #ifdef CONFIG_PREEMPT_RT_BASE
 
 struct zsmalloc_handle {
@@ -78,11 +80,11 @@ struct zsmalloc_handle {
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
 
@@ -380,7 +383,7 @@ static unsigned long cache_alloc_handle(
 #ifdef CONFIG_PREEMPT_RT_BASE
 static struct zsmalloc_handle *zs_get_pure_handle(unsigned long handle)
 {
-	return (void *)(handle &~((1 << OBJ_TAG_BITS) - 1));
+	return (void *)(handle & ~BIT(HANDLE_PIN_BIT));
 }
 #endif
 
