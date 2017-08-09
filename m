From: Mike Galbraith <efault@gmx.de>
Subject: [patch-rt] locking, rwlock-rt: do not save state multiple times in
 __write_rt_lock()
Date: Wed, 09 Aug 2017 14:04:48 +0200
Message-ID: <1502280288.6441.3.camel@gmx.de>
References: <20170804173823.lzuhnejlnxczr2lj@linutronix.de>
         <1501913583.7917.42.camel@gmx.de>
         <20170807075254.pdu7immtbakn7f7g@linutronix.de>
         <1502095134.5568.27.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502095134.5568.27.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Save state prior to entering the acquisition loop, otherwise we may
initially see readers, but upon releasing ->wait_lock see none, loop
back around, and having not slept, save TASK_UNINTERRUPTIBLE.

Signed-off-by_ Mike Galbraith <efault@gmx.de>
---
 kernel/locking/rwlock-rt.c |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--- a/kernel/locking/rwlock-rt.c
+++ b/kernel/locking/rwlock-rt.c
@@ -190,30 +190,33 @@ void __sched __write_rt_lock(struct rt_r
 	/* Force readers into slow path */
 	atomic_sub(READER_BIAS, &lock->readers);
 
-	for (;;) {
-		raw_spin_lock_irqsave(&m->wait_lock, flags);
-
-		raw_spin_lock(&self->pi_lock);
-		self->saved_state = self->state;
-		__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
-		raw_spin_unlock(&self->pi_lock);
+	raw_spin_lock_irqsave(&m->wait_lock, flags);
+	raw_spin_lock(&self->pi_lock);
+	self->saved_state = self->state;
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+	raw_spin_unlock(&self->pi_lock);
 
+	for (;;) {
 		/* Have all readers left the critical region? */
-		if (!atomic_read(&lock->readers)) {
-			atomic_set(&lock->readers, WRITER_BIAS);
-			raw_spin_lock(&self->pi_lock);
-			__set_current_state_no_track(self->saved_state);
-			self->saved_state = TASK_RUNNING;
-			raw_spin_unlock(&self->pi_lock);
-			raw_spin_unlock_irqrestore(&m->wait_lock, flags);
-			return;
-		}
+		if (!atomic_read(&lock->readers))
+			break;
 
 		raw_spin_unlock_irqrestore(&m->wait_lock, flags);
-
 		if (atomic_read(&lock->readers) != 0)
 			schedule();
+		raw_spin_lock_irqsave(&m->wait_lock, flags);
+
+		raw_spin_lock(&self->pi_lock);
+		__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
+		raw_spin_unlock(&self->pi_lock);
 	}
+
+	atomic_set(&lock->readers, WRITER_BIAS);
+	raw_spin_lock(&self->pi_lock);
+	__set_current_state_no_track(self->saved_state);
+	self->saved_state = TASK_RUNNING;
+	raw_spin_unlock(&self->pi_lock);
+	raw_spin_unlock_irqrestore(&m->wait_lock, flags);
 }
 
 int __write_rt_trylock(struct rt_rw_lock *lock)
