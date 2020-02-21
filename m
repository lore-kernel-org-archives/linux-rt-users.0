Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579ECC3566F
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F213206EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582320387;
	bh=w+SEUaeZRJ1y/bxhM5og4B/G9JdKcfZzdUg3aHde21w=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:List-ID:From;
	b=g7g3voirPDMT5o4oOqf8VcKwO3oN2ytCov35dE+j/9OzZA8BfBIATGhmSTUlwmXNy
	 2yzZQHpEjAlgUa+xc87dXNQHjpguXU3yk8YfQfEQ1HUbFiEg3F0W7ffk3ZNohMzVDQ
	 7E/jHaNm/sls7/fwKVfsXdxpWf8VwR9Dgh8YJTH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgBUV0U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:26:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:39246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729172AbgBUVZa (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:25:30 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4484824684;
        Fri, 21 Feb 2020 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582320329;
        bh=w+SEUaeZRJ1y/bxhM5og4B/G9JdKcfZzdUg3aHde21w=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=M8RQ9Iw18gfKkbfXrhaGwI+XsUw7O4bG6GDAWMiqEeO8NEd6DYjwKdF/h01BkM/o2
         TXImbqz5xio776VzRWEHl6qIU/cvadiUSHcTaSlfz7Rf+IfVZ2n7sQ2lwjbuNYnmLE
         QNEItdrK8RZ5TZ52NK1SJa7vR+UAcGB59+JPH4TY=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 14/25] kmemleak: Change the lock of kmemleak_object to raw_spinlock_t
Date:   Fri, 21 Feb 2020 15:24:42 -0600
Message-Id: <3da095f98a2d5bca50190b69799f5d8b57af47da.1582320278.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
In-Reply-To: <cover.1582320278.git.zanussi@kernel.org>
References: <cover.1582320278.git.zanussi@kernel.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Liu Haitao <haitao.liu@windriver.com>

v4.14.170-rt75-rc1 stable review patch.
If anyone has any objections, please let me know.

-----------


[ Upstream commit 217847f57119b5fdd377bfa3d344613ddb98d9fc ]

The commit ("kmemleak: Turn kmemleak_lock to raw spinlock on RT")
changed the kmemleak_lock to raw spinlock. However the
kmemleak_object->lock is held after the kmemleak_lock is held in
scan_block().

Make the object->lock a raw_spinlock_t.

Cc: stable-rt@vger.kernel.org
Link: https://lkml.kernel.org/r/20190927082230.34152-1-yongxin.liu@windriver.com
Signed-off-by: Liu Haitao <haitao.liu@windriver.com>
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 mm/kmemleak.c | 72 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c18e23619f95..17718a11782b 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -148,7 +148,7 @@ struct kmemleak_scan_area {
  * (use_count) and freed using the RCU mechanism.
  */
 struct kmemleak_object {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int flags;		/* object status flags */
 	struct list_head object_list;
 	struct list_head gray_list;
@@ -562,7 +562,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_LIST_HEAD(&object->object_list);
 	INIT_LIST_HEAD(&object->gray_list);
 	INIT_HLIST_HEAD(&object->area_list);
-	spin_lock_init(&object->lock);
+	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
@@ -643,9 +643,9 @@ static void __delete_object(struct kmemleak_object *object)
 	 * Locking here also ensures that the corresponding memory block
 	 * cannot be freed when it is being scanned.
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags &= ~OBJECT_ALLOCATED;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -717,9 +717,9 @@ static void paint_it(struct kmemleak_object *object, int color)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	__paint_it(object, color);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 static void paint_ptr(unsigned long ptr, int color)
@@ -779,7 +779,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (size == SIZE_MAX) {
 		size = object->pointer + object->size - ptr;
 	} else if (ptr + size > object->pointer + object->size) {
@@ -795,7 +795,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 
 	hlist_add_head(&area->node, &object->area_list);
 out_unlock:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	put_object(object);
 }
@@ -818,9 +818,9 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->excess_ref = excess_ref;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -840,9 +840,9 @@ static void object_no_scan(unsigned long ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags |= OBJECT_NO_SCAN;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -903,11 +903,11 @@ static void early_alloc(struct early_log *log)
 			       log->min_count, GFP_ATOMIC);
 	if (!object)
 		goto out;
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	for (i = 0; i < log->trace_len; i++)
 		object->trace[i] = log->trace[i];
 	object->trace_len = log->trace_len;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	rcu_read_unlock();
 }
@@ -1097,9 +1097,9 @@ void __ref kmemleak_update_trace(const void *ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->trace_len = __save_stack_trace(object->trace);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 }
@@ -1335,7 +1335,7 @@ static void scan_block(void *_start, void *_end,
 		 * previously acquired in scan_object(). These locks are
 		 * enclosed by scan_mutex.
 		 */
-		spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 		/* only pass surplus references (object already gray) */
 		if (color_gray(object)) {
 			excess_ref = object->excess_ref;
@@ -1344,7 +1344,7 @@ static void scan_block(void *_start, void *_end,
 			excess_ref = 0;
 			update_refs(object);
 		}
-		spin_unlock(&object->lock);
+		raw_spin_unlock(&object->lock);
 
 		if (excess_ref) {
 			object = lookup_object(excess_ref, 0);
@@ -1353,9 +1353,9 @@ static void scan_block(void *_start, void *_end,
 			if (object == scanned)
 				/* circular reference, ignore */
 				continue;
-			spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+			raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 			update_refs(object);
-			spin_unlock(&object->lock);
+			raw_spin_unlock(&object->lock);
 		}
 	}
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
@@ -1391,7 +1391,7 @@ static void scan_object(struct kmemleak_object *object)
 	 * Once the object->lock is acquired, the corresponding memory block
 	 * cannot be freed (the same lock is acquired in delete_object).
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (object->flags & OBJECT_NO_SCAN)
 		goto out;
 	if (!(object->flags & OBJECT_ALLOCATED))
@@ -1410,9 +1410,9 @@ static void scan_object(struct kmemleak_object *object)
 			if (start >= end)
 				break;
 
-			spin_unlock_irqrestore(&object->lock, flags);
+			raw_spin_unlock_irqrestore(&object->lock, flags);
 			cond_resched();
-			spin_lock_irqsave(&object->lock, flags);
+			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else
 		hlist_for_each_entry(area, &object->area_list, node)
@@ -1420,7 +1420,7 @@ static void scan_object(struct kmemleak_object *object)
 				   (void *)(area->start + area->size),
 				   object);
 out:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 /*
@@ -1473,7 +1473,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1490,7 +1490,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1555,14 +1555,14 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
 		    && update_checksum(object) && get_object(object)) {
 			/* color it gray temporarily */
 			object->count = object->min_count;
 			list_add_tail(&object->gray_list, &gray_list);
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1582,13 +1582,13 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
 			new_leaks++;
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1740,10 +1740,10 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
 	struct kmemleak_object *object = v;
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if ((object->flags & OBJECT_REPORTED) && unreferenced_object(object))
 		print_unreferenced(seq, object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	return 0;
 }
 
@@ -1773,9 +1773,9 @@ static int dump_str_object_info(const char *str)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	dump_object_info(object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 	return 0;
@@ -1794,11 +1794,11 @@ static void kmemleak_clear(void)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if ((object->flags & OBJECT_REPORTED) &&
 		    unreferenced_object(object))
 			__paint_it(object, KMEMLEAK_GREY);
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
-- 
2.14.1

