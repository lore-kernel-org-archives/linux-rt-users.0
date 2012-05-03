From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH 1/3] RFC: Solved unnecessary schedule latency in the TTY layer (1/3)
Date: Thu, 3 May 2012 14:37:41 +0200
Message-ID: <1336048663-21882-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, Alan Cox <alan@linux.intel.com>,
	RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:22889
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754277Ab2ECMiA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 3 May 2012 08:38:00 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Solved unnecessary schedule latency in the TTY layer when used in
realtime context:
In case of PREEMPT_RT or when low_latency flag is set by the serial driver
the TTY receive flip buffer is copied to the line discipline directly
instead of using a workqueue in the background. Therefor only in case a
workqueue is actually used for copying data to the line discipline
we'll have to wait for the workqueue to finish. For a PREEMPT system this
prevents us from unnecessary blocking by the workqueue spin lock.

Note: In a PREEMPT_RT system "normal" spin locks behave like mutexes and
no interrupts (and therefor no scheduling) is disabled.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---
 drivers/tty/tty_buffer.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6c9b7cd..ed86359 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -317,12 +317,7 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
 
 void tty_schedule_flip(struct tty_struct *tty)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&tty->buf.lock, flags);
-	if (tty->buf.tail != NULL)
-		tty->buf.tail->commit = tty->buf.tail->used;
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
-	schedule_work(&tty->buf.work);
+	tty_flip_buffer_push(tty);
 }
 EXPORT_SYMBOL(tty_schedule_flip);
 
@@ -469,7 +464,16 @@ static void flush_to_ldisc(struct work_struct *work)
  */
 void tty_flush_to_ldisc(struct tty_struct *tty)
 {
-	flush_work(&tty->buf.work);
+	/*
+	 * Only in case a workqueue is actually used for copying data to the
+	 * line discipline, we'll have to wait for the workqueue to finish. In
+	 * other cases this prevents us from unnecessary blocking by the workqueue
+	 * spin lock.
+	 */
+#ifndef CONFIG_PREEMPT_RT_FULL
+	if (!tty->low_latency)
+		flush_work(&tty->buf.work);
+#endif
 }
 
 /**
-- 
1.7.0.4


