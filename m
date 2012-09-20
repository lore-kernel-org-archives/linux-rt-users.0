From: Ivo Sieben <meltedpianoman@gmail.com>
Subject: [PATCH] tty: Use raw spin lock to protect the TTY read section
Date: Thu, 20 Sep 2012 16:09:26 +0200
Message-ID: <1348150166-4868-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ivo Sieben <meltedpianoman@gmail.com>
To: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:26807
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753101Ab2ITOMJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Sep 2012 10:12:09 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The "normal" spin lock that guards the N_TTY line discipline read section
is replaced by a raw spin lock.

On a PREEMP_RT system this prevents unwanted scheduling overhead when data is
read at the same time as data is being received: while RX IRQ threaded handling
is busy a TTY read call is performed from a RT priority > threaded IRQ priority.
The read call tries to take the read section spin lock (held by the threaded
IRQ) which blocks and causes a context switch to/from the threaded IRQ handler
until the spin lock is unlocked.

On a 240 MHz AT91SAM9261 processor setup this fixes about 100us of scheduling
overhead on the TTY read call.

Signed-off-by: Ivo Sieben <meltedpianoman@gmail.com>
---
 drivers/tty/n_tty.c  |   44 ++++++++++++++++++++++----------------------
 drivers/tty/tty_io.c |    2 +-
 include/linux/tty.h  |    2 +-
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index ee1c268..743ef45 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -138,9 +138,9 @@ static void put_tty_queue(unsigned char c, struct tty_struct *tty)
 	 *	The problem of stomping on the buffers ends here.
 	 *	Why didn't anyone see this one coming? --AJK
 	*/
-	spin_lock_irqsave(&tty->read_lock, flags);
+	raw_spin_lock_irqsave(&tty->read_lock, flags);
 	put_tty_queue_nolock(c, tty);
-	spin_unlock_irqrestore(&tty->read_lock, flags);
+	raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 }
 
 /**
@@ -173,9 +173,9 @@ static void reset_buffer_flags(struct tty_struct *tty)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&tty->read_lock, flags);
+	raw_spin_lock_irqsave(&tty->read_lock, flags);
 	tty->read_head = tty->read_tail = tty->read_cnt = 0;
-	spin_unlock_irqrestore(&tty->read_lock, flags);
+	raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 
 	mutex_lock(&tty->echo_lock);
 	tty->echo_pos = tty->echo_cnt = tty->echo_overrun = 0;
@@ -230,7 +230,7 @@ static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 	unsigned long flags;
 	ssize_t n = 0;
 
-	spin_lock_irqsave(&tty->read_lock, flags);
+	raw_spin_lock_irqsave(&tty->read_lock, flags);
 	if (!tty->icanon) {
 		n = tty->read_cnt;
 	} else if (tty->canon_data) {
@@ -238,7 +238,7 @@ static ssize_t n_tty_chars_in_buffer(struct tty_struct *tty)
 			tty->canon_head - tty->read_tail :
 			tty->canon_head + (N_TTY_BUF_SIZE - tty->read_tail);
 	}
-	spin_unlock_irqrestore(&tty->read_lock, flags);
+	raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 	return n;
 }
 
@@ -868,19 +868,19 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 		kill_type = WERASE;
 	else {
 		if (!L_ECHO(tty)) {
-			spin_lock_irqsave(&tty->read_lock, flags);
+			raw_spin_lock_irqsave(&tty->read_lock, flags);
 			tty->read_cnt -= ((tty->read_head - tty->canon_head) &
 					  (N_TTY_BUF_SIZE - 1));
 			tty->read_head = tty->canon_head;
-			spin_unlock_irqrestore(&tty->read_lock, flags);
+			raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 			return;
 		}
 		if (!L_ECHOK(tty) || !L_ECHOKE(tty) || !L_ECHOE(tty)) {
-			spin_lock_irqsave(&tty->read_lock, flags);
+			raw_spin_lock_irqsave(&tty->read_lock, flags);
 			tty->read_cnt -= ((tty->read_head - tty->canon_head) &
 					  (N_TTY_BUF_SIZE - 1));
 			tty->read_head = tty->canon_head;
-			spin_unlock_irqrestore(&tty->read_lock, flags);
+			raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 			finish_erasing(tty);
 			echo_char(KILL_CHAR(tty), tty);
 			/* Add a newline if ECHOK is on and ECHOKE is off. */
@@ -914,10 +914,10 @@ static void eraser(unsigned char c, struct tty_struct *tty)
 				break;
 		}
 		cnt = (tty->read_head - head) & (N_TTY_BUF_SIZE-1);
-		spin_lock_irqsave(&tty->read_lock, flags);
+		raw_spin_lock_irqsave(&tty->read_lock, flags);
 		tty->read_head = head;
 		tty->read_cnt -= cnt;
