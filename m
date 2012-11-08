From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: scheduler clock for MXS
Date: Thu, 8 Nov 2012 22:11:13 +0000
Message-ID: <20121108221113.GB28327@n2100.arm.linux.org.uk>
References: <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <5098CB9F.9030401@meduna.org> <20121106134630.GD27643@S2100-06.ap.freescale.net> <20121106202038.GB32398@n2100.arm.linux.org.uk> <50998F94.8000908@meduna.org> <20121106224624.GR28327@n2100.arm.linux.org.uk> <509C23DF.1020106@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39249 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184Ab2KHWLn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Nov 2012 17:11:43 -0500
Content-Disposition: inline
In-Reply-To: <509C23DF.1020106@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Nov 08, 2012 at 10:27:59PM +0100, Stanislav Meduna wrote:
> What is actually the reason of round_jiffies there? The
> http://kernel.org/doc/htmldocs/device-drivers/API-round-jiffies.html
> mentions saving power, is it the only one?
> 
> I'd probably just leave the round_jiffies out at least for
> wrap_ticks < around 16*HZ. Above that the error by possibly
> rounding up can be ignored.
> 
> There is also a round_jiffies_up - unless I am too tired, as long as
> we tick no faster than once per second, subtracting (HZ-1) and rounding
> up should be the same as rounding down.
> 
> But: is the round_jiffies* safe at all for sub-second precision
> at jiffies around 0xffffffff? From quick looking it does a modulo,
> 0xffffffff % say 250 is 45, the next jiffy is at 0...

Well, the idea is to avoid having yet another random thing causing yet
another wakeup from the idle modes.  If you've ever watched a LED
indicating when the kernel is in the idle loop and when it isn't,
you'll know exactly what I'm talking about; your normal Linux system
sits there constantly being kicked out of idle several times a second
while... idle to service various kernel tasks.

We really don't want to add to that; if we get enough of these events
happening at random intervals, we will end up with things like cpu idle
being completely thwarted by stuff like this.

As I have said, what we want is a version of round_jiffies() which
rounds down to something, not up.
