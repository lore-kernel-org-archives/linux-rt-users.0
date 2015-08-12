From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Wed, 12 Aug 2015 13:05:58 +0300
Message-ID: <55CB1A86.2050802@ti.com>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos> <55C0D8F3.3030105@ti.com> <20150804153641.GR7557@n2100.arm.linux.org.uk> <55CA4BC2.4020505@ti.com> <20150811192514.GB7557@n2100.arm.linux.org.uk> <20150811220609.31346.15943@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Nishanth Menon <nm@ti.com>, Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, <linux-clk@vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49321 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853AbbHLKGX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Aug 2015 06:06:23 -0400
In-Reply-To: <20150811220609.31346.15943@quantum>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/12/2015 01:06 AM, Michael Turquette wrote:
> Quoting Russell King - ARM Linux (2015-08-11 12:25:15)
>> On Tue, Aug 11, 2015 at 10:23:46PM +0300, Grygorii Strashko wrote:
>>> Hi All,
>>>
>>> On 08/04/2015 06:36 PM, Russell King - ARM Linux wrote:
>>>> On Tue, Aug 04, 2015 at 10:23:31AM -0500, Nishanth Menon wrote:
>>>>> Consider clk_enable/disable/set_parent/setfreq operations. none of these
>>>>> operations are "atomic" from hardware point of view. instead, they are a
>>>>> set of steps which culminates to moving from state A to state B of the
>>>>> clock tree configuration.
>>>>
>>>> There's a world of difference between clk_enable()/clk_disable() and
>>>> the rest of the clk API.
>>>>
>>>> clk_enable()/clk_disable() _should_ be callable from any context, since
>>>> you may need to enable or disable a clock from any context.  The remainder
>>>> of the clk API is callable only from contexts where sleeping is permissible.
>>>>
>>>> The reason we have this split is because clk_enable()/clk_disable() have
>>>> historically been used in interrupt handlers, and they're specifically
>>>> not supposed to impose big delays.
>>>>
>>>> Things like waiting for a PLL to re-lock is time-consuming, so it's not
>>>> something I'd expect to see behind a clk_enable() implementation (the
>>>> fact you can't sleep in there is a big hint.)  Such waits should be in
>>>> the clk_prepare() stage instead.
>>>>
>>>> Now, as for clk_enable() being interrupted - if clk_enable() is interrupted
>>>> and another clk_enable() comes along for the same clock, that second
>>>> clk_enable() should not return until the clock has actually been enabled,
>>>> and it's up to the implementation to decode how to achieve that.  If that
>>>> means a RT implementation using a raw spinlock, then that's one option
>>>> (which basically would have the side effect of blocking until the preempted
>>>> clk_enable() finishes its business.)  Alternatively, if we can preempt
>>>> inside clk_enable(), then the clk_enable() implementation should be written
>>>> to cope with that (eg, by the second clk_enable() fiddling with the hardware,
>>>> and the first thread noticing that it has nothing to do.)
>>>>
>>>
>>> Thanks a lot for your comments and explanations.
>>>
>>> Now lock object in CCF is not a raw spinlock, so, seems, I have to update
>>> code and try to move clk_enable()/clk_disable() out of atomic context.
>>
>> clk_enable/clk_disable _should_ be usable from atomic contexts.

Thanks Russell - above is not true on -RT.

> 
> Grygorii,
> 
> Note that the common clk implementation allows for the same thread to
> re-enter the clock framework even while the lock is held. For instance
> if calling clk_enable(foo) resulted in a call to clk_enable(bar), this
> would not deadlock. However this re-entrant behavior is ONLY for the
> same thread that is already holding the lock.
> 
> I doubt that the above bit of trivial will solve your problem and it
> probably does not add any new complexity for you either, but it seems
> relevant enough for me to add here.

Thanks Mike.
I'm aware about above feature :) And I understand that CCF is implemented in
thread-safe manner. My problem is that the same part of code
works on vanilla kernel, but might not work on -RT due to locking issues.

Example:
	raw_spin_lock_irqsave(&bank->lock, flags);
	clk_enable(foo);
	  + clk_enable_lock
	   + spin_lock_irqsave (BUG on -RT)
 	<access hw>
	raw_spin_unlock_irqrestore(&bank->lock, flags);
- or - 
HW irq handler:
	clk_enable(bar);

in both cases it will produce
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:917

This is first question I've asked.

The second one related to the fact that clk_enable/disable API can be
preempted on -RT now in the middle of HW accessing sequence -
from comments in this thread I understood that none know about or can
imaging possible issues related to above behavior. 
So, It's ok for CCF to be preemptive.


-- 
regards,
-grygorii