-		spin_unlock_irqrestore(&tty->read_lock, flags);
+		raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 		if (L_ECHO(tty)) {
 			if (L_ECHOPRT(tty)) {
 				if (!tty->erasing) {
@@ -1290,12 +1290,12 @@ send_signal:
 				put_tty_queue(c, tty);
 
 handle_newline:
-			spin_lock_irqsave(&tty->read_lock, flags);
+			raw_spin_lock_irqsave(&tty->read_lock, flags);
 			set_bit(tty->read_head, tty->read_flags);
 			put_tty_queue_nolock(c, tty);
 			tty->canon_head = tty->read_head;
 			tty->canon_data++;
-			spin_unlock_irqrestore(&tty->read_lock, flags);
+			raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
 			if (waitqueue_active(&tty->read_wait))
 				wake_up_interruptible(&tty->read_wait);
@@ -1371,7 +1371,7 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		return;
 
 	if (tty->real_raw) {
-		spin_lock_irqsave(&tty->read_lock, cpuflags);
+		raw_spin_lock_irqsave(&tty->read_lock, cpuflags);
 		i = min(N_TTY_BUF_SIZE - tty->read_cnt,
 			N_TTY_BUF_SIZE - tty->read_head);
 		i = min(count, i);
@@ -1387,7 +1387,7 @@ static void n_tty_receive_buf(struct tty_struct *tty, const unsigned char *cp,
 		memcpy(tty->read_buf + tty->read_head, cp, i);
 		tty->read_head = (tty->read_head + i) & (N_TTY_BUF_SIZE-1);
 		tty->read_cnt += i;
-		spin_unlock_irqrestore(&tty->read_lock, cpuflags);
+		raw_spin_unlock_irqrestore(&tty->read_lock, cpuflags);
 	} else {
 		for (i = count, p = cp, f = fp; i; i--, p++) {
 			if (f)
@@ -1633,23 +1633,23 @@ static int copy_from_read_buf(struct tty_struct *tty,
 	bool is_eof;
 
 	retval = 0;
-	spin_lock_irqsave(&tty->read_lock, flags);
+	raw_spin_lock_irqsave(&tty->read_lock, flags);
 	n = min(tty->read_cnt, N_TTY_BUF_SIZE - tty->read_tail);
 	n = min(*nr, n);
-	spin_unlock_irqrestore(&tty->read_lock, flags);
+	raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 	if (n) {
 		retval = copy_to_user(*b, &tty->read_buf[tty->read_tail], n);
 		n -= retval;
 		is_eof = n == 1 &&
 			tty->read_buf[tty->read_tail] == EOF_CHAR(tty);
 		tty_audit_add_data(tty, &tty->read_buf[tty->read_tail], n);
-		spin_lock_irqsave(&tty->read_lock, flags);
+		raw_spin_lock_irqsave(&tty->read_lock, flags);
 		tty->read_tail = (tty->read_tail + n) & (N_TTY_BUF_SIZE-1);
 		tty->read_cnt -= n;
 		/* Turn single EOF into zero-length read */
 		if (L_EXTPROC(tty) && tty->icanon && is_eof && !tty->read_cnt)
 			n = 0;
-		spin_unlock_irqrestore(&tty->read_lock, flags);
+		raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 		*b += n;
 		*nr -= n;
 	}
@@ -1838,7 +1838,7 @@ do_it_again:
 				eol = test_and_clear_bit(tty->read_tail,
 						tty->read_flags);
 				c = tty->read_buf[tty->read_tail];
-				spin_lock_irqsave(&tty->read_lock, flags);
+				raw_spin_lock_irqsave(&tty->read_lock, flags);
 				tty->read_tail = ((tty->read_tail+1) &
 						  (N_TTY_BUF_SIZE-1));
 				tty->read_cnt--;
@@ -1850,7 +1850,7 @@ do_it_again:
 					if (--tty->canon_data < 0)
 						tty->canon_data = 0;
 				}
-				spin_unlock_irqrestore(&tty->read_lock, flags);
+				raw_spin_unlock_irqrestore(&tty->read_lock, flags);
 
 				if (!eol || (c != __DISABLED_CHAR)) {
 					if (tty_put_user(tty, c, b++)) {
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index b425c79..a3ef00b 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2943,7 +2943,7 @@ void initialize_tty_struct(struct tty_struct *tty,
 	mutex_init(&tty->atomic_write_lock);
 	mutex_init(&tty->output_lock);
 	mutex_init(&tty->echo_lock);
-	spin_lock_init(&tty->read_lock);
+	raw_spin_lock_init(&tty->read_lock);
 	spin_lock_init(&tty->ctrl_lock);
 	INIT_LIST_HEAD(&tty->tty_files);
 	INIT_WORK(&tty->SAK_work, do_SAK_work);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index e728ecc..21bceef 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -327,7 +327,7 @@ struct tty_struct {
 	struct mutex echo_lock;
 	unsigned char *write_buf;
 	int write_cnt;
-	spinlock_t read_lock;
+	raw_spinlock_t read_lock;
 	/* If the tty has a pending do_SAK, queue it here - akpm */
 	struct work_struct SAK_work;
 	struct tty_port *port;
-- 
1.7.9.5


