From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: -rt kernel hitting yield()s in I2C non-default code paths
 (2.6.24)
Date: Mon, 2 Nov 2009 15:58:47 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0911021554310.12138@localhost.localdomain>
References: <c384c5ea0910310239l549a13c5h7289ffc53ff0a648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39163 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754852AbZKBO6r (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 2 Nov 2009 09:58:47 -0500
In-Reply-To: <c384c5ea0910310239l549a13c5h7289ffc53ff0a648@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 31 Oct 2009, Leon Woestenberg wrote:
> Hello,
> 
> 
> yesterday while debugging embedded systems I noticed the non-happy
> paths in the I2C code hitting yield() code, this resulted in
> a BUG: RT-Task yielding. This was with 2.6.24 (yes I know).
> 
> A real-time task (prio 99, low real-time priority) on the generic
> workqueue was executing I2C functions, such as try_address() and
> hitting the yield().
> 
> http://lxr.linux.no/#linux+v2.6.31/drivers/i2c/algos/i2c-algo-bit.c#L319
> 
> Further grepping shows yield()s sprinkled throughout device driver
> code, especially in the non-default execution paths.
> 
> What's the -rt devs opinion on this one?

yield() in kernel code is either a bug or useless nonsense.
 
> For most of the yield()s I really could not think why they are there...

Exactly. Most likely some blindly copied old code, which needs to be
fixed. Going through it later today.

Thanks for pointing it out.

       tglx
