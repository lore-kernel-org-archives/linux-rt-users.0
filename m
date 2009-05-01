From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: compile error for mips with 2.6.29.2-rt10
Date: Fri, 1 May 2009 23:14:29 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0905012310210.3375@localhost.localdomain>
References: <49FB2619.7070608@walsimou.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Gaye Abdoulaye Walsimou <walsimou@walsimou.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41225 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255AbZEAVOe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 May 2009 17:14:34 -0400
In-Reply-To: <49FB2619.7070608@walsimou.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 1 May 2009, Gaye Abdoulaye Walsimou wrote:

> Hello list,
> I use 2.6.29.2-rt10 patch on linux-2.6.29.2 (from linux-mips.org and for
> bcm47xx MCU) and I had following compilation error:
> 
> kernel/sched.c: In function 'finish_task_switch':
> kernel/sched.c:2902: error: implicit declaration of function
> '_finish_arch_switch'
> make[1]: *** [kernel/sched.o] Error 1
> make: *** [kernel] Error 2
> 
> When I change "_finish_arch_switch" to "finish_arch_switch" in
> kernel/sched.c, no compilation error, but I didn't try resulting vmlinux.
> 
> Do I miss something?

Yes. 

http://lkml.org/lkml/2009/2/11/405

> The patch is working on x86 (32 and 64bit) but we have not yet
> updated ARM, PPC and MIPS (work in progress).

This is still true for MIPS , but we are working on it and hopefully
one of the next preempt-rt releases will have MIPS support again. Stay
tuned.

Thanks,

	tglx
