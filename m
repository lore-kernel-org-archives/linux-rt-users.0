From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC RT] tty: serial: 8250: don't take the lock on OOPs
Date: Fri, 11 Mar 2016 19:05:04 +0100
Message-ID: <20160311180504.GB29850@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: tglx@linutronix.de, rostedt@goodmis.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On panic() from IRQ (for instance from the lockup detector) we will
end up in an endless loop on -RT. Each time we invoke
spin_trylock_irqsave() we will trigger the WARN_ON() in rt_mutex_trylock().
The WARN_ON() will stuff more data into the printk buffer than we can
print on one iteration and so we never end the printing loop.

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
2.7.0
