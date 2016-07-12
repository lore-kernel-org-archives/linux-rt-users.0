From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 15/20] kernel/printk: Dont try to print from IRQ/NMI region
Date: Tue, 12 Jul 2016 10:24:20 -0400
Message-ID: <20160712142420.030701458@goodmis.org>
References: <20160712142405.634544943@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0015-kernel-printk-Don-t-try-to-print-from-IRQ-NMI-region.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.27-rt31-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

On -RT we try to acquire sleeping locks which might lead to warnings
from lockdep or a warn_on() from spin_try_lock() (which is a rtmutex on
RT).
We don't print in general from a IRQ off region so we should not try
this via console_unblank() / bust_spinlocks() as well.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/printk/printk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 899645a2ebcc..398bf2bbd3bc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1426,6 +1426,11 @@ static void call_console_drivers(int level, const char *text, size_t len)
 	if (!console_drivers)
 		return;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	migrate_disable();
 	for_each_console(con) {
 		if (exclusive_console && con != exclusive_console)
@@ -2392,6 +2397,11 @@ void console_unblank(void)
 {
 	struct console *c;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
+		if (in_irq() || in_nmi())
+			return;
+	}
+
 	/*
 	 * console_unblank can no longer be called in interrupt context unless
 	 * oops_in_progress is set to 1..
-- 
2.8.1
