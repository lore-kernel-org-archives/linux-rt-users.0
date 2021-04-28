Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1ADC433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB5D61446
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Apr 2021 23:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhD1X3Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 19:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28696 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231874AbhD1X3Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Apr 2021 19:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619652519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sMzyc+7EJPbcNw7it8I/GUe42LK9swyChBaCXViQbq0=;
        b=g/DRUAS978hiWZzymTj4FRwv/YUzJKcj/ijO/IrY0HXlJWrsWEfyq3zL7UmCbvUEqiP6KB
        wbkvtqq7mv8u+hvYkzw5bd5WMsZbFS81f1q/fpoAGh1ALyFrnvMeQcNfi5kxVR+69v53Lz
        9po8zYkkzsls5LVkELmYJyiSyLL34iQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-mDCBhKW-Of-4Qlf4Hz6Mbg-1; Wed, 28 Apr 2021 19:28:36 -0400
X-MC-Unique: mDCBhKW-Of-4Qlf4Hz6Mbg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 174A2100A615;
        Wed, 28 Apr 2021 23:28:35 +0000 (UTC)
Received: from p1g2.redhat.com (ovpn-114-20.rdu2.redhat.com [10.10.114.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3986770580;
        Wed, 28 Apr 2021 23:28:30 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Scott Wood <swood@redhat.com>
Subject: [PATCH v2 2/3] sched/fair: Enable interrupts when dropping lock in newidle_balance()
Date:   Wed, 28 Apr 2021 18:28:20 -0500
Message-Id: <20210428232821.2506201-3-swood@redhat.com>
In-Reply-To: <20210428232821.2506201-1-swood@redhat.com>
References: <20210428232821.2506201-1-swood@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When combined with the next patch, which breaks out of rebalancing
when an RT task is runnable, significant latency reductions are seen
on systems with many CPUs.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 kernel/sched/fair.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff369c38a5b5..aa8c87b6aff8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10521,6 +10521,8 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
 
 	raw_spin_unlock(&this_rq->lock);
+	if (newidle_balance_in_callback)
+		local_irq_enable();
 	/*
 	 * This CPU is going to be idle and blocked load of idle CPUs
 	 * need to be updated. Run the ilb locally as it is a good
@@ -10529,6 +10531,8 @@ static void nohz_newidle_balance(struct rq *this_rq)
 	 */
 	if (!_nohz_idle_balance(this_rq, NOHZ_STATS_KICK, CPU_NEWLY_IDLE))
 		kick_ilb(NOHZ_STATS_KICK);
+	if (newidle_balance_in_callback)
+		local_irq_disable();
 	raw_spin_lock(&this_rq->lock);
 }
 
@@ -10599,6 +10603,8 @@ static int do_newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 
 	raw_spin_unlock(&this_rq->lock);
+	if (newidle_balance_in_callback)
+		local_irq_enable();
 
 	update_blocked_averages(this_cpu);
 	rcu_read_lock();
@@ -10636,6 +10642,8 @@ static int do_newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	}
 	rcu_read_unlock();
 
+	if (newidle_balance_in_callback)
+		local_irq_disable();
 	raw_spin_lock(&this_rq->lock);
 
 	if (curr_cost > this_rq->max_idle_balance_cost)
-- 
2.27.0

