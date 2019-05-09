Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E25C04AB2
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB1D20675
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 17:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkd1twvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEIRqJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 13:46:09 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33210 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIRqJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 13:46:09 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so3121046otq.0;
        Thu, 09 May 2019 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2rPN51UTprRWfL+/Mbu5kUKExuV0ZyVi6ggAMsxnVQg=;
        b=lkd1twvolh8B7YM/6UcVbdwb0RepRsb+2vX5MphepdIwIzViVDjnFmNG7a6B9itZU5
         HaV0QGUsfajKzVFWIyczk0km9BVUYYYBRGI7LNjosz7yhzNOFJw0sU6LZUFAPMgYC/ON
         n4JhUBGDzg98VhtPVP4Q8e+ioTy79YkA8kJOtucg6YGwSCGdrNe0Zp/IhzFYD7cPWKly
         uFMmQ+UBsThNDKn7kRokOTi+3spt9SZSKQ7YgZWqKYxnk4B1IVltenwGQnIVZfECs4X+
         rkNuOmtRWhsblEdgyZRzvw9rs939mdHbSaQXlmRDNwnEcJH3R0+iclP8Iu15dPIrKHMW
         eBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=2rPN51UTprRWfL+/Mbu5kUKExuV0ZyVi6ggAMsxnVQg=;
        b=rLHM9mMt3UMR7q8iBXBoQWn4a3z1Fnot+DIAbi1yAnw7XrsTKH/X5YqQLKrhKEFSTG
         efjsvHx0bhnficli/zeYt3/JouOJqxds92reSW1Rou312L9x4wYekLP/8k6ImTeCp4wp
         /PnaYWUvaxZcNC++RvZsBr5ULfOZO4gl737cDBZ6Q74ybPOadNZ2/1jy5oL37dURv5YB
         8JGgw6HVyLYj3KM7PdbssmUuPCJOBRNFkpQpgZxFg/FnFgY0RIbYbLGLxV/IxrFrXwDO
         6gZskwZBq10tywWB8eeSSobw3CC+kpvoVXMZThBpuSnXtP8NaCFBKz0i+g01DLZ5xYjF
         uMZg==
X-Gm-Message-State: APjAAAVgENcLU7/rHz6fyxHIS/l6WOGHbvA+6aFadOvUPh4U4I7mI9AV
        pMCW8lwk0XRlBWyBLrK8doWIBNY=
X-Google-Smtp-Source: APXvYqwUnW+MxO1Ns2RBYuq/5aQa/0JnAMVeg1moQgw0Ko4wzWKpQr2N3pAGK3wfe7MOz4KIiVQ8Cw==
X-Received: by 2002:a9d:6407:: with SMTP id h7mr3627519otl.35.1557423967740;
        Thu, 09 May 2019 10:46:07 -0700 (PDT)
Received: from serve.minyard.net ([47.184.134.43])
        by smtp.gmail.com with ESMTPSA id q205sm1079611oih.17.2019.05.09.10.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 May 2019 10:46:07 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id 9ADAD18190F;
        Thu,  9 May 2019 17:46:06 +0000 (UTC)
Date:   Thu, 9 May 2019 12:46:05 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190509174605.GI16145@minyard.net>
Reply-To: minyard@acm.org
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509161925.kul66w54wpjcinuc@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 09, 2019 at 06:19:25PM +0200, Sebastian Andrzej Siewior wrote:
> Please:
>  - add some RT developers on Cc:
>  - add lkml
>  - use [PATCH RT] instead just [PATCH] so it is visible that you target
>    the RT tree.

Will do.  I'll add your diagram below, too.

