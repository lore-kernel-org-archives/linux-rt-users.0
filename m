From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 1/3] spinlock/rt: Include bug.h in spinlock_rt.h to satisfy BUG() usage
Date: Fri, 22 Jun 2012 23:05:49 -0400
Message-ID: <20120623030638.813391214@goodmis.org>
References: <20120623030548.500374594@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-spinlock-rt-Include-bug.h-in-spinlock_rt.h-to-satisf.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <srostedt@redhat.com>

Some archs (powerpc) failed to compile because of the reference to
BUG() in spinlock_rt.h. Although bug.h is included in many headers,
if spinlock.h is included in a C file before that, it will fail to
compile.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/spinlock_rt.h |    2 ++
 1 file changed, 2 insertions(+)

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
1.7.10
