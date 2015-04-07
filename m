From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/2] rtmutex Real-Time Linux: Fixing kernel BUG at
 kernel/locking/rtmutex.c:997!
Date: Tue, 7 Apr 2015 14:07:30 +0200
Message-ID: <20150407120730.GQ24151@twins.programming.kicks-ass.net>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>
 <1428369962-74723-1-git-send-email-tmac@hp.com>
 <1428369962-74723-2-git-send-email-tmac@hp.com>
 <alpine.DEB.2.11.1504071255410.3845@nanos>
 <1428407236.3152.81.camel@gmail.com>
 <20150407120403.GN21418@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Thavatchai Makphaibulchoke <tmac@hp.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, mingo@redhat.com,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43258 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbbDGMHn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2015 08:07:43 -0400
Content-Disposition: inline
In-Reply-To: <20150407120403.GN21418@twins.programming.kicks-ass.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Apr 07, 2015 at 02:04:03PM +0200, Peter Zijlstra wrote:
> +out:
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	rt_spin_unlock_after_trylock_in_irq(&base->lock);
> +#endif
> +	/* The ; ensures that gcc won't complain in the !RT case */
> +	;
>  }

Fwiw, I typically use a 'return' in that case. But yes, gcc is a bit of
a whiny arse when it comes to labels to the end of the block.
