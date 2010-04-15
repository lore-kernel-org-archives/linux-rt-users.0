From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Debugging a hard lockup with no symptoms
Date: Thu, 15 Apr 2010 14:59:12 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004151455230.3625@localhost.localdomain>
References: <Pine.LNX.4.64.1004132345050.14952@haggis.caltech.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Martin Shepherd <mcs@astro.caltech.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:36620 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297Ab0DOM7X (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Apr 2010 08:59:23 -0400
In-Reply-To: <Pine.LNX.4.64.1004132345050.14952@haggis.caltech.edu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 14 Apr 2010, Martin Shepherd wrote:

> I have been experiencing hard lockups running a real-time application
> under preempt-rt. Having originally had this problem while running
> under 2.6.29.4-rt16, today I upgraded to 2.6.31.12-rt21, but the
> problem persisted. Under both kernels, the computer simply freezes,
> usually after a few hours of otherwise flawless operation. Nothing
> appears on the serial console or in the system log when the system
> freezes. Unfortunately, turning on the NMI watchdog stops the freezes
> from occurring at all, such that I can't force an Oops that way.
> 
> I have tried running memtest86 on the RAM, without detecting any
> memory errors, and I have verified that the same problem occurs on two
> different (but essentially identical) computers.
> 
> I wonder whether there might be a clue in the fact that turning on the
> NMI watchdog stops the freezes from occuring. Turning on the watchdog
> unfortunately turns off tickless mode, which I need. According to the
> boot-time messages, tickless is turned off because the local APIC is
> non-functional (presumably because the NMI watchdog is using it). What
> kind of bugs would be more likely to be seen when running under
> tickless?

Can you try nmi_watchdog=1 ? That keeps the tickless mode alive.

> Could anybody give me any ideas on how to further debug this problem?
> I have been trying to figure this out for weeks, but I haven't found
> any clues.
> 
> In case it is important, the CPU is a 1.8GHz Intel Celeron, on a
> Foxconn motherboard with an Intel G31 chipset, and Intel GMA 3100
> onboard graphics. I am running the kernel (downloaded from kernel.org)
> under Unbuntu 9.10. The computer also hosts two commercial digital I/O
> boards, both generating interrupts, and one commercial analog I/O
> board.

Does the problem reproduce when you disable those boards ? Do you have
the source of the drivers ? Did you ever run with lockdep enabled
(CONFIG_PROVE_LOCKING=y) ?

Thanks,

	tglx
