Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABFC38147
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Jan 2023 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjARQER (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjARQDp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Jan 2023 11:03:45 -0500
Received: from outbound-smtp37.blacknight.com (outbound-smtp37.blacknight.com [46.22.139.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4184F3D0A2
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jan 2023 08:00:23 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp37.blacknight.com (Postfix) with ESMTPS id 226721C18
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Jan 2023 16:00:22 +0000 (GMT)
Received: (qmail 11314 invoked from network); 18 Jan 2023 16:00:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 18 Jan 2023 16:00:21 -0000
Date:   Wed, 18 Jan 2023 16:00:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linux-RT <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] locking/rwbase: Prevent indefinite writer starvation
Message-ID: <20230118160020.jcubwokkipnm7fls@techsingularity.net>
References: <20230117083817.togfwc5cy4g67e5r@techsingularity.net>
 <Y8avJm1FQI9vB9cv@linutronix.de>
 <20230117165021.t5m7c2d6frbbfzig@techsingularity.net>
 <Y8fN2VQQTGUZ3ykw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <Y8fN2VQQTGUZ3ykw@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jan 18, 2023 at 11:45:45AM +0100, Ingo Molnar wrote:
> 
> > +/*
> > + * Allow reader bias with a pending writer for a minimum of 4ms or 1 tick.
> > + * This matches RWSEM_WAIT_TIMEOUT for the generic RWSEM implementation.
> > + * The granularity is not exact as the lowest bit in rwbase_rt->waiter_timeout
> > + * is used to detect recent DL / RT tasks taking a read lock.
> > + */
> > +#define RWBASE_RT_WAIT_TIMEOUT DIV_ROUND_UP(HZ, 250)
> > +
> > +static void __sched update_dlrt_reader(struct rwbase_rt *rwb)
> > +{
> > +	/* No update required if DL / RT tasks already identified. */
> > +	if (rwb->waiter_timeout & 1)
> > +		return;
> > +
> > +	/*
> > +	 * Record a DL / RT task acquiring the lock for read. This may result
> > +	 * in indefinite writer starvation but DL / RT tasks should avoid such
> > +	 * behaviour.
> > +	 */
> > +	if (rt_task(current)) {
> > +		struct rt_mutex_base *rtm = &rwb->rtmutex;
> > +		unsigned long flags;
> > +
> > +		raw_spin_lock_irqsave(&rtm->wait_lock, flags);
> > +		rwb->waiter_timeout |= 1;
> > +		raw_spin_unlock_irqrestore(&rtm->wait_lock, flags);
> > +	}
> > +}
> 
> So I'm not sure this should be dependent on the task being an RT task.
> 
> Starvation scenarios are bad no matter what scheduling policy is used.
> 
> Should be unconditional - and all workloads should live with the new 
> behavior.
> 

The DL / RT task special casing was based on feedback given here
https://lore.kernel.org/r/Y7wxjBN9bDaZ0BKo@hirez.programming.kicks-ass.net.
Based on that, I assumed that allowing write to blocks readers that
may be depending on priority inheritance is potentially problematic for
applications that likely have been designed with writer-starvation in mind.
The first version of the patch did not care about the scheduling classes
were but I admit there is a non-zero possibility that breaking reader bias
for a writer may break some unknown RT-specific application that relied
on writer starvation for DL / RT tasks.

-- 
Mel Gorman
SUSE Labs
