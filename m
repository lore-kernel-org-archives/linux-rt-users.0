Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58245C83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3762F20731
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuyorktZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgD1Wdq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:33:46 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726474AbgD1Wdp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 18:33:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588113224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cfynA1GS9zoR/R+KpFpTNVmup6mUfUXSRebr4yyqKDI=;
        b=TuyorktZyDcRWUXloJrwe0Tfg64aII8VJRRHGeZ7Q0S25MVyibDWaF3gEyOjN4K+wMjpDb
        Qjo7k0Xjm14fv1Ipu6YQuZUKAJuYc7Cacjf9UTBe0tsuwHZA1f4hgnb8f4el6MBqkSY1vZ
        p1aM7ASFIRlh8OEPe4lA/BtEsJ9Sv9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-6hJ8-lZdOYewsG-HbLb0OQ-1; Tue, 28 Apr 2020 18:33:40 -0400
X-MC-Unique: 6hJ8-lZdOYewsG-HbLb0OQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A04DA108BD0F;
        Tue, 28 Apr 2020 22:33:38 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 50009600D2;
        Tue, 28 Apr 2020 22:33:37 +0000 (UTC)
Message-ID: <fa406883f0eace37fe7f658814e29f82a4f0addf.camel@redhat.com>
Subject: Re: [RFC PATCH 3/3] sched,rt: break out of load balancing if an RT
 task appears
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
Date:   Tue, 28 Apr 2020 17:33:36 -0500
In-Reply-To: <jhjees7s29u.mognet@arm.com>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-4-swood@redhat.com> <jhjees7s29u.mognet@arm.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-04-28 at 22:56 +0100, Valentin Schneider wrote:
> On 28/04/20 06:02, Scott Wood wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index dfde7f0ce3db..e7437e4e40b4 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9394,6 +9400,10 @@ static int should_we_balance(struct lb_env *env)
> >       struct sched_group *sg = env->sd->groups;
> >       int cpu, balance_cpu = -1;
> > 
> > +	/* Run the realtime task now; load balance later. */
> > +	if (rq_has_runnable_rt_task(env->dst_rq))
> > +		return 0;
> > +
> 
> I have a feeling this isn't very nice to CFS tasks, since we would now
> "waste" load-balance attempts if they happen to coincide with an RT task
> being runnable.
>
> On your 72 CPUs machine, the system-wide balance happens (at best) every
> 72ms if you have idle time, every ~2300ms otherwise (every balance
> CPU gets to try to balance however, so it's not as horrible as I'm making
> it sound). This is totally worst-case scenario territory, and you'd hope
> newidle_balance() could help here and there (as it isn't gated by any
> balance interval).
> 
> Still, even for a single rq, postponing a system-wide balance for a
> full balance interval (i.e. ~2 secs worst case here) just because we had a
> single RT task running when we tried to balance seems a bit much.
> 
> It may be possible to hack something to detect those cases and reset the
> interval to "now" when e.g. dequeuing the last RT task (& after having
> previously aborted a load-balance due to RT/DL/foobar).

Yeah, some way to retry at an appropriate time after aborting a rebalance
would be good.


> > +
> > +/* Is there a task of a high priority class? */
> > +static inline bool rq_has_runnable_rt_task(struct rq *rq)
> > +{
> > +	return unlikely(rq->nr_running != rq->cfs.h_nr_running);
> 
> Seeing as that can be RT, DL or stopper, that name is somewhat misleading.

rq_has_runnable_rt_dl_task()?  Or is there some term that unambiguously
encompasses both?

-Scott


