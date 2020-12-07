Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DEAC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 10:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B1522B3B
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Dec 2020 10:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgLGKX3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Dec 2020 05:23:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32818 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726083AbgLGKX3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Dec 2020 05:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607336523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z29GeURbS80t941pnzdyshdYfYbAY9RA3phQHjsW7+I=;
        b=PN7+oGjARNueep40PSx+GwTVwdfqM5Wz6qydEdr09cMdD0Gr3Xt1qMQkWaaysgZEzJ4y9t
        9F9X2QLPJz6c6qRfQWgsODdqAVl14DYZDXutokAZhqiNtm+5wSmcJ7401M3MBsUY/DnaGp
        EXkxzBu+s47jeH8n2ARk7ZyBT7l0M+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-cMUuWF0qNRmfVZVnlHVCjA-1; Mon, 07 Dec 2020 05:22:01 -0500
X-MC-Unique: cMUuWF0qNRmfVZVnlHVCjA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 205311005504;
        Mon,  7 Dec 2020 10:22:00 +0000 (UTC)
Received: from ovpn-113-92.phx2.redhat.com (ovpn-113-92.phx2.redhat.com [10.3.113.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3798910016FF;
        Mon,  7 Dec 2020 10:21:59 +0000 (UTC)
Message-ID: <c707dab0a1ff71117663e9f1e35879f4345cbca4.camel@redhat.com>
Subject: Re: [PATCH] sched/fair: Don't migrate with src_cpu == dst_cpu
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Mon, 07 Dec 2020 04:21:58 -0600
In-Reply-To: <20201203084723.GG2414@hirez.programming.kicks-ass.net>
References: <20201203060449.3352126-1-swood@redhat.com>
         <20201203084723.GG2414@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-12-03 at 09:47 +0100, Peter Zijlstra wrote:
> On Thu, Dec 03, 2020 at 12:04:49AM -0600, Scott Wood wrote:
> > Besides being a waste of time to try to move tasks to where they already
> > are, this avoids triggering the WARN_ON_ONCE(is_migration_disabled(p))
> > in set_task_cpu().
> > 
> > Signed-off-by: Scott Wood <swood@redhat.com>
> > ---
> > Patch is against tip/master.  Assertion was seen by running rteval on
> > the
> > RT tree.
> > 
> >  kernel/sched/fair.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index e7e21ac479a2..f443626164d4 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7574,7 +7574,8 @@ int can_migrate_task(struct task_struct *p, struct
> > lb_env *env)
> >  
> >  		/* Prevent to re-select dst_cpu via env's CPUs: */
> >  		for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
> > -			if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
> > +			if (cpu != env->src_cpu &&
> > +			    cpumask_test_cpu(cpu, p->cpus_ptr)) {
> >  				env->flags |= LBF_DST_PINNED;
> >  				env->new_dst_cpu = cpu;
> >  				break;
> 
> Do we have _any_ clue as to how we ended up in that situation? The above
> sounds like it should be a WARN and we should avoid getting here in the
> first place.

My initial impression was that there simply wasn't anything stopping it from
happening, but digging deeper it looks like it's specific to NUMA domains
with overlapping CPUs.

-Scott


