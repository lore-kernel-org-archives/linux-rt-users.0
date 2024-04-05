Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FCB1428F6
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303803; cv=none; b=XUXIYKBQcubC7ngNOEcvXwDL8ochibEdwSMdYUbgGWMNwhkNR9I0scPkB8JKUP2NbenTCYqXx3ZtlCM/amVh0y3KU3O98gU9kqzSpOkEg9xz20yqPR2IbyQ5ERvhD2q6zcES52jGJtfZTNj5qmleuTyDr7FoqENJ2SmbyfKCr3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303803; c=relaxed/simple;
	bh=K16QnRgvT4dMrMRox/DiWe9smtefNt3KIx43FXMD7aA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8PAT0uWL2zkOQnMLFv3GwUDd42JuKKamr5sxtXSF+2Z6cfr2QDb+NV7eHpvQXVcctEAXi+C+pg2za+UCciGV83mJ/ccsw5Nnb3VYZzFuU80kI666Mv9pgNfwCAPdcuCFvLlQinI+oKGe+KUdHAN+HJjn559Vjs9XAKTNRQi+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=vxe6zRsS; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="vxe6zRsS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=rqPjwOUtTaX+2YF0/AT8bUriZY97UGR7hb61YgQIdbQ=; b=vxe6zRsS44LvOWyk7rZ9JvY5iI
	dBk2olc6wBefPt0xTD/ZGcrxHvwsWRkoUJbjWm3VVds3pVYUdqPK/SPuG/HlX8ft/0hOn2/ii6/8a
	Ly8uha22xvkyxphzNq7+n0fDi6qXMJUecDAjjHpomAjN6JPWFXv+NCYzEC+12BgXCXDDmJ7iMhMKB
	qcaZ6KQrmcLE6ntgexdEj0NM2rrqChsKS79e7SBLjxisBEuOZahByEmHdvJF5Gc5DLO6TvksPoh3N
	b6AB2NzlMgHL7/pnWza77Zi23VsskpvaqLbnuj9LWMnbtdQzT+ysg518Y8CBDbLe8mgYOJ5O0QAVn
	jQNH1BsA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rseRB-0005M2-Oe; Fri, 05 Apr 2024 09:56:37 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rseRB-0006MT-1k;
	Fri, 05 Apr 2024 09:56:37 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v2 2/2] serial: imx: Switch to nbcon console
Date: Fri,  5 Apr 2024 09:56:38 +0200
Message-ID: <2bc0b5d3f99184d8ddbf860666513f9fa7760af8.1712303358.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712303358.git.esben@geanix.com>
References: <cover.1712303358.git.esben@geanix.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

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
index f7e4f38f08f3..2a49880c2651 100644
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
+				 0, 1000000, false, sport, USR2);
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
+			  1, 1000000, false, sport, USR2);
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

