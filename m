From: Libo Chen <chenlibo.3@gmail.com>
Subject: [PATCH] drivers: tty:  Make RT aware
Date: Thu, 24 Jan 2013 12:07:47 +0800
Message-ID: <5100B393.1020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: lizefan@huawei.com, jovi.zhangwei@huawei.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-da0-f48.google.com ([209.85.210.48]:41861 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252Ab3AXEHx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Jan 2013 23:07:53 -0500
Received: by mail-da0-f48.google.com with SMTP id k18so4035507dae.35
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Jan 2013 20:07:52 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Libo Chen <libo.chen@huawei.com>

On RT  spinlocks are converted to "sleeping" locks and
therefor the local_irq_save/restore must be converted to
local_irq_save/restore_nort

Signed-off-by: Libo Chen <libo.chen@huawei.com>

---
 arch/alpha/kernel/srmcons.c       |    4 ++--
 drivers/tty/serial/amba-pl011.c   |    4 ++--
 drivers/tty/serial/ar933x_uart.c  |    4 ++--
 drivers/tty/serial/bcm63xx_uart.c |    4 ++--
 drivers/tty/serial/mfd.c          |    4 ++--
 drivers/tty/serial/sunhv.c        |    8 ++++----
 drivers/tty/serial/sunsab.c       |    4 ++--
 drivers/tty/serial/sunzilog.c     |    4 ++--
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/alpha/kernel/srmcons.c b/arch/alpha/kernel/srmcons.c
index 3ea8094..effdd18 100644
--- a/arch/alpha/kernel/srmcons.c
+++ b/arch/alpha/kernel/srmcons.c
@@ -71,7 +71,7 @@ srmcons_receive_chars(unsigned long data)
 	unsigned long flags;
 	int incr = 10;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (spin_trylock(&srmcons_callback_lock)) {
 		if (!srmcons_do_receive_chars(port->tty))
 			incr = 100;
@@ -83,7 +83,7 @@ srmcons_receive_chars(unsigned long data)
 		mod_timer(&srmconsp->timer, jiffies + incr);
 	spin_unlock(&port->lock);

-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 /* called with callback_lock held */
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b69356c..2558544 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1788,7 +1788,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)

 	clk_enable(uap->clk);

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (uap->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
@@ -1817,7 +1817,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)

 	if (locked)
 		spin_unlock(&uap->port.lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);

 	clk_disable(uap->clk);
 }
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index e4f60e2..2f17b1a 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -468,7 +468,7 @@ static void ar933x_uart_console_write(struct console *co, const char *s,
 	unsigned int int_en;
 	int locked = 1;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);

 	if (up->port.sysrq)
 		locked = 0;
@@ -497,7 +497,7 @@ static void ar933x_uart_console_write(struct console *co, const char *s,
 	if (locked)
 		spin_unlock(&up->port.lock);

-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 static int ar933x_uart_console_setup(struct console *co, char *options)
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index c0b68b9..e699c72 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -718,7 +718,7 @@ static void bcm_console_write(struct console *co, const char *s,

 	port = &ports[co->index];

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (port->sysrq) {
 		/* bcm_uart_interrupt() already took the lock */
 		locked = 0;
@@ -737,7 +737,7 @@ static void bcm_console_write(struct console *co, const char *s,

 	if (locked)
 		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 /*
diff --git a/drivers/tty/serial/mfd.c b/drivers/tty/serial/mfd.c
index c4b50af..15cf1cf 100644
--- a/drivers/tty/serial/mfd.c
+++ b/drivers/tty/serial/mfd.c
@@ -1113,7 +1113,7 @@ serial_hsu_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned int ier;
 	int locked = 1;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress) {
@@ -1136,7 +1136,7 @@ serial_hsu_console_write(struct console *co, const char *s, unsigned int count)

 	if (locked)
 		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 static struct console serial_hsu_console;
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 505961c..44aa631 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -432,7 +432,7 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
 	unsigned long flags;
 	int locked = 1;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (port->sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
@@ -470,7 +470,7 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign

 	if (locked)
 		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 static inline void sunhv_console_putchar(struct uart_port *port, char c)
@@ -491,7 +491,7 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 	unsigned long flags;
 	int i, locked = 1;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (port->sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
@@ -507,7 +507,7 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig

 	if (locked)
 		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 static struct console sunhv_console = {
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index f0d93eb..49c761d 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -850,7 +850,7 @@ static void sunsab_console_write(struct console *con, const char *s, unsigned n)
 	unsigned long flags;
 	int locked = 1;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (up->port.sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
@@ -863,7 +863,7 @@ static void sunsab_console_write(struct console *con, const char *s, unsigned n)

 	if (locked)
 		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 static int sunsab_console_setup(struct console *con, char *options)
diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index babd947..e38492b 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1202,7 +1202,7 @@ sunzilog_console_write(struct console *con, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;

-	local_irq_save(flags);
+	local_irq_save_nort(flags);
 	if (up->port.sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
@@ -1215,7 +1215,7 @@ sunzilog_console_write(struct console *con, const char *s, unsigned int count)

 	if (locked)
 		spin_unlock(&up->port.lock);
-	local_irq_restore(flags);
+	local_irq_restore_nort(flags);
 }

 static int __init sunzilog_console_setup(struct console *con, char *options)
-- 1.7.1

