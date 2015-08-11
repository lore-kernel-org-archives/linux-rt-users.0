From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Tue, 11 Aug 2015 22:23:46 +0300
Message-ID: <55CA4BC2.4020505@ti.com>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos> <55C0D8F3.3030105@ti.com> <20150804153641.GR7557@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, <linux-clk@vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nishanth Menon <nm@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbbHKTYH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Aug 2015 15:24:07 -0400
In-Reply-To: <20150804153641.GR7557@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

On 08/04/2015 06:36 PM, Russell King - ARM Linux wrote:
> On Tue, Aug 04, 2015 at 10:23:31AM -0500, Nishanth Menon wrote:
>> Consider clk_enable/disable/set_parent/setfreq operations. none of these
>> operations are "atomic" from hardware point of view. instead, they are a
>> set of steps which culminates to moving from state A to state B of the
>> clock tree configuration.
> 
> There's a world of difference between clk_enable()/clk_disable() and
> the rest of the clk API.
> 
> clk_enable()/clk_disable() _should_ be callable from any context, since
> you may need to enable or disable a clock from any context.  The remainder
> of the clk API is callable only from contexts where sleeping is permissible.
> 
> The reason we have this split is because clk_enable()/clk_disable() have
> historically been used in interrupt handlers, and they're specifically
> not supposed to impose big delays.
> 
> Things like waiting for a PLL to re-lock is time-consuming, so it's not
> something I'd expect to see behind a clk_enable() implementation (the
> fact you can't sleep in there is a big hint.)  Such waits should be in
> the clk_prepare() stage instead.
> 
> Now, as for clk_enable() being interrupted - if clk_enable() is interrupted
> and another clk_enable() comes along for the same clock, that second
> clk_enable() should not return until the clock has actually been enabled,
> and it's up to the implementation to decode how to achieve that.  If that
> means a RT implementation using a raw spinlock, then that's one option
> (which basically would have the side effect of blocking until the preempted
> clk_enable() finishes its business.)  Alternatively, if we can preempt
> inside clk_enable(), then the clk_enable() implementation should be written
> to cope with that (eg, by the second clk_enable() fiddling with the hardware,
> and the first thread noticing that it has nothing to do.)
> 

Thanks a lot for your comments and explanations.

Now lock object in CCF is not a raw spinlock, so, seems, I have to update 
code and try to move clk_enable()/clk_disable() out of atomic context.

-- 
regards,
-grygorii
