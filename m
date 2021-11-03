Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0143FC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF00C61076
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 17:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhKCRIJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Nov 2021 13:08:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233112AbhKCRIH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Nov 2021 13:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635959130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5+bpUJMaMqU4MgQRu2MTHVpkguUbctBrwUfDWUc8b78=;
        b=ZW6f2yXhevfJFUe0rMjvxhRg2aQ2ygNcmVEoy1cuDgYAHvON5gtIvZ8oDc6ClhBdQSEH4+
        ALV4LDuMa0knxJ7XB2gvgvT5S7RhzbzC1wC8CSHQTuSHEmRoCEYjswGF9rz9Db/nU9e+SW
        uAE3i3aniOXLlYK8SpCbrWHZIaq5EeA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-U7ipp-PFNbmdQAqqfhDDKQ-1; Wed, 03 Nov 2021 13:05:28 -0400
X-MC-Unique: U7ipp-PFNbmdQAqqfhDDKQ-1
Received: by mail-wm1-f69.google.com with SMTP id a18-20020a1cf012000000b0032ca3eb2ac3so1392075wmb.0
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Nov 2021 10:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+bpUJMaMqU4MgQRu2MTHVpkguUbctBrwUfDWUc8b78=;
        b=jeEDrzRcF6/JDusiQyOcR6/WBKXTEVa6qqH4qdmt50prZDJYtvaNqBq4b75/TJO9+z
         pJtTUBF6Xwa+vfVMuZ2tPZYoUkl9zNN6jkx1HNkjdlX3IkHhfpkYQ6cVnVgYKjxY554b
         GEjlxPim1ZFFU9kKn576T6URdOCsxSqEKnXHpe77NFA+EFioQcUPiSOh9L9+XRKAykkx
         g8R2sNh+R0oL0ZL/EzMzoxS1mrTZ1tWQeHjvaYDsBtYfyu0RFaPPnQUmD07vEeW9IjdS
         Q0YHrRxqW50W2aqKYnGC9xxYo5c9F8xdx+a2iMlNKBoe3MI57Xpe3dHrn6Owlik8qg5b
         FaoA==
X-Gm-Message-State: AOAM530fEX79Moa+NDFsdmzLEGXrBQqZTnDHzj8vcPhNWmIhNH/QJ8CB
        aTKXZkuF1bsUU0u/HThFxv/GyfHNJmFvYepvswyCaQ/quOp4FoqcLMCVTRy9wGuc1wXrWK8ngCw
        hgd+rQPdFelFWPtUN0IRWBxCLZAY=
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr57138406wrg.339.1635959121851;
        Wed, 03 Nov 2021 10:05:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymt56oD7xssX0KLrDRxqFfhgxvPTvsPtL5aMyYaSGk8fSIesEVDxu69NGKhno90RaTMwzFJQ==
X-Received: by 2002:adf:ba0d:: with SMTP id o13mr57138368wrg.339.1635959121636;
        Wed, 03 Nov 2021 10:05:21 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id h22sm2900610wmq.14.2021.11.03.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 10:05:21 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        ppandit@redhat.com, Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH v2 3/3] mm/page_alloc: Remotely drain per-cpu lists
Date:   Wed,  3 Nov 2021 18:05:12 +0100
Message-Id: <20211103170512.2745765-4-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211103170512.2745765-1-nsaenzju@redhat.com>
References: <20211103170512.2745765-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
drain work queued by __drain_all_pages(). So introduce new a mechanism
to remotely drain the per-cpu lists. It is made possible by remotely
locking 'struct per_cpu_pages' new per-cpu spinlocks. A benefit of this
new scheme is that drain operations are now migration safe.

There was no observed performance degradation vs. the previous scheme.
Both netperf and hackbench were run in parallel to triggering the
__drain_all_pages(NULL, true) code path around ~100 times per second.
The new scheme performs a bit better (~5%), although the important point
here is there are no performance regressions vs. the previous mechanism.
Per-cpu lists draining happens only in slow paths.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/page_alloc.c | 59 +++++--------------------------------------------
 1 file changed, 5 insertions(+), 54 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b332d5cc40f1..7dbdab100461 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -140,13 +140,7 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
 EXPORT_PER_CPU_SYMBOL(_numa_mem_);
 #endif
 
