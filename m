Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD59CCA481
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Jul 2022 11:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbiGLLqQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiGLLqN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Jul 2022 07:46:13 -0400
Received: from mail.infraroot.at (mail.infraroot.at [IPv6:2001:41d0:701:1100::afc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD382B197F
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Jul 2022 04:46:10 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id DA1F9409FD;
        Tue, 12 Jul 2022 13:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at DA1F9409FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1657624968;
        bh=E9i38R1wm0EM8ywtxezt7+nBR0GmxMlEPh/7Wks4NTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ottv+2dge/7N/OV3xX7uJ8ytaNlCQSuOJ1/GZBT3kNdZ+8ucbKs7ci24ZE7GC1l2A
         26jLZDsOFJRFiwhx5hz1QOqxGd1s5R3jobsjuwZaNR8Nz9iDNCKjTPpGFbrthfgpRE
         zCf79rq41egyKymd1ONDd+76OFsliq3cHl84eN/g=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH 2/4] mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT where needed.
Date:   Tue, 12 Jul 2022 13:22:36 +0200
Message-Id: <20220712112238.18824-3-goliath@infraroot.at>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712112238.18824-1-goliath@infraroot.at>
References: <20220712112238.18824-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The per-CPU counter are modified with the non-atomic modifier. The
consistency is ensured by disabling interrupts for the update.
On non PREEMPT_RT configuration this works because acquiring a
spinlock_t typed lock with the _irq() suffix disables interrupts. On
PREEMPT_RT configurations the RMW operation can be interrupted.

Another problem is that mem_cgroup_swapout() expects to be invoked with
disabled interrupts because the caller has to acquire a spinlock_t which
is acquired with disabled interrupts. Since spinlock_t never disables
interrupts on PREEMPT_RT the interrupts are never disabled at this
point.

The code is never called from in_irq() context on PREEMPT_RT therefore
disabling preemption during the update is sufficient on PREEMPT_RT.
The sections which explicitly disable interrupts can remain on
PREEMPT_RT because the sections remain short and they don't involve
sleeping locks (memcg_check_events() is doing nothing on PREEMPT_RT).

Disable preemption during update of the per-CPU variables which do not
explicitly disable interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 31fcc702ca33..c2e1aed2e1fb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -683,6 +683,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 
@@ -690,6 +692,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
 	memcg_rstat_updated(memcg, val);
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
 
 /**
@@ -790,8 +794,12 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
+	if (IS_ENABLED(PREEMPT_RT))
+		preempt_disable();
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg, count);
+	if (IS_ENABLED(PREEMPT_RT))
+		preempt_enable();
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -7243,9 +7251,18 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * i_pages lock which is taken with interrupts-off. It is
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
+	 * On PREEMPT_RT interrupts are never disabled and the updates to per-CPU
+	 * variables are synchronised by keeping preemption disabled.
 	 */
-	VM_BUG_ON(!irqs_disabled());
-	mem_cgroup_charge_statistics(memcg, page, -nr_entries);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		VM_BUG_ON(!irqs_disabled());
+		mem_cgroup_charge_statistics(memcg, page, -nr_entries);
+	} else {
+		preempt_disable();
+		mem_cgroup_charge_statistics(memcg, page, -nr_entries);
+		preempt_enable();
+	}
+
 	memcg_check_events(memcg, page_to_nid(page));
 
 	css_put(&memcg->css);
-- 
2.36.1

