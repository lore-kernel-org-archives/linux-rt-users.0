From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH-v2] tty: prevent unnecessary work queue lock checking on flip buffer copy
Date: Tue, 25 Sep 2012 14:01:46 +0200
Message-ID: <1348574506-23625-1-git-send-email-meltedpianoman@gmail.com>
References: <CAMSQXEGEf8xSYZa+0N77K-Ld5xHLefyMHtK6FxcKCqNhpnMp6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <CAMSQXEGEf8xSYZa+0N77K-Ld5xHLefyMHtK6FxcKCqNhpnMp6g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

In case of PREEMPT_RT or when low_latency flag is set by the serial driver
the TTY receive flip buffer is copied to the line discipline directly
instead of using a work queue in the background. Therefor only in case a
workqueue is actually used for copying data to the line discipline
we'll have to check & wait for the workqueue to finish.

This prevents unnecessary spin lock/unlock on the workqueue spin lock that can
cause additional scheduling overhead on a PREEMPT_RT system. On a 240 MHz
AT91SAM9261 processor setup this fixes about 100us of scheduling overhead on the
TTY read call.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---

 v2:
 Patch v1 was based on the fact that only the tty_flip_buffer_push() function
 was used to copy dat to the line discipline because I removed the
 tty_schedule_flip() in my previous patch "[PATCH] tty: cleanup duplicate
 functions in tty_buffer". Since that patched turned out to be invalid, I had
 to implement this functionality differently.

 drivers/tty/tty_buffer.c |   17 ++++++++++++++---
 include/linux/tty.h      |    3 ++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 6146e8b..dee77b4 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -354,6 +354,7 @@ void tty_schedule_flip(struct tty_struct *tty)
 		tty->buf.tail->commit = tty->buf.tail->used;
 	spin_unlock_irqrestore(&tty->buf.lock, flags);
 	schedule_work(&tty->buf.work);
+	atomic_set(&tty->buf.flush_work, 1);
 }
 EXPORT_SYMBOL(tty_schedule_flip);
 
@@ -514,7 +515,14 @@ static void flush_to_ldisc(struct work_struct *work)
  */
 void tty_flush_to_ldisc(struct tty_struct *tty)
 {
-	flush_work(&tty->buf.work);
+	/*
+	 * The work queue is not always used to move data from the flip buffer
+	 * to the line discipline: the tty_flip_buffer_push() will call the
+	 * flush_to_ldisc() routine directly when low_latency flag is set.
+	 * Therefor only flush the work queue when required.
+	 */
+	if (atomic_xchg(&tty->buf.flush_work, 0))
+		flush_work(&tty->buf.work);
 }
 
 /**
@@ -538,10 +546,12 @@ void tty_flip_buffer_push(struct tty_struct *tty)
 		tty->buf.tail->commit = tty->buf.tail->used;
 	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 
-	if (tty->low_latency)
+	if (tty->low_latency) {
 		flush_to_ldisc(&tty->buf.work);
-	else
+	} else {
 		schedule_work(&tty->buf.work);
+		atomic_set(&tty->buf.flush_work, 1);
+	}
 }
 EXPORT_SYMBOL(tty_flip_buffer_push);
 
@@ -563,5 +573,6 @@ void tty_buffer_init(struct tty_struct *tty)
 	tty->buf.free = NULL;
 	tty->buf.memory_used = 0;
 	INIT_WORK(&tty->buf.work, flush_to_ldisc);
+	atomic_set(&tty->buf.flush_work, 0);
 }
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 21bceef..f76ac5e 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -43,7 +43,7 @@
 #include <linux/tty_driver.h>
 #include <linux/tty_ldisc.h>
 #include <linux/mutex.h>
-
+#include <linux/atomic.h>
 
 
 /*
@@ -86,6 +86,7 @@ struct tty_buffer {
 
 struct tty_bufhead {
 	struct work_struct work;
+	atomic_t flush_work;
 	raw_spinlock_t lock;
 	struct tty_buffer *head;	/* Queue head */
 	struct tty_buffer *tail;	/* Active buffer */
-- 
1.7.9.5


