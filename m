From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/12] cpu/rt: Fix cpu_hotplug variable initialization
Date: Wed, 18 Jul 2012 18:39:19 -0400
Message-ID: <20120718223959.345484946@goodmis.org>
References: <20120718223910.898476857@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-cpu-rt-Fix-cpu_hotplug-variable-initialization.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt <srostedt@redhat.com>

The commit "cpu/rt: Rework cpu down for PREEMPT_RT" changed the double
meaning of the cpu_hotplug.lock, where it was a spinlock for RT and a
mutex for non-RT, to just a mutex for both.  But the initialization of
the variable was not updated to reflect this change.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/cpu.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 11e6e9a..3bcbf99 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -54,11 +54,7 @@ static struct {
 	int refcount;
 } cpu_hotplug = {
 	.active_writer = NULL,
-#ifdef CONFIG_PREEMPT_RT_FULL
-	.lock = __SPIN_LOCK_UNLOCKED(cpu_hotplug.lock),
-#else
 	.lock = __MUTEX_INITIALIZER(cpu_hotplug.lock),
-#endif
 	.refcount = 0,
 };
 
-- 
1.7.10.4
