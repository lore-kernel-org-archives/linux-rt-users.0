From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/2] list_bl.h: make list head locking RT safe
Date: Mon, 10 Jun 2013 17:36:48 -0400
Message-ID: <1370900209-40769-2-git-send-email-paul.gortmaker@windriver.com>
References: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-rt-users@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: <rostedt@goodmis.org>, <tglx@linutronix.de>,
	<bigeasy@linutronix.de>, <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:56153 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab3FJVhY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Jun 2013 17:37:24 -0400
In-Reply-To: <1370900209-40769-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

As per changes in include/linux/jbd_common.h for avoiding the
bit_spin_locks on RT ("fs: jbd/jbd2: Make state lock and journal
head lock rt safe") we continue the assumption that bit_spin_locks
are unsafe for RT and hence do the same thing here.

Force the LIST_BL_LOCKMASK to zero for RT, since we won't be
setting the zero'th bit as lock/unlocked state.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/list_bl.h | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index 31f9d75..9c46fea 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -2,6 +2,7 @@
 #define _LINUX_LIST_BL_H
 
 #include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/bit_spinlock.h>
 
 /*
@@ -17,7 +18,7 @@
  * some fast and compact auxiliary data.
  */
 
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
+#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)) && !defined(CONFIG_PREEMPT_RT_BASE)
 #define LIST_BL_LOCKMASK	1UL
 #else
 #define LIST_BL_LOCKMASK	0UL
@@ -32,13 +33,22 @@
 
 struct hlist_bl_head {
 	struct hlist_bl_node *first;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	spinlock_t lock;
+#endif
 };
 
 struct hlist_bl_node {
 	struct hlist_bl_node *next, **pprev;
 };
-#define INIT_HLIST_BL_HEAD(ptr) \
-	((ptr)->first = NULL)
+
+static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
+{
+	h->first = NULL;
+#ifdef CONFIG_PREEMPT_RT_BASE
+	spin_lock_init(&h->lock);
+#endif
+}
 
 static inline void INIT_HLIST_BL_NODE(struct hlist_bl_node *h)
 {
@@ -117,12 +127,20 @@ static inline void hlist_bl_del_init(struct hlist_bl_node *n)
 
 static inline void hlist_bl_lock(struct hlist_bl_head *b)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 	bit_spin_lock(0, (unsigned long *)b);
+#else
+	spin_lock(&b->lock);
+#endif
 }
 
 static inline void hlist_bl_unlock(struct hlist_bl_head *b)
 {
+#ifndef CONFIG_PREEMPT_RT_BASE
 	__bit_spin_unlock(0, (unsigned long *)b);
+#else
+	spin_unlock(&b->lock);
+#endif
 }
 
 /**
-- 
1.8.1.2

