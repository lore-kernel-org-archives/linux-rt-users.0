From: PRINGLE Chris <chris.pringle@miranda.com>
Subject: RE: Lookaside cache with high volume of objects hangs the kernel on
 destruction (deadlock)
Date: Fri, 6 Jul 2012 09:34:54 +0000
Message-ID: <E7D6489E57008E4088E37F78D30C62E60C4957@LB-OPS-EXCH01.miranda.com>
References: <E7D6489E57008E4088E37F78D30C62E60BAB7A@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60BC983@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60C0120@LB-OPS-EXCH01.miranda.com>
 <20120704131520.GH9200@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from stanmail.omnibus.co.uk ([194.201.223.253]:19879 "EHLO
	exch-lb.miranda.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752549Ab2GFJfP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jul 2012 05:35:15 -0400
In-Reply-To: <20120704131520.GH9200@uudg.org>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> Yes, I was able to reproduce the issue on 3.4.4-rt13. I ran a few tests under
> ftrace and got a bit more of information.
> 
> The problem seems to happen in kmem_cache_free(), at this piece of code:
> 
>         local_lock_irqsave(slab_lock, flags);
>         __cache_free(cachep, objp, __builtin_return_address(0));
>         unlock_slab_and_free_delayed(flags);
> 
> It seems to fail at the local_lock_irqsave() statement with:
> 
> 	[  149.328013] kernel BUG at kernel/rtmutex.c:725!
> 	[  149.328013] invalid opcode: 0000 [#1] PREEMPT SMP
> 
> And by the end I see:
> 
> 	[  149.420228] note: insmod[2801] exited with preempt_count 1 

Thanks for this. Any ideas where we might go from here? This used to work in 2.6.33 but got broken between 2.6.33 and 3.0; unfortunately there don't appear to be any RT patch releases between those two versions so it's hard to see what might have been broken.

It worries me a bit because this could potentially go wrong during runtime if the kernel ever reaps the lookaside cache for memory; this will then crash the entire system.

Cheers,
Chris
