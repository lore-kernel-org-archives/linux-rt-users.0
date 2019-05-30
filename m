Return-Path: <SRS0=CUgu=T6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C0FC28CC0
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 20:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48122614E
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 May 2019 20:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfE3UPt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 May 2019 16:15:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58576 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfE3UPt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 May 2019 16:15:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CBCFA30833AF;
        Thu, 30 May 2019 20:15:48 +0000 (UTC)
Received: from amt.cnet (ovpn-112-13.gru2.redhat.com [10.97.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE4DE611A1;
        Thu, 30 May 2019 20:15:42 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
        by amt.cnet (Postfix) with ESMTP id 199B210519C;
        Thu, 30 May 2019 17:15:03 -0300 (BRT)
Received: (from marcelo@localhost)
        by amt.cnet (8.14.7/8.14.7/Submit) id x4UKF0jJ028233;
        Thu, 30 May 2019 17:15:00 -0300
Date:   Thu, 30 May 2019 17:14:58 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [patch 2/3] timers: do not raise softirq unconditionally
 (spinlockless version)
Message-ID: <20190530201455.GC23199@amt.cnet>
References: <20190415201213.600254019@amt.cnet>
 <20190415201429.427759476@amt.cnet>
 <alpine.DEB.2.21.1905291653120.1395@somnus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1905291653120.1395@somnus>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 30 May 2019 20:15:48 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, May 29, 2019 at 04:53:26PM +0200, Anna-Maria Gleixner wrote:
> On Mon, 15 Apr 2019, Marcelo Tosatti wrote:
> 
> > Check base->pending_map locklessly and skip raising timer softirq 
> > if empty.
> > 
> > What allows the lockless (and potentially racy against mod_timer) 
> > check is that mod_timer will raise another timer softirq after
> > modifying base->pending_map.
> 
> The raise of the timer softirq after adding the timer is done
> unconditionally - so there are timer softirqs raised which are not required
> at all, as mentioned before.

Yes. However i can't see a way to avoid that: its not possible to know
if the race described earlier happened or not. 

Do you have a suggestion on how to avoid this or a way to avoid
the IPI+raise softirq ?

> This check is for !CONFIG_PREEMPT_RT_FULL only implemented. The commit
> message totally igonres that you are implementing something
> CONFIG_PREEMPT_RT_FULL dependent as well.
> 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > ---
> >  kernel/time/timer.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > Index: linux-rt-devel/kernel/time/timer.c
> > ===================================================================
> > --- linux-rt-devel.orig/kernel/time/timer.c	2019-04-15 14:21:02.788704354 -0300
> > +++ linux-rt-devel/kernel/time/timer.c	2019-04-15 14:22:56.755047354 -0300
> > @@ -1776,6 +1776,24 @@
> >  		if (time_before(jiffies, base->clk))
> >  			return;
> >  	}
> > +
> > +#ifdef CONFIG_PREEMPT_RT_FULL
> > +/* On RT, irq work runs from softirq */
> > +	if (irq_work_needs_cpu())
> > +		goto raise;
> 
> So with this patch and the change you made in the patch before, timers on
> RT are expired only when there is pending irq work or after modifying a
> timer on a non housekeeping cpu?

Well, run_timer_softirq execute only if pending_map contains a bit set.

> With your patches I could create the following problematic situation on RT
> (if I understood everything properly): I add a timer which should expire in
> 50 jiffies to the wheel of a non housekeeping cpu. So it ends up 50 buckets
> away form now in the first wheel. This timer is the only timer in the wheel
> and the next timer softirq raise is required in 50 jiffies. After adding
> the timer, the timer interrupt is raised, and no timer has to be expired,
> because there is no timer pending.

But the softirq will be raised, because pending_map will be set:

+               if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
+                       goto raise;

No?

>  If there is no irq work required during
> the next 51 jiffies and also no timer changed, the timer I added, will not
> expire in time. The timer_base will come out of idle but will not forward
> the base clk. 

> This makes it even worse: When then adding a timer, the timer
> base is forwarded - but without checking for the next pending timer, so the
> first added timer will be delayed even more.
> 
> So your implementation lacks forwarding the timer_base->clk when timer_base
> comes out of idle with respect to the next pending timer.

> > +#endif
> > +	base = this_cpu_ptr(&timer_bases[BASE_STD]);
> > +	if (!housekeeping_cpu(base->cpu, HK_FLAG_TIMER)) {
> > +		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> > +			goto raise;
> > +		base++;
> > +		if (!bitmap_empty(base->pending_map, WHEEL_SIZE))
> > +			goto raise;
> > +
> > +		return;
> > +	}
> > +
> > +raise:
> >  	raise_softirq(TIMER_SOFTIRQ);
> >  }
> >  
> >
> 
> Thanks,
> 
> 	Anna-Maria
