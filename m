Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18932C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F188960F94
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 16:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbhHDQRT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 12:17:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhHDQRT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 12:17:19 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD8260E78;
        Wed,  4 Aug 2021 16:17:05 +0000 (UTC)
Date:   Wed, 4 Aug 2021 12:17:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804121704.1587c41b@oasis.local.home>
In-Reply-To: <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
        <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
        <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
        <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
        <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
        <20210804131731.GG8057@worktop.programming.kicks-ass.net>
        <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
        <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
        <20210804153308.oasahcxjmcw7vivo@linutronix.de>
        <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
        <20210804154743.niogqvnladdkfgi2@linutronix.de>
        <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 4 Aug 2021 09:49:48 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> > @@ -430,9 +430,9 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
> >  	}
> >  
> >  	if (stall_hash != -1U) {
> > -		raw_spin_unlock(&wqe->lock);
> > +		raw_spin_unlock_irq(&wqe->lock);
> >  		io_wait_on_hash(wqe, stall_hash);
> > -		raw_spin_lock(&wqe->lock);
> > +		raw_spin_lock_irq(&wqe->lock);
> >  	}
> >  
> >  	return NULL;
> > 
> > (this is on-top of the patch you sent earlier and Daniel Cc: me on after
> > I checked that the problem/warning still exists).  
> 
> That'd work on non-RT as well, but it makes it worse on non-RT as well with
> the irq enable/disable dance. While that's not the end of the world, would
> be nice to have a solution that doesn't sacrifice anything, yet doesn't
> make RT unhappy.

We use to have something like:

	local_irq_disable_rt()

that would only disable irqs when PREEMPT_RT was configured, but this
was considered "ugly" and removed to try to only use spin_lock_irq()
and raw_spin_lock_irq(). But for this situation, it looks like it would
do exactly what you wanted. Not sacrifice anything yet keep RT happy.

Not sure that's a solution still. :-/

Perhaps in this situation, we could open code it to:

  	if (stall_hash != -1U) {
		raw_spin_unlock(&wqe->lock);

		/* On RT the spin_lock_irq() does not disable interrupts */
		if (IS_ENABLED(CONFIG_PREEMPT_RT))
			local_irq_enable();

 		io_wait_on_hash(wqe, stall_hash);

		if (IS_ENABLED(CONFIG_PREEMPT_RT))
			local_irq_disable();
		raw_spin_lock(&wqe->lock);
 	}

Note, I haven't looked at the rest of the code to know the ripple
effect of this, but I'm just suggesting the idea.

-- Steve
