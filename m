From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 4.4-rt2] fix
 arm-at91-pit-remove-irq-handler-when-clock-is-unused.patch
Date: Thu, 17 Mar 2016 20:55:09 +0100
Message-ID: <20160317195509.GF2831@piout.net>
References: <1452997394-8554-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1452997394-8554-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20160118172522.GB12309@linutronix.de>
 <20160118184247.GQ3367@piout.net>
 <alpine.DEB.2.11.1601201158280.3575@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1601201158280.3575@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

On 20/01/2016 at 12:07:30 +0100, Thomas Gleixner wrote :
> Well freeing the irq from that context in RT only works because its called
> before SYSTEM_STATE=RUNNING. So no, this was wrong forever.
> 
> The issue we are dealing with is that the timer interrupt is shared with the
> uart. So the timer has IRQ_NO_THREAD set and the uart interrupt gets force
> threaded. So that results in a failure to request the interrupt for the
> UART. That's not RT specific, that already happens in mainline if you add
> 'threadirqs' to the command line.
> 
> So until the DT folks come to senses and we get that dummy demux chip done, I
> came up with the following - completely untested - solution.
> 
> The downside of this is, that the timer will be delayed until the uart thread
> returns, but with the replacement clockevent in place on RT that's a non
> issue. For mainline it's obviously better than what we have now.
> 

I've tested it and it seems to work properly on the few platform where I
can reproduce the issue. What is your plan regarding upstreaming? I
guess you can split and take the resulting patches through your tree.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
