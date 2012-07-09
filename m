From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: Lookaside cache with high volume of objects hangs the kernel on
 destruction (deadlock)
Date: Mon, 9 Jul 2012 12:11:37 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1207091211060.32033@ionos>
References: <E7D6489E57008E4088E37F78D30C62E60BAB7A@LB-OPS-EXCH01.miranda.com> <E7D6489E57008E4088E37F78D30C62E60BC983@LB-OPS-EXCH01.miranda.com> <E7D6489E57008E4088E37F78D30C62E60C0120@LB-OPS-EXCH01.miranda.com> <20120704131520.GH9200@uudg.org>
 <E7D6489E57008E4088E37F78D30C62E60C4957@LB-OPS-EXCH01.miranda.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: PRINGLE Chris <chris.pringle@miranda.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:49591 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab2GIKLl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2012 06:11:41 -0400
In-Reply-To: <E7D6489E57008E4088E37F78D30C62E60C4957@LB-OPS-EXCH01.miranda.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 6 Jul 2012, PRINGLE Chris wrote:

> > Yes, I was able to reproduce the issue on 3.4.4-rt13. I ran a few tests under
> > ftrace and got a bit more of information.
> > 
> > The problem seems to happen in kmem_cache_free(), at this piece of code:
> > 
> >         local_lock_irqsave(slab_lock, flags);
> >         __cache_free(cachep, objp, __builtin_return_address(0));
> >         unlock_slab_and_free_delayed(flags);
> > 
> > It seems to fail at the local_lock_irqsave() statement with:
> > 
> > 	[  149.328013] kernel BUG at kernel/rtmutex.c:725!
> > 	[  149.328013] invalid opcode: 0000 [#1] PREEMPT SMP
> > 
> > And by the end I see:
> > 
> > 	[  149.420228] note: insmod[2801] exited with preempt_count 1 
> 
> Thanks for this. Any ideas where we might go from here? This used to
> work in 2.6.33 but got broken between 2.6.33 and 3.0; unfortunately
> there don't appear to be any RT patch releases between those two
> versions so it's hard to see what might have been broken.
>
> It worries me a bit because this could potentially go wrong during
> runtime if the kernel ever reaps the lookaside cache for memory;
> this will then crash the entire system.

Found the root cause, working on a fix.

Thanks,

	tglx
