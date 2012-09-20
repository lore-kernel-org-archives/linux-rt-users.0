From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] tty: Use raw spin lock to protect TTY ldisc administration
Date: Thu, 20 Sep 2012 16:05:28 +0200
Message-ID: <1348149928-4681-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The global "normal" spin lock that guards the line discipline
administration is replaced by a raw spin lock. On a PREEMPT_RT system this
prevents unwanted scheduling overhead around the line discipline administration.

On a 240 MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
overhead on a TTY read or write call.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---
 drivers/tty/tty_ldisc.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 6f99c99..12cfde6 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -26,7 +26,7 @@
  *	callers who will do ldisc lookups and cannot sleep.
  */
 
-static DEFINE_SPINLOCK(tty_ldisc_lock);
+static DEFINE_RAW_SPINLOCK(tty_ldisc_lock);
 static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
 /* Line disc dispatch table */
 static struct tty_ldisc_ops *tty_ldiscs[NR_LDISCS];
@@ -49,21 +49,21 @@ static void put_ldisc(struct tty_ldisc *ld)
 	 * If this is the last user, free the ldisc, and
 	 * release the ldisc ops.
 	 *
-	 * We really want an "atomic_dec_and_lock_irqsave()",
+	 * We really want an "atomic_dec_and_raw_lock_irqsave()",
 	 * but we don't have it, so this does it by hand.
 	 */
-	local_irq_save(flags);
-	if (atomic_dec_and_lock(&ld->users, &tty_ldisc_lock)) {
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
+	if (atomic_dec_and_test(&ld->users)) {
 		struct tty_ldisc_ops *ldo = ld->ops;
 
 		ldo->refcount--;
 		module_put(ldo->owner);
-		spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+		raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 
 		kfree(ld);
 		return;
 	}
-	local_irq_restore(flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	wake_up(&ld->wq_idle);
 }
 
@@ -88,11 +88,11 @@ int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return -EINVAL;
 
-	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	tty_ldiscs[disc] = new_ldisc;
 	new_ldisc->num = disc;
 	new_ldisc->refcount = 0;
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 
 	return ret;
 }
@@ -118,12 +118,12 @@ int tty_unregister_ldisc(int disc)
 	if (disc < N_TTY || disc >= NR_LDISCS)
 		return -EINVAL;
 
-	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	if (tty_ldiscs[disc]->refcount)
 		ret = -EBUSY;
 	else
 		tty_ldiscs[disc] = NULL;
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 
 	return ret;
 }
@@ -134,7 +134,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 	unsigned long flags;
 	struct tty_ldisc_ops *ldops, *ret;
 
-	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	ret = ERR_PTR(-EINVAL);
 	ldops = tty_ldiscs[disc];
 	if (ldops) {
@@ -144,7 +144,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 			ret = ldops;
 		}
 	}
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	return ret;
 }
 
@@ -152,10 +152,10 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	ldops->refcount--;
 	module_put(ldops->owner);
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 }
 
 /**
@@ -287,11 +287,11 @@ static struct tty_ldisc *tty_ldisc_try(struct tty_struct *tty)
 	unsigned long flags;
 	struct tty_ldisc *ld;
 
-	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	ld = NULL;
 	if (test_bit(TTY_LDISC, &tty->flags))
 		ld = get_ldisc(tty->ldisc);
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	return ld;
 }
 
-- 
1.7.9.5


