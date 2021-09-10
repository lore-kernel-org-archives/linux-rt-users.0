Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03652C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 17:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E172A611B0
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 Sep 2021 17:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhIJRCX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhIJRCW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 Sep 2021 13:02:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87155C061574;
        Fri, 10 Sep 2021 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A8E4lu1Is9mJI0mP0sXoEb8y0qwvFdrdnDFXgt9hwsw=; b=Z7M+aN57jYTYTP88/VfZ0QiO+h
        uk9ILF3DUM696Cpa1kopXmgP3ac9pZTYaPG0UfgCL7GAQBcnUEnWVA/R4sb93BVjHRSYIHqkw3ohu
        aEUhFeKaxUk7HnIFY+xyFEsQnQpdkBR1+HJfiRvd7vyyNlRyMXpb30MNkVe2yFO5jQHcUy2panHZ3
        D9mAu/enUfwHpzyr605vEi+jlSJtQNHOafyQvm54N+ifeH02zk4K1asQb8qJ8kfZcsy/I0gGBLKKB
        xFDAqELThwpRigRdrMBGdCHBb+IqcCsIyuZ/GI+lxp0kgRrc22q+8S1b1aYT8mnxvms2lYth4zN6h
        cHJDHEww==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mOjtU-002B3C-Ob; Fri, 10 Sep 2021 17:00:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 349A998627A; Fri, 10 Sep 2021 19:00:51 +0200 (CEST)
Date:   Fri, 10 Sep 2021 19:00:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        achaiken@aurora.tech
Subject: Re: [PATCH v4 0/8] sched: support schedstats for RT sched class
Message-ID: <20210910170051.GL4323@worktop.programming.kicks-ass.net>
References: <20210905143547.4668-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210905143547.4668-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Sep 05, 2021 at 02:35:39PM +0000, Yafang Shao wrote:
> Yafang Shao (8):
>   sched, fair: use __schedstat_set() in set_next_entity()
>   sched: make struct sched_statistics independent of fair sched class
>   sched: make schedstats helpers independent of fair sched class
>   sched: introduce task block time in schedstats
>   sched, rt: support sched_stat_runtime tracepoint for RT sched class
>   sched, rt: support schedstats for RT sched class
>   sched, dl: support sched_stat_runtime tracepoint for deadline sched
>     class
>   sched, dl: support schedstats for deadline sched class
> 
>  include/linux/sched.h    |   8 +-
>  kernel/sched/core.c      |  25 +++---
>  kernel/sched/deadline.c  |  99 +++++++++++++++++++++-
>  kernel/sched/debug.c     |  97 +++++++++++----------
>  kernel/sched/fair.c      | 177 +++++++++++----------------------------
>  kernel/sched/rt.c        | 130 +++++++++++++++++++++++++++-
>  kernel/sched/stats.c     | 104 +++++++++++++++++++++++
>  kernel/sched/stats.h     |  49 +++++++++++
>  kernel/sched/stop_task.c |   4 +-
>  9 files changed, 500 insertions(+), 193 deletions(-)

*sigh*, okay I suppose, let's try this :-)
