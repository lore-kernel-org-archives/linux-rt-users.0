Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C704C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 10:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E20C460EB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jul 2021 10:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhGWJ1e (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jul 2021 05:27:34 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:33882 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230008AbhGWJ1e (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jul 2021 05:27:34 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Jul 2021 05:27:33 EDT
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id F087EBEEEB
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jul 2021 11:00:44 +0100 (IST)
Received: (qmail 8804 invoked from network); 23 Jul 2021 10:00:44 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 23 Jul 2021 10:00:44 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/2] Protect vmstats on PREEMPT_RT
Date:   Fri, 23 Jul 2021 11:00:32 +0100
Message-Id: <20210723100034.13353-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When adding local_lock support to mm/page_alloc.c and reducing the overhead
of vmstats in general, I wondered how vmstats could be safe on PREEMPT_RT
as it partially relies on interrupts being disabled for the stats that
must be accurate for correctness. As it turns out, the preempt-rt tree
already encountered the same problem.

This series protects just the primary counters. While there is another
vmstat-related patch, it is related to memcg getting using local_lock and
I have not fully considered those patches and whether they are ok as-is
or need modification but this series makes a start.

Patch 1 is authored by Thomas (cc'd) and has not being altered.

Patch 2 is authored by Ingo (cc'd) but I modified what he implemented
for reasons explained in the changelog.

This is specific to PREEMPT_RT which cannot be enabled on mainline yet
and should have no impact on !PREEMPT_RT kernels.

 include/linux/preempt.h | 18 +++++++++++++++++-
 mm/vmstat.c             | 12 ++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.26.2

