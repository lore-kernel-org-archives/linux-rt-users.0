From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT][PTT] Revert "ACPI: Convert embedded controller lock to
 raw spinlock"
Date: Fri, 09 Mar 2012 17:31:26 -0500
Message-ID: <1331332286.25686.610.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>, Tim Blechmann <tim@klingt.org>
To: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24808 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964875Ab2CIWb2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 Mar 2012 17:31:28 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is a call for PTT (Please Test This).

There's been lots of complaints about acpi failing. One of the solutions
is to revert the spin_lock to raw_spin_locks of the acpi code. This is
the revert. Please apply this to 3.0.23-rt39 and lets see if it fixes
the problem at hand, and make sure it doesn't cause other bugs.

Thanks,

-- Steve



commit 8ba46b8b7b495a98b47dfcb316d16634c3c2c924
Author: Steven Rostedt <srostedt@redhat.com>
Date:   Fri Mar 9 17:14:05 2012 -0500

    Revert "ACPI: Convert embedded controller lock to raw spinlock"
    
    This reverts commit 1a39c79b4d1a6911a39083719a999fbfba7287ae.

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index db0e6c3..b72a603 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -152,10 +152,10 @@ static int ec_transaction_done(struct acpi_ec *ec)
 {
 	unsigned long flags;
 	int ret = 0;
-	raw_spin_lock_irqsave(&ec->curr_lock, flags);
+	spin_lock_irqsave(&ec->curr_lock, flags);
 	if (!ec->curr || ec->curr->done)
 		ret = 1;
-	raw_spin_unlock_irqrestore(&ec->curr_lock, flags);
+	spin_unlock_irqrestore(&ec->curr_lock, flags);
 	return ret;
 }
 
@@ -169,7 +169,7 @@ static void start_transaction(struct acpi_ec *ec)
 static void advance_transaction(struct acpi_ec *ec, u8 status)
 {
 	unsigned long flags;
-	raw_spin_lock_irqsave(&ec->curr_lock, flags);
+	spin_lock_irqsave(&ec->curr_lock, flags);
 	if (!ec->curr)
 		goto unlock;
 	if (ec->curr->wlen > ec->curr->wi) {
@@ -194,7 +194,7 @@ err:
 	if (in_interrupt())
 		++ec->curr->irq_count;
 unlock:
-	raw_spin_unlock_irqrestore(&ec->curr_lock, flags);
+	spin_unlock_irqrestore(&ec->curr_lock, flags);
 }
 
 static int acpi_ec_sync_query(struct acpi_ec *ec);
@@ -232,9 +232,9 @@ static int ec_poll(struct acpi_ec *ec)
 		if (acpi_ec_read_status(ec) & ACPI_EC_FLAG_IBF)
 			break;
 		pr_debug(PREFIX "controller reset, restart transaction\n");
-		raw_spin_lock_irqsave(&ec->curr_lock, flags);
+		spin_lock_irqsave(&ec->curr_lock, flags);
 		start_transaction(ec);
-		raw_spin_unlock_irqrestore(&ec->curr_lock, flags);
+		spin_unlock_irqrestore(&ec->curr_lock, flags);
 	}
 	return -ETIME;
 }
@@ -247,17 +247,17 @@ static int acpi_ec_transaction_unlocked(struct acpi_ec *ec,
 	if (EC_FLAGS_MSI)
 		udelay(ACPI_EC_MSI_UDELAY);
 	/* start transaction */
-	raw_spin_lock_irqsave(&ec->curr_lock, tmp);
+	spin_lock_irqsave(&ec->curr_lock, tmp);
 	/* following two actions should be kept atomic */
 	ec->curr = t;
 	start_transaction(ec);
 	if (ec->curr->command == ACPI_EC_COMMAND_QUERY)
 		clear_bit(EC_FLAGS_QUERY_PENDING, &ec->flags);
-	raw_spin_unlock_irqrestore(&ec->curr_lock, tmp);
+	spin_unlock_irqrestore(&ec->curr_lock, tmp);
 	ret = ec_poll(ec);
-	raw_spin_lock_irqsave(&ec->curr_lock, tmp);
+	spin_lock_irqsave(&ec->curr_lock, tmp);
 	ec->curr = NULL;
-	raw_spin_unlock_irqrestore(&ec->curr_lock, tmp);
+	spin_unlock_irqrestore(&ec->curr_lock, tmp);
 	return ret;
 }
 
@@ -678,7 +678,7 @@ static struct acpi_ec *make_acpi_ec(void)
 	mutex_init(&ec->lock);
 	init_swait_head(&ec->wait);
 	INIT_LIST_HEAD(&ec->list);
-	raw_spin_lock_init(&ec->curr_lock);
+	spin_lock_init(&ec->curr_lock);
 	return ec;
 }
 
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 2519b6e..6f889ba 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -64,7 +64,7 @@ struct acpi_ec {
 	struct swait_head wait;
 	struct list_head list;
 	struct transaction *curr;
-	raw_spinlock_t curr_lock;
+	spinlock_t curr_lock;
 };
 
 extern struct acpi_ec *first_ec;


