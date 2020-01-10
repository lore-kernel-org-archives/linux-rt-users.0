Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1FAC33CA4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024F22072E
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 20:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgAJUOf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 15:14:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59652 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgAJUOf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 15:14:35 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iq0fu-00046M-BJ; Fri, 10 Jan 2020 21:14:30 +0100
Date:   Fri, 10 Jan 2020 21:14:30 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.4.10-rt5
Message-ID: <20200110201430.vl3sxiwntj5o4z74@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.4.10-rt5 patch set. 

Changes since v5.4.10-rt4:

  - Dick Hollenbeck reported that the printk rework had a negative
    impact on the 8250 driver if not used as a console. Patch by John
    Ogness.

Known issues
     - None

The delta patch against v5.4.10-rt4 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/incr/patch-5.4.10-rt4-rt5.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.4.10-rt5

The RT patch against v5.4.10 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patch-5.4.10-rt5.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.4/older/patches-5.4.10-rt5.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 4e6c74330829d..b29aed97a54dc 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -96,10 +96,6 @@ struct serial8250_config {
 #define SERIAL8250_SHARE_IRQS 0
 #endif
 
-void set_ier(struct uart_8250_port *up, unsigned char ier);
-void clear_ier(struct uart_8250_port *up);
-void restore_ier(struct uart_8250_port *up);
-
 #define SERIAL8250_PORT_FLAGS(_base, _irq, _flags)		\
 	{							\
 		.iobase		= _base,			\
@@ -134,21 +130,55 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 	up->dl_write(up, value);
 }
 
+static inline void serial8250_set_IER(struct uart_8250_port *up,
+				      unsigned char ier)
+{
+	struct uart_port *port = &up->port;
+	unsigned int flags;
+	bool is_console;
+
+	is_console = uart_console(port);
+
+	if (is_console)
+		console_atomic_lock(&flags);
+
+	serial_out(up, UART_IER, ier);
+
+	if (is_console)
+		console_atomic_unlock(flags);
+}
+
+static inline unsigned char serial8250_clear_IER(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	unsigned int clearval = 0;
+	unsigned int prior;
+	unsigned int flags;
+	bool is_console;
+
+	is_console = uart_console(port);
+
+	if (up->capabilities & UART_CAP_UUE)
+		clearval = UART_IER_UUE;
+
+	if (is_console)
+		console_atomic_lock(&flags);
+
+	prior = serial_port_in(port, UART_IER);
+	serial_port_out(port, UART_IER, clearval);
+
+	if (is_console)
+		console_atomic_unlock(flags);
+
+	return prior;
+}
+
 static inline bool serial8250_set_THRI(struct uart_8250_port *up)
 {
 	if (up->ier & UART_IER_THRI)
 		return false;
 	up->ier |= UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
-	return true;
-}
-
-static inline bool serial8250_set_THRI_sier(struct uart_8250_port *up)
-{
-	if (up->ier & UART_IER_THRI)
-		return false;
-	up->ier |= UART_IER_THRI;
-	set_ier(up, up->ier);
+	serial8250_set_IER(up, up->ier);
 	return true;
 }
 
@@ -157,16 +187,7 @@ static inline bool serial8250_clear_THRI(struct uart_8250_port *up)
 	if (!(up->ier & UART_IER_THRI))
 		return false;
 	up->ier &= ~UART_IER_THRI;
-	serial_out(up, UART_IER, up->ier);
-	return true;
-}
-
-static inline bool serial8250_clear_THRI_sier(struct uart_8250_port *up)
-{
-	if (!(up->ier & UART_IER_THRI))
-		return false;
-	up->ier &= ~UART_IER_THRI;
-	set_ier(up, up->ier);
+	serial8250_set_IER(up, up->ier);
 	return true;
 }
 
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 8c40472eff194..eabb9274c0a9d 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -275,7 +275,7 @@ static void serial8250_timeout(struct timer_list *t)
 static void serial8250_backup_timeout(struct timer_list *t)
 {
 	struct uart_8250_port *up = from_timer(up, t, timer);
-	unsigned int iir, lsr;
+	unsigned int iir, ier = 0, lsr;
 	unsigned long flags;
 
 	spin_lock_irqsave(&up->port.lock, flags);
@@ -285,7 +285,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	 * based handler.
 	 */
 	if (up->port.irq)
-		clear_ier(up);
+		ier = serial8250_clear_IER(up);
 
 	iir = serial_in(up, UART_IIR);
 
@@ -308,7 +308,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 		serial8250_tx_chars(up);
 
 	if (up->port.irq)
-		restore_ier(up);
+		serial8250_set_IER(up, ier);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index c91dafbca57c9..890fa7ddaa7f3 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -35,7 +35,7 @@ static void __dma_tx_complete(void *param)
 
 	ret = serial8250_tx_dma(p);
 	if (ret)
-		serial8250_set_THRI_sier(p);
+		serial8250_set_THRI(p);
 
 	spin_unlock_irqrestore(&p->port.lock, flags);
 }
