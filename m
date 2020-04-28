Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16FEC83000
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3DD206F0
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAo+CRXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgD1WdJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:33:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55624 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgD1WdJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 18:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588113187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzATFGFE6RVRk5bLNJ/DzVa1W9rD6ySZvjPouyZsilE=;
        b=KAo+CRXe8+p9SBYj2HQPy5sunaclvHHwLfsFhY+VXyhbc/prQ+ro9B+ywuzLxTqOA/Rygv
        JXaxabfesKaqTkpNFkQ5RUxo8/NjH7eaMcTUEDI0O48nL9Q9fet7IBJCa55JDSY0z4CpUB
        K/p0vz3nK85tdwb+PWTAcn1/DARIYrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-_PVkpR6UN76kIlMtwTv9lQ-1; Tue, 28 Apr 2020 18:33:05 -0400
X-MC-Unique: _PVkpR6UN76kIlMtwTv9lQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CA4353;
        Tue, 28 Apr 2020 22:33:03 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D55C391;
        Tue, 28 Apr 2020 22:33:02 +0000 (UTC)
Message-ID: <2a30101cc0adb63ee7ce7b32119579d78de24b71.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Tue, 28 Apr 2020 17:33:01 -0500
In-Reply-To: <jhjftcns35d.mognet@arm.com>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com> <jhjftcns35d.mognet@arm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-04-28 at 22:37 +0100, Valentin Schneider wrote:
> On 28/04/20 06:02, Scott Wood wrote:
> > Thus, newidle_balance() is entered with interrupts enabled, which allows
> > (in the next patch) enabling interrupts when the lock is dropped.
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> >  kernel/sched/core.c  |  7 ++++---
> >  kernel/sched/fair.c  | 45 ++++++++++++++++----------------------------
> >  kernel/sched/sched.h |  6 ++----
> >  3 files changed, 22 insertions(+), 36 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9a2fbf98fd6f..0294beb8d16c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct
> > task_struct *prev)
> >       }
> > 
> >       tick_nohz_task_switch();
> > +
> > +	if (is_idle_task(current))
> > +		newidle_balance();
> > +
> 
> This means we must go through a switch_to(idle) before figuring out we
> could've switched to a CFS task, and do it then. I'm curious to see the
> performance impact of that.

Any particular benchmark I should try?

> >      return rq;
> >  }
> > 
> > @@ -10425,14 +10408,23 @@ static inline void nohz_newidle_balance(struct
> > rq *this_rq) { }
> >   *     0 - failed, no new tasks
> >   *   > 0 - success, new (fair) tasks present
> >   */
> > -int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
> > +int newidle_balance(void)
> >  {
> >       unsigned long next_balance = jiffies + HZ;
> > -	int this_cpu = this_rq->cpu;
> > +	int this_cpu;
> >       struct sched_domain *sd;
> > +	struct rq *this_rq;
> >       int pulled_task = 0;
> >       u64 curr_cost = 0;
> > 
> > +	preempt_disable();
> > +	this_rq = this_rq();
> > +	this_cpu = this_rq->cpu;
> > +	local_bh_disable();
> > +	raw_spin_lock_irq(&this_rq->lock);
> > +
> > +	update_rq_clock(this_rq);
> > +
> >       update_misfit_status(NULL, this_rq);
> 
> I'm thinking this should be moved to where newidle_balance() used to be,
> otherwise we have a window where the rq is flagged as having a misfit
> task despite not having any runnable CFS tasks.

OK

-Scott


