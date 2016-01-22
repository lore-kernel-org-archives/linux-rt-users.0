From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch v4.4-rt2] sched: fix up preempt lazy forward port
Date: Fri, 22 Jan 2016 15:14:53 +0100
Message-ID: <56A2395D.3090106@linutronix.de>
References: <1453108103.4123.4.camel@gmail.com>
 <20160118201828.GE12309@linutronix.de> <1453170597.3740.7.camel@gmail.com>
 <20160121125405.GA11749@linutronix.de> <56A21F7D.9070101@ti.com>
 <56A22C49.5020401@linutronix.de> <56A22FE7.6070005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46442 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753699AbcAVOOz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Jan 2016 09:14:55 -0500
In-Reply-To: <56A22FE7.6070005@ti.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/22/2016 02:34 PM, Grygorii Strashko wrote:
>> Do you still see it with the missing lazy bits? I don't see where this
>> could come from.
>>
> 
> yep. I've tried it with and without changing _TIF_WORK_MASK
> Seems It's triggered by Virtual terminal keyboard_tasklet

Just bootet my current v4.4 to cross check what you see and I have this:

[    3.808273] clocksource: Switched to clocksource arch_sys_counter
[    3.851193] keyboard: kbd_init(1609)
[    3.861903] keyboard: kbd_bh(1201)
[    3.868322] keyboard: kbd_init(1612)
[    3.868581] NET: Registered protocol family 2

So. No backtrace here. According to the full dmesg I should have all
CPUs up by now. kbd_bh is comming from ksoftirqd as well. No idea why
you see this.
There is a irq off region which sets and removes RUN bit, I have no
idea why you have this backtrace.

Sebastian

