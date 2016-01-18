From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Fix preempt-rt on AT91
Date: Mon, 18 Jan 2016 21:30:13 +0100
Message-ID: <569D4B55.10103@linutronix.de>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de> <20160118192308.GR3367@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48348 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbcARUaQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 15:30:16 -0500
In-Reply-To: <20160118192308.GR3367@piout.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/18/2016 08:23 PM, Alexandre Belloni wrote:
> Hi,
Hi,

>>> I'd say that the proper solution would still be to implement the virtual
>>> irqchip because this would still hit people not wanting to use the TCB as
>>> their clock source.
>>
>> why wouldn't people not want that?
> 
> Because they may be using the TCBs for something else: PWM, frequency
> measure, quadrature decoder...

Oh okay.

>> For a virtual irqchip you would need a mask/unmask register in order to
>> individual disable/enable the irq and you need something to figure out
>> which one of the three is active. You don't have all those things, do
>> you?
>>
> 
> The proposed solution was software only. It mainly consisted in a simple
> irq demuxer.

Well, if it works properly and does not lead to any new bugs or
anything else then nobody will mind I guess.

>> All in all, care to forwarded the working pieces from -RT patch set
>> upstream? I problem I have here is mostly that I can't the patches on
>> actual hardware. Disabling the PIT and running on the other clocksource
>> isn't that -RT specific after all :)
> 
> I'd say that the only remaining part is the IRQ freeing/requesting but
> as I said, this can't land in mainline as is. I still plan to work on
> that later.
> I'd say that most people running linux on at91 are already using the tcb
> as the clocksource, this is already available in the mainline and is the
> default unless the TCBs are used for something else.

Wasn't there one of the patches to increase the frequency of the TCB
clocksource from the default to something higher?

Sebastian
