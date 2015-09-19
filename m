From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: SDHCI interrupt handling
Date: Sat, 19 Sep 2015 09:23:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509190922060.3951@nanos>
References: <20150918202812.GA22647@nathan3500-linux-VM>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, msmucr@gmail.com,
	bigeasy@linutronix.de
To: Nathan Sullivan <nathan.sullivan@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60263 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbISHYH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 19 Sep 2015 03:24:07 -0400
In-Reply-To: <20150918202812.GA22647@nathan3500-linux-VM>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 18 Sep 2015, Nathan Sullivan wrote:

> I have noticed that doing SDIO access from the SDHCI interrupt handler, like
> the ath6kl_sdio driver does, is currently broken in 4.1 RT due to d04ea10ba1ea
> 'mmc: sdhci: don't provide hard irq handler'.  Since the SDHCI IRQ is masked in
> the threaded handler that calls the card IRQ handler, drivers cannot perform
> MMC IO from their card IRQ handlers since the SDHCI driver will time out
> waiting for the SDHCI hard IRQ to happen.
> 
> Is d04ea10ba1ea a temporary hack, or should drivers be fixed to perform IO a in
> a different way?

That's temporary and looks not really well thought out. I have a
mainline report against SDHCI + interrupt force threading as well, so
I'm looking for a solution.

Thanks,

	tglx
