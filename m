From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 02/25][RFC 3.0.23-rt39-rc1] revert-seqlock-create-raw_seqlock
Date: Tue, 06 Mar 2012 11:16:38 -0500
Message-ID: <20120306161945.335361061@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-revert-seqlock-create-raw_seqlock.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

revert: seqlock: Create raw_seqlock

Revert:

Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Sat Jul 25 19:27:54 2009 +0200

    seqlock: Create raw_seqlock

    raw_seqlock_t will be used to annotate seqlocks which can not be
    converted to sleeping locks in preempt-rt

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/seqlock.h |   63 -----------------------------------------------
 1 files changed, 0 insertions(+), 63 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index e262353..11a9073 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -152,11 +152,6 @@ static inline void write_seqcount_barrier(seqcount_t *s)
 
 typedef struct {
 	struct seqcount seqcount;
-	raw_spinlock_t lock;
-} raw_seqlock_t;
-
-typedef struct {
-	struct seqcount seqcount;
 	spinlock_t lock;
 } seqlock_t;
 
@@ -164,21 +159,6 @@ typedef struct {
  * These macros triggered gcc-3.x compile-time problems.  We think these are
  * OK now.  Be cautious.
  */
-#define __RAW_SEQLOCK_UNLOCKED(lockname)			\
-	{							\
-		.seqcount = SEQCNT_ZERO,			\
-		.lock =	__RAW_SPIN_LOCK_UNLOCKED(lockname)	\
-	}
-
-#define raw_seqlock_init(x)					\
-	do {							\
-		seqcount_init(&(x)->seqcount);			\
-		raw_spin_lock_init(&(x)->lock);			\
-	} while (0)
-
-#define DEFINE_RAW_SEQLOCK(x) \
-		raw_seqlock_t x = __RAW_SEQLOCK_UNLOCKED(x)
-
 #define __SEQLOCK_UNLOCKED(lockname)			\
 	{						\
 		.seqcount = SEQCNT_ZERO,		\
@@ -202,49 +182,6 @@ typedef struct {
  * Acts like a normal spin_lock/unlock.
  * Don't need preempt_disable() because that is in the spin_lock already.
  */
-static inline void raw_write_seqlock(raw_seqlock_t *sl)
-{
-	raw_spin_lock(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
-}
-
-static inline void raw_write_sequnlock(raw_seqlock_t *sl)
-{
-	write_seqcount_end(&sl->seqcount);
-	raw_spin_unlock(&sl->lock);
-}
-
-static inline void raw_write_seqlock_irq(raw_seqlock_t *sl)
-{
-	raw_spin_lock_irq(&sl->lock);
-	write_seqcount_begin(&sl->seqcount);
-}
-
-static inline void raw_write_sequnlock_irq(raw_seqlock_t *sl)
-{
-	write_seqcount_end(&sl->seqcount);
-	raw_spin_unlock_irq(&sl->lock);
-}
-
-static inline unsigned long __raw_write_seqlock_irqsave(raw_seqlock_t *sl)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&sl->lock, flags);
-	write_seqcount_begin(&sl->seqcount);
-	return flags;
-}
-
-#define raw_write_seqlock_irqsave(lock, flags)				\
-	do { flags = __raw_write_seqlock_irqsave(lock); } while (0)
-
-static inline void
-raw_write_sequnlock_irqrestore(raw_seqlock_t *sl, unsigned long flags)
-{
-	write_seqcount_end(&sl->seqcount);
-	raw_spin_unlock_irqrestore(&sl->lock, flags);
-}
-
 static inline void write_seqlock(seqlock_t *sl)
 {
 	spin_lock(&sl->lock);
-- 
1.7.8.3
