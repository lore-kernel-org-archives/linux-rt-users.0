From: Thomas Gleixner <tglx@linutronix.de>
Subject: [ANNOUNCE] 3.2-rc4-rt6
Date: Mon, 5 Dec 2011 22:09:37 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112052205350.2735@ionos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57444 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586Ab1LEVJj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 16:09:39 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear RT Folks,

I'm pleased to announce the 3.2-rc4-rt6 release.

NOTE: Releases are back to www.kernel.org - the intermediate tglx.de
      release URL is history!

Changes vs. 3.2-rc4-rt5:

  * more acpi raw spinlock annotations (Clark)
    	[acpi-make-ec-lock-raw-as-well.patch] -> stable

The incremental patch against 3.2-rc4-rt5 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/incr/patch-3.2-rc4-rt5-rt6.patch.bz2    

and is also appended below.


The RT patch against 3.2-rc4 can be found here:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patch-3.2-rc4-rt6.patch.bz2 


The split quilt queue is available at:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.2/patches-3.2-rc4-rt6.tar.bz2 


Enjoy,

	tglx
---
Index: linux-3.2/localversion-rt
===================================================================
--- linux-3.2.orig/localversion-rt
+++ linux-3.2/localversion-rt
@@ -1 +1 @@
--rt5
+-rt6
Index: linux-3.2/drivers/acpi/ec.c
===================================================================
--- linux-3.2.orig/drivers/acpi/ec.c
+++ linux-3.2/drivers/acpi/ec.c
@@ -152,10 +152,10 @@ static int ec_transaction_done(struct ac
 {
 	unsigned long flags;
 	int ret = 0;
-	spin_lock_irqsave(&ec->curr_lock, flags);
+	raw_spin_lock_irqsave(&ec->curr_lock, flags);
 	if (!ec->curr || ec->curr->done)
 		ret = 1;
-	spin_unlock_irqrestore(&ec->curr_lock, flags);
+	raw_spin_unlock_irqrestore(&ec->curr_lock, flags);
 	return ret;
 }
 
@@ -169,7 +169,7 @@ static void start_transaction(struct acp
 static void advance_transaction(struct acpi_ec *ec, u8 status)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&ec->curr_lock, flags);
+	raw_spin_lock_irqsave(&ec->curr_lock, flags);
 	if (!ec->curr)
 		goto unlock;
 	if (ec->curr->wlen > ec->curr->wi) {
@@ -194,7 +194,7 @@ err:
 	if (in_interrupt())
 		++ec->curr->irq_count;
 unlock:
-	spin_unlock_irqrestore(&ec->curr_lock, flags);
+	raw_spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
 
 static int acpi_ec_sync_query(struct acpi_ec *ec);
@@ -232,9 +232,9 @@ static int ec_poll(struct acpi_ec *ec)
 		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
 			break;
 		pr_debug(PREFIX "controller reset, restart transaction\n");
-		spin_lock_irqsave(&ec->curr_lock, flags);
+		raw_spin_lock_irqsave(&ec->curr_lock, flags);
 		start_transaction(ec);
-		spin_unlock_irqrestore(&ec->curr_lock, flags);
+		raw_spin_unlock_irqrestore(&ec->curr_lock, flags);
 	}
 	return -ETIME;
 }
@@ -247,17 +247,17 @@ static int acpi_ec_transaction_unlocked(
 	if (EC_FLAGS_MSI)
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
-	spin_lock_irqsave(&ec->curr_lock, tmp);
+	raw_spin_lock_irqsave(&ec->curr_lock, tmp);
 	/* following two actions should be kept atomic */
 	ec->curr = t;
 	start_transaction(ec);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	spin_unlock_irqrestore(&ec->curr_lock, tmp);
+	raw_spin_unlock_irqrestore(&ec->curr_lock, tmp);
 	ret = ec_poll(ec);
-	spin_lock_irqsave(&ec->curr_lock, tmp);
+	raw_spin_lock_irqsave(&ec->curr_lock, tmp);
 	ec->curr = NULL;
-	spin_unlock_irqrestore(&ec->curr_lock, tmp);
+	raw_spin_unlock_irqrestore(&ec->curr_lock, tmp);
 	return ret;
 }
 
@@ -678,7 +678,7 @@ static struct acpi_ec *make_acpi_ec(void
 	mutex_init(&ec->lock);
 	init_waitqueue_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	spin_lock_init(&ec->curr_lock);
+	raw_spin_lock_init(&ec->curr_lock);
 	return ec;
 }
 
Index: linux-3.2/drivers/acpi/internal.h
===================================================================
--- linux-3.2.orig/drivers/acpi/internal.h
+++ linux-3.2/drivers/acpi/internal.h
@@ -62,7 +62,7 @@ struct acpi_ec {
 	wait_queue_head_t wait;
 	struct list_head list;
 	struct transaction *curr;
-	spinlock_t curr_lock;
+	raw_spinlock_t curr_lock;
 };
 
 extern struct acpi_ec *first_ec;
