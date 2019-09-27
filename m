Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B6DC32774
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 08:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F349A217D9
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 08:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfI0I3P (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:29:15 -0400
Received: from mail5.windriver.com ([192.103.53.11]:50412 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfI0I3P (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 04:29:15 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x8R8RCgN030907
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Fri, 27 Sep 2019 01:27:46 -0700
Received: from pek-lpggp6.wrs.com (128.224.153.40) by ALA-HCB.corp.ad.wrs.com
 (147.11.189.41) with Microsoft SMTP Server id 14.3.468.0; Fri, 27 Sep 2019
 01:27:26 -0700
From:   Yongxin Liu <yongxin.liu@windriver.com>
To:     <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
CC:     <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <rostedt@goodmis.org>, <haitao.liu@windriver.com>,
        <zhe.he@windriver.com>
Subject: [PATCH RT] kmemleak: Change the lock of kmemleak_object to raw_spinlock_t
Date:   Fri, 27 Sep 2019 16:22:30 +0800
Message-ID: <20190927082230.34152-1-yongxin.liu@windriver.com>
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Liu Haitao <haitao.liu@windriver.com>

The following call trace would be triggered as kmemleak is running.

  BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:968
  in_atomic(): 1, irqs_disabled(): 1, pid: 902, name: kmemleak
  4 locks held by kmemleak/902:
   #0:
   000000001f69be68
    (
  scan_mutex
  ){+.+.}
  , at: kmemleak_scan_thread+0x7c/0xc3
   #1:
  00000000a795ae4c
   (
  mem_hotplug_lock.rw_sem
  ){++++}
   , at: kmemleak_scan+0x1ba/0x7a0
   #2:
  0000000079c12e8b
   (
  kmemleak_lock
  ){....}
  , at: scan_block+0x31/0x120
   #3:
  00000000191afe4b
   (
  &object->lock
  /1
  ){....}
  , at: scan_block+0x8b/0x120
  irq event stamp: 16791384
  hardirqs last  enabled at (16791383): [<ffffffff8326d682>] _raw_spin_unlock_irqrestore+0x82/0x90
  hardirqs last disabled at (16791384): [<ffffffff8326d3da>] _raw_spin_lock_irqsave+0x1a/0x80
  softirqs last  enabled at (0): [<ffffffff824f1f70>] copy_process.part.5+0x760/0x2000
  softirqs last disabled at (0): [<0000000000000000>] 0x0
  Preemption disabled at:
  [<ffffffff82743381>] scan_block+0x31/0x120

  CPU: 63 PID: 902 Comm: kmemleak Tainted: G        W         5.2.14-rt7-preempt-rt+ #2
  Hardware name: Intel Corporation S2600WFS/S2600WFS, BIOS SE5C620.86B.01.00.0694.120620170818 12/06/2017
  Call Trace:
   dump_stack+0x70/0xa5
   ___might_sleep+0x140/0x1e0
   rt_spin_lock_nested+0x59/0x70
   ? scan_block+0x8b/0x120
   scan_block+0x8b/0x120
   kmemleak_scan+0x285/0x7a0
   kmemleak_scan_thread+0x81/0xc3
   kthread+0x12f/0x150
   ? kmemleak_write+0x460/0x460
   ? kthread_park+0xb0/0xb0
   ret_from_fork+0x3a/0x50

The commit 3520604cc08dd63c057296c34756da1b6a655f71 changed the kmemleak_lock
to raw spinlock. However the kmemleak_object->lock is held after the
kmemleak_lock is held in scan_block().

scan_block()
    |
    raw_spin_lock_irqsave(&kmemleak_lock, flags)
       |
       spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);

In this case, the object->lock is implemented by mutex in RT. It could casue a sleeping problem.

Fixes: 3520604cc08d ("kmemleak: Turn kmemleak_lock to raw spinlock on RT")

Signed-off-by: Liu Haitao <haitao.liu@windriver.com>
Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
---
 mm/kmemleak.c | 72 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index aaee59c0306a..355dd95d0611 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -135,7 +135,7 @@ struct kmemleak_scan_area {
  * (use_count) and freed using the RCU mechanism.
  */
 struct kmemleak_object {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int flags;		/* object status flags */
 	struct list_head object_list;
 	struct list_head gray_list;
@@ -560,7 +560,7 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 	INIT_LIST_HEAD(&object->object_list);
 	INIT_LIST_HEAD(&object->gray_list);
 	INIT_HLIST_HEAD(&object->area_list);
-	spin_lock_init(&object->lock);
+	raw_spin_lock_init(&object->lock);
 	atomic_set(&object->use_count, 1);
 	object->flags = OBJECT_ALLOCATED;
 	object->pointer = ptr;
@@ -642,9 +642,9 @@ static void __delete_object(struct kmemleak_object *object)
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
 
@@ -716,9 +716,9 @@ static void paint_it(struct kmemleak_object *object, int color)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	__paint_it(object, color);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 static void paint_ptr(unsigned long ptr, int color)
@@ -778,7 +778,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 		goto out;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (size == SIZE_MAX) {
 		size = object->pointer + object->size - ptr;
 	} else if (ptr + size > object->pointer + object->size) {
@@ -794,7 +794,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 
 	hlist_add_head(&area->node, &object->area_list);
 out_unlock:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 out:
 	put_object(object);
 }
@@ -817,9 +817,9 @@ static void object_set_excess_ref(unsigned long ptr, unsigned long excess_ref)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->excess_ref = excess_ref;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -839,9 +839,9 @@ static void object_no_scan(unsigned long ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->flags |= OBJECT_NO_SCAN;
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 	put_object(object);
 }
 
@@ -902,11 +902,11 @@ static void early_alloc(struct early_log *log)
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
@@ -1096,9 +1096,9 @@ void __ref kmemleak_update_trace(const void *ptr)
 		return;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	object->trace_len = __save_stack_trace(object->trace);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 }
@@ -1346,7 +1346,7 @@ static void scan_block(void *_start, void *_end,
 		 * previously acquired in scan_object(). These locks are
 		 * enclosed by scan_mutex.
 		 */
-		spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
+		raw_spin_lock_nested(&object->lock, SINGLE_DEPTH_NESTING);
 		/* only pass surplus references (object already gray) */
 		if (color_gray(object)) {
 			excess_ref = object->excess_ref;
@@ -1355,7 +1355,7 @@ static void scan_block(void *_start, void *_end,
 			excess_ref = 0;
 			update_refs(object);
 		}
-		spin_unlock(&object->lock);
+		raw_spin_unlock(&object->lock);
 
 		if (excess_ref) {
 			object = lookup_object(excess_ref, 0);
@@ -1364,9 +1364,9 @@ static void scan_block(void *_start, void *_end,
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
@@ -1402,7 +1402,7 @@ static void scan_object(struct kmemleak_object *object)
 	 * Once the object->lock is acquired, the corresponding memory block
 	 * cannot be freed (the same lock is acquired in delete_object).
 	 */
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	if (object->flags & OBJECT_NO_SCAN)
 		goto out;
 	if (!(object->flags & OBJECT_ALLOCATED))
@@ -1421,9 +1421,9 @@ static void scan_object(struct kmemleak_object *object)
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
@@ -1431,7 +1431,7 @@ static void scan_object(struct kmemleak_object *object)
 				   (void *)(area->start + area->size),
 				   object);
 out:
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 }
 
 /*
@@ -1484,7 +1484,7 @@ static void kmemleak_scan(void)
 	/* prepare the kmemleak_object's */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 #ifdef DEBUG
 		/*
 		 * With a few exceptions there should be a maximum of
@@ -1501,7 +1501,7 @@ static void kmemleak_scan(void)
 		if (color_gray(object) && get_object(object))
 			list_add_tail(&object->gray_list, &gray_list);
 
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1569,14 +1569,14 @@ static void kmemleak_scan(void)
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
 
@@ -1596,7 +1596,7 @@ static void kmemleak_scan(void)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(object, &object_list, object_list) {
-		spin_lock_irqsave(&object->lock, flags);
+		raw_spin_lock_irqsave(&object->lock, flags);
 		if (unreferenced_object(object) &&
 		    !(object->flags & OBJECT_REPORTED)) {
 			object->flags |= OBJECT_REPORTED;
@@ -1606,7 +1606,7 @@ static void kmemleak_scan(void)
 
 			new_leaks++;
 		}
-		spin_unlock_irqrestore(&object->lock, flags);
+		raw_spin_unlock_irqrestore(&object->lock, flags);
 	}
 	rcu_read_unlock();
 
@@ -1758,10 +1758,10 @@ static int kmemleak_seq_show(struct seq_file *seq, void *v)
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
 
@@ -1791,9 +1791,9 @@ static int dump_str_object_info(const char *str)
 		return -EINVAL;
 	}
 
-	spin_lock_irqsave(&object->lock, flags);
+	raw_spin_lock_irqsave(&object->lock, flags);
 	dump_object_info(object);
-	spin_unlock_irqrestore(&object->lock, flags);
+	raw_spin_unlock_irqrestore(&object->lock, flags);
 
 	put_object(object);
 	return 0;
@@ -1812,11 +1812,11 @@ static void kmemleak_clear(void)
 
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
2.14.4

