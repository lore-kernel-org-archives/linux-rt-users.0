From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: CPU hotplug and IRQ affinity with 2.6.24-rt1
Date: Mon, 04 Feb 2008 20:21:36 -0800
Message-ID: <47A7E450.50509@qualcomm.com>
References: <47A7A131.8040800@qualcomm.com> <20080205025144.GA31774@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@dwalker1.mvista.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755228AbYBEEV7@vger.kernel.org>
In-Reply-To: <20080205025144.GA31774@dwalker1.mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



Daniel Walker wrote:
> On Mon, Feb 04, 2008 at 03:35:13PM -0800, Max Krasnyanskiy wrote:
>> This is just an FYI. As part of the "Isolated CPU extensions" thread Daniel suggest for me
>> to check out latest RT kernels. So I did or at least tried to and immediately spotted a couple
>> of issues.
>>
>> The machine I'm running it on is:
>> 	HP xw9300, Dual Opteron, NUMA
>>
>> It looks like with -rt kernel IRQ affinity masks are ignored on that 
>> system. ie I write 1 to lets say /proc/irq/23/smp_affinity but the 
>> interrupts keep coming to CPU1. Vanilla 2.6.24 does not have that issue.
> 
> I tried this, and it works according to /proc/interrupts .. Are you
> looking at the interrupt threads affinity ?
Nope. I'm looking at the /proc/interrupts. ie The interrupt count keeps incrementing for cpu1 even
though affinity mask is set to 1.

IRQ thread affinity was btw set to 3 which is probably wrong.
To clarify, by default after reboot:
	- IRQ affinity set 3, IRQ thread affinity set to 3
	- User writes 1 into /proc/irq/N/smp_affinity
	- IRQ affinity is now set to 1, IRQ thread affinity is still set to 3

It'd still work I guess but does not seem right. Ideally IRQ thread affinity should have change as well.
We could of course just have some user-space tool that adjusts both.

Looks like Greg already replied to the cpu hotplug issue. For me it did not oops. Just got stuck probably
because it could not move an IRQ due to broken IRQ affinity logic.

Max
