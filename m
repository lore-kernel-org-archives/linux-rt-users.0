Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1DAC433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 07:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CD7613D9
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 07:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhD1HMk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:12:40 -0400
Received: from mail.monom.org ([188.138.9.77]:40714 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231600AbhD1HMj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Apr 2021 03:12:39 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id EB62F50056B;
        Wed, 28 Apr 2021 09:11:53 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id 9BE5B50022D;
        Wed, 28 Apr 2021 09:11:53 +0200 (CEST)
Date:   Wed, 28 Apr 2021 09:11:53 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Cc:     Joe Korty <joe.korty@concurrent-rt.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] 4.9.263-rt177: Balance local_irq_{disable,enable} in
 irq_forced_thread_fn
Message-ID: <20210428071153.meilcgaarpznqndv@beryllium.lan>
References: <20210427221009.GA23708@zipoli.concurrrent-rt.com>
 <YIiUjUo0PqJh+782@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIiUjUo0PqJh+782@uudg.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Tue, Apr 27, 2021 at 07:47:41PM -0300, Luis Claudio R. Goncalves wrote:
> On Tue, Apr 27, 2021 at 06:10:09PM -0400, Joe Korty wrote:
> > Balance local_irq_{disable,enable} usage in irq_forced_thread_fn
> > 
> > Re: 0152-genirq-Allow-disabling-of-softirq-processing-in-irq-.patch
> > 
> > In 4.9.263-rt177, irq_forced_thread_fn has potentially unbalanced calls to
> > local_irq_disable ... local_irq_enable.  This is probably not intentional.
> > 
> > I am not absolutely sure what the proper fix is.  Attached is an example
> > of what that might look like.
> > 
> > [ Issue detected via compiler warning, using a sufficiently advanced gcc ]
> > 
> > Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>
> 
> Joe, I fell a bit behind on v4.9-rt and intend to get up to date this
> weekend. I am now satisfied with my current backport of the futex changes
> from v4.9.264 and my 96h of pi_stress testing.
> 
> Your patch makes sense, taking v4.19-rt as reference, but I will wait
> for comments from the wise people you listed on the Cc: before taking
> action.

I had to resolve the same merge conflict in v4.4-rt. The fix from Joe
resolve to the same solution I've done in v4.4-rt

> 
> Best regards,
> Luis
> 
> > 
> > Index: b/kernel/irq/manage.c
> > ===================================================================
> > --- a/kernel/irq/manage.c
> > +++ b/kernel/irq/manage.c
> > @@ -1035,6 +1035,9 @@ irq_forced_thread_fn(struct irq_desc *de
> >  		atomic_inc(&desc->threads_handled);
> >  
> >  	irq_finalize_oneshot(desc, action);
> > +

Nit there is no new line here in upstream, dd652c6ab49b ("genirq:
Disable interrupts for force threaded handlers")

> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
> > +		local_irq_enable();
> >  	/*
> >  	 * Interrupts which have real time requirements can be set up
> >  	 * to avoid softirq processing in the thread handler. This is
> > @@ -1043,8 +1046,6 @@ irq_forced_thread_fn(struct irq_desc *de
> >  	if (irq_settings_no_softirq_call(desc))
> >  		_local_bh_enable();
> >  	else
> > -		if (!IS_ENABLED(CONFIG_PREEMPT_RT_BASE))
> > -			local_irq_enable();
> >  		local_bh_enable();
> >  	return ret;
> >  }
> ---end quoted text---

Thanks,
Daniel
