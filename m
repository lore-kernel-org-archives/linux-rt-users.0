Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E75BC56202
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Nov 2020 11:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2B92076E
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Nov 2020 11:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732974AbgKXLkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Nov 2020 06:40:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:45544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgKXLkr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Nov 2020 06:40:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A9982AC2E;
        Tue, 24 Nov 2020 11:40:45 +0000 (UTC)
Date:   Tue, 24 Nov 2020 11:40:42 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/5] sched: make schedstats helper independent of
 cfs_rq
Message-ID: <20201124114042.GJ3306@suse.de>
References: <20201123125808.50896-1-laoar.shao@gmail.com>
 <20201123125808.50896-4-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201123125808.50896-4-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Nov 23, 2020 at 08:58:06PM +0800, Yafang Shao wrote:
> The 'cfs_rq' in these helpers
> update_stats_{wait_start, wait_end, enqueue_sleeper} is only used to get
> the rq_clock, so we can pass the rq directly. Then these helpers can be
> used by all sched class after being moved into stats.h.
> 
> After that change, the size of vmlinux is increased around 824Bytes.
> 			w/o this patch, with this patch
> Size of vmlinux:	78443832	78444656
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

The inline helpers are quite large. When I was suggesting that the overhead
was minimal, what I expected what that the inline functions would be a
schedstat_enabled() followed by a real function call. It would introduce
a small additional overhead when schedstats are enabled but avoid vmlinux
growing too large

e.g.
 
static inline void
update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
{
	if (!schedstat_enabled())
		return;

	__update_stats_wait_start(cfs_rq, se);
}

where __update_stats_wait_start then lives in kernel/sched/stats.c

-- 
Mel Gorman
SUSE Labs