-/* work_structs for global per-cpu drains */
-struct pcpu_drain {
-	struct zone *zone;
-	struct work_struct work;
-};
 static DEFINE_MUTEX(pcpu_drain_mutex);
-static DEFINE_PER_CPU(struct pcpu_drain, pcpu_drain);
 
 #ifdef CONFIG_GCC_PLUGIN_LATENT_ENTROPY
 volatile unsigned long latent_entropy __latent_entropy;
@@ -3050,9 +3044,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
  * Called from the vmstat counter updater to drain pagesets of this
  * currently executing processor on remote nodes after they have
  * expired.
- *
- * Note that this function must be called with the thread pinned to
- * a single processor.
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
@@ -3070,10 +3061,6 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 
 /*
  * Drain pcplists of the indicated processor and zone.
- *
- * The processor must either be the current processor and the
- * thread pinned to the current processor or a processor that
- * is not online.
  */
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
@@ -3089,10 +3076,6 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 
 /*
  * Drain pcplists of all zones on the indicated processor.
- *
- * The processor must either be the current processor and the
- * thread pinned to the current processor or a processor that
- * is not online.
  */
 static void drain_pages(unsigned int cpu)
 {
@@ -3105,9 +3088,6 @@ static void drain_pages(unsigned int cpu)
 
 /*
  * Spill all of this CPU's per-cpu pages back into the buddy allocator.
- *
- * The CPU has to be pinned. When zone parameter is non-NULL, spill just
- * the single zone's pages.
  */
 void drain_local_pages(struct zone *zone)
 {
@@ -3119,24 +3099,6 @@ void drain_local_pages(struct zone *zone)
 		drain_pages(cpu);
 }
 
-static void drain_local_pages_wq(struct work_struct *work)
-{
-	struct pcpu_drain *drain;
-
-	drain = container_of(work, struct pcpu_drain, work);
-
-	/*
-	 * drain_all_pages doesn't use proper cpu hotplug protection so
-	 * we can race with cpu offline when the WQ can move this from
-	 * a cpu pinned worker to an unbound one. We can operate on a different
-	 * cpu which is alright but we also have to make sure to not move to
-	 * a different one.
-	 */
-	migrate_disable();
-	drain_local_pages(drain->zone);
-	migrate_enable();
-}
-
 /*
  * The implementation of drain_all_pages(), exposing an extra parameter to
  * drain on all cpus.
@@ -3157,13 +3119,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	 */
 	static cpumask_t cpus_with_pcps;
 
-	/*
-	 * Make sure nobody triggers this path before mm_percpu_wq is fully
-	 * initialized.
-	 */
-	if (WARN_ON_ONCE(!mm_percpu_wq))
-		return;
-
 	/*
 	 * Do not drain if one is already in progress unless it's specific to
 	 * a zone. Such callers are primarily CMA and memory hotplug and need
@@ -3213,14 +3168,12 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 	}
 
 	for_each_cpu(cpu, &cpus_with_pcps) {
-		struct pcpu_drain *drain = per_cpu_ptr(&pcpu_drain, cpu);
-
-		drain->zone = zone;
-		INIT_WORK(&drain->work, drain_local_pages_wq);
-		queue_work_on(cpu, mm_percpu_wq, &drain->work);
+		if (zone) {
+			drain_pages_zone(cpu, zone);
+		} else {
+			drain_pages(cpu);
+		}
 	}
-	for_each_cpu(cpu, &cpus_with_pcps)
-		flush_work(&per_cpu_ptr(&pcpu_drain, cpu)->work);
 
 	mutex_unlock(&pcpu_drain_mutex);
 }
@@ -3229,8 +3182,6 @@ static void __drain_all_pages(struct zone *zone, bool force_all_cpus)
  * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
  *
  * When zone parameter is non-NULL, spill just the single zone's pages.
- *
- * Note that this can be extremely slow as the draining happens in a workqueue.
  */
 void drain_all_pages(struct zone *zone)
 {
-- 
2.33.1

