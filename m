From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] tty: serial: 8250: don't take the trylock during oops
Date: Tue, 12 Apr 2016 09:16:42 +0200
Message-ID: <20160412071642.GA20685@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	Steven Rostedt <rostedt@goodmis.org>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

An oops with irqs off (panic() from irqsafe hrtimer like the watchdog
timer) will lead to a lockdep warning on each invocation and as such
never completes.
Therefore we skip the trylock in the oops case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/tty/serial/8250/8250_port.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 5568d70eee0c..138b1b985063 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2850,9 +2850,9 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 
 	serial8250_rpm_get(up);
 
-	if (port->sysrq)
+	if (port->sysrq || oops_in_progress)
 		locked = 0;
-	else if (oops_in_progress || in_kdb_printk())
+	else if (in_kdb_printk())
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.8.0.rc3
