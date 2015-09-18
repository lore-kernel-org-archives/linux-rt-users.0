From: Nathan Sullivan <nathan.sullivan@ni.com>
Subject: SDHCI interrupt handling
Date: Fri, 18 Sep 2015 15:28:12 -0500
Message-ID: <20150918202812.GA22647@nathan3500-linux-VM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: linux-rt-users@vger.kernel.org, msmucr@gmail.com,
	bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:47557 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751659AbbIRU2Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 16:28:25 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I have noticed that doing SDIO access from the SDHCI interrupt handler, like
the ath6kl_sdio driver does, is currently broken in 4.1 RT due to d04ea10ba1ea
'mmc: sdhci: don't provide hard irq handler'.  Since the SDHCI IRQ is masked in
the threaded handler that calls the card IRQ handler, drivers cannot perform
MMC IO from their card IRQ handlers since the SDHCI driver will time out
waiting for the SDHCI hard IRQ to happen.

Is d04ea10ba1ea a temporary hack, or should drivers be fixed to perform IO a in
a different way?
