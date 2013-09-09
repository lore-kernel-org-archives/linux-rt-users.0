From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/16] list_bl.h: fix it for for !SMP && !DEBUG_SPINLOCK
Date: Mon, 09 Sep 2013 08:47:50 -0400
Message-ID: <20130909124759.575383146@goodmis.org>
References: <20130909124745.590777496@goodmis.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-list_bl.h-fix-it-for-for-SMP-DEBUG_SPINLOCK.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

=46rom: =3D?UTF-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig@=
pengutronix.de>

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

Cc: stable-rt@vger.kernel.org
Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/list_bl.h |    4 ++++
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
1.7.10.4
