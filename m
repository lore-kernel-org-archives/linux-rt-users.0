Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3CA149DFD
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157777; cv=none; b=JkOvip2YsACAHxq6ewvWlVW1d3Xjevls8SfM2D4mc5BUA3FVUqw+z8UtoPC+bzIt+DirYPJJKYpF90l1M6yLmSbPukq7vXcXHtAJHe+sT32a/GjnMNNIP4PeAe+MLTwvdV5zQXgZ5sh3CTfWZMzUnEbOkXyWnhTzYxnJGBty1ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157777; c=relaxed/simple;
	bh=SxpR1u4qw4FLXORsNfelmog7zJByFeg7BE3dEP4Jo3Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=llQxMdkV5H/Gh7qhELxz5GMBGT/ZgesB9Hq21ZXNeCpwKoc2ue7cNNMizmcht/uNq5DWpOePGQ7C/f9JAmTn+kpJ41rQ+VtMWHV1GDaX/ckEMyi7ar0lePGBtWAw0jrdi/wRGaB7+eqJcwFSHoZg8pqE/nky8xTJmofaluKr9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=JiWknZFA; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="JiWknZFA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=pYAA+BILTgcm8agMd1DYp0oRUZ3ZGpnHgkGBWLwmfmA=; b=JiWknZFAc4U/RPZ6p9KRb7fyHB
	ysgDdxpZ2ESGmpdYFVUwOMjF1sSE4rvHNbaVXMFzqQGLzw7sBVaRV/mBvB5FI9ebztpQsysPTD7WK
	DdiN/IIkXRQfixlBGkHh4DUL6RdvzB9tm1OIWdvCvb+kmEk8/AxYeO6Dc0k9ZgqWdSOSAiYzxkok2
	RewETgURoccl+fBfI6lmZ3AUJEAsnMYkdCva2JpaBTkpIWfXehlWimcNj5o2bPCe9+04yy7CYNLRd
	y+PpbV1T2gHedg7ryMUTIFijmaE1ykpQxiJL1PcP9Roe1Qq1BX9gyHRek7uBOUlHDGw2ypKPGrp9g
	r5dZcdqw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rs2Rv-000Hwh-Kn; Wed, 03 Apr 2024 17:22:51 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rs2Rv-004jtg-1J;
	Wed, 03 Apr 2024 17:22:51 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH 1/2] serial: imx: Avoid busy polling for transmitter to become empty
Date: Wed,  3 Apr 2024 17:22:52 +0200
Message-ID: <9895c8f9553523d158f47a9718bd24f22dbe0455.1712156846.git.esben@geanix.com>
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

Busy polling with readl() is a rather harsh way to wait for a potentially
long time.

While there, introduce a 10 ms timeout on this waiting, similar to what
many other serial drivers do.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/tty/serial/imx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 54b760d845c0..16661827277e 100644
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
+				 1, 10000, false, sport, USR2);
 	imx_uart_ucrs_restore(sport, &old_ucr);
 
 	if (locked)
-- 
2.44.0

