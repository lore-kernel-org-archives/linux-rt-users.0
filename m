From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: [PATCH] futex: futex_wait_requeue_pi commentary corrections
Date: Fri, 31 Jul 2009 16:18:32 -0700
Message-ID: <4A737BC8.7080205@us.ibm.com>
References: <4A737261.20601@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>
To: "lkml, " <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51704 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbZGaXSe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Jul 2009 19:18:34 -0400
In-Reply-To: <4A737261.20601@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Darren Hart wrote:
> futex: futex_wait_requeue_pi commentary corrections
> 
> From: Darren Hart <dvhltc@us.ibm.com>
> 
> The state machine described in the comments wasn't updated with a follow-on
> fix.  Address that and cleanup the corresponding commentary in the 
> function.
> 
> Signed-off-by: Darren Hart <dvhltc@us.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@elte.hu>
> ---
> 
> kernel/futex.c |   23 ++++++++++-------------
> 1 files changed, 10 insertions(+), 13 deletions(-)
> 
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index 0672ff8..18752ae 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2102,11 +2102,11 @@ int handle_early_requeue_pi_wakeup(struct 
> futex_hash_bucket *hb,
>  * We call schedule in futex_wait_queue_me() when we enqueue and return 
> there
>  * via the following:
>  * 1) wakeup on uaddr2 after an atomic lock acquisition by futex_requeue()
> - * 2) wakeup on uaddr2 after a requeue and subsequent unlock
> - * 3) signal (before or after requeue)
> - * 4) timeout (before or after requeue)
> + * 2) wakeup on uaddr2 after a requeue
> + * 3) signal
> + * 4) timeout
>  *
> - * If 3, we setup a restart_block with futex_wait_requeue_pi() as the 
> function.
> + * If 3, we setup a restart_block and return -ERESTARTNOINTR.

Gah, not we don't.  We removed the restart block altogether.  Sorry.  V2 
en route.

Nacked-by: Darren Hart <dvhltc@us.ibm.com>

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
