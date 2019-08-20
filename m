Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9186C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95D206DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxqCDeCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbfHTAdb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:33:31 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46934 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfHTAdb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 20:33:31 -0400
Received: by mail-yb1-f195.google.com with SMTP id x10so1253110ybs.13;
        Mon, 19 Aug 2019 17:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8xujnXPvByvO77xUkBnJzhQKwD/i/4jy5/YnqYkj3w=;
        b=bxqCDeCzUlSvA5GV+SnyfLf66N1QAGVzFlnRNU43Xtwv5yTj6/lyImJVyQ2Ux+aj1K
         +hllzNuiUfP38anrW1dkhTeWI6M9tZrwDqYQfHoRDVeUgEyVJP/WIKHFUhCU6RKCMsRT
         q4ItbNq7DTtwoRDcmua+SzHJivpxHzw7bghj62V2Qzi4vFZRSjK49XBE84/j2oBIWQhX
         ZAV3qyMIVAfZZwD7LUBPIWnji82wBVPiu10JxqdeOw/Yc+zedceHL8MpVTQfqUNMYrHE
         N1ZavKr8EhPKjc6GRo2F8YBuK3jY/XD5tAAhGFPoc4GdmFuDyfVFhdKuUx8OdFdEwFvE
         4sAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8xujnXPvByvO77xUkBnJzhQKwD/i/4jy5/YnqYkj3w=;
        b=MWsNOkCiXueK5S7p4HTMUUlcePfgxoH0UyY/Huu6bGG9TDCWyoBtPNPcnNLk8S6kAH
         0AVqsscDm0nOJQrYlpgaZgpZVM7fbrkEyNLdhm0fvXBfaeZ35bfC8BVDUFDLVITBA6Iz
         BOu9/rUPJ36hhdyDM/XEwHjTzeCDuaRcd932PvNfyT5CWOI85AEPFP7428saTTy3jURd
         SymJrz53HAvEte3tU9sPwfT/yb2TSVLOygAIrJxFWycYyMuPE6lV23fD1SkynbN8Ukvs
         ztoVsUUzuDr6LcgnRhbSEcQGksLSYrgLxvFQg7mdLiJyIOcMTT6v2IvizxBtZt+nAI4b
         M+7A==
X-Gm-Message-State: APjAAAVskiMdFauojw+/euQUaVGIF0FSAgs1Smw+lmy6kSEa7z79tFzR
        KB++GFAXLqLljOq7xRUdv4NOYmz1
X-Google-Smtp-Source: APXvYqy8nLbKT8SKkxihMsoS6o1zY8YXUMr+Nk9pGb+5s612YMw/bkwjZDSUl9w7otc+qae9pUq9WQ==
X-Received: by 2002:a25:d8d3:: with SMTP id p202mr18859766ybg.512.1566261210027;
        Mon, 19 Aug 2019 17:33:30 -0700 (PDT)
Received: from theseus.lan ([2604:2d80:b386:1f00::780])
        by smtp.gmail.com with ESMTPSA id 193sm3658853ywh.89.2019.08.19.17.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 17:33:29 -0700 (PDT)
From:   Clark Williams <clark.williams@gmail.com>
To:     bigeasy@linutronix.com
Cc:     tglx@linutronix.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PREEMPT_RT PATCH 1/3] i915: do not call lockdep_assert_irqs_disabled() on PREEMPT_RT
Date:   Mon, 19 Aug 2019 19:33:17 -0500
Message-Id: <20190820003319.24135-2-clark.williams@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820003319.24135-1-clark.williams@gmail.com>
References: <20190820003319.24135-1-clark.williams@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Clark Williams <williams@redhat.com>

The 'breadcrumb' code in the i915 driver calls lockdep_assert_irqs_disabled()
when starting some operations. This is valid on a stock kernel
but on a PREEMPT_RT kernel the spin_lock_irq*() calls to not disable
interrupts and likewise the spin_unlock_irq*() calls to not enable interrupts.

Conditionalize these calls based on whether PREEMPT_RT_FULL is enabled.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/intel_breadcrumbs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
index 832cb6b1e9bd..3eef6010ebf6 100644
--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -101,7 +101,8 @@ __dma_fence_signal__notify(struct dma_fence *fence)
 	struct dma_fence_cb *cur, *tmp;
 
 	lockdep_assert_held(fence->lock);
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		lockdep_assert_irqs_disabled();
 
 	list_for_each_entry_safe(cur, tmp, &fence->cb_list, node) {
 		INIT_LIST_HEAD(&cur->node);
@@ -276,7 +277,8 @@ void intel_engine_fini_breadcrumbs(struct intel_engine_cs *engine)
 bool i915_request_enable_breadcrumb(struct i915_request *rq)
 {
 	lockdep_assert_held(&rq->lock);
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		lockdep_assert_irqs_disabled();
 
 	if (test_bit(I915_FENCE_FLAG_ACTIVE, &rq->fence.flags)) {
 		struct intel_breadcrumbs *b = &rq->engine->breadcrumbs;
@@ -325,7 +327,8 @@ void i915_request_cancel_breadcrumb(struct i915_request *rq)
 	struct intel_breadcrumbs *b = &rq->engine->breadcrumbs;
 
 	lockdep_assert_held(&rq->lock);
-	lockdep_assert_irqs_disabled();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
+		lockdep_assert_irqs_disabled();
 
 	/*
 	 * We must wait for b->irq_lock so that we know the interrupt handler
-- 
2.21.0

