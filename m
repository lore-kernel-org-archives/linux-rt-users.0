From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH-v3] tty: prevent unnecessary work queue lock checking on flip buffer copy
Date: Thu, 27 Sep 2012 14:02:05 +0200
Message-ID: <1348747325-13539-1-git-send-email-meltedpianoman@gmail.com>
References: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:46480
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752089Ab2I0MCT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 27 Sep 2012 08:02:19 -0400
In-Reply-To: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

When low_latency flag is set the TTY receive flip buffer is copied to the
line discipline directly instead of using a work queue in the background.
Therefor only in case a workqueue is actually used for copying data to the
line discipline we'll have to flush the workqueue.

This prevents unnecessary spin lock/unlock on the workqueue spin lock that
can cause additional scheduling overhead on a PREEMPT_RT system. On a 200
MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
overhead on the TTY read call.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---
 v3:
 Prevented the flush the easy way: workque is not flused when low latency
 flag is set. This means that drivers that use the tty_schedule_flip()
 functions instead of the tty_flip_buffer_push() should never have the
 low_latency flag set, otherwise the workqueue won't be flushed. Added a
 WARN_ON() to detect those drivers.

 For PREEMPT_RT systems: this optimization will only work when the user has
 actually enabled the ASYNC_LOW_LATENCY option for the serial driver, otherwise
 the workqueue will still be flushed although it is not used since the PREMPT_RT
 patch makes the tty_flip_buffer_push() function to always bypass the workqueue.

 drivers/tty/tty_buffer.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6146e8b..b952de1 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -342,6 +342,8 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
  *	Takes any pending buffers and transfers their ownership to the
  *	ldisc side of the queue. It then schedules those characters for
  *	processing by the line discipline.
+ *	Note that this function can only be used when the low_latency flag
+ *	is unset. Otherwise the workqueue won't be flushed.
  *
  *	Locking: Takes tty->buf.lock
  */
@@ -349,6 +351,7 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
 void tty_schedule_flip(struct tty_struct *tty)
 {
 	unsigned long flags;
+	WARN_ON(tty->low_latency);
 	spin_lock_irqsave(&tty->buf.lock, flags);
 	if (tty->buf.tail != NULL)
 		tty->buf.tail->commit = tty->buf.tail->used;
@@ -514,7 +517,8 @@ static void flush_to_ldisc(struct work_struct *work)
  */
 void tty_flush_to_ldisc(struct tty_struct *tty)
 {
-	flush_work(&tty->buf.work);
+	if (!tty->low_latency)
+		flush_work(&tty->buf.work);
 }
 
 /**
-- 
1.7.9.5


