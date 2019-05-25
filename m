Return-Path: <SRS0=dorw=TZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E00C282E1
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D237221871
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 May 2019 03:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfEYDdS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 May 2019 23:33:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbfEYDdR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 May 2019 23:33:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBFFF2184E;
        Sat, 25 May 2019 03:33:16 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hUNQp-0002Go-Sp; Fri, 24 May 2019 23:33:16 -0400
Message-Id: <20190525033315.775106086@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 24 May 2019 23:32:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com
Subject: [PATCH RT 4/6] drm/i915: Dont disable interrupts independently of the lock
References: <20190525033232.795741612@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.37-rt20-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The locks (timeline->lock and rq->lock) need to be taken with disabled
interrupts. This is done in __retire_engine_request() by disabling the
interrupts independently of the locks itself.
While local_irq_disable()+spin_lock() equals spin_lock_irq() on vanilla
it does not on RT. Also, it is not obvious if there is a special reason
to why the interrupts are disabled independently of the lock.

Enable/disable interrupts as part of the locking instruction.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/gpu/drm/i915/i915_request.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index 5c2c93cbab12..7124510b9131 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -356,9 +356,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 
 	GEM_BUG_ON(!i915_request_completed(rq));
 
-	local_irq_disable();
-
-	spin_lock(&engine->timeline.lock);
+	spin_lock_irq(&engine->timeline.lock);
 	GEM_BUG_ON(!list_is_first(&rq->link, &engine->timeline.requests));
 	list_del_init(&rq->link);
 	spin_unlock(&engine->timeline.lock);
@@ -372,9 +370,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 		GEM_BUG_ON(!atomic_read(&rq->i915->gt_pm.rps.num_waiters));
 		atomic_dec(&rq->i915->gt_pm.rps.num_waiters);
 	}
-	spin_unlock(&rq->lock);
-
-	local_irq_enable();
+	spin_unlock_irq(&rq->lock);
 
 	/*
 	 * The backing object for the context is done after switching to the
-- 
2.20.1


