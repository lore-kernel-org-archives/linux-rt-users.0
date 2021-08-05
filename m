Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8167C4320A
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF4C261158
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242731AbhHEQAq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 12:00:46 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:48487 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242715AbhHEQAp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 12:00:45 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 54EB4F84AB
        for <linux-rt-users@vger.kernel.org>; Thu,  5 Aug 2021 17:00:30 +0100 (IST)
Received: (qmail 17347 invoked from network); 5 Aug 2021 16:00:30 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPA; 5 Aug 2021 16:00:30 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/1 v2] Protect vmstats on PREEMPT_RT
Date:   Thu,  5 Aug 2021 17:00:18 +0100
Message-Id: <20210805160019.1137-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Changelog since v1
o Remove preempt_[en|dis]able_rt helper

When adding local_lock support to mm/page_alloc.c and reducing the overhead
of vmstats in general, I wondered how vmstats could be safe on PREEMPT_RT
as it partially relies on interrupts being disabled for the stats that
must be accurate for correctness. As it turns out, the preempt-rt tree
already encountered the same problem.

This series protects just the accurate counters. As Thomas expressed
concern that the preempt_enable_rt() helper could be abused, this
version open-codes the preemption with a comment explaining why it
is necessary.

This is specific to PREEMPT_RT which cannot be enabled on mainline yet
and should have no impact on !PREEMPT_RT kernels.

This patch replaces the following mmotm patches

o preempt-provide-preempt__nort-variants.patch
o mm-vmstat-protect-per-cpu-variables-with-preempt-disable-on-rt.patch

-- 
2.31.1

