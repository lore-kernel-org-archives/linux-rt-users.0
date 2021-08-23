Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BAFC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A80DC613A6
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 20:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhHWUBI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 16:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhHWUBH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Aug 2021 16:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629748823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/rpPS8476jT+j14HYEnQugw58KjCjolM6XDTGzrL7Q8=;
        b=RtAtCY4WeZAPK5qrsqmqwCcXYWXiZt7GmvxHzzJwJSzDsxyO5xj0Le9nhYvUWmtIWQHOo8
        3iq4ykP+I5QeoNUhaLlHSzzI1KJqizrQH8wwdEDw8uI5XaclwHp/KK6BrxGaoWhpznoE1h
        qjbjG+vbNy0/zhmsN2yNr9E3PTLJJ1s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-8uGg5a33MiyiAxjiEOwLyA-1; Mon, 23 Aug 2021 16:00:20 -0400
X-MC-Unique: 8uGg5a33MiyiAxjiEOwLyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D7C41082923;
        Mon, 23 Aug 2021 20:00:18 +0000 (UTC)
Received: from theseus (unknown [10.22.17.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15FD369CBC;
        Mon, 23 Aug 2021 20:00:16 +0000 (UTC)
Date:   Mon, 23 Aug 2021 15:00:15 -0500
From:   Clark Williams <williams@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH PREEMPT_RT] i915: fix PREEMPT_RT locking splats
Message-ID: <20210823150015.61ebc7d6@theseus>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Found two separate spots where i915 was throwing "sleeping
function called from invalid context" when running on a
PREEMPT_RT kernel. In both cases it was from calling
local_irq_disable prior to taking a spin_lock. Since spin
locks are converted to rt_mutex_t on PREEMPT_RT this means
that we might sleep with interrupts disabled.

Since in both cases the calls were in threaded context on RT
(irq or ksoftirqd) and in no danger of reentrance, change the
code to only disable interrupts on non-PREEMPT_RT kernels.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c          | 6 ++++--
 drivers/gpu/drm/i915/gt/intel_execlists_submission.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
index 38cc42783dfb..b8bf8d6d3c61 100644
--- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
@@ -318,9 +318,11 @@ void __intel_breadcrumbs_park(struct intel_breadcrumbs *b)
 	/* Kick the work once more to drain the signalers, and disarm the irq */
 	irq_work_sync(&b->irq_work);
 	while (READ_ONCE(b->irq_armed) && !atomic_read(&b->active)) {
-		local_irq_disable();
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_disable();
 		signal_irq_work(&b->irq_work);
-		local_irq_enable();
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			local_irq_enable();
 		cond_resched();
 	}
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
index fc77592d88a9..0e918831b69f 100644
--- a/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_execlists_submission.c
@@ -1580,9 +1580,11 @@ static void execlists_dequeue(struct intel_engine_cs *engine)
 
 static void execlists_dequeue_irq(struct intel_engine_cs *engine)
 {
-	local_irq_disable(); /* Suspend interrupts across request submission */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable(); /* Suspend interrupts across request submission */
 	execlists_dequeue(engine);
-	local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable(); /* flush irq_work (e.g. breadcrumb enabling) */
 }
 
 static void clear_ports(struct i915_request **ports, int count)
-- 
2.31.1

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

