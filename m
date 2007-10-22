From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: [PATCH][DEBUG_PI_LIST]: Set plist.lock to NULL on PREEMPT_RT
Date: Mon, 22 Oct 2007 14:43:02 -0200
Message-ID: <20071022164302.GB15773@ghostprotocols.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.233]:14618 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXJVQnK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Oct 2007 12:43:10 -0400
Received: by nz-out-0506.google.com with SMTP id s18so477677nze
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Oct 2007 09:43:09 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On RT struct plist_head->lock is a raw_spinlock_t, but struct futex_hash_bucket->lock,
that is set to plist_head->lock is a spinlock, which becomes a mutex on RT.
Later in plist_check_head spin_is_locked can't figure out what is the right type,
triggering a WARN_ON_SMP. As we were already special casing PREEMPT_RT on
plist_check_head..

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff -uNrp linux-2.6.23-rt1.orig/kernel/futex.c linux-2.6.23-rt1/kernel/futex.c
--- linux-2.6.23-rt1.orig/kernel/futex.c	2007-10-22 12:28:11.000000000 -0200
+++ linux-2.6.23-rt1/kernel/futex.c	2007-10-22 12:27:07.000000000 -0200
@@ -947,9 +947,13 @@ static int futex_requeue(u32 __user *uad
 				plist_del(&this->list, &hb1->chain);
 				plist_add(&this->list, &hb2->chain);
 				this->lock_ptr = &hb2->lock;
-#if defined(CONFIG_DEBUG_PI_LIST) && !defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_DEBUG_PI_LIST
+#ifdef CONFIG_PREEMPT_RT
+				this->list.plist.lock = NULL;
+#else
 				this->list.plist.lock = &hb2->lock;
 #endif
+#endif
 			}
 			this->key = key2;
 			get_futex_key_refs(&key2);
@@ -1008,9 +1012,13 @@ static inline void __queue_me(struct fut
 	prio = min(current->normal_prio, MAX_RT_PRIO);
 
 	plist_node_init(&q->list, prio);
-#if defined(CONFIG_DEBUG_PI_LIST) && !defined(CONFIG_PREEMPT_RT)
+#ifdef CONFIG_DEBUG_PI_LIST
+#ifdef CONFIG_PREEMPT_RT
+	q->list.plist.lock = NULL;
+#else
 	q->list.plist.lock = &hb->lock;
 #endif
+#endif
 	plist_add(&q->list, &hb->chain);
 	q->task = current;
 	spin_unlock(&hb->lock);
