From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/15] locallock: add local_lock_on()
Date: Tue, 12 Jul 2016 10:29:19 -0400
Message-ID: <20160712142920.569513688@goodmis.org>
References: <20160712142907.636678217@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52506 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567AbcGLO3Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jul 2016 10:29:24 -0400
Content-Disposition: inline; filename=0012-locallock-add-local_lock_on.patch
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

3.18.36-rt38-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/locallock.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/locallock.h b/include/linux/locallock.h
index 21653e9bfa20..015271ff8ec8 100644
--- a/include/linux/locallock.h
+++ b/include/linux/locallock.h
@@ -66,6 +66,9 @@ static inline void __local_lock(struct local_irq_lock *lv)
 #define local_lock(lvar)					\
 	do { __local_lock(&get_local_var(lvar)); } while (0)
 
+#define local_lock_on(lvar, cpu)				\
+	do { __local_lock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline int __local_trylock(struct local_irq_lock *lv)
 {
 	if (lv->owner != current && spin_trylock_local(&lv->lock)) {
@@ -104,6 +107,9 @@ static inline void __local_unlock(struct local_irq_lock *lv)
 		put_local_var(lvar);				\
 	} while (0)
 
+#define local_unlock_on(lvar, cpu)                       \
+	do { __local_unlock(&per_cpu(lvar, cpu)); } while (0)
+
 static inline void __local_lock_irq(struct local_irq_lock *lv)
 {
 	spin_lock_irqsave(&lv->lock, lv->flags);
-- 
2.8.1


