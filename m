From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: PowerPC PPC32 CONFIG_HIGHMEM dependency question
Date: Tue, 18 Mar 2014 11:54:38 +0100
Message-ID: <20140318105438.GA10448@linutronix.de>
References: <d23eabd04d35481db8b483f9630341fd@SPIEXCHMAIL01.sierraphotonics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Robert Johnson <rjohnson@sierraphotonics.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52653 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbaCRKyk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Mar 2014 06:54:40 -0400
Content-Disposition: inline
In-Reply-To: <d23eabd04d35481db8b483f9630341fd@SPIEXCHMAIL01.sierraphotonics.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Robert Johnson | 2014-03-17 17:41:25 [+0000]:

>I am using an embedded single board computer (SBC) that has a Freescale P2020 processor.  The vendor board support package (BSP) for this product currently uses a 3.0.4 Linux kernel.  In looking through the RT patch for various Linux kernel versions even up through 3.12.13-rt21, I see that CONFIG_HIGHMEM is not allowed if CONFIG_PREEMPT_RT_FULL is selected (see arch/powerpc/Kconfig).
>
>The result for my SBC is that if I enable CONFIG_PREEMPT_RT_FULL in the kernel, I am then only able to access 1GB of RAM instead of the 4GB that is resident.

For 2 GiB you could move the memory mapping to something like 1.5GiB
userland, 2.GiB kernel and the remaining 500MiB for virtual.

>Is there any way to get CONFIG_PREEMPT_RT_FULL to work with CONFIG_HIGHMEM?

Yes. The trick is to look either at the ARM code or at the x86 code and
do something similar for powerpc.

>If I want to use CONFIG_HIGHMEM, should I consider the use of CONFIG_PREEMPT_RTB which does not appear to have a dependency?

You could CONFIG_PREEMPT_RT_BASE with CONFIG_HIGHMEM, yes. But then
don't complain about your latency which will be higher compared to
_FULL. Again: CONFIG_PREEMPT_RT_BASE is only debugging option.

Sebastian
