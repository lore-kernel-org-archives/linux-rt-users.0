Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0C5C83004
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE88220730
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWXUWvka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgD1WwW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:52:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56717 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725934AbgD1WwV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 18:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588114340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ufHYW9Szgtlfn6kl1fo0AOdgn3k3qUj3jPCNjzfkXDU=;
        b=HWXUWvkaViE8CENmKVcw4kK9wxqottkgqUtQqL0U9h9Aq8Zpb6SqdbqJOGQaGsehptQfxZ
        n6N7oa26RJ9WW7LSmqubfJMltzVHVgbF2NV3CTW/ZYfbxbqme61IBAgPaVA6Zu+adujagT
        eKXOS5M1insjXzc/Cpi/AghdUUrWnpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-BGnQH7F_PX6ZifZbE81wYg-1; Tue, 28 Apr 2020 18:52:16 -0400
X-MC-Unique: BGnQH7F_PX6ZifZbE81wYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A55451005510;
        Tue, 28 Apr 2020 22:52:14 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0A971001B30;
        Tue, 28 Apr 2020 22:52:13 +0000 (UTC)
Message-ID: <fc7efe6dd23ba1d25c29441fc8132ea2bbf7b5fb.camel@redhat.com>
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
Date:   Tue, 28 Apr 2020 17:52:13 -0500
In-Reply-To: <fa406883f0eace37fe7f658814e29f82a4f0addf.camel@redhat.com>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-4-swood@redhat.com> <jhjees7s29u.mognet@arm.com>
         <fa406883f0eace37fe7f658814e29f82a4f0addf.camel@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 2020-04-28 at 17:33 -0500, Scott Wood wrote:
> On Tue, 2020-04-28 at 22:56 +0100, Valentin Schneider wrote:
> > On 28/04/20 06:02, Scott Wood wrote:
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index dfde7f0ce3db..e7437e4e40b4 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -9394,6 +9400,10 @@ static int should_we_balance(struct lb_env
> > > *env)
> > >       struct sched_group *sg = env->sd->groups;
> > >       int cpu, balance_cpu = -1;
> > > 
> > > +	/* Run the realtime task now; load balance later. */
> > > +	if (rq_has_runnable_rt_task(env->dst_rq))
> > > +		return 0;
> > > +
> > 
> > I have a feeling this isn't very nice to CFS tasks, since we would now
> > "waste" load-balance attempts if they happen to coincide with an RT task
> > being runnable.
> > 
> > On your 72 CPUs machine, the system-wide balance happens (at best) every
> > 72ms if you have idle time, every ~2300ms otherwise (every balance
> > CPU gets to try to balance however, so it's not as horrible as I'm
> > making
> > it sound). This is totally worst-case scenario territory, and you'd hope
> > newidle_balance() could help here and there (as it isn't gated by any
> > balance interval).
> > 
> > Still, even for a single rq, postponing a system-wide balance for a
> > full balance interval (i.e. ~2 secs worst case here) just because we had
> > a
> > single RT task running when we tried to balance seems a bit much.
> > 
> > It may be possible to hack something to detect those cases and reset the
> > interval to "now" when e.g. dequeuing the last RT task (& after having
> > previously aborted a load-balance due to RT/DL/foobar).
> 
> Yeah, some way to retry at an appropriate time after aborting a rebalance
> would be good.

Another option is to limit the bailing out to newidle balancing (as the
patchset currently stands, it isn't checking the right rq for global
balancing anyway).  On RT the softirq runs from thread context, so enabling
interrupts and (on RT) preemption should suffice to avoid latency problems
in the global rebalance.

-Scott


