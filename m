Return-Path: <SRS0=dFCZ=TN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D08C04AAA
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 May 2019 12:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944B620879
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 May 2019 12:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbfEMMNH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 May 2019 08:13:07 -0400
Received: from mail.monom.org ([188.138.9.77]:37206 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfEMMNG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 May 2019 08:13:06 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A302750065D;
        Mon, 13 May 2019 14:13:03 +0200 (CEST)
Received: from [127.0.0.1] (mail.monom.org [188.138.9.77])
        by mail.monom.org (Postfix) with ESMTPSA id 42DF75003CD;
        Mon, 13 May 2019 14:13:03 +0200 (CEST)
Subject: Re: [PATCH] Fix a lockup in wait_for_completion() and friends
To:     minyard@acm.org, linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Corey Minyard <cminyard@mvista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20190508202759.13842-1-minyard@acm.org>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <e30aebd4-2d7e-f892-b31a-66ff2c7e474d@monom.org>
Date:   Mon, 13 May 2019 14:13:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508202759.13842-1-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Corey,

On 08.05.19 22:27, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> The function call do_wait_for_common() has a race condition that
> can result in lockups waiting for completions.  Adding the thread
> to (and removing the thread from) the wait queue for the completion
> is done outside the do loop in that function.  However, if the thread
> is woken up with swake_up_locked(), that function will delete the
> entry from the wait queue.  If that happens and another thread sneaks
> in and decrements the done count in the completion to zero, the
> loop will go around again, but the thread will no longer be in the
> wait queue, so there is no way to wake it up.
> 
> Fix it by adding/removing the thread to/from the wait queue inside
> the do loop.
> 
> Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Added Peter and lkml to the CC since this is mainline and not -rt only.

Thanks,
Daniel

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
> customer reports of failures.
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
> index 755a58084978..4cde33cf8b28 100644
> --- a/kernel/sched/completion.c
> +++ b/kernel/sched/completion.c
> @@ -70,10 +70,10 @@ do_wait_for_common(struct completion *x,
>  		   long (*action)(long), long timeout, int state)
>  {
>  	if (!x->done) {
> -		DECLARE_SWAITQUEUE(wait);
> -
> -		__prepare_to_swait(&x->wait, &wait);
>  		do {
> +			DECLARE_SWAITQUEUE(wait);
> +
> +			__prepare_to_swait(&x->wait, &wait);
>  			if (signal_pending_state(state, current)) {
>  				timeout = -ERESTARTSYS;
>  				break;
> @@ -82,8 +82,8 @@ do_wait_for_common(struct completion *x,
>  			raw_spin_unlock_irq(&x->wait.lock);
>  			timeout = action(timeout);
>  			raw_spin_lock_irq(&x->wait.lock);
> +			__finish_swait(&x->wait, &wait);
>  		} while (!x->done && timeout);
> -		__finish_swait(&x->wait, &wait);
>  		if (!x->done)
>  			return timeout;
>  	}
> 
