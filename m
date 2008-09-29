From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/3] rt bit spinlocks: fix compile failure for !CONFIG_PREEMPT_RT
Date: Mon, 29 Sep 2008 10:32:52 -0400
Message-ID: <2207c74a6dd86a8c88b6c0adfac45e7852f8b99b.1222698507.git.paul.gortmaker@windriver.com>
References: <1222698773-5920-1-git-send-email-paul.gortmaker@windriver.com>
 <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
Cc: linux-rt-users@vger.kernel.org
To: rostedt@goodmis.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:44153 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbYI2Oc6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Sep 2008 10:32:58 -0400
In-Reply-To: <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
In-Reply-To: <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
References: <1fcdb5cc884c1e226bcdc40e8a9918c9f80be027.1222698507.git.paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The RT patches disable the existing bit_spinlock.h defns with
an "#if 0" in favour of re-stating its own within spinlock.h
itself.  But the latter are incomplete when PREEMPT_RT is not set.

The smallest footprint change to work around this is to simply use
CONFIG_PREEMPT_RT as a trigger to choose between the new spinlock.h
definitions, or the older/existing definitions.  This change should
be considered for folding into the rt-mutex-core.patch.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/linux/bit_spinlock.h |    2 +-
 include/linux/spinlock.h     |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index 864ca40..b809011 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -1,7 +1,7 @@
 #ifndef __LINUX_BIT_SPINLOCK_H
 #define __LINUX_BIT_SPINLOCK_H
 
-#if 0
+#ifndef CONFIG_PREEMPT_RT
 
 /*
  *  bit-based spin_lock()
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 8abd577..ba0a5e6 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -509,6 +509,7 @@ do {									\
 	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irqsave, 	\
 		_spin_trylock_irqsave, lock, &flags))
 
+#ifdef CONFIG_PREEMPT_RT
 /*
  *  bit-based spin_lock()
  *
@@ -569,6 +570,7 @@ static inline int bit_spin_is_locked(int bitnum, unsigned long *addr)
 	return 1;
 #endif
 }
+#endif /* CONFIG_PREEMPT_RT */
 
 /**
  * __raw_spin_can_lock - would __raw_spin_trylock() succeed?
-- 
1.6.0

