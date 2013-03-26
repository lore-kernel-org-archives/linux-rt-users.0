From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cpufreq + PREEMPT_RT_FULL give bad context sleeping BUG
Date: Tue, 26 Mar 2013 22:33:56 +0100
Message-ID: <20130326213356.GC14220@linutronix.de>
References: <alpine.LFD.2.02.1303222301010.22263@ionos>
 <20130323013003.GU11538@uudg.org>
 <514DE3BF.5010800@gentil.com>
 <20130326205107.GB14220@linutronix.de>
 <alpine.LFD.2.02.1303262203560.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregoire Gentil <gregoire@gentil.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59301 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab3CZVd7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Mar 2013 17:33:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1303262203560.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Thomas Gleixner | 2013-03-26 22:07:45 [+0100]:

>> that means it should trigger on mainline as well.
>
>No. It won't. Mainline uses a spinlock which gets converted to a
>sleeping spinlock on rt.
>
>  (rt_spin_lock+0x30/0x64) from (clk_get_rate+0x30/0x54)

This is true but this spinlock in only available in the OOT code
Gregoire Gentil pointed out ([0]). In mainline we have a mutex in
drivers/clk/clk.c and this is what my omap4 blaze is using.

[0] http://dev.omapzoom.org/?p=integration/kernel-ubuntu.git;a=blob;f=arch/arm/plat-omap/clock.c;h=8c0e8fe2c5c51673e41e4304194d922dbfaedf38;hb=3e1c9f139425663ceee48f92e8d3f23158580334

>Thanks,
>
>	tglx

Sebastian
