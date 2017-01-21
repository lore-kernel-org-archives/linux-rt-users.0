From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/mm/cpa: avoid wbinvd() for PREEMPT_RT_FULL
Date: Sat, 21 Jan 2017 15:19:15 +0100
Message-ID: <20170121141915.GT6485@twins.programming.kicks-ass.net>
References: <87o9z1ic9a.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
To: John Ogness <john.ogness@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39968 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAUOTV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Jan 2017 09:19:21 -0500
Content-Disposition: inline
In-Reply-To: <87o9z1ic9a.fsf@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Patches really should go to lkml, if you want to bug a user list with
them I won't stop you, but please don't hide actual useful content.

On Fri, Jan 20, 2017 at 11:42:57PM +0100, John Ogness wrote:
> Although wbinvd() is faster than flushing many individual pages, it
> blocks the memory bus for "long" periods of time (>100us), thus
> directly causing unusually large latencies for PREEMPT_RT_FULL. For
> 1024 pages, flushing those pages individually can take up to 2200us,
> but the task remains fully preemptible during that time.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/x86/mm/pageattr.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
> index e3353c9..a182477 100644
> --- a/arch/x86/mm/pageattr.c
> +++ b/arch/x86/mm/pageattr.c
> @@ -214,7 +214,12 @@ static void cpa_flush_array(unsigned long *start, int numpages, int cache,
>  			    int in_flags, struct page **pages)
>  {
>  	unsigned int i, level;
> +#ifdef CONFIG_PREEMPT_RT_FULL
> +	/* wbinvd() causes ugly latencies, avoid it */
> +	unsigned long do_wbinvd = 0;

Arguably we should do the same for CONFIG_PREEMPT and possibly even
always, esp. when considering CAT.
