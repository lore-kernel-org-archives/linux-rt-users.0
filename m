Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF209C433E4
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47492071A
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 16:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1VfGc7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732366AbgFPQPX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:15:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731962AbgFPQPU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 12:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592324119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=XJLuoghI/fMLU/t56qjzSXs0nL3rf9/yjTX5onCIa7Y=;
        b=D1VfGc7pnBpLXgEQzIvXTqz1FYdzzd9eXQiu6LLf7viSzSi2cp0SUfPixLQ+HTpANCi6y7
        /WF8jNf6CKo/s6VsTQSN8f/gMCTSQcIzMxe2yQrmwJooQXW6FUzp8+f44vCJD5+I1AViw8
        SWrfYD+8PPwCHfssyvVfrsn+2tJnTQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-AoQLSxlRO8eNYcbZLsy38A-1; Tue, 16 Jun 2020 12:15:17 -0400
X-MC-Unique: AoQLSxlRO8eNYcbZLsy38A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13A6A835BA7;
        Tue, 16 Jun 2020 16:15:16 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-9.gru2.redhat.com [10.97.112.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EB7BB5C1BD;
        Tue, 16 Jun 2020 16:15:12 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BBA11412EF4A; Tue, 16 Jun 2020 13:14:49 -0300 (-03)
Message-ID: <20200616161409.299575008@fuller.cnet>
User-Agent: quilt/0.66
Date:   Tue, 16 Jun 2020 13:11:51 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 2/2] mm: page_alloc: drain pages remotely
References: <20200616161149.392213902@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remote draining of pages was removed from 5.6-rt.

Unfortunately its necessary for use-cases which have a busy spinning 
SCHED_FIFO thread on isolated CPU:

[ 7475.821066] INFO: task ld:274531 blocked for more than 600 seconds.
[ 7475.822157]       Not tainted 4.18.0-208.rt5.20.el8.x86_64 #1
[ 7475.823094] echo 0  /proc/sys/kernel/hung_task_timeout_secs disables this message.
[ 7475.824392] ld              D    0 274531 274530 0x00084080
[ 7475.825307] Call Trace:
[ 7475.825761]  __schedule+0x342/0x850
[ 7475.826377]  schedule+0x39/0xd0
[ 7475.826923]  schedule_timeout+0x20e/0x410
[ 7475.827610]  ? __schedule+0x34a/0x850
[ 7475.828247]  ? ___preempt_schedule+0x16/0x18
[ 7475.828953]  wait_for_completion+0x85/0xe0
[ 7475.829653]  flush_work+0x11a/0x1c0
[ 7475.830313]  ? flush_workqueue_prep_pwqs+0x130/0x130
[ 7475.831148]  drain_all_pages+0x140/0x190
[ 7475.831803]  __alloc_pages_slowpath+0x3f8/0xe20
[ 7475.832571]  ? mem_cgroup_commit_charge+0xcb/0x510
[ 7475.833371]  __alloc_pages_nodemask+0x1ca/0x2b0
[ 7475.834134]  pagecache_get_page+0xb5/0x2d0
[ 7475.834814]  ? account_page_dirtied+0x11a/0x220
[ 7475.835579]  grab_cache_page_write_begin+0x1f/0x40
[ 7475.836379]  iomap_write_begin.constprop.44+0x1c1/0x370
[ 7475.837241]  ? iomap_write_end+0x91/0x290
[ 7475.837911]  iomap_write_actor+0x92/0x170
...

So enable remote draining again.

The original commit message is:

    mm: page_alloc: rt-friendly per-cpu pages
    
    rt-friendly per-cpu pages: convert the irqs-off per-cpu locking
    method into a preemptible, explicit-per-cpu-locks method.
    
    Contains fixes from:
             Peter Zijlstra <a.p.zijlstra@chello.nl>
             Thomas Gleixner <tglx@linutronix.de>

From: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 mm/page_alloc.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: linux-rt-devel/mm/page_alloc.c
===================================================================
--- linux-rt-devel.orig/mm/page_alloc.c
+++ linux-rt-devel/mm/page_alloc.c
@@ -360,6 +360,16 @@ EXPORT_SYMBOL(nr_online_nodes);
 
 static DEFINE_LOCAL_IRQ_LOCK(pa_lock);
 
+#ifdef CONFIG_PREEMPT_RT
+# define cpu_lock_irqsave(cpu, flags)          \
+	local_lock_irqsave_on(pa_lock, flags, cpu)
+# define cpu_unlock_irqrestore(cpu, flags)     \
+	local_unlock_irqrestore_on(pa_lock, flags, cpu)
+#else
+# define cpu_lock_irqsave(cpu, flags)		local_irq_save(flags)
+# define cpu_unlock_irqrestore(cpu, flags)	local_irq_restore(flags)
+#endif
+
 int page_group_by_mobility_disabled __read_mostly;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -2852,7 +2862,7 @@ static void drain_pages_zone(unsigned in
 	LIST_HEAD(dst);
 	int count;
 
-	local_lock_irqsave(pa_lock, flags);
+	cpu_lock_irqsave(cpu, flags);
 	pset = per_cpu_ptr(zone->pageset, cpu);
 
 	pcp = &pset->pcp;
@@ -2860,7 +2870,7 @@ static void drain_pages_zone(unsigned in
 	if (count)
 		isolate_pcp_pages(count, pcp, &dst);
 
-	local_unlock_irqrestore(pa_lock, flags);
+	cpu_unlock_irqrestore(cpu, flags);
 
 	if (count)
 		free_pcppages_bulk(zone, &dst, false);
@@ -2898,6 +2908,7 @@ void drain_local_pages(struct zone *zone
 		drain_pages(cpu);
 }
 
+#ifndef CONFIG_PREEMPT_RT
 static void drain_local_pages_wq(struct work_struct *work)
 {
 	struct pcpu_drain *drain;
@@ -2915,6 +2926,7 @@ static void drain_local_pages_wq(struct
 	drain_local_pages(drain->zone);
 	migrate_enable();
 }
+#endif
 
 /*
  * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
@@ -2982,6 +2994,7 @@ void drain_all_pages(struct zone *zone)
 			cpumask_clear_cpu(cpu, &cpus_with_pcps);
 	}
 
+#ifndef CONFIG_PREEMPT_RT
 	for_each_cpu(cpu, &cpus_with_pcps) {
 		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
 
@@ -2991,6 +3004,10 @@ void drain_all_pages(struct zone *zone)
 	}
 	for_each_cpu(cpu, &cpus_with_pcps)
 		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
+#else
+	for_each_cpu(cpu, &cpus_with_pcps)
+		drain_pages(cpu);
+#endif
 
 	mutex_unlock(&pcpu_drain_mutex);
 }


