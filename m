From: Nishanth Menon <nm@ti.com>
Subject: Re: Common clock framework API vs RT patchset
Date: Tue, 4 Aug 2015 10:23:31 -0500
Message-ID: <55C0D8F3.3030105@ti.com>
References: <55C0A96F.80307@ti.com> <alpine.DEB.2.11.1508041405290.3983@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, Felipe Balbi <balbi@ti.com>,
	Sekhar Nori <nsekhar@ti.com>, <linux-clk@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>,
	Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51700 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566AbbHDPXy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2015 11:23:54 -0400
In-Reply-To: <alpine.DEB.2.11.1508041405290.3983@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/04/2015 07:06 AM, Thomas Gleixner wrote:
> On Tue, 4 Aug 2015, Grygorii Strashko wrote:
> 
>> Hi All,
>>
>> I'd very appreciated if someone can clarify one point for me.
>>
>> Is allowed/expected/prohibited to use CLK API like clk_enable/disable
>> in atomic context now on RT-Kernel (HW IRQ or under RAW spinlocks)?
> 
> It's not possible, if the spinlock in the clock framework is not a raw
> spinlock.
>  
>> How safe is it to allow CLK API to be preemptive?
> 
> The functions are protected by the locks. So it's not an issue at all.

interesting topic, looping in linux-clk. original thread in [1].

clk apis are protected by spinlocks which in turn should make the clock
apis pre-emptible in RT kernel build.

I think Grygorii's question is "what happens(is it safe) when clock APIs
are pre-empted"? I think it is a bit dependent on the hardware behavior
I think..

Two angles to this:

i) is there an upper time bound in the programming sequence: if any step
x to step y in the sequence takes more than N time, then we can have  a
failure - but then, that is a broken hardware in itself.. Linux (non-RT)
cannot guarantee a strict upper bound either.

ii) if by preempting the operation itself CPU cannot guarantee time
accuracy for scheduling. This can be an issue. more below:

Consider clk_enable/disable/set_parent/setfreq operations. none of these
operations are "atomic" from hardware point of view. instead, they are a
set of steps which culminates to moving from state A to state B of the
clock tree configuration.

specific example could be as follows: changing clock parent in the clock
tree results in kernel tick timer configuration to be in an intermediate
state before going to a final "relocked" state which is expected at the
end of clock setparent call, could be involved in a few steps:
step a) unlock pll (put in bypass)
step b) change parent
step c) relock pll with new parent frequency

if interrupted between (a), (c), we could be in "bypass" frequency or
"new parent" frequency... final frequency is guarenteed only when step
(c) is completed.

In the above example if the clock generated is fundamental to kernel
scheduler accuracy, well, we do have a problem..


I am not sure any of these cases can happen could happen in at least the
hardware I am aware of... not sure if other SoC vendors might have
interesting scenarios..

[1] http://marc.info/?t=143868984600001&r=1&w=2
-- 
Regards,
Nishanth Menon