> 
> On 2019-05-08 15:57:28 [-0500], minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > The function call do_wait_for_common() has a race condition that
> > can result in lockups waiting for completions.  Adding the thread
> > to (and removing the thread from) the wait queue for the completion
> > is done outside the do loop in that function.  However, if the thread
> > is woken up, the swake_up_locked() function will delete the entry
> > from the wait queue.  If that happens and another thread sneaks
> > in and decrements the done count in the completion to zero, the
> > loop will go around again, but the thread will no longer be in the
> > wait queue, so there is no way to wake it up.
> > 
> > Fix it by adding/removing the thread to/from the wait queue inside
> > the do loop.
> 
> So you are saying:
> 	T0			T1			    T2
> 	wait_for_completion()
> 	 do_wait_for_common()
> 	  __prepare_to_swait()
> 	   schedule()
> 	    		       complete()
> 			        x->done++ (0 -> 1)
> 				raw_spin_lock_irqsave()
> 				 swake_up_locked()           wait_for_completion()
> 				  wake_up_process(T0)
> 				  list_del_init()
> 				raw_spin_unlock_irqrestore()
> 	                                                      raw_spin_lock_irq(&x->wait.lock)
> 	 raw_spin_lock_irq(&x->wait.lock)                      x->done != UINT_MAX, 1 -> 0
> 							       return 1
> 							      raw_spin_unlock_irq(&x->wait.lock)
> 	 while (!x->done && timeout),
> 	 continue loop, not enqueued
> 	 on &x->wait
> 
> The difference compared to the non-swait based implementation is that
> swake_up_locked() removes woken up tasks from the list while the other
> implementation (wait_queue_entry based, default_wake_function()) does
> not. Buh

Yes, exactly.  I was wondering if swait could be changed to not remove
the waiter, but that seemed like a bad idea.  It is an unusual semantic,
though.

I thought some more about this, wondering why everything isn't keeling
over because of this.  I'm guessing that just about everything using
completions has a single waiter, so it doesn't matter.  I just wrote
some code that has a bunch of waiters, so I hit it.

-corey

> 
> One question for the upstream completion implementation:
> completion_done() returns true if there are no waiters. It acquires the
> wait.lock to ensure that complete()/complete_all() is done. However,
> once complete releases the lock it is guaranteed that the wake_up() (for
> the waiter) occurred. The waiter task still needs to be remove itself
> from the wait-queue before the completion can be removed.
> Do I miss something?
> 
> > Fixes: a04ff6b4ec4ee7e ("completion: Use simple wait queues")
> > Signed-off-by: Corey Minyard <cminyard@mvista.com>
> > ---
> > I sent the wrong version of this, I had spotted this before but didn't
> > fix it here.  Adding the thread to the wait queue needs to come after
> > the signal check.  Sorry about the noise.
> > 
> >  kernel/sched/completion.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
> > index 755a58084978..4f9b4cc0c95a 100644
> > --- a/kernel/sched/completion.c
> > +++ b/kernel/sched/completion.c
> > @@ -70,20 +70,20 @@ do_wait_for_common(struct completion *x,
> >  		   long (*action)(long), long timeout, int state)
> >  {
> >  	if (!x->done) {
> > -		DECLARE_SWAITQUEUE(wait);
> > -
> > -		__prepare_to_swait(&x->wait, &wait);
> 
> you can keep DECLARE_SWAITQUEUE remove just __prepare_to_swait()
> 
> >  		do {
> > +			DECLARE_SWAITQUEUE(wait);
> > +
> >  			if (signal_pending_state(state, current)) {
> >  				timeout = -ERESTARTSYS;
> >  				break;
> >  			}
> > +			__prepare_to_swait(&x->wait, &wait);
> 
> add this, yes and you are done.
> 
> >  			__set_current_state(state);
> >  			raw_spin_unlock_irq(&x->wait.lock);
> >  			timeout = action(timeout);
> >  			raw_spin_lock_irq(&x->wait.lock);
> > +			__finish_swait(&x->wait, &wait);
> >  		} while (!x->done && timeout);
> > -		__finish_swait(&x->wait, &wait);
> >  		if (!x->done)
> >  			return timeout;
> >  	}
> 
> Sebastian
