From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Issues with 4.4-rt2 with arm64
Date: Wed, 20 Jan 2016 16:00:08 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601201553500.3575@nanos>
References: <BY1PR0701MB15949D1B10F90EE124B51176E1C20@BY1PR0701MB1594.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59955 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbcATPBJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 10:01:09 -0500
In-Reply-To: <BY1PR0701MB15949D1B10F90EE124B51176E1C20@BY1PR0701MB1594.namprd07.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 20 Jan 2016, Jaggi, Manish wrote:

> b) With 48 cores boot hangs, sata doesnt mount and network VFs have
>    issues. Probably the threadded irq are not scheduled
> [   37.354634] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 7 from VF3
... 
> c) By disabling NO_HZ_ IDLE and enabling PERIODIC no issues are observed in
> kernel boot. There are random issues like mount of a partition throws errors
> (run fsck)

So is it a NOHZ idle issue or a HIGHRES/PERIODIC issue?

> d) Enabling sleep while atomic debug config, got the call traces

> [   19.506039] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:930

> [   19.506130] [<ffff8000009c72a8>] rt_spin_lock+0x30/0x68
> [   19.506133] [<ffff80000009a7e4>] __aarch64_insn_write+0x34/0x108

I have no idea how you manage this:

__aarch64_insn_write()
{
	raw_spin_lock_irqsave(&patch_lock, flags);

That is a raw lock. So I have no idea how that might end up in the sleeping
spinlocks.

Thanks,

	tglx
