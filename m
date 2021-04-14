Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A169EC43616
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA9611AD
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Apr 2021 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351434AbhDNNkF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Apr 2021 09:40:05 -0400
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:48965 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351423AbhDNNkE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Apr 2021 09:40:04 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 2D6AA37A93C
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Apr 2021 14:39:42 +0100 (IST)
Received: (qmail 27216 invoked from network); 14 Apr 2021 13:39:42 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 14 Apr 2021 13:39:41 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 0/11 v3] Use local_lock for pcp protection and reduce stat overhead
Date:   Wed, 14 Apr 2021 14:39:20 +0100
Message-Id: <20210414133931.4555-1-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Changelog since v2
o Fix zonestats initialisation
o Merged memory hotplug fix separately
o Embed local_lock within per_cpu_pages

This series requires patches in Andrew's tree so for convenience, it's
also available at

git://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git mm-percpu-local_lock-v3r6

The PCP (per-cpu page allocator in page_alloc.c) shares locking
requirements with vmstat and the zone lock which is inconvenient and
causes some issues. For example, the PCP list and vmstat share the
same per-cpu space meaning that it's possible that vmstat updates dirty
cache lines holding per-cpu lists across CPUs unless padding is used.
Second, PREEMPT_RT does not want to disable IRQs for too long in the
page allocator.

This series splits the locking requirements and uses locks types more
suitable for PREEMPT_RT, reduces the time when special locking is required
for stats and reduces the time when IRQs need to be disabled on !PREEMPT_RT
kernels.

Why local_lock? PREEMPT_RT considers the following sequence to be unsafe
as documented in Documentation/locking/locktypes.rst

   local_irq_disable();
   spin_lock(&lock);

The pcp allocator has this sequence for rmqueue_pcplist (local_irq_save)
-> __rmqueue_pcplist -> rmqueue_bulk (spin_lock). While it's possible to
separate this out, it generally means there are points where we enable
IRQs and reenable them again immediately. To prevent a migration and the
per-cpu pointer going stale, migrate_disable is also needed. That is a
custom lock that is similar, but worse, than local_lock. Furthermore,
on PREEMPT_RT, it's undesirable to leave IRQs disabled for too long.
By converting to local_lock which disables migration on PREEMPT_RT, the
locking requirements can be separated and start moving the protections
for PCP, stats and the zone lock to PREEMPT_RT-safe equivalent locking. As
a bonus, local_lock also means that PROVE_LOCKING does something useful.

After that, it's obvious that zone_statistics incurs too much overhead
and leaves IRQs disabled for longer than necessary on !PREEMPT_RT
kernels. zone_statistics uses perfectly accurate counters requiring IRQs
be disabled for parallel RMW sequences when inaccurate ones like vm_events
would do. The series makes the NUMA statistics (NUMA_HIT and friends)
inaccurate counters that then require no special protection on !PREEMPT_RT.

The bulk page allocator can then do stat updates in bulk with IRQs enabled
which should improve the efficiency.  Technically, this could have been
done without the local_lock and vmstat conversion work and the order
simply reflects the timing of when different series were implemented.

Finally, there are places where we conflate IRQs being disabled for the
PCP with the IRQ-safe zone spinlock. The remainder of the series reduces
the scope of what is protected by disabled IRQs on !PREEMPT_RT kernels.
By the end of the series, page_alloc.c does not call local_irq_save so
the locking scope is a bit clearer. The one exception is that modifying
NR_FREE_PAGES still happens in places where it's known the IRQs are
disabled as it's harmless for PREEMPT_RT and would be expensive to split
the locking there.

No performance data is included because despite the overhead of the stats,
it's within the noise for most workloads on !PREEMPT_RT. However, Jesper
Dangaard Brouer ran a page allocation microbenchmark on a E5-1650 v4 @
3.60GHz CPU on the first version of this series. Focusing on the array
variant of the bulk page allocator reveals the following.

(CPU: Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz)
ARRAY variant: time_bulk_page_alloc_free_array: step=bulk size

         Baseline        Patched
 1       56.383          54.225 (+3.83%)
 2       40.047          35.492 (+11.38%)
 3       37.339          32.643 (+12.58%)
 4       35.578          30.992 (+12.89%)
 8       33.592          29.606 (+11.87%)
 16      32.362          28.532 (+11.85%)
 32      31.476          27.728 (+11.91%)
 64      30.633          27.252 (+11.04%)
 128     30.596          27.090 (+11.46%)

While this is a positive outcome, the series is more likely to be
interesting to the RT people in terms of getting parts of the PREEMPT_RT
tree into mainline.

 drivers/base/node.c    |  18 +--
 include/linux/mmzone.h |  58 ++++++--
 include/linux/vmstat.h |  65 +++++----
 mm/mempolicy.c         |   2 +-
 mm/page_alloc.c        | 302 +++++++++++++++++++++++++----------------
 mm/vmstat.c            | 250 ++++++++++++----------------------
 6 files changed, 370 insertions(+), 325 deletions(-)

-- 
2.26.2

Mel Gorman (11):
  mm/page_alloc: Split per cpu page lists and zone stats
  mm/page_alloc: Convert per-cpu list protection to local_lock
  mm/vmstat: Convert NUMA statistics to basic NUMA counters
  mm/vmstat: Inline NUMA event counter updates
  mm/page_alloc: Batch the accounting updates in the bulk allocator
  mm/page_alloc: Reduce duration that IRQs are disabled for VM counters
  mm/page_alloc: Remove duplicate checks if migratetype should be
    isolated
  mm/page_alloc: Explicitly acquire the zone lock in __free_pages_ok
  mm/page_alloc: Avoid conflating IRQs disabled with zone->lock
  mm/page_alloc: Update PGFREE outside the zone lock in __free_pages_ok
  mm/page_alloc: Embed per_cpu_pages locking within the per-cpu
    structure

 drivers/base/node.c    |  18 +--
 include/linux/mmzone.h |  58 ++++++--
 include/linux/vmstat.h |  65 +++++----
 mm/mempolicy.c         |   2 +-
 mm/page_alloc.c        | 302 +++++++++++++++++++++++++----------------
 mm/vmstat.c            | 250 ++++++++++++----------------------
 6 files changed, 370 insertions(+), 325 deletions(-)

-- 
2.26.2

