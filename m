From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] tty: cleanup duplicate functions in tty_buffer
Date: Thu, 20 Sep 2012 15:53:43 +0200
Message-ID: <1348149223-4281-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>,
	Heiko Carstens <heiko.carstens@de.ibm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

tty_buffer.c implements two functions that implement similar functionality
* tty_schedule_flip()
* tty_flip_buffer_push()

Both functions flush data from the flip buffer to the ldisc side of the
queue. Only difference is that the tty_schedule_flip() will always use a
work queue to do the job, while the tty_flip_buffer_push() function can
flush the data immediately in case of low latency mode or in case of
PREEMT_RT.

Therefor the the tty_scedule_flip() function and replaced it everywhere
with the tty_flip_buffer_push() beause that function is used the most by
serial drivers and implements the work queue bypass mechanism.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---
 arch/alpha/kernel/srmcons.c             |    2 +-
 drivers/s390/char/keyboard.h            |    4 ++--
 drivers/staging/serqt_usb2/serqt_usb2.c |    4 +---
 drivers/tty/cyclades.c                  |    6 +++---
 drivers/tty/moxa.c                      |    4 ++--
 drivers/tty/serial/68328serial.c        |    2 +-
 drivers/tty/tty_buffer.c                |   25 +------------------------
 include/linux/tty_flip.h                |    1 -
 8 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 3ea8094..22436cc 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -58,7 +58,7 @@ srmcons_do_receive_chars(struct tty_struct *tty)
 	} while((result.bits.status & 1) && (++loops < 10));
 
 	if (count)
-		tty_schedule_flip(tty);
+		tty_flip_buffer_push(tty);
 
 	return count;
 }
diff --git a/drivers/s390/char/keyboard.h b/drivers/s390/char/keyboard.h
index d0ae2be..e21d318 100644
--- a/drivers/s390/char/keyboard.h
+++ b/drivers/s390/char/keyboard.h
@@ -47,7 +47,7 @@ kbd_put_queue(struct tty_port *port, int ch)
 	if (!tty)
 		return;
 	tty_insert_flip_char(tty, ch, 0);
-	tty_schedule_flip(tty);
+	tty_flip_buffer_push(tty);
 	tty_kref_put(tty);
 }
 
@@ -59,6 +59,6 @@ kbd_puts_queue(struct tty_port *port, char *cp)
 		return;
 	while (*cp)
 		tty_insert_flip_char(tty, *cp++, 0);
-	tty_schedule_flip(tty);
+	tty_flip_buffer_push(tty);
 	tty_kref_put(tty);
 }
diff --git a/drivers/staging/serqt_usb2/serqt_usb2.c b/drivers/staging/serqt_usb2/serqt_usb2.c
index 8a362f7..32a6c87 100644
--- a/drivers/staging/serqt_usb2/serqt_usb2.c
+++ b/drivers/staging/serqt_usb2/serqt_usb2.c
@@ -428,10 +428,8 @@ static void qt_read_bulk_callback(struct urb *urb)
 		dbg("%s - failed resubmitting read urb, error %d",
 		    __func__, result);
 	else {
-		if (tty && RxCount) {
+		if (tty && RxCount)
 			tty_flip_buffer_push(tty);
-			tty_schedule_flip(tty);
-		}
 	}
 
 	schedule_work(&port->work);
diff --git a/drivers/tty/cyclades.c b/drivers/tty/cyclades.c
index e61cabd..71b54b2 100644
--- a/drivers/tty/cyclades.c
+++ b/drivers/tty/cyclades.c
@@ -564,7 +564,7 @@ static void cyy_chip_rx(struct cyclades_card *cinfo, int chip,
 		}
 		info->idle_stats.recv_idle = jiffies;
 	}
-	tty_schedule_flip(tty);
+	tty_flip_buffer_push(tty);
 	tty_kref_put(tty);
 end:
 	/* end of service */
@@ -1009,7 +1009,7 @@ static void cyz_handle_rx(struct cyclades_port *info, struct tty_struct *tty)
 						jiffies + 1);
 #endif
 			info->idle_stats.recv_idle = jiffies;
