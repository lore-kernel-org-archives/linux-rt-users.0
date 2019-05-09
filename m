Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB30BC04AB2
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 18:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7AF2177B
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 18:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfEISI3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 14:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfEISI3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 14:08:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1A82084E;
        Thu,  9 May 2019 18:08:27 +0000 (UTC)
Date:   Thu, 9 May 2019 14:08:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     minyard@acm.org
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190509140825.5bac9591@gandalf.local.home>
In-Reply-To: <20190509180211.14893-1-minyard@acm.org>
References: <20190509180211.14893-1-minyard@acm.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu,  9 May 2019 13:02:11 -0500
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
> Fix it by adding/removing the thread to/from the wait queue inside
> the do loop.
> 
> Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
> This looks like a fairly serious bug, I guess, but I've never seen a
> report on it before.
> 
> I found it because I have an out-of-tree feature (hopefully in tree some
> day) that takes a core dump of a running process without killing it.  It
> makes extensive use of completions, and the test code is fairly brutal.
> It didn't lock up on stock 4.19, but failed with the RT patches applied.
> 
> The funny thing is, I've never seen this test code fail before on earlier
> releases, but it locks up pretty reliably on 4.19-rt.  It looks like this
> bug goes back to at least the 4.4-rt kernel.  But we haven't received any
> customer reports of failures.  I'm guessing that almost all completion
> users have a single waiter, so you would never see this.
> 
> The feature and test are in a public tree if someone wants to try to
> reproduce this.  But hopefully this is pretty obvious with the explaination.
> 
> Also, you could put the DECLARE_SWAITQUEUE() outside the loop, I think,
> but maybe it's cleaner or safer to declare it in the loop?  If someone
> cares I can test it that way.
> 
> -corey
> 
>  kernel/sched/completion.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> index 755a58084978..4f9b4cc0c95a 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -70,20 +70,20 @@ do_wait_for_common(struct completion *x,
>  		   long (*action)(long), long timeout, int state)
>  {
>  	if (!x->done) {
> -		DECLARE_SWAITQUEUE(wait);
> -
> -		__prepare_to_swait(&x->wait, &wait);
>  		do {
> +			DECLARE_SWAITQUEUE(wait);
> +
>  			if (signal_pending_state(state, current)) {
>  				timeout = -ERESTARTSYS;
>  				break;
>  			}
> +			__prepare_to_swait(&x->wait, &wait);

Sebastian mentioned that moving the __prepare_to_swait() was the only
change needed. Please do that.

Thanks!

-- Steve

>  			__set_current_state(state);
>  			raw_spin_unlock_irq(&x->wait.lock);
>  			timeout = action(timeout);
>  			raw_spin_lock_irq(&x->wait.lock);
> +			__finish_swait(&x->wait, &wait);
>  		} while (!x->done && timeout);
> -		__finish_swait(&x->wait, &wait);
>  		if (!x->done)
>  			return timeout;
>  	}

