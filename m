From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT] printk: Shortcut out of waiter spinning on PREEMPT_RT
Date: Tue, 15 Jan 2019 12:39:10 -0500
Message-ID: <20190115123910.2b18df54@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

As the consoles are written with preemption enabled in PREEMPT_RT, we
must not have any task spinning waiting on them. Currently, the code
that would make the task spin is #ifdef out when PREEMPT_RT is
enabled, but why go through grabbing of the locks to see if an owner is
set, when it never will be?

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index a43d07d4e043..1a61132deec1 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1742,6 +1742,13 @@ static int console_trylock_spinning(void)
 	if (console_trylock())
 		return 1;
 
+	/*
+	 * The consoles are preemptable in PREEMPT_RT, which can cause
+	 * spinning to deadlock.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		return 0;
+
 	printk_safe_enter_irqsave(flags);
 
 	raw_spin_lock(&console_owner_lock);