-			tty_schedule_flip(tty);
+			tty_flip_buffer_push(tty);
 		}
 		/* Update rx_get */
 		cy_writel(&buf_ctrl->rx_get, new_rx_get);
@@ -1188,7 +1188,7 @@ static void cyz_handle_cmd(struct cyclades_card *cinfo)
 		if (delta_count)
 			wake_up_interruptible(&info->port.delta_msr_wait);
 		if (special_count)
-			tty_schedule_flip(tty);
+			tty_flip_buffer_push(tty);
 		tty_kref_put(tty);
 	}
 }
diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 324467d..dff6e5a 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -1384,7 +1384,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 		if (inited && !test_bit(TTY_THROTTLED, &tty->flags) &&
 				MoxaPortRxQueue(p) > 0) { /* RX */
 			MoxaPortReadData(p);
-			tty_schedule_flip(tty);
+			tty_flip_buffer_push(tty);
 		}
 	} else {
 		clear_bit(EMPTYWAIT, &p->statusflags);
@@ -1409,7 +1409,7 @@ static int moxa_poll_port(struct moxa_port *p, unsigned int handle,
 
 	if (tty && (intr & IntrBreak) && !I_IGNBRK(tty)) { /* BREAK */
 		tty_insert_flip_char(tty, 0, TTY_BREAK);
-		tty_schedule_flip(tty);
+		tty_flip_buffer_push(tty);
 	}
 
 	if (intr & IntrLine)
diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
index 3ed20e4..2bdc514 100644
--- a/drivers/tty/serial/68328serial.c
+++ b/drivers/tty/serial/68328serial.c
@@ -310,7 +310,7 @@ static void receive_chars(struct m68k_serial *info, struct tty_struct *tty,
 	} while((rx = uart->urx.w) & URX_DATA_READY);
 #endif
 
-	tty_schedule_flip(tty);
+	tty_flip_buffer_push(tty);
 
 clear_and_exit:
 	return;
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 91e326f..5cfa548 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -336,28 +336,6 @@ int tty_insert_flip_string_flags(struct tty_struct *tty,
 EXPORT_SYMBOL(tty_insert_flip_string_flags);
 
 /**
- *	tty_schedule_flip	-	push characters to ldisc
- *	@tty: tty to push from
- *
- *	Takes any pending buffers and transfers their ownership to the
- *	ldisc side of the queue. It then schedules those characters for
- *	processing by the line discipline.
- *
- *	Locking: Takes tty->buf.lock
- */
-
-void tty_schedule_flip(struct tty_struct *tty)
-{
-	unsigned long flags;
-	spin_lock_irqsave(&tty->buf.lock, flags);
-	if (tty->buf.tail != NULL)
-		tty->buf.tail->commit = tty->buf.tail->used;
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
-	schedule_work(&tty->buf.work);
-}
-EXPORT_SYMBOL(tty_schedule_flip);
-
-/**
  *	tty_prepare_flip_string		-	make room for characters
  *	@tty: tty
  *	@chars: return pointer for character write area
@@ -521,8 +499,7 @@ void tty_flush_to_ldisc(struct tty_struct *tty)
  *	tty_flip_buffer_push	-	terminal
  *	@tty: tty to push
  *
- *	Queue a push of the terminal flip buffers to the line discipline. This
- *	function must not be called from IRQ context if tty->low_latency is set.
+ *	Queue a push of the terminal flip buffers to the line discipline.
  *
  *	In the event of the queue being busy for flipping the work will be
  *	held off and retried later.
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 9239d03..7d58772 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -6,7 +6,6 @@ extern int tty_insert_flip_string_flags(struct tty_struct *tty, const unsigned c
 extern int tty_insert_flip_string_fixed_flag(struct tty_struct *tty, const unsigned char *chars, char flag, size_t size);
 extern int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size);
 extern int tty_prepare_flip_string_flags(struct tty_struct *tty, unsigned char **chars, char **flags, size_t size);
-void tty_schedule_flip(struct tty_struct *tty);
 
 static inline int tty_insert_flip_char(struct tty_struct *tty,
 					unsigned char ch, char flag)
-- 
1.7.9.5


