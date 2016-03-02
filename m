From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 01/17] ptrace: dont open IRQs in ptrace_freeze_traced() too early
Date: Wed, 02 Mar 2016 10:44:34 -0500
Message-ID: <20160302154459.926377799@goodmis.org>
References: <20160302154433.638594715@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	kernel test robot <ying.huang@linux.intel.com>,
	<stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0001-ptrace-don-t-open-IRQs-in-ptrace_freeze_traced-too-e.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.61-rt64-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

In the non-RT case the spin_lock_irq() here disables interrupts as well
as raw_spin_lock_irq(). So in the unlock case the interrupts are enabled
too early.

Reported-by: kernel test robot <ying.huang@linux.intel.com>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/ptrace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c8cd8ffab511..fe11653fb005 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -135,12 +135,14 @@ static bool ptrace_freeze_traced(struct task_struct *task)
 
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !__fatal_signal_pending(task)) {
-		raw_spin_lock_irq(&task->pi_lock);
+		unsigned long flags;
+
+		raw_spin_lock_irqsave(&task->pi_lock, flags);
 		if (task->state & __TASK_TRACED)
 			task->state = __TASK_TRACED;
 		else
 			task->saved_state = __TASK_TRACED;
-		raw_spin_unlock_irq(&task->pi_lock);
+		raw_spin_unlock_irqrestore(&task->pi_lock, flags);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
-- 
2.7.0