@@ -98,7 +98,7 @@ int serial8250_tx_dma(struct uart_8250_port *p)
 	dma_async_issue_pending(dma->txchan);
 	if (dma->tx_err) {
 		dma->tx_err = 0;
-		serial8250_clear_THRI_sier(p);
+		serial8250_clear_THRI(p);
 	}
 	return 0;
 err:
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index aa0e216d5eadb..8f711afadd4b5 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -57,9 +57,18 @@ int fsl8250_handle_irq(struct uart_port *port)
 
 	/* Stop processing interrupts on input overrun */
 	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
+		unsigned int ca_flags;
 		unsigned long delay;
+		bool is_console;
 
+		is_console = uart_console(port);
+
+		if (is_console)
+			console_atomic_lock(&ca_flags);
 		up->ier = port->serial_in(port, UART_IER);
+		if (is_console)
+			console_atomic_unlock(ca_flags);
+
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
 		} else {
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 424c07c5f6299..47f1482bd818a 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -146,6 +146,8 @@ OF_EARLYCON_DECLARE(x1000_uart, "ingenic,x1000-uart",
 
 static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 {
+	unsigned int flags;
+	bool is_console;
 	int ier;
 
 	switch (offset) {
@@ -167,7 +169,12 @@ static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 		 * If we have enabled modem status IRQs we should enable
 		 * modem mode.
 		 */
+		is_console = uart_console(p);
+		if (is_console)
+			console_atomic_lock(&flags);
 		ier = p->serial_in(p, UART_IER);
+		if (is_console)
+			console_atomic_unlock(flags);
 
 		if (ier & UART_IER_MSI)
 			value |= UART_MCR_MDCE | UART_MCR_FCM;
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 4d067f515f748..b509c3de0301f 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -212,12 +212,37 @@ static void mtk8250_shutdown(struct uart_port *port)
 
 static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
 {
-	serial_out(up, UART_IER, serial_in(up, UART_IER) & (~mask));
+	struct uart_port *port = &up->port;
+	unsigned int flags;
+	unsigned int ier;
+	bool is_console;
+
+	is_console = uart_console(port);
+
+	if (is_console)
+		console_atomic_lock(&flags);
+
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, ier & (~mask));
+
+	if (is_console)
+		console_atomic_unlock(flags);
 }
 
 static void mtk8250_enable_intrs(struct uart_8250_port *up, int mask)
 {
-	serial_out(up, UART_IER, serial_in(up, UART_IER) | mask);
+	struct uart_port *port = &up->port;
+	unsigned int flags;
+	unsigned int ier;
+
+	if (uart_console(port))
+		console_atomic_lock(&flags);
+
+	ier = serial_in(up, UART_IER);
+	serial_out(up, UART_IER, ier | mask);
+
+	if (uart_console(port))
+		console_atomic_unlock(flags);
 }
 
 static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 51d9a79b70db3..7767701122236 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -721,7 +721,7 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 			serial_out(p, UART_EFR, UART_EFR_ECB);
 			serial_out(p, UART_LCR, 0);
 		}
-		set_ier(p, sleep ? UART_IERX_SLEEP : 0);
+		serial8250_set_IER(p, sleep ? UART_IERX_SLEEP : 0);
 		if (p->capabilities & UART_CAP_EFR) {
 			serial_out(p, UART_LCR, UART_LCR_CONF_MODE_B);
 			serial_out(p, UART_EFR, efr);
@@ -1390,7 +1390,7 @@ static void serial8250_stop_rx(struct uart_port *port)
 
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	up->port.read_status_mask &= ~UART_LSR_DR;
-	set_ier(up, up->ier);
+	serial8250_set_IER(up, up->ier);
 
 	serial8250_rpm_put(up);
 }
@@ -1408,7 +1408,7 @@ static void __do_stop_tx_rs485(struct uart_8250_port *p)
 		serial8250_clear_and_reinit_fifos(p);
 
 		p->ier |= UART_IER_RLSI | UART_IER_RDI;
-		set_ier(p, p->ier);
+		serial8250_set_IER(p, p->ier);
 	}
 }
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
@@ -1459,7 +1459,7 @@ static void __stop_tx_rs485(struct uart_8250_port *p)
 
 static inline void __do_stop_tx(struct uart_8250_port *p)
 {
-	if (serial8250_clear_THRI_sier(p))
+	if (serial8250_clear_THRI(p))
 		serial8250_rpm_put_tx(p);
 }
 
@@ -1509,7 +1509,7 @@ static inline void __start_tx(struct uart_port *port)
 	if (up->dma && !up->dma->tx_dma(up))
 		return;
 
-	if (serial8250_set_THRI_sier(up)) {
+	if (serial8250_set_THRI(up)) {
 		if (up->bugs & UART_BUG_TXEN) {
 			unsigned char lsr;
 
@@ -1616,7 +1616,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	mctrl_gpio_disable_ms(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
-	set_ier(up, up->ier);
+	serial8250_set_IER(up, up->ier);
 }
 
 static void serial8250_enable_ms(struct uart_port *port)
@@ -1632,7 +1632,7 @@ static void serial8250_enable_ms(struct uart_port *port)
 	up->ier |= UART_IER_MSI;
 
 	serial8250_rpm_get(up);
-	set_ier(up, up->ier);
+	serial8250_set_IER(up, up->ier);
 	serial8250_rpm_put(up);
 }
 
@@ -1991,54 +1991,6 @@ static void wait_for_xmitr(struct uart_8250_port *up, int bits)
 	}
 }
 
