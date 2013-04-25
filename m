From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: cpufreq + PREEMPT_RT_FULL give bad context sleeping BUG
Date: Thu, 25 Apr 2013 17:23:34 +0200
Message-ID: <20130425152334.GA5561@linutronix.de>
References: <alpine.LFD.2.02.1303222301010.22263@ionos>
 <20130323013003.GU11538@uudg.org>
 <514DE3BF.5010800@gentil.com>
 <20130326205107.GB14220@linutronix.de>
 <alpine.LFD.2.02.1303262203560.22263@ionos>
 <20130326213356.GC14220@linutronix.de>
 <alpine.LFD.2.02.1303262236300.22263@ionos>
 <alpine.LFD.2.02.1303262243540.22263@ionos>
 <51530EE4.1040600@gentil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>,
	Rob Herring <rob.herring@calxeda.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Gregoire Gentil <gregoire@gentil.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44775 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932596Ab3DYPXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 11:23:39 -0400
Content-Disposition: inline
In-Reply-To: <51530EE4.1040600@gentil.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Gregoire Gentil | 2013-03-27 08:23:16 [-0700]:

>>>>[0] http://dev.omapzoom.org/?p=3Dintegration/kernel-ubuntu.git;a=3D=
blob;f=3Darch/arm/plat-omap/clock.c;h=3D8c0e8fe2c5c51673e41e4304194d922=
dbfaedf38;hb=3D3e1c9f139425663ceee48f92e8d3f23158580334
>>>
>>>Yeah, it's that way in mainline as well.
>>
>>I meant, that the mutex is taken. So yes, this will cause a warning i=
n
>>!RT too.
>Hello,
>
>So what could be a tentative solution? Could you advise what I could t=
ry?

The easy way would be to get the clockfw_lock lock changed into a
raw_spinlock_t and fix clk_get_rate() and others. If the lock is taken
for a long time it will increase you latency.
You try to check if it is possible to defer twd_update_frequency() to a
workqueue and execute it later and not directly from the interrupt.

On the other hand you might want simply disable cpufreq. If you have a
certain latency and the cpu frequency goes down because the system is
idle then you latency will increase. Basicaly an idle machine will wors=
e
latency than a busy one. You probably don't want this.

>
>Many thanks in advance,
>
>Gr=C3=A9goire

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
