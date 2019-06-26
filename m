Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAA1C48BD6
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 10:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C920E20663
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 10:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pBMW6Cf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfFZKgK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 06:36:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfFZKgJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 06:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Z59P3DCESmzNCcibG3WuNOZ7nMH3x4w5SM4UGQx+3GM=; b=pBMW6Cf1ltUNRA+WHq8nTd1Ta
        FhAzvEn03lZYSKkrEkpKW1RV8ZTINiw7UXlApumZIfN8GSm24gQ8x2GtThDHqFfNr4+jqxmUsmLBZ
        w9u9SPam+mFPOo1EC86eCdaJkFD1srGZINVOn36d6XrZYypmoXLhKqwCPC8U/mklN76IekBqz+/jE
        ChJfqxCIYvAYzXroETavkB13DKBcOzydl0+vOiALmURIMag3a0avBciBa0RxFXn8EljokQoSPbyD5
        CLSmyiAzM5SjioYIvpEiX+jiytugntz68Mu0RZmyhWGrj5ygb4RxdwVzG6fr21HHkL6oiBPGqxwJg
        FPJjJlOvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg5HU-0001Ni-KT; Wed, 26 Jun 2019 10:36:00 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 41D43209C957B; Wed, 26 Jun 2019 12:35:58 +0200 (CEST)
Date:   Wed, 26 Jun 2019 12:35:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     minyard@acm.org, linux-rt-users@vger.kernel.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190626103558.GL3419@hirez.programming.kicks-ass.net>
References: <20190508205728.25557-1-minyard@acm.org>
 <20190509161925.kul66w54wpjcinuc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509161925.kul66w54wpjcinuc@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 09, 2019 at 06:19:25PM +0200, Sebastian Andrzej Siewior wrote:
> One question for the upstream completion implementation:
> completion_done() returns true if there are no waiters. It acquires the
> wait.lock to ensure that complete()/complete_all() is done. However,
> once complete releases the lock it is guaranteed that the wake_up() (for
> the waiter) occurred. The waiter task still needs to be remove itself
> from the wait-queue before the completion can be removed.
> Do I miss something?

So you mean:

	init_completion(&done);


	wait_for_copmletion(&done)
	  spin_lock()
	   __add_wait_queue()
	  spin_unlock()
	  schedule()

					complete()
								completion_done()
	  spin_lock()
	  __remove_wait_queue()
	  spin_unlock()

Right?

I think that boils down to that whenever you have multiple waiters,
someone needs to be in charge of @done's lifetime.

The case that matters is:

	DECLARE_COMPLETION_ONSTACK(done)

	while (!completion_done(&done))
		cpu_relax();

Where there is but a single waiter, and that waiter is
completion_done(). In that case it must not return early.

Now, I've also seen a ton of code do:

	if (!completion_done(done))
		complete(done);

And that makes me itch... but I've not bothered to look into it hard
enough.
