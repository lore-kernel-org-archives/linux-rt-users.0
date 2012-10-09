From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH-v2] tty: Use raw spin lock to protect RX flip buffer
Date: Tue, 9 Oct 2012 13:15:13 +0200
Message-ID: <1349781313-8670-1-git-send-email-meltedpianoman@gmail.com>
References: <1348478680-11505-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Ivo Sieben <meltedpianoman@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	<linux-serial@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1348478680-11505-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The "normal" spin lock that guards the RX flip buffer is replaced by a raw
spin lock.

On a PREEMP_RT system this prevents unwanted scheduling overhead when data is
read at the same time as data is being received: while RX IRQ threaded handling
is busy a TTY read call is performed from a RT priority > threaded IRQ priority.
The read call tries to take the flip buffer spin lock (held by the threaded IRQ)
which blocks and causes a context switch to/from the threaded IRQ handler until
the spin lock is unlocked.

On a 200 MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
overhead on the TTY read call.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---

@Thomas Gleixner & Steven Rostedt:
Alan Cox has responded to this patch: "I've no real opinion on the spin/raw_spin
choices as it's basically an RT question not a tty one so if the rt folks are
happy with it so am I." Do you agree?

v2:
Patch was based on another - abandoned - patch om mine, what introduced a bug in
the tty_schedule_flip() function. Fixed this and rebased it on the latest kernel
tree.


 drivers/tty/tty_buffer.c |   44 ++++++++++++++++++++++----------------------
 include/linux/kbd_kern.h |    4 ++--
 include/linux/tty.h      |    2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index 91e326f..70cf324 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -135,20 +135,20 @@ static void __tty_buffer_flush(struct tty_struct *tty)
 void tty_buffer_flush(struct tty_struct *tty)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&tty->buf.lock, flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, flags);
 
 	/* If the data is being pushed to the tty layer then we can't
 	   process it here. Instead set a flag and the flush_to_ldisc
 	   path will process the flush request before it exits */
 	if (test_bit(TTY_FLUSHING, &tty->flags)) {
 		set_bit(TTY_FLUSHPENDING, &tty->flags);
-		spin_unlock_irqrestore(&tty->buf.lock, flags);
+		raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 		wait_event(tty->read_wait,
 				test_bit(TTY_FLUSHPENDING, &tty->flags) == 0);
 		return;
 	} else
 		__tty_buffer_flush(tty);
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 }
 
 /**
@@ -238,9 +238,9 @@ int tty_buffer_request_room(struct tty_struct *tty, size_t size)
 	unsigned long flags;
 	int length;
 
-	spin_lock_irqsave(&tty->buf.lock, flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, flags);
 	length = __tty_buffer_request_room(tty, size);
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 	return length;
 }
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
@@ -268,18 +268,18 @@ int tty_insert_flip_string_fixed_flag(struct tty_struct *tty,
 		unsigned long flags;
 		struct tty_buffer *tb;
 
-		spin_lock_irqsave(&tty->buf.lock, flags);
+		raw_spin_lock_irqsave(&tty->buf.lock, flags);
 		space = __tty_buffer_request_room(tty, goal);
 		tb = tty->buf.tail;
 		/* If there is no space then tb may be NULL */
 		if (unlikely(space == 0)) {
-			spin_unlock_irqrestore(&tty->buf.lock, flags);
+			raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 			break;
 		}
 		memcpy(tb->char_buf_ptr + tb->used, chars, space);
 		memset(tb->flag_buf_ptr + tb->used, flag, space);
 		tb->used += space;
-		spin_unlock_irqrestore(&tty->buf.lock, flags);
+		raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 		copied += space;
 		chars += space;
 		/* There is a small chance that we need to split the data over
@@ -313,18 +313,18 @@ int tty_insert_flip_string_flags(struct tty_struct *tty,
 		unsigned long __flags;
 		struct tty_buffer *tb;
 
-		spin_lock_irqsave(&tty->buf.lock, __flags);
+		raw_spin_lock_irqsave(&tty->buf.lock, __flags);
 		space = __tty_buffer_request_room(tty, goal);
 		tb = tty->buf.tail;
 		/* If there is no space then tb may be NULL */
 		if (unlikely(space == 0)) {
-			spin_unlock_irqrestore(&tty->buf.lock, __flags);
+			raw_spin_unlock_irqrestore(&tty->buf.lock, __flags);
 			break;
 		}
 		memcpy(tb->char_buf_ptr + tb->used, chars, space);
 		memcpy(tb->flag_buf_ptr + tb->used, flags, space);
 		tb->used += space;
