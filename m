Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4E014A4CD
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Apr 2024 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712157776; cv=none; b=OKTmvzkC1wcyVASswlN89pEkXDD/U+5K/LM7nkCEoxJW/RE6dqMFiDffaXOmWL3g4vZgrLD+v/EQW8clZrAyVXLW/W0VAgEcsMP6G+qusQI7psS7toqNyucLmg7WiwCp+fDPN3iK/q5MwkYAZ0tjo1pWGgV4uHGvz2etDLCwkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712157776; c=relaxed/simple;
	bh=EbzhIC0AKnWIE6qFPsEsjnTJOZUppf3Ff727FpGdKG4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bz5hreTuUyQ/vedPrEoPXCBLGkmNP14NDnX3ItH0oBe4copLnSQqM6seHmWe8Qvc213a4RlBNVUFF8EwNnGBwcYYQfzkpnFJUXHNzE0W34dVVOgSJkBr/webxVL/TtcXExuL8SVOfXlon5F00u20zSyUOauctiZYS6ME8ZdF4IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=hDSyY/Bh; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="hDSyY/Bh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=x9vvwJqbGW0e3TyN5McNhbry+v/8dFkupfnhWGSgKZA=; b=hDSyY/BhpBPJmGkk6nLDSrevsF
	hBNOo9LxMyYAvpKlXOQrwIxx6DP6+CKfpzvYQyh+bOWayv5tcQPFRQHzUvOh5S//fiVpwiJQIy23M
	3/yV4xnjImFNi+Q92xt58hOznRSAQxPa4ha8N7yzJFRhLAwx3MhJc+TpEOI1Oo7ZpCylWKzVitcb8
	GSeOJfuMgqqMC6loABrv0fUzOMLgRr4rvnYUJNubafJ8caD/kUYXirf1LaEgL3aU37eqUkuK30mvI
	cKdji1/UnMEkKYfgGu0KGFpeunXoTs82sAU4LUiSgxtwXmMW1m1hvA5yNRbCc+mGjZ39GFXykWpnD
	LHx8CYEw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1rs2Rv-000HwX-94; Wed, 03 Apr 2024 17:22:51 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1rs2Ru-004jry-35;
	Wed, 03 Apr 2024 17:22:50 +0200
From: Esben Haabendal <esben@geanix.com>
To: linux-rt-users@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>
Subject: [RFC PATCH 0/2] serial: imx: Switch to nbcon console
Date: Wed,  3 Apr 2024 17:22:51 +0200
Message-ID: <cover.1712156846.git.esben@geanix.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27234/Wed Apr  3 10:25:27 2024)

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

Esben Haabendal (2):
  serial: imx: Avoid busy polling for transmitter to become empty
  serial: imx: Switch to nbcon console

 drivers/tty/serial/imx.c | 161 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 157 insertions(+), 4 deletions(-)

-- 
2.44.0

