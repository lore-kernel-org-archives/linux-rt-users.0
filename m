Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A173AC433C1
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7356B61934
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Mar 2021 12:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhC2MMb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Mar 2021 08:12:31 -0400
Received: from outbound-smtp10.blacknight.com ([46.22.139.15]:48267 "EHLO
        outbound-smtp10.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231708AbhC2MMF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Mar 2021 08:12:05 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Mar 2021 08:12:04 EDT
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp10.blacknight.com (Postfix) with ESMTPS id 3D4301C2F2D
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Mar 2021 13:06:59 +0100 (IST)
Received: (qmail 17289 invoked from network); 29 Mar 2021 12:06:59 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 29 Mar 2021 12:06:59 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 0/6] Use local_lock for pcp protection and reduce stat overhead
Date:   Mon, 29 Mar 2021 13:06:42 +0100
Message-Id: <20210329120648.19040-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This series requires patches in Andrew's tree so the series is also
available at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v1r15

tldr: Jesper and Chuck, it would be nice to verify if this series helps
	the allocation rate of the bulk page allocator. RT people, this
	*partially* addresses some problems PREEMPT_RT has with the page
	allocator but it needs review.

The PCP (per-cpu page allocator in page_alloc.c) share locking requirements
with vmstat which is inconvenient and causes some issues. Possibly because
of that, the PCP list and vmstat share the same per-cpu space meaning that
it's possible that vmstat updates dirty cache lines holding per-cpu lists
across CPUs unless padding is used. The series splits that structure and
separates the locking.

Second, PREEMPT_RT considers the following sequence to be unsafe
as documented in Documentation/locking/locktypes.rst

   local_irq_disable();
   spin_lock(&lock);

The pcp allocator has this sequence for rmqueue_pcplist (local_irq_save)
-> __rmqueue_pcplist -> rmqueue_bulk (spin_lock). This series explicitly
separates the locking requirements for the PCP list (local_lock) and stat
updates (irqs disabled). Once that is done, the length of time IRQs are
disabled can be reduced and in some cases, IRQ disabling can be replaced
with preempt_disable.

After that, it was very obvious that zone_statistics in particular has way
too much overhead and leaves IRQs disabled for longer than necessary. It
has perfectly accurate counters requiring IRQs be disabled for parallel
RMW sequences when inaccurate ones like vm_events would do. The series
makes the NUMA statistics (NUMA_HIT and friends) inaccurate counters that
only require preempt be disabled.

Finally the bulk page allocator can then do all the stat updates in bulk
with IRQs enabled which should improve the efficiency of the bulk page
allocator. Technically, this could have been done without the local_lock
and vmstat conversion work and the order simply reflects the timing of
when different series were implemented.

No performance data is included because despite the overhead of the
stats, it's within the noise for most workloads but Jesper and Chuck may
observe a significant different with the same tests used for the bulk
page allocator. The series is more likely to be interesting to the RT
folk in terms of slowing getting the PREEMPT tree into mainline.

 drivers/base/node.c    |  18 +--
 include/linux/mmzone.h |  29 +++--
 include/linux/vmstat.h |  65 ++++++-----
 mm/mempolicy.c         |   2 +-
 mm/page_alloc.c        | 173 ++++++++++++++++------------
 mm/vmstat.c            | 254 +++++++++++++++--------------------------
 6 files changed, 254 insertions(+), 287 deletions(-)

-- 
2.26.2

