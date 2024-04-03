Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429CD14A4CE
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157777; cv=none; b=EKEj1hihCVtJIzy8fkaZIhIgMYLunlOP8TQoe2m3IYSw2dKdtJ76/I80EaRIJAoWZdgcgCe8HPbkBdlgs/u/GJ4r2hWxKvrQ69y4mgY8sseXMsJOgag0LAlNuR5NvaQZgfy2pHn1uIXIHk2NHlWORFXADEfnba9dayeG/zK1kHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157777; c=relaxed/simple;
	bh=E/YW0lYQkq32hi/6tLdxY4zD3i4BzL3bLXi2HNlkB3g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WXmWElc6QouWKkNl8397qgv0tLAbSCjPXtm8e09gkEcm+mrb8Myt3UFVBbkHuURvnFjBUfgDxH9XpY5p8FjVzUfFEHzUCgSbDRpnvODOSWyRE3Tnf29ijsiweLhQJ5/T8esHJ+s5Mxf08TflL2L+qg/HFLMBO7mqcNJCgVM2akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=CCFUxh7m; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="CCFUxh7m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+mOrOqvyV/OGQLcHRueApbE5Rwa5KJKgYDdT2tk0Q+Q=; b=CCFUxh7mvEdEokBiSevV7gB+KI
	ruQGzlTN3C8470qEO9mvX9lYUhWGfxqAwXvjqGF2YPkskdSDQl2ykqSXACx9ZjejNPynOKqIByC1q
	vIugl6aRfsXMvjSHvzxWo3T4NDKXzAWDeORF+vE6WXrYVnVx6oUoEE6K8rLFtBkeL9TwiIw2sxQEU
	3XWe217VS0h2ZcFWOg0xhAv20LDexVVvh4rwvoK4wS8fxokUCO0LonePYgWhCpbzCfqiqoZlbJtWL
	4vr6H527qSMoWZDfiWXL+4I7TiiOnJ692FzqR2zzwG5R2KkBuKxsRdUE47sjqzm3i6J5G5BhoKiJr
	8XLfh0zA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rs2Rw-000Hwq-2F; Wed, 03 Apr 2024 17:22:52 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rs2Rv-004jvH-2i;
	Wed, 03 Apr 2024 17:22:51 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH 2/2] serial: imx: Switch to nbcon console
Date: Wed,  3 Apr 2024 17:22:53 +0200
Message-ID: <47b4667db579019c292ece5563d74f897c62f046.1712156846.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712156846.git.esben@geanix.com>
References: <cover.1712156846.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

Implements the necessary callbacks to switch the imx console driver to
perform as an nbcon console.

Add implementations for the nbcon consoles (write_atomic, write_thread,
driver_enter, driver_exit) and add CON_NBCON to the initial flags.

The legacy code is kept in order to easily switch back to legacy mode
by defining CONFIG_SERIAL_IMX_LEGACY_CONSOLE.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/imx.c | 154 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 16661827277e..7030fa2bcaea 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -230,6 +230,8 @@ struct imx_port {
 	unsigned int            saved_reg[10];
 	bool			context_saved;
 
+	bool			console_newline_needed;
+
 	enum imx_tx_state	tx_state;
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
@@ -1985,8 +1987,14 @@ static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
 		barrier();
 
 	imx_uart_writel(sport, ch, URTX0);
+
+	if (ch == '\n')
+		sport->console_newline_needed = false;
+	else
+		sport->console_newline_needed = true;
 }
 
+#ifdef CONFIG_SERIAL_IMX_LEGACY_CONSOLE
 /*
  * Interrupts are disabled on entering
  */
@@ -2034,6 +2042,140 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		uart_port_unlock_irqrestore(&sport->port, flags);
 }
