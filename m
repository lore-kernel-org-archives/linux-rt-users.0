From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 04/25][RFC 3.0.23-rt39-rc1] revert-seqlock-remove-unused-functions
Date: Tue, 06 Mar 2012 11:16:40 -0500
Message-ID: <20120306161945.770871645@goodmis.org>
References: <20120306161636.491172179@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-revert-seqlock-remove-unused-functions.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>

revert: seqlock-remove-unused-functions.patch

Revert:

Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Sat Jul 16 18:38:22 2011 +0200

    seqlock-remove-unused-functions.patch

    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/seqlock.h |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index b990f6e..c6db9fb 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -69,6 +69,17 @@ static inline void write_sequnlock(seqlock_t *sl)
 	spin_unlock(&sl->lock);
 }
 
+static inline int write_tryseqlock(seqlock_t *sl)
+{
+	int ret = spin_trylock(&sl->lock);
+
+	if (ret) {
+		++sl->sequence;
+		smp_wmb();
+	}
+	return ret;
+}
+
 /* Start of read calculation -- fetch last complete writer token */
 static __always_inline unsigned read_seqbegin(const seqlock_t *sl)
 {
@@ -237,4 +248,14 @@ static inline void write_seqcount_barrier(seqcount_t *s)
 #define write_sequnlock_bh(lock)					\
 	do { write_sequnlock(lock); local_bh_enable(); } while(0)
 
+#define read_seqbegin_irqsave(lock, flags)				\
+	({ local_irq_save(flags);   read_seqbegin(lock); })
+
+#define read_seqretry_irqrestore(lock, iv, flags)			\
+	({								\
+		int ret = read_seqretry(lock, iv);			\
+		local_irq_restore(flags);				\
+		ret;							\
+	})
+
 #endif /* __LINUX_SEQLOCK_H */
-- 
1.7.8.3
