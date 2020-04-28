Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34177C83000
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E1F206D6
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 22:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kf6lgipz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgD1WJy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD1WJy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 18:09:54 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024E0C03C1AC;
        Tue, 28 Apr 2020 15:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i0UfKrqGLok7Kx5f2Cnl5Y270Tvst3mtRJd6yLGqJ7Q=; b=Kf6lgipzK8W4jussQcrLvosJGP
        BWWpUDPQ4c1/fRbFfTLIiMSiRrJv4jMyvhi4dSuZaSXocSoI5VPcjJNMspUEfKsoE/qp6TW7Mb0oY
        OYDJz3lYCZbAlXbeyzfZzVp0R4cR+0SGTMh+PjdxeGg2ntiapu3vswq28kuD2k2QBTFPveLj4wqeu
        wHmpRdvu4caEBo3FIgpvlX0t3HOeTUeEqfszfmJfetg9aNe5fUepdPTsk3+38aRagkH7POjETbWl3
        c2Ca/hPvRG97k4r13U/hBBCDTCsVJQJLvw8FRE7tqOJh0dmBxnwjvUwT+cEt14ezIZnPV3LHLEkQc
        ISDCgZlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTYPo-00040d-Ce; Tue, 28 Apr 2020 22:09:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B45F2301224;
        Wed, 29 Apr 2020 00:09:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 96CB8286C2DCC; Wed, 29 Apr 2020 00:09:17 +0200 (CEST)
Date:   Wed, 29 Apr 2020 00:09:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Scott Wood <swood@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
Message-ID: <20200428220917.GB16027@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
 <20200428050242.17717-2-swood@redhat.com>
 <jhjftcns35d.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjftcns35d.mognet@arm.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Apr 28, 2020 at 10:37:18PM +0100, Valentin Schneider wrote:
> 
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
> > @@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct task_struct *prev)
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

Also, if you move it this late, this is entirely the wrong place. If you
do it after the context switch either use the balance_callback or put it
in the idle path.

But what Valentin said; this needs a fair bit of support, the whole
reason we've never done this is to avoid that double context switch...
