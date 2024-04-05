Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43891428F5
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303804; cv=none; b=AGCstgl9OtTcBMK5aggp788MiqjXSpWgFYCYsRgl0tf+DiaWuYtuf0f+RTc4ryxycmTlksjdV1VHVVVirevHVEokGI+0qAYsU9mGjAeKDlQ1RYnFApMXmf88Dbro/WWR6Qv6oXqRGQ2gA1sY+L1N1BaCM1xIVR6WeHUT6BQpfAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303804; c=relaxed/simple;
	bh=62/kBfCFqywb6RolU+elMlCQFqop7JIerJ8T2hSZePU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DogVLjKL5WlQ5xLwahVnJtOOr9IPU4cYY7ECSTF0RoHUeKEVWdVTrVbhFg+TJoY+imOrWbDcvxZzP+0Ysxmy1JMBGZ4RiUvJ7WyZcBqBfJ6fjeUSTB5K0QStnoHtKUjs2qXbvWLf489OMXwbhHYvt3Z6bWtSyVHFnwfm1NE5yv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=yPsDqkxr; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="yPsDqkxr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=A+KMB3ZPLg0xQOTlbKLq4wkG6MWTg/99Psbp1VqQgYk=; b=yPsDqkxrgtjpAqOlxUSFBeaIIm
	DjpqwsmWGYdPkbqTiJy8LrkgxRTO5yXPaMQdhZZt5h/BMVjbuT5VC0SfNhuHPuynLtTt2joBINJiY
	3rk2TbGlCDZOuWdCG5BbmYHe8L3GnPNRntvUxQgbQRaJv1SaWp5QNcw+NztHm/yyv47ou4oCyJdQy
	JwvEXzoz5l6uNs2b/l8qZ4NcRTF5nmhbmQZcUSc9m70lWgso0CniV0M6ecqKgS0/rDzKws76dGEis
	7FBXl5Y6FlV+TA4hqX4pcaqLYglXMP20lO3bGelaFSfgIDNrz4s5RjRTOjtk07m21CW7/NSwdVuEJ
	8r02modg==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rseRB-0005Lr-DC; Fri, 05 Apr 2024 09:56:37 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rseRB-0006IH-0H;
	Fri, 05 Apr 2024 09:56:37 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH v2 1/2] serial: imx: Introduce timeout when waiting on transmitter empty
Date: Fri,  5 Apr 2024 09:56:37 +0200
Message-ID: <7bfab9fb4313e64d8998a78e49411bdc7f9bd7c7.1712303358.git.esben@geanix.com>
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

By waiting at most 1 second for USR2_TXDC to be set, we avoid a potentital
deadlock.

In case of the timeout, there is not much we can do, so we simply ignore
the transmitter state and optimistically try to continue.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 54b760d845c0..f7e4f38f08f3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/irq.h>
@@ -1995,7 +1996,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_uart_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned long flags;
-	unsigned int ucr1;
+	unsigned int ucr1, usr2;
 	int locked = 1;
 
 	if (sport->port.sysrq)
@@ -2026,8 +2027,8 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore UCR1/2/3
 	 */
-	while (!(imx_uart_readl(sport, USR2) & USR2_TXDC));
-
+	read_poll_timeout_atomic(imx_uart_readl, usr2, usr2 & USR2_TXDC,
+				 0, 1000000, false, sport, USR2);
 	imx_uart_ucrs_restore(sport, &old_ucr);
 
 	if (locked)
-- 
2.44.0

