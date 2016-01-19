From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: Fix preempt-rt on AT91
Date: Tue, 19 Jan 2016 02:02:11 +0100
Message-ID: <20160119010211.GU3367@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118174259.GC12309@linutronix.de>
 <20160118192308.GR3367@piout.net>
 <569D4B55.10103@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:35146 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932524AbcASBCM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Jan 2016 20:02:12 -0500
Content-Disposition: inline
In-Reply-To: <569D4B55.10103@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18/01/2016 at 21:30:13 +0100, Sebastian Andrzej Siewior wrote :
> Well, if it works properly and does not lead to any new bugs or
> anything else then nobody will mind I guess.
> 

Yeah, the DT guys were not happy about the patch set, I'll try to work
around using DT ;)

> >> All in all, care to forwarded the working pieces from -RT patch set
> >> upstream? I problem I have here is mostly that I can't the patches on
> >> actual hardware. Disabling the PIT and running on the other clocksource
> >> isn't that -RT specific after all :)
> > 
> > I'd say that the only remaining part is the IRQ freeing/requesting but
> > as I said, this can't land in mainline as is. I still plan to work on
> > that later.
> > I'd say that most people running linux on at91 are already using the tcb
> > as the clocksource, this is already available in the mainline and is the
> > default unless the TCBs are used for something else.
> 
> Wasn't there one of the patches to increase the frequency of the TCB
> clocksource from the default to something higher?
> 

Indeed, it may be worth mainlining that one.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
