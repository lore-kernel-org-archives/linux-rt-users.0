From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: cpufreq + PREEMPT_RT_FULL give bad context sleeping BUG
Date: Tue, 26 Mar 2013 22:07:45 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1303262203560.22263@ionos>
References: <alpine.LFD.2.02.1303222301010.22263@ionos> <20130323013003.GU11538@uudg.org> <514DE3BF.5010800@gentil.com> <20130326205107.GB14220@linutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregoire Gentil <gregoire@gentil.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59204 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab3CZVHy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Mar 2013 17:07:54 -0400
In-Reply-To: <20130326205107.GB14220@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 26 Mar 2013, Sebastian Andrzej Siewior wrote:

> * Gregoire Gentil | 2013-03-23 10:17:51 [-0700]:
> 
> >Hello,
> Hi,
> 
> >On OMAP + 3.4 + rt patches with CONFIG_PREEMPT_RT_FULL
> >CONFIG_CPU_FREQ_GOV_ONDEMAND, I get a lot of those cpufreq-related
> >bugs:
> >
> >http://pastebin.com/csy9y3xk
> >
> >BUG: sleeping function called from invalid context at kernel/rtmutex.c:646
> >(__might_sleep+0x124/0x144) from (rt_spin_lock+0x30/0x64)
> >(rt_spin_lock+0x30/0x64) from (clk_get_rate+0x30/0x54)
> >(clk_get_rate+0x30/0x54) from (twd_update_frequency+0x20/0x58)
> 
> Here it tries to grab a mutex
> 
> >(twd_update_frequency+0x20/0x58) from (smp_call_function_single+0xd0/0x1c4)
> >(smp_call_function_single+0xd0/0x1c4) from
> 
> Here it calls a smp functions which runs with interupts off.
> 
> >(twd_cpufreq_transition+0x34/0x40)
> 
> that means it should trigger on mainline as well.

No. It won't. Mainline uses a spinlock which gets converted to a
sleeping spinlock on rt.

  (rt_spin_lock+0x30/0x64) from (clk_get_rate+0x30/0x54)
 
> >Any idea what I should do to fix this problem?

One possibility would be to convert the clk->spinlock to a raw
spinlock, but you have to audit the code which implications this has
latency wise. In theory the code under the spinlock should not do
anything time consuming, so it should be fine. If it does something
time consuming, we better fix that anyway.

Thanks,

	tglx

 
