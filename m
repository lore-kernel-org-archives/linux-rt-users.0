Return-Path: <SRS0=m88/=7S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA322C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 23:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3C32074B
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Jun 2020 23:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFEXmZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Jun 2020 19:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:57610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728439AbgFEXmY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Jun 2020 19:42:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B894207F7;
        Fri,  5 Jun 2020 23:42:23 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jhLyg-002sCv-JC; Fri, 05 Jun 2020 19:42:22 -0400
Message-ID: <20200605234222.459959297@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 05 Jun 2020 19:41:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Kevin Hao <haokexin@gmail.com>, stable-rt@vger.kernel.org
Subject: [PATCH RT 5/8] mm: slub: Always flush the delayed empty slubs in flush_all()
References: <20200605234149.965509211@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

5.4.44-rt27-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Kevin Hao <haokexin@gmail.com>

After commit f0b231101c94 ("mm/SLUB: delay giving back empty slubs to
IRQ enabled regions"), when the free_slab() is invoked with the IRQ
disabled, the empty slubs are moved to a per-CPU list and will be
freed after IRQ enabled later. But in the current codes, there is
a check to see if there really has the cpu slub on a specific cpu
before flushing the delayed empty slubs, this may cause a reference
of already released kmem_cache in a scenario like below:
	cpu 0				cpu 1
  kmem_cache_destroy()
    flush_all()
                         --->IPI       flush_cpu_slab()
                                         flush_slab()
                                           deactivate_slab()
                                             discard_slab()
                                               free_slab()
                                             c->page = NULL;
      for_each_online_cpu(cpu)
        if (!has_cpu_slab(1, s))
          continue
        this skip to flush the delayed
        empty slub released by cpu1
    kmem_cache_free(kmem_cache, s)

                                       kmalloc()
                                         __slab_alloc()
                                            free_delayed()
                                            __free_slab()
                                            reference to released kmem_cache

Fixes: f0b231101c94 ("mm/SLUB: delay giving back empty slubs to IRQ enabled regions")
Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 mm/slub.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index bea18bbae247..b2809a9ca8f8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2382,9 +2382,6 @@ static void flush_all(struct kmem_cache *s)
 	for_each_online_cpu(cpu) {
 		struct slub_free_list *f;
 
-		if (!has_cpu_slab(cpu, s))
-			continue;
-
 		f = &per_cpu(slub_free_list, cpu);
 		raw_spin_lock_irq(&f->lock);
 		list_splice_init(&f->list, &tofree);
-- 
2.26.2