-static atomic_t ier_counter = ATOMIC_INIT(0);
-static atomic_t ier_value = ATOMIC_INIT(0);
-
-void set_ier(struct uart_8250_port *up, unsigned char ier)
-{
-	struct uart_port *port = &up->port;
-	unsigned int flags;
-
-	console_atomic_lock(&flags);
-	if (atomic_read(&ier_counter) > 0)
-		atomic_set(&ier_value, ier);
-	else
-		serial_port_out(port, UART_IER, ier);
-	console_atomic_unlock(flags);
-}
-
-void clear_ier(struct uart_8250_port *up)
-{
-	struct uart_port *port = &up->port;
-	unsigned int ier_cleared = 0;
-	unsigned int flags;
-	unsigned int ier;
-
-	console_atomic_lock(&flags);
-	atomic_inc(&ier_counter);
-	ier = serial_port_in(port, UART_IER);
-	if (up->capabilities & UART_CAP_UUE)
-		ier_cleared = UART_IER_UUE;
-	if (ier != ier_cleared) {
-		serial_port_out(port, UART_IER, ier_cleared);
-		atomic_set(&ier_value, ier);
-	}
-	console_atomic_unlock(flags);
-}
-EXPORT_SYMBOL_GPL(clear_ier);
-
-void restore_ier(struct uart_8250_port *up)
-{
-	struct uart_port *port = &up->port;
-	unsigned int flags;
-
-	console_atomic_lock(&flags);
-	if (atomic_fetch_dec(&ier_counter) == 1)
-		serial_port_out(port, UART_IER, atomic_read(&ier_value));
-	console_atomic_unlock(flags);
-}
-EXPORT_SYMBOL_GPL(restore_ier);
-
 #ifdef CONFIG_CONSOLE_POLL
 /*
  * Console polling routines for writing and reading from the uart while
@@ -2070,10 +2022,11 @@ static int serial8250_get_poll_char(struct uart_port *port)
 static void serial8250_put_poll_char(struct uart_port *port,
 			 unsigned char c)
 {
+	unsigned int ier;
 	struct uart_8250_port *up = up_to_u8250p(port);
 
 	serial8250_rpm_get(up);
-	clear_ier(up);
+	ier = serial8250_clear_IER(up);
 
 	wait_for_xmitr(up, BOTH_EMPTY);
 	/*
@@ -2086,7 +2039,7 @@ static void serial8250_put_poll_char(struct uart_port *port,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	restore_ier(up);
+	serial8250_set_IER(up, ier);
 	serial8250_rpm_put(up);
 }
 
@@ -2394,7 +2347,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 */
 	spin_lock_irqsave(&port->lock, flags);
 	up->ier = 0;
-	set_ier(up, 0);
+	serial8250_set_IER(up, 0);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	synchronize_irq(port->irq);
@@ -2679,7 +2632,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (up->capabilities & UART_CAP_RTOIE)
 		up->ier |= UART_IER_RTOIE;
 
-	set_ier(up, up->ier);
+	serial8250_set_IER(up, up->ier);
 
 	if (up->capabilities & UART_CAP_EFR) {
 		unsigned char efr = 0;
@@ -3189,12 +3142,13 @@ void serial8250_console_write_atomic(struct uart_8250_port *up,
 {
 	struct uart_port *port = &up->port;
 	unsigned int flags;
+	unsigned int ier;
 
 	console_atomic_lock(&flags);
 
 	touch_nmi_watchdog();
 
-	clear_ier(up);
+	ier = serial8250_clear_IER(up);
 
 	if (atomic_fetch_inc(&up->console_printing)) {
 		uart_console_write(port, "\n", 1,
@@ -3204,7 +3158,7 @@ void serial8250_console_write_atomic(struct uart_8250_port *up,
 	atomic_dec(&up->console_printing);
 
 	wait_for_xmitr(up, BOTH_EMPTY);
-	restore_ier(up);
+	serial8250_set_IER(up, ier);
 
 	console_atomic_unlock(flags);
 }
@@ -3220,13 +3174,14 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 {
 	struct uart_port *port = &up->port;
 	unsigned long flags;
+	unsigned int ier;
 
 	touch_nmi_watchdog();
 
 	serial8250_rpm_get(up);
 	spin_lock_irqsave(&port->lock, flags);
 
-	clear_ier(up);
+	ier = serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3243,7 +3198,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 *	and restore the IER
 	 */
 	wait_for_xmitr(up, BOTH_EMPTY);
-	restore_ier(up);
+	serial8250_set_IER(up, ier);
 
 	/*
 	 *	The receive handling will happen properly because the
diff --git a/localversion-rt b/localversion-rt
index ad3da1bcab7e8..0efe7ba1930e1 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt4
+-rt5
