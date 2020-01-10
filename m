Return-Path: <SRS0=Qnkb=27=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A1AC33CA4
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 15:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34E6C20721
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Jan 2020 15:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgAJPjw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:39:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAJPjw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Jan 2020 10:39:52 -0500
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1ipwO5-0007H0-6B; Fri, 10 Jan 2020 16:39:49 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dick Hollenbeck <dick@softplc.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH RT 2/2] serial: 8250: fsl/ingenic/mtk: fix atomic console
Date:   Fri, 10 Jan 2020 16:45:32 +0106
Message-Id: <20200110153932.14970-3-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110153932.14970-1-john.ogness@linutronix.de>
References: <20200110153932.14970-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

A few 8250 implementations have their own IER access. If the port
is a console, wrap the accesses with console_atomic_lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 drivers/tty/serial/8250/8250_fsl.c     |  9 ++++++++
 drivers/tty/serial/8250/8250_ingenic.c |  7 +++++++
 drivers/tty/serial/8250/8250_mtk.c     | 29 ++++++++++++++++++++++++--
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index aa0e216d5ead..8f711afadd4b 100644
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
index 424c07c5f629..47f1482bd818 100644
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
index 4d067f515f74..b509c3de0301 100644
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
-- 
2.20.1

