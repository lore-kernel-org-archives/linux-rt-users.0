From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RT] rtmutex: fix deadlock in spin_trylock
Date: Wed, 6 Nov 2013 18:39:37 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311061832020.23353@ionos.tec.linutronix.de>
References: <641D1EBAB8EAD046954CD69996C8FE00164297@USCHMBX003.nsn-intra.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Cowell, Matt (NSN - US/Arlington Heights)" <matt.cowell@nsn.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46658 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3KFRjk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 12:39:40 -0500
In-Reply-To: <641D1EBAB8EAD046954CD69996C8FE00164297@USCHMBX003.nsn-intra.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 30 Oct 2013, Cowell, Matt (NSN - US/Arlington Heights) wrote:

> Repost to linux-rt-users list, as there has been no response on the linux-kernel list and it missed several rt patch releases.  Originally seen on 3.10.10-rt7.
> 
> 
> There is a deadlock condition with RT spin_locks that may use trylock in
> hardirq context.  The main user of this is get_next_timer_interrupt, which
> will deadlock if an IRQ preempts a timer wheel modification.

Errm. No. 

> Detected by spinlock lockup debug:
>    BUG: spinlock lockup suspected on CPU#1, ncp_nca_0_grp_5/133
>     lock: 0xee02a000, .magic: dead4ead, .owner: <none>/-1, .owner_cpu: -1
>    CPU: 1 PID: 133 Comm: ncp_nca_0_grp_5 Tainted: G           O 3.10.10-rt7 #53

The cpu is in thread context and therefor not idle. 

void tick_nohz_irq_exit(void)
{
        if (!ts->inidle)
                return;
	....
}

So you are papering over the real issue:

   Why is ts->inidle true, if the CPU is not in idle?

Thanks,

	tglx
