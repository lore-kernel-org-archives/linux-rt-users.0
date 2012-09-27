From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH-v3] tty: prevent unnecessary work queue lock checking on flip buffer copy
Date: Thu, 27 Sep 2012 13:58:21 +0200
Message-ID: <1348747101-13462-1-git-send-email-meltedpianoman@gmail.com>
References: <20120925154707.33aa2fa4@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120925154707.33aa2fa4@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

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
 todo

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


