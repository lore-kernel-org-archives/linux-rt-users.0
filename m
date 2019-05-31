Return-Path: <SRS0=n5VO=T7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6547C04AB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 11:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8592026877
	for <linux-rt-users@archiver.kernel.org>; Fri, 31 May 2019 11:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEaL4J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 31 May 2019 07:56:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59575 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfEaL4J (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 31 May 2019 07:56:09 -0400
Received: from [5.158.153.53] (helo=[10.100.31.75])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <anna-maria@linutronix.de>)
        id 1hWg8j-0005oq-9O; Fri, 31 May 2019 13:56:05 +0200
Date:   Fri, 31 May 2019 13:55:59 +0200 (CEST)
From:   Anna-Maria Gleixner <anna-maria@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 2/3] timers: do not raise softirq unconditionally
 (spinlockless version)
In-Reply-To: <20190530201455.GC23199@amt.cnet>
Message-ID: <alpine.DEB.2.21.1905311355180.4899@somnus>
References: <20190415201213.600254019@amt.cnet> <20190415201429.427759476@amt.cnet> <alpine.DEB.2.21.1905291653120.1395@somnus> <20190530201455.GC23199@amt.cnet>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 30 May 2019, Marcelo Tosatti wrote:

> On Wed, May 29, 2019 at 04:53:26PM +0200, Anna-Maria Gleixner wrote:
> > On Mon, 15 Apr 2019, Marcelo Tosatti wrote:
> > 
> > > --- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
> > > +++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:22:56.755047354 -0300
> > > @@ -1776,6 +1776,24 @@
> > >  		if (time_before(jiffies, base->clk))
> > >  			return;
> > >  	}
> > > +
> > > +#ifdef CONFIG_PREEMPT_RT_FULL
> > > +/* On RT, irq work runs from softirq */
> > > +	if (irq_work_needs_cpu())
> > > +		goto raise;
> > 
> > So with this patch and the change you made in the patch before, timers on
> > RT are expired only when there is pending irq work or after modifying a
> > timer on a non housekeeping cpu?
> 
> Well, run_timer_softirq execute only if pending_map contains a bit set.
> 
> > With your patches I could create the following problematic situation on RT
> > (if I understood everything properly): I add a timer which should expire in
> > 50 jiffies to the wheel of a non housekeeping cpu. So it ends up 50 buckets
> > away form now in the first wheel. This timer is the only timer in the wheel
> > and the next timer softirq raise is required in 50 jiffies. After adding
> > the timer, the timer interrupt is raised, and no timer has to be expired,
> > because there is no timer pending.
> 
> But the softirq will be raised, because pending_map will be set:
> 
> +               if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> +                       goto raise;
> 
> No?

I'm sorry! I read the #endif of the CONFIG_PREEMPT_RT_FULL section as an
#else... This is where my confusion comes from. I will think about the
problem and your solution a little bit more and give you feedback hopefully
on monday.

Thanks,
	Anna-Maria

