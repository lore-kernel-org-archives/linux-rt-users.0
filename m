Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A88C28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 20:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5095026156
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 20:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE3UPp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 May 2019 16:15:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfE3UPp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 May 2019 16:15:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CFD2300740E;
        Thu, 30 May 2019 20:15:44 +0000 (UTC)
Received: from amt.cnet (ovpn-112-13.gru2.redhat.com [10.97.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B405E87B1;
        Thu, 30 May 2019 20:15:42 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 6E04E105193;
        Thu, 30 May 2019 16:23:34 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x4UJNUG8027096;
        Thu, 30 May 2019 16:23:30 -0300
Date:   Thu, 30 May 2019 16:23:29 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 1/3] timers: raise timer softirq on
 __mod_timer/add_timer_on
Message-ID: <20190530192326.GA23199@amt.cnet>
References: <20190415201213.600254019@amt.cnet>
 <20190415201429.342103190@amt.cnet>
 <alpine.DEB.2.21.1905291652480.1395@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905291652480.1395@somnus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 30 May 2019 20:15:44 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Anna-Maria,

On Wed, May 29, 2019 at 04:53:05PM +0200, Anna-Maria Gleixner wrote:
> On Mon, 15 Apr 2019, Marcelo Tosatti wrote:
> 
> [...]
> 
> > The patch "timers: do not raise softirq unconditionally" from Thomas
> > attempts to address that by checking, in the sched tick, whether its
> > necessary to raise the timer softirq. 

https://lore.kernel.org/patchwork/patch/446045/

>> Unfortunately, it attempts to grab
> > the tvec base spinlock which generates the issue described in the patch
> > "Revert "timers: do not raise softirq unconditionally"".

https://lore.kernel.org/patchwork/patch/552474/

> Both patches are not available in the version your patch set is based
> on. Better pointers would be helpful.

See above.

> 
> > tvec_base->lock protects addition of timers to the wheel versus
> > timer interrupt execution.
> 
> The timer_base->lock (formally known as tvec_base->lock), synchronizes all
> accesses to timer_base and not only addition of timers versus timer
> interrupt execution. Deletion of timers, getting the next timer interrupt,
> forwarding the base clock and migration of timers are protected as well by
> timer_base->lock.

Right.

> > This patch does not grab the tvec base spinlock from irq context,
> > but rather performs a lockless access to base->pending_map.
> 
> I cannot see where this patch performs a lockless access to
> timer_base->pending_map.

[patch 2/3] timers: do not raise softirq unconditionally (spinlockless
version)

> > It handles the the race between timer addition and timer interrupt
> > execution by unconditionally (in case of isolated CPUs) raising the
> > timer softirq after making sure the updated bitmap is visible 
> > on remote CPUs.
> 
> So after modifying a timer on a non housekeeping timer base, the timer
> softirq is raised - even if there is no pending timer in the next
> bucket. Only with this patch, this shouldn't be a problem - but it is an
> additional raise of timer softirq and an overhead when adding a timer,
> because the normal timer softirq is raised from sched tick anyway.

It should be clear why this is necessary when reading

[patch 2/3] timers: do not raise softirq unconditionally (spinlockless
version)

> 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  kernel/time/timer.c |   38 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > Index: linux-rt-devel/kernel/time/timer.c
> > ===================================================================
> > --- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 13:56:06.974210992 -0300
> > +++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
> > @@ -1056,6 +1063,17 @@
> >  		internal_add_timer(base, timer);
> >  	}
> >  
> > +	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER) &&
> > +	    !(timer->flags & TIMER_DEFERRABLE)) {
> > +		call_single_data_t *c;
> > +
> > +		c = per_cpu_ptr(&raise_timer_csd, base->cpu);
> > +
> > +		/* Make sure bitmap updates are visible on remote CPUs */
> > +		smp_wmb();
> > +		smp_call_function_single_async(base->cpu, c);
> > +	}
> > +
> >  out_unlock:
> >  	raw_spin_unlock_irqrestore(&base->lock, flags);
> >
> 
> Could you please explain me, why you decided to use the above
> implementation for raising the timer softirq after modifying a timer?

Because of the following race condition which is open after

"[patch 2/3] timers: do not raise softirq unconditionally (spinlockless
version)": 


CPU-0				CPU-1

				jiffies=99
runs
add_timer_on, with 
timer->expires=100
				jiffies=100
				run_softirq(), sees pending bitmap clear

add_timer_on 
returns and 
timer was not executed

P)


This race did not exist before. 

So by raising a softirq on the remote CPU 
at point P), its ensured the timer will 
be executed ASAP.