+#else
+static void imx_uart_console_driver_enter(struct console *co, unsigned long *flags)
+{
+	struct uart_port *up = &imx_uart_ports[co->index]->port;
+
+	return __uart_port_lock_irqsave(up, flags);
+}
+
+static void imx_uart_console_driver_exit(struct console *co, unsigned long flags)
+{
+	struct uart_port *up = &imx_uart_ports[co->index]->port;
+
+	return __uart_port_unlock_irqrestore(up, flags);
+}
+
+static bool imx_uart_console_write_atomic(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct imx_port *sport = imx_uart_ports[co->index];
+	struct uart_port *port = &sport->port;
+	struct imx_port_ucrs old_ucr;
+	unsigned int ucr1, usr2;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return false;
+
+	/*
+	 *	First, save UCR1/2/3 and then disable interrupts
+	 */
+	imx_uart_ucrs_save(sport, &old_ucr);
+	ucr1 = old_ucr.ucr1;
+
+	if (imx_uart_is_imx1(sport))
+		ucr1 |= IMX1_UCR1_UARTCLKEN;
+	ucr1 |= UCR1_UARTEN;
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
+
+	imx_uart_writel(sport, ucr1, UCR1);
+
+	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
+
+	if (sport->console_newline_needed)
+		uart_console_write(port, "\n", 1, imx_uart_console_putchar);
+	uart_console_write(port, wctxt->outbuf, wctxt->len,
+			   imx_uart_console_putchar);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore UCR1/2/3
+	 */
+	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
+				 1, 10000, false, sport, USR2);
+	imx_uart_ucrs_restore(sport, &old_ucr);
+
+	/* Success if no handover/takeover. */
+	return nbcon_exit_unsafe(wctxt);
+}
+
+static bool imx_uart_console_write_thread(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct imx_port *sport = imx_uart_ports[co->index];
+	struct uart_port *port = &sport->port;
+	struct imx_port_ucrs old_ucr;
+	unsigned int ucr1, usr2;
+	bool done = false;
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return false;
+
+	/*
+	 *	First, save UCR1/2/3 and then disable interrupts
+	 */
+	imx_uart_ucrs_save(sport, &old_ucr);
+	ucr1 = old_ucr.ucr1;
+
+	if (imx_uart_is_imx1(sport))
+		ucr1 |= IMX1_UCR1_UARTCLKEN;
+	ucr1 |= UCR1_UARTEN;
+	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN);
+
+	imx_uart_writel(sport, ucr1, UCR1);
+
+	imx_uart_writel(sport, old_ucr.ucr2 | UCR2_TXEN, UCR2);
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int len = READ_ONCE(wctxt->len);
+		int i;
+
+		/*
+		 * Write out the message. Toggle unsafe for each byte in order
+		 * to give another (higher priority) context the opportunity
+		 * for a friendly takeover. If such a takeover occurs, this
+		 * context must reacquire ownership in order to perform final
+		 * actions (such as re-enabling the interrupts).
+		 *
+		 * IMPORTANT: wctxt->outbuf and wctxt->len are no longer valid
+		 *	      after a reacquire so writing the message must be
+		 *	      aborted.
+		 */
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt)) {
+				nbcon_reacquire(wctxt);
+				break;
+			}
+
+			uart_console_write(port, wctxt->outbuf + i, 1,
+					   imx_uart_console_putchar);
+
+			if (!nbcon_exit_unsafe(wctxt)) {
+				nbcon_reacquire(wctxt);
+				break;
+			}
+		}
+		done = (i == len);
+	} else {
+		nbcon_reacquire(wctxt);
+	}
+
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire(wctxt);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore UCR1/2/3
+	 */
+	read_poll_timeout(imx_uart_readl, usr2, usr2 & USR2_TXDC,
+			  1, 10000, false, sport, USR2);
+	imx_uart_ucrs_restore(sport, &old_ucr);
+
+	/* Success if no handover/takeover and message fully printed. */
+	return (nbcon_exit_unsafe(wctxt) && done);
+}
+#endif /* CONFIG_SERIAL_IMX_LEGACY_CONSOLE */
 
 /*
  * If the port was already initialised (eg, by a boot loader),
@@ -2124,6 +2266,8 @@ imx_uart_console_setup(struct console *co, char *options)
 	if (retval)
 		goto error_console;
 
+	sport->console_newline_needed = false;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else
@@ -2160,11 +2304,19 @@ imx_uart_console_exit(struct console *co)
 static struct uart_driver imx_uart_uart_driver;
 static struct console imx_uart_console = {
 	.name		= DEV_NAME,
+#ifdef CONFIG_SERIAL_IMX_LEGACY_CONSOLE
 	.write		= imx_uart_console_write,
+	.flags		= CON_PRINTBUFFER,
+#else
+	.write_atomic	= imx_uart_console_write_atomic,
+	.write_thread	= imx_uart_console_write_thread,
+	.driver_enter	= imx_uart_console_driver_enter,
+	.driver_exit	= imx_uart_console_driver_exit,
+	.flags		= CON_PRINTBUFFER | CON_NBCON,
+#endif
 	.device		= uart_console_device,
 	.setup		= imx_uart_console_setup,
 	.exit		= imx_uart_console_exit,
-	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 	.data		= &imx_uart_uart_driver,
 };
-- 
2.44.0

