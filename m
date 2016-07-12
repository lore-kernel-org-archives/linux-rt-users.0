From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 14/20] sched,preempt: Fix preempt_count manipulations
Date: Tue, 12 Jul 2016 10:24:19 -0400
Message-ID: <20160712142419.864176083@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	<stable@vger.kernel.org>, <stable-rt@vger.kernel.org>,
	Vikram Mulukutla <markivx@codeaurora.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0014-sched-preempt-Fix-preempt_count-manipulations.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

Vikram reported that his ARM64 compiler managed to 'optimize' away the
preempt_count manipulations in code like:

	preempt_enable_no_resched();
	put_user();
	preempt_disable();

Irrespective of that fact that that is horrible code that should be
fixed for many reasons, it does highlight a deficiency in the generic
preempt_count manipulators. As it is never right to combine/elide
preempt_count manipulations like this.

Therefore sprinkle some volatile in the two generic accessors to
ensure the compiler is aware of the fact that the preempt_count is
observed outside of the regular program-order view and thus cannot be
optimized away like this.

x86; the only arch not using the generic code is not affected as we
do all this in asm in order to use the segment base per-cpu stuff.

Cc: stable@vger.kernel.org
Cc: stable-rt@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: a787870924db ("sched, arch: Create asm/preempt.h")
Reported-by: Vikram Mulukutla <markivx@codeaurora.org>
Tested-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/asm-generic/preempt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index b6a53e8e526a..c91d3d764c36 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -7,10 +7,10 @@
 
 static __always_inline int preempt_count(void)
 {
-	return current_thread_info()->preempt_count;
+	return READ_ONCE(current_thread_info()->preempt_count);
 }
 
-static __always_inline int *preempt_count_ptr(void)
+static __always_inline volatile int *preempt_count_ptr(void)
 {
 	return &current_thread_info()->preempt_count;
 }
-- 
2.8.1
