From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH rt] fix "list_bl.h: make list head locking RT safe" for !SMP && !DEBUG_SPINLOCK
Date: Tue,  9 Jul 2013 00:26:32 +0200
Message-ID: <1373322392-27604-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rostedt@goodmis.org, tglx@linutronix.de,
	paulmck@linux.vnet.ibm.com, linux-rt-users@vger.kernel.org,
	kernel@pengutronix.de
To: Paul Gortmaker <paul.gortmaker@windriver.com>,
	bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44333 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975Ab3GHW1f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 8 Jul 2013 18:27:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The patch "list_bl.h: make list head locking RT safe" introduced
an unconditional

	__set_bit(0, (unsigned long *)b);

in void hlist_bl_lock(struct hlist_bl_head *b). This clobbers the value
of b->first. When the value of b->first is retrieved using
hlist_bl_first the clobbering is undone using

	(unsigned long)h->first & ~LIST_BL_LOCKMASK

and so depending on LIST_BL_LOCKMASK being one. But LIST_BL_LOCKMASK is
only one if at least on of CONFIG_SMP and CONFIG_DEBUG_SPINLOCK are
defined. Without these the value returned by hlist_bl_first has the
zeroth bit set which likely results in a crash.

So only do the clobbering in the cases where LIST_BL_LOCKMASK is one.
An alternative would be to always define LIST_BL_LOCKMASK to one with
CONFIG_PREEMPT_RT_BASE.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello,

this applies on top of 3.8-rt13 and makes my ARM board boot again.

Best regards
Uwe

 include/linux/list_bl.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
index ddfd46a..becd7a6 100644
--- a/include/linux/list_bl.h
+++ b/include/linux/list_bl.h
@@ -131,8 +131,10 @@ static inline void hlist_bl_lock(struct hlist_bl_h=
ead *b)
 	bit_spin_lock(0, (unsigned long *)b);
 #else
 	raw_spin_lock(&b->lock);
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	__set_bit(0, (unsigned long *)b);
 #endif
+#endif
 }
=20
 static inline void hlist_bl_unlock(struct hlist_bl_head *b)
@@ -140,7 +142,9 @@ static inline void hlist_bl_unlock(struct hlist_bl_=
head *b)
 #ifndef CONFIG_PREEMPT_RT_BASE
 	__bit_spin_unlock(0, (unsigned long *)b);
 #else
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
 	__clear_bit(0, (unsigned long *)b);
+#endif
 	raw_spin_unlock(&b->lock);
 #endif
 }
--=20
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
