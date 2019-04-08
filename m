Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620BAC10F13
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300792147A
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 15:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDHPaS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:30:18 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53267 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDHPaS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 11:30:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hDWDu-0000pG-Qp; Mon, 08 Apr 2019 17:30:14 +0200
Date:   Mon, 8 Apr 2019 17:30:14 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     Ralf Mardorf <ralf.mardorf@alice-dsl.net>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190408153014.q5hnrz3dwphudeq2@linutronix.de>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
 <20190328115559.275af3c3@archlinux>
 <f5d4ea60-aa23-a294-3850-42f35ca3d76d@manjaro.org>
 <20190328120022.bhwijbp2roizysiw@linutronix.de>
 <82482272-6912-c1d4-4a11-550a962f632c@manjaro.org>
 <1e1974c5-2ad3-98db-d160-577594a471e1@manjaro.org>
 <4ddfde7a-122b-5f18-f41a-b5e967217510@manjaro.org>
 <20190329083400.m4kx4spuvysoszlm@linutronix.de>
 <4f5db7b4-e129-075a-f5f7-81fc0c0a1d82@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f5db7b4-e129-075a-f5f7-81fc0c0a1d82@manjaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-29 09:38:33 [+0100], Bernhard Landauer wrote:
> 
> > How do I reproduce this?
> 
> For me this happens reliably when I launch a fresh instance of ff and it
> automatically tries to restore tabs of the previous session.
> Alternatively, when I select 'Restore Previous Session' from the menu.

Does this help?

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index ca95ab2f4cfa3..8744d20ac1681 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -278,9 +278,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 
 	GEM_BUG_ON(!i915_request_completed(rq));
 
-	local_irq_disable();
-
-	spin_lock(&engine->timeline.lock);
+	spin_lock_irq(&engine->timeline.lock);
 	GEM_BUG_ON(!list_is_first(&rq->link, &engine->timeline.requests));
 	list_del_init(&rq->link);
 	spin_unlock(&engine->timeline.lock);
@@ -294,9 +292,7 @@ static void __retire_engine_request(struct intel_engine_cs *engine,
 		GEM_BUG_ON(!atomic_read(&rq->i915->gt_pm.rps.num_waiters));
 		atomic_dec(&rq->i915->gt_pm.rps.num_waiters);
 	}
-	spin_unlock(&rq->lock);
-
-	local_irq_enable();
+	spin_unlock_irq(&rq->lock);
 
 	/*
 	 * The backing object for the context is done after switching to the

Sebastian
