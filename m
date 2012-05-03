From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH 2/3] RFC: Solved unnecessary schedule latency in the TTY layer (2/3)
Date: Thu, 3 May 2012 14:37:42 +0200
Message-ID: <1336048663-21882-2-git-send-email-meltedpianoman@gmail.com>
References: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:49867
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754830Ab2ECMiG (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 08:38:06 -0400
In-Reply-To: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Solved unnecessary schedule latency in the TTY layer when used in
realtime context:
The global "normal" spin lock that guards the line discipline
administration is replaced by a raw spin lock.

Note: In a PREEMPT_RT system "normal" spin locks behave like mutexes and
no interrupts (and therefor no scheduling) is disabled.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>

Conflicts:

	drivers/tty/tty_ldisc.c
---
 drivers/tty/tty_ldisc.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 24b95db..30836cc 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -26,7 +26,7 @@
  *	callers who will do ldisc lookups and cannot sleep.
  */
 
-static DEFINE_SPINLOCK(tty_ldisc_lock);
+static DEFINE_RAW_SPINLOCK(tty_ldisc_lock);
 static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_wait);
 static DECLARE_WAIT_QUEUE_HEAD(tty_ldisc_idle);
 /* Line disc dispatch table */
@@ -53,18 +53,18 @@ static void put_ldisc(struct tty_ldisc *ld)
 	 * We really want an "atomic_dec_and_lock_irqsave()",
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
 	wake_up(&tty_ldisc_idle);
 }
 
@@ -89,11 +89,11 @@ int tty_register_ldisc(int disc, struct tty_ldisc_ops *new_ldisc)
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
@@ -119,12 +119,12 @@ int tty_unregister_ldisc(int disc)
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
@@ -135,7 +135,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 	unsigned long flags;
 	struct tty_ldisc_ops *ldops, *ret;
 
-	spin_lock_irqsave(&tty_ldisc_lock, flags);
+	raw_spin_lock_irqsave(&tty_ldisc_lock, flags);
 	ret = ERR_PTR(-EINVAL);
 	ldops = tty_ldiscs[disc];
 	if (ldops) {
@@ -145,7 +145,7 @@ static struct tty_ldisc_ops *get_ldops(int disc)
 			ret = ldops;
 		}
 	}
-	spin_unlock_irqrestore(&tty_ldisc_lock, flags);
+	raw_spin_unlock_irqrestore(&tty_ldisc_lock, flags);
 	return ret;
 }
 
@@ -153,10 +153,10 @@ static void put_ldops(struct tty_ldisc_ops *ldops)
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
@@ -286,11 +286,11 @@ static struct tty_ldisc *tty_ldisc_try(struct tty_struct *tty)
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
1.7.0.4


