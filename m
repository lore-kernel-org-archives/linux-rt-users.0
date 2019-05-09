Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A2BC04AB3
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 19:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9040B2177E
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 19:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfEITvl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 15:51:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbfEITvl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 15:51:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FC4320989;
        Thu,  9 May 2019 19:51:39 +0000 (UTC)
Date:   Thu, 9 May 2019 15:51:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     minyard@acm.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190509155137.7f84caaa@gandalf.local.home>
In-Reply-To: <20190509193320.21105-1-minyard@acm.org>
References: <20190509193320.21105-1-minyard@acm.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu,  9 May 2019 14:33:20 -0500
minyard@acm.org wrote:

> From: Corey Minyard <cminyard@mvista.com>
> 
> The function call do_wait_for_common() has a race condition that
> can result in lockups waiting for completions.  Adding the thread
> to (and removing the thread from) the wait queue for the completion
> is done outside the do loop in that function.  However, if the thread
> is woken up, the swake_up_locked() function will delete the entry
> from the wait queue.  If that happens and another thread sneaks
> in and decrements the done count in the completion to zero, the
> loop will go around again, but the thread will no longer be in the
> wait queue, so there is no way to wake it up.
> 
> Visually, here's a diagram from Sebastian Andrzej Siewior:
>   T0                    T1                       T2
>   wait_for_completion()
>    do_wait_for_common()
>     __prepare_to_swait()
>      schedule()
>                         complete()
>                          x->done++ (0 -> 1)
>                          raw_spin_lock_irqsave()
>                          swake_up_locked()       wait_for_completion()
>                           wake_up_process(T0)
>                           list_del_init()
>                          raw_spin_unlock_irqrestore()
>                                                   raw_spin_lock_irq(&x->wait.lock)
>   raw_spin_lock_irq(&x->wait.lock)                x->done != UINT_MAX, 1 -> 0
>                                                   raw_spin_unlock_irq(&x->wait.lock)
>                                                   return 1
>    while (!x->done && timeout),
>    continue loop, not enqueued
>    on &x->wait
> 
> Basically, the problem is that the original wait queues used in
> completions did not remove the item from the queue in the wakeup
> function, but swake_up_locked() does.
> 
> Fix it by adding the thread to the wait queue inside the do loop.
> The design of swait detects if it is already in the list and doesn't
> do the list add again.
> 
> Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Thanks!

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> ---
> Changes since v1:
> * Only move __prepare_to_swait() into the loop.  __prepare_to_swait()
>   handles if called when already in the list, and of course
>   __finish_swait() handles if the item is not queued on the
>   list.
> 
>  kernel/sched/completion.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index 755a58084978..49c14137988e 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -72,12 +72,12 @@ do_wait_for_common(struct completion *x,
>  	if (!x->done) {
>  		DECLARE_SWAITQUEUE(wait);
>  
> -		__prepare_to_swait(&x->wait, &wait);
>  		do {
>  			if (signal_pending_state(state, current)) {
>  				timeout = -ERESTARTSYS;
>  				break;
>  			}
> +			__prepare_to_swait(&x->wait, &wait);
>  			__set_current_state(state);
>  			raw_spin_unlock_irq(&x->wait.lock);
>  			timeout = action(timeout);

