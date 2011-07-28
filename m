From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: rt5, sleeping function called from invalid context
Date: Thu, 28 Jul 2011 21:45:29 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1107282144510.31246@ionos>
References: <4E31B6F3.80602@am.sony.com> <4E31BA74.3070102@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48318 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1G1Tpc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 Jul 2011 15:45:32 -0400
In-Reply-To: <4E31BA74.3070102@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 28 Jul 2011, Frank Rowand wrote:

> On 07/28/11 12:22, Frank Rowand wrote:
> > Thomas,
> > 
> > Here is one of my current BUGs, from rt5 (same panda board, same config):
> 
> And some from rt3 (I don't know if they are still valid, just documenting
> them because they reproduce reliably on rt3):
> 
> ---------------------------------------------------------------------------
> 
> Running bash on the console:
> 
> BUG: sleeping function called from invalid context at kernel/rtmutex.c:645
> in_atomic(): 1, irqs_disabled(): 128, pid: 1, name: swapper
> 3 locks held by swapper/1:
>  #0:  (&sig->cred_guard_mutex){+.+.+.}, at: [<c015270c>] prepare_bprm_creds+0x20/0x58
>  #1:  (&p->alloc_lock){+.+...}, at: [<c0152afc>] flush_old_exec+0x2dc/0x5d4
>  #2:  (cpu_asid_lock){......}, at: [<c006d158>] __new_context+0x14/0xbc
> irq event stamp: 475085
> hardirqs last  enabled at (475084): [<c0484800>] _raw_spin_unlock_irqrestore+0x60/0x74
> hardirqs last disabled at (475085): [<c0152b04>] flush_old_exec+0x2e4/0x5d4
> softirqs last  enabled at (0): [<c009d9cc>] copy_process+0x364/0xf84
> softirqs last disabled at (0): [<  (null)>]   (null)
> [<c00681b8>] (unwind_backtrace+0x0/0xf0) from [<c0483ce0>] (rt_spin_lock+0x24/0x5c)
> [<c0483ce0>] (rt_spin_lock+0x24/0x5c) from [<c006d104>] (set_mm_context+0x1c/0x5c)
> [<c006d104>] (set_mm_context+0x1c/0x5c) from [<c006d198>] (__new_context+0x54/0xbc)

Fixed in rt4/5 already.
