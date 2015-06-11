From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: scheduling while atomic on 4.0.4-rt
Date: Thu, 11 Jun 2015 16:21:35 +0200
Message-ID: <20150611142135.GJ16115@linutronix.de>
References: <20150601180529.76806ca5@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Joakim Hernberg <jhernberg@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56829 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbbFKOVg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Jun 2015 10:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20150601180529.76806ca5@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Joakim Hernberg | 2015-06-01 18:05:29 [+0200]:

>Just got this on 4.0.4-rt1.
>
>[74169.672071] BUG: scheduling while atomic: chromium/1566/0x00000002
>[74169.672134] Call Trace:
>[74169.672146]  [<ffffffff8158c6af>] schedule+0x3f/0xd0
>[74169.672148]  [<ffffffff8158dc1d>] rt_spin_lock_slowlock+0xdd/0x290
>[74169.672151]  [<ffffffff8158f749>] rt_spin_lock+0x29/0x30
>[74169.672154]  [<ffffffff81177bdd>] pagevec_lru_move_fn+0x9d/0x120
>[74169.672156]  [<ffffffff81176fb0>] ? ftrace_raw_output_mm_lru_activate+0x70/0x70
>[74169.672158]  [<ffffffff8117873e>] lru_add_drain_cpu+0x12e/0x170
>[74169.672160]  [<ffffffff81192587>] compact_zone+0x537/0x8e0

This should fix it:

diff --git a/include/linux/swap.h b/include/linux/swap.h
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,6 +298,7 @@ extern unsigned long nr_free_pagecache_pages(void);
 
 
 /* linux/mm/swap.c */
+DECLARE_LOCAL_IRQ_LOCK(swapvec_lock);
 extern void lru_cache_add(struct page *);
 extern void lru_cache_add_anon(struct page *page);
 extern void lru_cache_add_file(struct page *page);
diff --git a/mm/compaction.c b/mm/compaction.c
index 8c0d9459b54a..0b670021a977 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1387,10 +1387,12 @@ static int compact_zone(struct zone *zone, struct compact_control *cc)
 				cc->migrate_pfn & ~((1UL << cc->order) - 1);
 
 			if (last_migrated_pfn < current_block_start) {
-				cpu = get_cpu();
+				cpu = get_cpu_light();
+				local_lock_irq(swapvec_lock);
 				lru_add_drain_cpu(cpu);
+				local_unlock_irq(swapvec_lock);
 				drain_local_pages(zone);
-				put_cpu();
+				put_cpu_light();
 				/* No more flushing until we migrate again */
 				last_migrated_pfn = 0;
 			}
diff --git a/mm/swap.c b/mm/swap.c
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -46,7 +46,7 @@ static DEFINE_PER_CPU(struct pagevec, lru_rotate_pvecs);
 static DEFINE_PER_CPU(struct pagevec, lru_deactivate_pvecs);
 
 static DEFINE_LOCAL_IRQ_LOCK(rotate_lock);
-static DEFINE_LOCAL_IRQ_LOCK(swapvec_lock);
+DEFINE_LOCAL_IRQ_LOCK(swapvec_lock);
 
 /*
  * This path almost never happens for VM activity - pages are normally

Sebastian
