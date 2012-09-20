From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] tty: prevent unnecessary work queue lock checking on flip buffer copy
Date: Thu, 20 Sep 2012 16:02:42 +0200
Message-ID: <1348149762-4596-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
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
 drivers/tty/tty_buffer.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 5cfa548..b8e90b8 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -492,7 +492,16 @@ static void flush_to_ldisc(struct work_struct *work)
  */
 void tty_flush_to_ldisc(struct tty_struct *tty)
 {
-	flush_work(&tty->buf.work);
+	/*
+	 * Only in case a workqueue is actually used for copying data to the
+	 * line discipline, we'll have to wait for the workqueue to finish. In
+	 * other cases this prevents us from unnecessary blocking by the
+	 * workqueue spin lock.
+	 */
+#ifndef CONFIG_PREEMPT_RT_FULL
+	if (!tty->low_latency)
+		flush_work(&tty->buf.work);
+#endif
 }
 
 /**
-- 
1.7.9.5


