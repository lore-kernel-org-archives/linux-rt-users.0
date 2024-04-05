Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCF142649
	for <linux-rt-users@vger.kernel.org>; Fri,  5 Apr 2024 07:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303802; cv=none; b=cRKa/zE/UTungwgBCThbI+NrOpiOYERbwnqNfPaLhb9SACIqqqq0avuT3rK/KX0CICh3XXZVypOiVdXvaTsFOPaNNxRvzu9wwW8jNlIyFNlYwssUNBgQ2o05d47uAOPXr+/svLcUOT1rUMZAeN1prhe0372952pEITjuCVwKijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303802; c=relaxed/simple;
	bh=2BhYTsKcB6ShQLavceEKhuwHR7SFeNxS4jvvVPGkLEM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YvJS/8Mp6/isjMH7gCcUI0/749rGVSZG+vScinUO+sZDTR1qPbVu3FtzexGujm3PTUzUi5AWZBTUOixR/1acGtCYbPSVzRQLiZe84JpBagq3B3NVr7lxHLCJwyJVaFO2/tfKFVnpk+SBveKiseG/Xpm+s0bbK4PJxEkKMrY5CWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kd1IwquZ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kd1IwquZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=E0tmjZ7Dt1kxHgBqEuBWCQrgvgbQW+TfS/LuD1kGAGY=; b=kd1IwquZCcAAQ/AM7UOtPRtlV5
	5n3b25fBPZbFaEegyXkTdIK6O/nijfw3cvGwfNilo8CRAnhO8YGzrLbLwphrYmZfzxoSH9Hyt7pBN
	7gLoxTXo7WjL5GEWnGw7BRourwQM8lNGU2g2VATTQpfeQtblcCFxPrDjh070kInlA1vmzh0UHrZTj
	cSF1T5NW+Rzyv2S+NmCsoFRjp5+pW8VOECrB+kZG9pBtbkweMSXFuwdTI7WeEggZI78w95HFYUR3S
	5OWHfjN7IQFQYWhA1L2vhShjMifpArvdkYoQ4UJDC18YmMNJjnydhXpeUpYlkKdcBaQk85RPhE7J4
	VPXnYq7g==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rseRA-0005Lh-R6
	for linux-rt-users@vger.kernel.org; Fri, 05 Apr 2024 09:56:36 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rseRA-0006E5-22
	for linux-rt-users@vger.kernel.org;
	Fri, 05 Apr 2024 09:56:36 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org
Subject: [RFC PATCH v2 0/2] serial: imx: Switch to nbcon console
Date: Fri,  5 Apr 2024 09:56:36 +0200
Message-ID: <cover.1712303358.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27235/Thu Apr  4 10:24:59 2024)

This is a first attempt at porting another serial console driver to nbcon.

The first patch is a preparatory patch, thought to be suitable for mainline
inclusion now, while the second patch is for rt only for now.

The second patch does have quite a copy-paste feeling to it.

The imx_uart_console_write_atomic() and imx_uart_console_write_thread()
includes copies of code from the old imx_uart_console_write() function.
This is similar to current status of nbcon support in 8250 driver.

The midle part of imx_uart_console_write_thread() is identical to the
middle part of serial8250_console_write_thread() in
drivers/tty/serial/8250/8250_port.c, except for the arguments to
uart_console_write() function.

There is clearly potential for writing some common code to avoid both cases
of copy-paste code.

I am unsure about what the plan is for keeping the legacy console code in
the drivers. Are we going to drop that before submitting the code to
mainline?

v2:
- Switch to tight loop (no udelay()) in atomic context.
- Increase timeout to 1 second.
- Add note in commit message about (no) error handling on timeout.


Esben Haabendal (2):
  serial: imx: Introduce timeout when waiting on transmitter empty
  serial: imx: Switch to nbcon console

 drivers/tty/serial/imx.c | 161 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 4 deletions(-)

-- 
2.44.0

