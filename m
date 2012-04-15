From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] rt/ARM: spinlock_rt.h uses BUG_ON and needs bug.h
Date: Sun, 15 Apr 2012 17:03:55 -0400
Message-ID: <1334523835-24475-1-git-send-email-paul.gortmaker@windriver.com>
Cc: linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: tglx@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:54902 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2DOVEQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 15 Apr 2012 17:04:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Seen on an RT_FULL enabled ARM stamp9g20_defconfig:

  CC      arch/arm/kernel/asm-offsets.s
In file included from include/linux/spinlock.h:273,
                 from include/linux/seqlock.h:29,
                 from include/linux/time.h:8,
                 from include/linux/timex.h:56,
                 from include/linux/sched.h:57,
                 from arch/arm/kernel/asm-offsets.c:13:
include/linux/spinlock_rt.h: In function 'assert_spin_locked':
include/linux/spinlock_rt.h:160: error: implicit declaration of function 'BUG_ON'
make[2]: *** [arch/arm/kernel/asm-offsets.s] Error 1

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[feel free to squash this into patches/rt-add-rt-locks.patch]

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 3b555b4..0618387 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -5,6 +5,8 @@
 #error Do not include directly. Use spinlock.h
 #endif
 
+#include <linux/bug.h>
+
 extern void
 __rt_spin_lock_init(spinlock_t *lock, char *name, struct lock_class_key *key);
 
-- 
1.7.9.1

