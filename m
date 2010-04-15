From: Martin Shepherd <mcs@astro.caltech.edu>
Subject: Re: Debugging a hard lockup with no symptoms
Date: Thu, 15 Apr 2010 09:08:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004150831030.22160@haggis.caltech.edu>
References: <Pine.LNX.4.64.1004132345050.14952@haggis.caltech.edu>
 <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from phobos.caltech.edu ([131.215.193.100]:40542 "EHLO
	phobos.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab0DOQIW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Apr 2010 12:08:22 -0400
In-Reply-To: <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Thu, 15 Apr 2010, Thomas Gleixner wrote:
> Can you try nmi_watchdog=1 ? That keeps the tickless mode alive.

It was nmi_watchdog=1 that turned off tickless. Perhaps you mean,
nmi_watchdog=2? I haven't tried that.

> Does the problem reproduce when you disable those boards ?

The real-time code that apparently causes the lockups is controlling
hardware continuously via those commercial boards. So unfortunately,
if I disable them, then I can't run the code that is causing the
problem. In particular, they provide the hardware interrupts that
drive the code, and servo feedback that determines what the code does
next.

> Do you have the source of the drivers ?

Yes, I wrote my own drivers for these boards. So this ought to be easy
to solve, if I knew what to look for in my code. Yesterday I found one
thing that might be a problem, and I hope to get a chance to test this
today. In one of my two interrupt threads, I was calling
wake_up_interruptible() before writing the PCI registers that clear
the interrupt on the board. When I wrote this, I assumed that the
interrupt handler would always finish before the scheduler came back
into play, but I am wondering whether this is still true with threaded
interrupts? Note that the user-land thread that is woken by the
wake-up runs at the same real-time priority as the interrupt
thread (another mistake?).

> Did you ever run with lockdep enabled
> (CONFIG_PROVE_LOCKING=y) ?

No. Sorry, I hadn't noticed that option. I will turn it on before
running the code again.

Thank you for your help,

Martin