-		spin_unlock_irqrestore(&tty->buf.lock, __flags);
+		raw_spin_unlock_irqrestore(&tty->buf.lock, __flags);
 		copied += space;
 		chars += space;
 		flags += space;
@@ -349,10 +349,10 @@ EXPORT_SYMBOL(tty_insert_flip_string_flags);
 void tty_schedule_flip(struct tty_struct *tty)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&tty->buf.lock, flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, flags);
 	if (tty->buf.tail != NULL)
 		tty->buf.tail->commit = tty->buf.tail->used;
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 	schedule_work(&tty->buf.work);
 }
 EXPORT_SYMBOL(tty_schedule_flip);
@@ -379,7 +379,7 @@ int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars,
 	unsigned long flags;
 	struct tty_buffer *tb;
 
-	spin_lock_irqsave(&tty->buf.lock, flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, flags);
 	space = __tty_buffer_request_room(tty, size);
 
 	tb = tty->buf.tail;
@@ -388,7 +388,7 @@ int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars,
 		memset(tb->flag_buf_ptr + tb->used, TTY_NORMAL, space);
 		tb->used += space;
 	}
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 	return space;
 }
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string);
@@ -416,7 +416,7 @@ int tty_prepare_flip_string_flags(struct tty_struct *tty,
 	unsigned long __flags;
 	struct tty_buffer *tb;
 
-	spin_lock_irqsave(&tty->buf.lock, __flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, __flags);
 	space = __tty_buffer_request_room(tty, size);
 
 	tb = tty->buf.tail;
@@ -425,7 +425,7 @@ int tty_prepare_flip_string_flags(struct tty_struct *tty,
 		*flags = tb->flag_buf_ptr + tb->used;
 		tb->used += space;
 	}
-	spin_unlock_irqrestore(&tty->buf.lock, __flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, __flags);
 	return space;
 }
 EXPORT_SYMBOL_GPL(tty_prepare_flip_string_flags);
@@ -455,7 +455,7 @@ static void flush_to_ldisc(struct work_struct *work)
 	if (disc == NULL)	/*  !TTY_LDISC */
 		return;
 
-	spin_lock_irqsave(&tty->buf.lock, flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, flags);
 
 	if (!test_and_set_bit(TTY_FLUSHING, &tty->flags)) {
 		struct tty_buffer *head;
@@ -484,10 +484,10 @@ static void flush_to_ldisc(struct work_struct *work)
 			char_buf = head->char_buf_ptr + head->read;
 			flag_buf = head->flag_buf_ptr + head->read;
 			head->read += count;
-			spin_unlock_irqrestore(&tty->buf.lock, flags);
+			raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 			disc->ops->receive_buf(tty, char_buf,
 							flag_buf, count);
-			spin_lock_irqsave(&tty->buf.lock, flags);
+			raw_spin_lock_irqsave(&tty->buf.lock, flags);
 		}
 		clear_bit(TTY_FLUSHING, &tty->flags);
 	}
@@ -499,7 +499,7 @@ static void flush_to_ldisc(struct work_struct *work)
 		clear_bit(TTY_FLUSHPENDING, &tty->flags);
 		wake_up(&tty->read_wait);
 	}
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 
 	tty_ldisc_deref(disc);
 }
@@ -533,10 +533,10 @@ void tty_flush_to_ldisc(struct tty_struct *tty)
 void tty_flip_buffer_push(struct tty_struct *tty)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&tty->buf.lock, flags);
+	raw_spin_lock_irqsave(&tty->buf.lock, flags);
 	if (tty->buf.tail != NULL)
 		tty->buf.tail->commit = tty->buf.tail->used;
-	spin_unlock_irqrestore(&tty->buf.lock, flags);
+	raw_spin_unlock_irqrestore(&tty->buf.lock, flags);
 
 	if (tty->low_latency)
 		flush_to_ldisc(&tty->buf.work);
@@ -557,7 +557,7 @@ EXPORT_SYMBOL(tty_flip_buffer_push);
 
 void tty_buffer_init(struct tty_struct *tty)
 {
-	spin_lock_init(&tty->buf.lock);
+	raw_spin_lock_init(&tty->buf.lock);
 	tty->buf.head = NULL;
 	tty->buf.tail = NULL;
 	tty->buf.free = NULL;
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 4f6c59a..c6299c5 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -87,7 +87,7 @@ struct tty_buffer {
 
 struct tty_bufhead {
 	struct work_struct work;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	struct tty_buffer *head;	/* Queue head */
 	struct tty_buffer *tail;	/* Active buffer */
 	struct tty_buffer *free;	/* Free queue head */
-- 
1.7.9.5


