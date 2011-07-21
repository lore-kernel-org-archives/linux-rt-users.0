From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] Various fixups from first bug reports
Date: Thu, 21 Jul 2011 21:57:57 +0200
Message-ID: <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
Cc: hermann <brummer-@web.de>, Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58044 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab1GUT6Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Jul 2011 15:58:24 -0400
In-Reply-To: <alpine.LFD.2.02.1107211932440.2702@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

---
Hello,

this is the patch Thomas sent earlier in this thread with the two fixups
folded in that occured in reply to Thomas' patch.

Best regards
Uwe

 include/linux/buffer_head.h |    6 ++++--
 kernel/timer.c              |   40 ++++++++++++++++++++++++++++++++--------
 mm/page_alloc.c             |    4 ++--
 3 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7283b77..dbaeaec 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -74,7 +74,8 @@ struct buffer_head {
 	atomic_t b_count;		/* users using this buffer_head */
 #ifdef CONFIG_PREEMPT_RT_BASE
 	spinlock_t b_uptodate_lock;
-#if defined(CONFIG_JBD) || defined(CONFIG_JBD2)
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || \
+    defined(CONFIG_JBD2) || defined(CONFIG_JBD2_MODULE)
 	spinlock_t b_state_lock;
 	spinlock_t b_journal_head_lock;
 #endif
@@ -109,7 +110,8 @@ static inline void buffer_head_init_locks(struct buffer_head *bh)
 {
 #ifdef CONFIG_PREEMPT_RT_BASE
 	spin_lock_init(&bh->b_uptodate_lock);
-#if defined(CONFIG_JBD) || defined(CONFIG_JBD2)
+#if defined(CONFIG_JBD) || defined(CONFIG_JBD_MODULE) || \
+    defined(CONFIG_JBD2) || defined(CONFIG_JBD2_MODULE)
 	spin_lock_init(&bh->b_state_lock);
 	spin_lock_init(&bh->b_journal_head_lock);
 #endif
diff --git a/kernel/timer.c b/kernel/timer.c
index 20b548f..937799f 100644
--- a/kernel/timer.c
+++ b/kernel/timer.c
@@ -654,6 +654,36 @@ static struct tvec_base *lock_timer_base(struct timer_list *timer,
 	}
 }
 
+#ifndef CONFIG_PREEMPT_RT_FULL
+static inline struct tvec_base *switch_timer_base(struct timer_list *timer,
+						  struct tvec_base *old,
+						  struct tvec_base *new)
+{
+	/* See the comment in lock_timer_base() */
+	timer_set_base(timer, NULL);
+	spin_unlock(&old->lock);
+	spin_lock(&new->lock);
+	timer_set_base(timer, new);
+	return new;
+}
+#else
+static inline struct tvec_base *switch_timer_base(struct timer_list *timer,
+						  struct tvec_base *old,
+						  struct tvec_base *new)
+{
+	/*
+	 * We cannot do the above because we might be preempted and
+	 * then the preempter would see NULL and loop forever.
+	 */
+	if (spin_trylock(&new->lock)) {
+		timer_set_base(timer, new);
+		spin_unlock(&old->lock);
+		return new;
+	}
+	return old;
+}
+#endif
+
 static inline int
 __mod_timer(struct timer_list *timer, unsigned long expires,
 						bool pending_only, int pinned)
@@ -699,14 +729,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires,
 		 * handler yet has not finished. This also guarantees that
 		 * the timer is serialized wrt itself.
 		 */
-		if (likely(base->running_timer != timer)) {
-			/* See the comment in lock_timer_base() */
-			timer_set_base(timer, NULL);
-			spin_unlock(&base->lock);
-			base = new_base;
-			spin_lock(&base->lock);
-			timer_set_base(timer, base);
-		}
+		if (likely(base->running_timer != timer))
+			base = switch_timer_base(timer, base, new_base);
 	}
 
 	timer->expires = expires;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 57d70b8..33fd80f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1943,8 +1943,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	if (*did_some_progress != COMPACT_SKIPPED) {
 
 		/* Page migration frees to the PCP lists but we want merging */
-		drain_pages(get_cpu());
-		put_cpu();
+		drain_pages(get_cpu_light());
+		put_cpu_light();
 
 		page = get_page_from_freelist(gfp_mask, nodemask,
 				order, zonelist, high_zoneidx,
-- 
1.7.5.4

