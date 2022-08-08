Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D978C00140
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Aug 2022 12:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242889AbiHHM4u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Aug 2022 08:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241944AbiHHM4m (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Aug 2022 08:56:42 -0400
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C87638B8
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Aug 2022 05:56:40 -0700 (PDT)
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
        by mail.infraroot.at (Postfix) with ESMTPSA id D665C416A4;
        Mon,  8 Aug 2022 14:56:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at D665C416A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
        s=default; t=1659963398;
        bh=WBJdTKD5Koj6Sq/5os1AOLuHKL0uDlfVZ7EpKgwzGV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4oa7znbVW9RyaY3yIYmRX8kJqlC45eFQBhdNAYthcBm8oAM+24K42FazqWr3/H/K
         lRXyEo93SZhlxsvleIz+UOoHq8lK0aosvULW/0n8iPgFmaTCl14RPrAAKTVWH9malH
         jqb7NZXYQoUCDM+hY4LOpKoctPepYWGGLEOxZ9Zk=
From:   David Oberhollenzer <goliath@infraroot.at>
To:     linux-rt-users@vger.kernel.org
Cc:     williams@redhat.com, bigeasy@linutronix.de, richard@nod.at,
        joseph.salisbury@canonical.com, Michal Hocko <mhocko@suse.com>,
        David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH v2 06/10] mm/memcg: Disable migration instead of preemption in drain_all_stock().
Date:   Mon,  8 Aug 2022 14:55:58 +0200
Message-Id: <20220808125602.97747-7-goliath@infraroot.at>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125602.97747-1-goliath@infraroot.at>
References: <20220808125602.97747-1-goliath@infraroot.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Before the for-each-CPU loop, preemption is disabled so that so that
drain_local_stock() can be invoked directly instead of scheduling a
worker. Ensuring that drain_local_stock() completed on the local CPU is
not correctness problem. It _could_ be that the charging path will be
forced to reclaim memory because cached charges are still waiting for
their draining.

Disabling preemption before invoking drain_local_stock() is problematic
on PREEMPT_RT due to the sleeping locks involved. To ensure that no CPU
migrations happens across for_each_online_cpu() it is enouhg to use
migrate_disable() which disables migration and keeps context preemptible
to a sleeping lock can be acquired.
A race with CPU hotplug is not a problem because pcp data is not going away.
In the worst case we just schedule draining of an empty stock.

Use migrate_disable() instead of get_cpu() around the
for_each_online_cpu() loop.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Michal Hocko <mhocko@suse.com>
[do: backported to v5.15]
Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 mm/memcontrol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 20bce9682e8a..4b5888bf0a60 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2313,7 +2313,8 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu = get_cpu();
+	migrate_disable();
+	curcpu = smp_processor_id();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2336,7 +2337,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 				schedule_work_on(cpu, &stock->work);
 		}
 	}
-	put_cpu();
+	migrate_enable();
 	mutex_unlock(&percpu_charge_mutex);
 }
 
-- 
2.37.1

