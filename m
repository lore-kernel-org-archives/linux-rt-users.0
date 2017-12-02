From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 7/9] rt/locking: allow recursive local_trylock()
Date: Fri, 01 Dec 2017 20:37:05 -0500
Message-ID: <20171202013712.321246203@goodmis.org>
References: <20171202013658.149533964@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Alex Shi <alex.shi@linaro.org>,
        stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752005AbdLBBhN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 1 Dec 2017 20:37:13 -0500
Content-Disposition: inline; filename=0007-rt-locking-allow-recursive-local_trylock.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

4.4.102-rt117-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

required for following networking patch which does recursive try-lock.
While at it, add the !RT version of it because it did not yet exist.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/locallock.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index e572a3971631..0baaf28dc4ee 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -77,6 +77,9 @@ static inline int __local_trylock(struct local_irq_lock *lv)
 		lv->owner = current;
 		lv->nestcnt = 1;
 		return 1;
+	} else if (lv->owner == current) {
+		lv->nestcnt++;
+		return 1;
 	}
 	return 0;
 }
@@ -250,6 +253,12 @@ static inline int __local_unlock_irqrestore(struct local_irq_lock *lv,
 
 static inline void local_irq_lock_init(int lvar) { }
 
+#define local_trylock(lvar)					\
+	({							\
+		preempt_disable();				\
+		1;						\
+	})
+
 #define local_lock(lvar)			preempt_disable()
 #define local_unlock(lvar)			preempt_enable()
 #define local_lock_irq(lvar)			local_irq_disable()
-- 
2.13.2


