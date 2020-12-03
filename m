Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E839C63777
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 06:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A44DF205ED
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 06:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgLCGGV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 01:06:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29973 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726635AbgLCGGU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 01:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606975494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ghG3uetExCwjAGSJ9dJf6EukQbWFwXvbKJ6Hw65gwok=;
        b=GbINk02BKItJj5FUMfXsSYM0Iii56xrf7z+o2MVwsqMmdW0tEn2AgYN57eLyBg3P7uPuwb
        QHEA30cNUTR2NZjiMKI+T1Zp8gI3smvf5U1MLixfW0s+ISU0FfezHwRWdYpAO0PyNCSEXw
        yFSYoqzpeB0da8l1osAsXB3qWZ92WNw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-DGUKdB5jNSy-a192JYrQUQ-1; Thu, 03 Dec 2020 01:04:52 -0500
X-MC-Unique: DGUKdB5jNSy-a192JYrQUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E154185E489;
        Thu,  3 Dec 2020 06:04:51 +0000 (UTC)
Received: from p1g2.redhat.com (ovpn-113-92.phx2.redhat.com [10.3.113.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0768C5C1B4;
        Thu,  3 Dec 2020 06:04:49 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH] sched/fair: Don't migrate with src_cpu == dst_cpu
Date:   Thu,  3 Dec 2020 00:04:49 -0600
Message-Id: <20201203060449.3352126-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Besides being a waste of time to try to move tasks to where they already
are, this avoids triggering the WARN_ON_ONCE(is_migration_disabled(p))
in set_task_cpu().

Signed-off-by: Scott Wood <swood@redhat.com>
---
Patch is against tip/master.  Assertion was seen by running rteval on the
RT tree.

 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7e21ac479a2..f443626164d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7574,7 +7574,8 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 
 		/* Prevent to re-select dst_cpu via env's CPUs: */
 		for_each_cpu_and(cpu, env->dst_grpmask, env->cpus) {
-			if (cpumask_test_cpu(cpu, p->cpus_ptr)) {
+			if (cpu != env->src_cpu &&
+			    cpumask_test_cpu(cpu, p->cpus_ptr)) {
 				env->flags |= LBF_DST_PINNED;
 				env->new_dst_cpu = cpu;
 				break;
-- 
2.27.0

