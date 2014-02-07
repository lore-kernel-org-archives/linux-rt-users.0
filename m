From: Allen Pais <allen.pais@oracle.com>
Subject: Re: Cyclictest results on Sparc64 with PREEMPT_RT
Date: Fri, 07 Feb 2014 19:00:55 +0530
Message-ID: <52F4E00F.9010009@oracle.com>
References: <52E616DB.2040202@oracle.com> <20140207123529.GA2382@linutronix.de> <52F4D474.6080107@oracle.com> <52F4DED2.3010800@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, davem@davemloft.net
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50939 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906AbaBGNbU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 08:31:20 -0500
In-Reply-To: <52F4DED2.3010800@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Sebastian,
> 
> This is a dead lock. Whatever lock you go after, you are already
> holding it in this context / hackbench. I don't know how you got from
> perfctr_irq() to do_exit() but you shouldn't do this in hardirq
> context.
> 
> But calling do_exit() is probably error recovery since it would kill
> hackbench and I assume it wasn't done yet.
> I see also tl0_irq15() in your stack trace. This is that evil NMI that
> checks if the system is stalling. I think that you stuck in
> flush_tsb_user() on that raw_lock and somebody is not letting it go and
> so you spin for ever. Maybe full lockdep shows you some informations
> about wrong context locking etc.
> 
Yes, there's someone's holding the lock and not releasing it in
flush_tsb_user(). I'll check with lockdep.

Thanks,
Allen

