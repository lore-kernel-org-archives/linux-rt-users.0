Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC9EC433C1
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 11:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADC261990
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 11:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhCaLCP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:02:15 -0400
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:49027 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235538AbhCaLBl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 07:01:41 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id EDD5C1C3831
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Mar 2021 12:01:38 +0100 (IST)
Received: (qmail 6962 invoked from network); 31 Mar 2021 11:01:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 Mar 2021 11:01:38 -0000
Date:   Wed, 31 Mar 2021 12:01:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to
 local_lock
Message-ID: <20210331110137.GA3697@techsingularity.net>
References: <20210329120648.19040-1-mgorman@techsingularity.net>
 <20210329120648.19040-3-mgorman@techsingularity.net>
 <877dln640j.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <877dln640j.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 31, 2021 at 11:55:56AM +0200, Thomas Gleixner wrote:
> On Mon, Mar 29 2021 at 13:06, Mel Gorman wrote:
> > There is a lack of clarity of what exactly local_irq_save/local_irq_restore
> > protects in page_alloc.c . It conflates the protection of per-cpu page
> > allocation structures with per-cpu vmstat deltas.
> >
> > This patch protects the PCP structure using local_lock which
> > for most configurations is identical to IRQ enabling/disabling.
> > The scope of the lock is still wider than it should be but this is
> > decreased in later patches. The per-cpu vmstat deltas are protected by
> > preempt_disable/preempt_enable where necessary instead of relying on
> > IRQ disable/enable.
> 
> Yes, this goes into the right direction and I really appreciate the
> scoped protection for clarity sake.
> 

Thanks.

> >  #ifdef CONFIG_MEMORY_HOTREMOVE
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 8a8f1a26b231..01b74ff73549 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -887,6 +887,7 @@ void cpu_vm_stats_fold(int cpu)
> >  
> >  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> >  
> > +		preempt_disable();
> 
> What's the reason for the preempt_disable() here? A comment would be
> appreciated.
> 

Very good question because it's protecting vm_stat_diff and
vm_numa_stat_diff in different contexts and not quite correctly at this
point of the series. By the end of the series vm_numa_stat_diff is a
simple counter and does not need special protection.

Right now, it's protecting against a read and clear of vm_stat_diff
in two contexts -- cpu_vm_stats_fold and drain_zonestats but it's only
defensive. cpu_vm_stats_fold is only called when a CPU is going dead and
drain_zonestats is called from memory hotplug context. The protection is
necessary only if a new drain_zonestats caller was added without taking
the RMW of vm_stat_diff into account which may never happen.

This whole problem with preemption could be avoided altogether if
this_cpu_xchg was used similar to what is done elsewhere in vmstat
so.... this?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 64429ca4957f..9528304ce24d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8969,8 +8969,9 @@ void zone_pcp_reset(struct zone *zone)
 	struct per_cpu_zonestat *pzstats;
 
 	/*
-	 * No race with drain_pages. drain_zonestat disables preemption
-	 * and drain_pages relies on the pcp local_lock.
+	 * No race with drain_pages. drain_zonestat is only concerned with
+	 * vm_*_stat_diff which is updated with this_cpu_xchg and drain_pages
+	 * only cares about the PCP lists protected by local_lock.
 	 */
 	if (zone->per_cpu_pageset != &boot_pageset) {
 		for_each_online_cpu(cpu) {
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 01b74ff73549..34ff61a145d2 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -887,13 +887,11 @@ void cpu_vm_stats_fold(int cpu)
 
 		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 
-		preempt_disable();
 		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 			if (pzstats->vm_stat_diff[i]) {
 				int v;
 
-				v = pzstats->vm_stat_diff[i];
-				pzstats->vm_stat_diff[i] = 0;
+				v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);
 				atomic_long_add(v, &zone->vm_stat[i]);
 				global_zone_diff[i] += v;
 			}
@@ -903,13 +901,11 @@ void cpu_vm_stats_fold(int cpu)
 			if (pzstats->vm_numa_stat_diff[i]) {
 				int v;
 
-				v = pzstats->vm_numa_stat_diff[i];
-				pzstats->vm_numa_stat_diff[i] = 0;
+				v = this_cpu_xchg(pzstats->vm_numa_stat_diff[i], 0);
 				atomic_long_add(v, &zone->vm_numa_stat[i]);
 				global_numa_diff[i] += v;
 			}
 #endif
-		preempt_enable();
 	}
 
 	for_each_online_pgdat(pgdat) {
@@ -943,10 +939,9 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 {
 	int i;
 
-	preempt_disable();
 	for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
 		if (pzstats->vm_stat_diff[i]) {
-			int v = pzstats->vm_stat_diff[i];
+			int v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);
 			pzstats->vm_stat_diff[i] = 0;
 			atomic_long_add(v, &zone->vm_stat[i]);
 			atomic_long_add(v, &vm_zone_stat[i]);
@@ -955,14 +950,12 @@ void drain_zonestat(struct zone *zone, struct per_cpu_zonestat *pzstats)
 #ifdef CONFIG_NUMA
 	for (i = 0; i < NR_VM_NUMA_STAT_ITEMS; i++)
 		if (pzstats->vm_numa_stat_diff[i]) {
-			int v = pzstats->vm_numa_stat_diff[i];
+			int v = this_cpu_xchg(pzstats->vm_numa_stat_diff[i], 0);
 
-			pzstats->vm_numa_stat_diff[i] = 0;
 			atomic_long_add(v, &zone->vm_numa_stat[i]);
 			atomic_long_add(v, &vm_numa_stat[i]);
 		}
 #endif
-	preempt_enable();
 }
 #endif
 
 
-- 
Mel Gorman
SUSE Labs
