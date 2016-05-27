From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] kernel/printk: Don't try to print from IRQ/NMI region
Date: Fri, 27 May 2016 15:58:12 +0200
Message-ID: <20160527135812.GB24120@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On -RT we try to acquire sleeping locks which might lead to warnings
from lockdep or a warn_on() from spin_try_lock() (which is a rtmutex on
RT).
We don't print in general from a IRQ off region so we should not try
this via console_unblank() / bust_spinlocks() as well.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/printk/printk.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1502,6 +1502,11 @@ static void call_console_drivers(int lev
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
@@ -2434,6 +2439,11 @@ void console_unblank(void)
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
