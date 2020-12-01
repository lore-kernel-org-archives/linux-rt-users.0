Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A61C64E7B
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 12:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD722084C
	for <linux-rt-users@archiver.kernel.org>; Tue,  1 Dec 2020 12:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730540AbgLAM3F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:29:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47636 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgLAM3F (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 1 Dec 2020 07:29:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1B55FACC1;
        Tue,  1 Dec 2020 12:28:24 +0000 (UTC)
Date:   Tue, 1 Dec 2020 12:28:20 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        qianjun.kernel@gmail.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] sched, fair: use __schedstat_set() in
 set_next_entity()
Message-ID: <20201201122820.GS3306@suse.de>
References: <20201201115416.26515-1-laoar.shao@gmail.com>
 <20201201115416.26515-3-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201201115416.26515-3-laoar.shao@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Dec 01, 2020 at 07:54:12PM +0800, Yafang Shao wrote:
> schedstat_enabled() has been already checked, so we can use
> __schedstat_set() directly.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
