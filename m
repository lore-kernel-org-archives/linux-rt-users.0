Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D3C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 07:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6718F246D4
	for <linux-rt-users@archiver.kernel.org>; Thu, 19 Nov 2020 07:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKSHpo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 19 Nov 2020 02:45:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:48674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgKSHpn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 19 Nov 2020 02:45:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11F17AD45;
        Thu, 19 Nov 2020 07:45:42 +0000 (UTC)
Date:   Thu, 19 Nov 2020 07:45:39 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] sched: make schedstats helpers not depend on
 cfs_rq
Message-ID: <20201119074539.GE3306@suse.de>
References: <20201119035230.45330-1-laoar.shao@gmail.com>
 <20201119035230.45330-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201119035230.45330-3-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Nov 19, 2020 at 11:52:28AM +0800, Yafang Shao wrote:
> The 'cfs_rq' in these helpers is only used to get the rq_clock, so we
> can pass the rq_clock directly. After that, these helpers can be used by
> all sched class.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

This introduces overhead in the general case even when schedstats is
disabled. Previously, update_stats_wait_start was a static inline so
function call overhead was avoided and schedstat_enabled() meant the
overhead was negligible. As it's now a function call, the cost of the
function entry/exit will be unconditionally hit regardless of intrest
in schedstat.

Regardless of the merit of adding schedstats for RT, the overhead of
schedstats when stats are disabled should remain the same with the
static branch check done in an inline function.

-- 
Mel Gorman
SUSE Labs
