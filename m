From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cpufreq + PREEMPT_RT_FULL give bad context sleeping BUG
Date: Tue, 26 Mar 2013 21:51:07 +0100
Message-ID: <20130326205107.GB14220@linutronix.de>
References: <alpine.LFD.2.02.1303222301010.22263@ionos>
 <20130323013003.GU11538@uudg.org>
 <514DE3BF.5010800@gentil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Gregoire Gentil <gregoire@gentil.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Rob Herring <rob.herring@calxeda.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59089 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3CZUvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 Mar 2013 16:51:12 -0400
Content-Disposition: inline
In-Reply-To: <514DE3BF.5010800@gentil.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gregoire Gentil | 2013-03-23 10:17:51 [-0700]:

>Hello,
Hi,

>On OMAP + 3.4 + rt patches with CONFIG_PREEMPT_RT_FULL
>CONFIG_CPU_FREQ_GOV_ONDEMAND, I get a lot of those cpufreq-related
>bugs:
>
>http://pastebin.com/csy9y3xk
>
>BUG: sleeping function called from invalid context at kernel/rtmutex.c=
:646
>(__might_sleep+0x124/0x144) from (rt_spin_lock+0x30/0x64)
>(rt_spin_lock+0x30/0x64) from (clk_get_rate+0x30/0x54)
>(clk_get_rate+0x30/0x54) from (twd_update_frequency+0x20/0x58)

Here it tries to grab a mutex

>(twd_update_frequency+0x20/0x58) from (smp_call_function_single+0xd0/0=
x1c4)
>(smp_call_function_single+0xd0/0x1c4) from

Here it calls a smp functions which runs with interupts off.

>(twd_cpufreq_transition+0x34/0x40)

that means it should trigger on mainline as well.

>Any idea what I should do to fix this problem?

This has been introduced in 4fd7f9b12 ("ARM: 7212/1: smp_twd: reconfigu=
re
clockevents after cpufreq change"). I think that omap got later
converted to the generic clk framework which uses now the mutex. Could
somebody please look at this?

>Gr=C3=A9goire

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
