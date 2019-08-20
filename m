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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D30C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B66D206DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o/pGECsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbfHTAde (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:33:34 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35293 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfHTAdd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 20:33:33 -0400
Received: by mail-yw1-f65.google.com with SMTP id g19so1642661ywe.2;
        Mon, 19 Aug 2019 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tLnc92wL21+oScOiXrElUzSPRxzZv2Npf5OFXKKJfUQ=;
        b=o/pGECsrmyz1Gm6A8WM4v3eGu7n9CvD9MOFA+CAfDDKfOpAUpwT7SxfFs2+NjemFZK
         8nxrSSQR8GKWRw9mvfphRjWG/oBpofyjFkHOGpNjFxSN2OUn+xvPdI/UP801V0/wHjHl
         vmCKsmjU4sD4cRR4xN4fEUM8hGmbJrXrqtaVrGCg1sD9diz7vfncdYaYFrFaAKLRLXYQ
         8T8FIE+zexrMwqRLIv0A78ybsJDqsv7ixVHspKcUckfCJEM67l1Xv+vOTFP7o3B0Bav8
         ZTZeHw/WdRmQB/qVN52MdMV1eD7vonKf+3IN2oszq1tz3aCF2xaxeWt862dlZsdbu27E
         Zt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tLnc92wL21+oScOiXrElUzSPRxzZv2Npf5OFXKKJfUQ=;
        b=nk6E0EJXui3RR+aRAFv/gMOxY9nIQfkoBgnyef1sqdxHaqIZzSSP4WDO//Eb7F1DeX
         znhrFuXvoLi8cUl+e0Znuu23jCBYIe8ZiSYWAYoMMlV5ygorLmIv0Tc53zHOD80KjS52
         QByLrmpu/JPyjeJrwE7yVkk2IPzckDneM1u3fn9lg2GvvgKX9p3VV96N7xrPmoGQ/NGK
         Wx8if+1Wou77vJrFNPMQD1UBiHtokDmgNqWlm6sftpPRMDulCbMntT240qqEMwdF3KRo
         HSJSJFiWSDd5q/g1GfdTiE7sOV2Jb9UErFlT1z6TFCzlXVRdsWBvApReOQ9xl5/JS1mZ
         Fhhw==
X-Gm-Message-State: APjAAAV0+4hXH9a4YeZYUf079wHjzVkITvWYjasuhGwahIMA3jt7TE8d
        ncNTDitG9yW6fmC+ERQweOE=
X-Google-Smtp-Source: APXvYqzIY5p91/MmAv/3TQwvM2YBWMY729OROUEHWgNz06PfGspnOS47TFuz8L90AmIA9iKVnTMXZA==
X-Received: by 2002:a81:3d82:: with SMTP id k124mr19219454ywa.193.1566261211189;
        Mon, 19 Aug 2019 17:33:31 -0700 (PDT)
Received: from theseus.lan ([2604:2d80:b386:1f00::780])
        by smtp.gmail.com with ESMTPSA id 193sm3658853ywh.89.2019.08.19.17.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 17:33:30 -0700 (PDT)
From:   Clark Williams <clark.williams@gmail.com>
To:     bigeasy@linutronix.com
Cc:     tglx@linutronix.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PREEMPT_RT PATCH 2/3] i915: convert all irq_locks spinlocks to raw spinlocks
Date:   Mon, 19 Aug 2019 19:33:18 -0500
Message-Id: <20190820003319.24135-3-clark.williams@gmail.com>
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

The following structures contain a member named 'irq_lock'.
These three locks are of type spinlock_t and are used in
multiple contexts including atomic:

    struct drm_i915_private
    struct intel_breadcrumbs
    strict intel_guc

Convert them all to be raw_spinlock_t so that lockdep and the lock
debugging code will be happy.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/i915_debugfs.c        |   8 +-
 drivers/gpu/drm/i915/i915_drv.c            |   6 +-
 drivers/gpu/drm/i915/i915_drv.h            |   2 +-
 drivers/gpu/drm/i915/i915_irq.c            | 142 ++++++++++-----------
 drivers/gpu/drm/i915/intel_breadcrumbs.c   |  42 +++---
 drivers/gpu/drm/i915/intel_display.c       |   4 +-
 drivers/gpu/drm/i915/intel_engine_types.h  |   2 +-
 drivers/gpu/drm/i915/intel_fifo_underrun.c |  16 +--
 drivers/gpu/drm/i915/intel_guc.c           |   6 +-
 drivers/gpu/drm/i915/intel_guc.h           |  10 +-
 drivers/gpu/drm/i915/intel_hotplug.c       |  36 +++---
 drivers/gpu/drm/i915/intel_runtime_pm.c    |   8 +-
 drivers/gpu/drm/i915/intel_tv.c            |   8 +-
 13 files changed, 145 insertions(+), 145 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 5823ffb17821..969dd63b12e9 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -4336,12 +4336,12 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
 	else
 		DRM_DEBUG_KMS("Disabling HPD storm detection\n");
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	hotplug->hpd_storm_threshold = new_threshold;
 	/* Reset the HPD storm stats so we don't accidentally trigger a storm */
 	for_each_hpd_pin(i)
 		hotplug->stats[i].count = 0;
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	/* Re-enable hpd immediately if we were in an irq storm */
 	flush_delayed_work(&dev_priv->hotplug.reenable_work);
@@ -4414,12 +4414,12 @@ static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
 	DRM_DEBUG_KMS("%sabling HPD short storm detection\n",
 		      new_state ? "En" : "Dis");
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	hotplug->hpd_short_storm_enabled = new_state;
 	/* Reset the HPD storm stats so we don't accidentally trigger a storm */
 	for_each_hpd_pin(i)
 		hotplug->stats[i].count = 0;
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	/* Re-enable hpd immediately if we were in an irq storm */
 	flush_delayed_work(&dev_priv->hotplug.reenable_work);
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 1ad88e6d7c04..ce8d0d8d31de 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -879,7 +879,7 @@ static int i915_driver_init_early(struct drm_i915_private *dev_priv)
 
 	intel_uncore_init_early(&dev_priv->uncore);
 
-	spin_lock_init(&dev_priv->irq_lock);
+	raw_spin_lock_init(&dev_priv->irq_lock);
 	spin_lock_init(&dev_priv->gpu_error.lock);
 	mutex_init(&dev_priv->backlight_lock);
 
@@ -2219,10 +2219,10 @@ static int i915_drm_resume(struct drm_device *dev)
 	intel_modeset_init_hw(dev);
 	intel_init_clock_gating(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (dev_priv->display.hpd_irq_setup)
 		dev_priv->display.hpd_irq_setup(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	intel_dp_mst_resume(dev_priv);
 
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index 066fd2a12851..293b69a870b9 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1552,7 +1552,7 @@ struct drm_i915_private {
 	struct resource mch_res;
 
 	/* protects the irq masks */
-	spinlock_t irq_lock;
+	raw_spinlock_t irq_lock;
 
 	bool display_irqs_enabled;
 
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 3d8abe9ebbb5..9b86926299b1 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -287,9 +287,9 @@ void i915_hotplug_interrupt_update(struct drm_i915_private *dev_priv,
 				   u32 mask,
 				   u32 bits)
 {
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	i915_hotplug_interrupt_update_locked(dev_priv, mask, bits);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 static u32
@@ -514,22 +514,22 @@ static void gen6_disable_pm_irq(struct drm_i915_private *dev_priv, u32 disable_m
 
 void gen11_reset_rps_interrupts(struct drm_i915_private *dev_priv)
 {
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	while (gen11_reset_one_iir(dev_priv, 0, GEN11_GTPM))
 		;
 
 	dev_priv->gt_pm.rps.pm_iir = 0;
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 void gen6_reset_rps_interrupts(struct drm_i915_private *dev_priv)
 {
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	gen6_reset_pm_iir(dev_priv, GEN6_PM_RPS_EVENTS);
 	dev_priv->gt_pm.rps.pm_iir = 0;
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 void gen6_enable_rps_interrupts(struct drm_i915_private *dev_priv)
@@ -539,7 +539,7 @@ void gen6_enable_rps_interrupts(struct drm_i915_private *dev_priv)
 	if (READ_ONCE(rps->interrupts_enabled))
 		return;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	WARN_ON_ONCE(rps->pm_iir);
 
 	if (INTEL_GEN(dev_priv) >= 11)
@@ -550,7 +550,7 @@ void gen6_enable_rps_interrupts(struct drm_i915_private *dev_priv)
 	rps->interrupts_enabled = true;
 	gen6_enable_pm_irq(dev_priv, dev_priv->pm_rps_events);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 void gen6_disable_rps_interrupts(struct drm_i915_private *dev_priv)
@@ -560,14 +560,14 @@ void gen6_disable_rps_interrupts(struct drm_i915_private *dev_priv)
 	if (!READ_ONCE(rps->interrupts_enabled))
 		return;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	rps->interrupts_enabled = false;
 
 	I915_WRITE(GEN6_PMINTRMSK, gen6_sanitize_rps_pm_mask(dev_priv, ~0u));
 
 	gen6_disable_pm_irq(dev_priv, GEN6_PM_RPS_EVENTS);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 	synchronize_irq(dev_priv->drm.irq);
 
 	/* Now that we will not be generating any more work, flush any
@@ -586,35 +586,35 @@ void gen9_reset_guc_interrupts(struct drm_i915_private *dev_priv)
 {
 	assert_rpm_wakelock_held(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	gen6_reset_pm_iir(dev_priv, dev_priv->pm_guc_events);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 void gen9_enable_guc_interrupts(struct drm_i915_private *dev_priv)
 {
 	assert_rpm_wakelock_held(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (!dev_priv->guc.interrupts_enabled) {
 		WARN_ON_ONCE(I915_READ(gen6_pm_iir(dev_priv)) &
 				       dev_priv->pm_guc_events);
 		dev_priv->guc.interrupts_enabled = true;
 		gen6_enable_pm_irq(dev_priv, dev_priv->pm_guc_events);
 	}
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 void gen9_disable_guc_interrupts(struct drm_i915_private *dev_priv)
 {
 	assert_rpm_wakelock_held(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	dev_priv->guc.interrupts_enabled = false;
 
 	gen6_disable_pm_irq(dev_priv, dev_priv->pm_guc_events);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 	synchronize_irq(dev_priv->drm.irq);
 
 	gen9_reset_guc_interrupts(dev_priv);
@@ -813,14 +813,14 @@ static void i915_enable_asle_pipestat(struct drm_i915_private *dev_priv)
 	if (!i915_has_asle(dev_priv))
 		return;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	i915_enable_pipestat(dev_priv, PIPE_B, PIPE_LEGACY_BLC_EVENT_STATUS);
 	if (INTEL_GEN(dev_priv) >= 4)
 		i915_enable_pipestat(dev_priv, PIPE_A,
 				     PIPE_LEGACY_BLC_EVENT_STATUS);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 /*
@@ -1291,12 +1291,12 @@ static void gen6_pm_rps_work(struct work_struct *work)
 	int new_delay, adj, min, max;
 	u32 pm_iir = 0;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (rps->interrupts_enabled) {
 		pm_iir = fetch_and_zero(&rps->pm_iir);
 		client_boost = atomic_read(&rps->num_waiters);
 	}
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	/* Make sure we didn't queue anything we're not going to process. */
 	WARN_ON(pm_iir & ~dev_priv->pm_rps_events);
@@ -1373,10 +1373,10 @@ static void gen6_pm_rps_work(struct work_struct *work)
 
 out:
 	/* Make sure not to corrupt PMIMR state used by ringbuffer on GEN6 */
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (rps->interrupts_enabled)
 		gen6_unmask_pm_irq(dev_priv, dev_priv->pm_rps_events);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 
@@ -1454,9 +1454,9 @@ static void ivybridge_parity_work(struct work_struct *work)
 
 out:
 	WARN_ON(dev_priv->l3_parity.which_slice);
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	gen5_enable_gt_irq(dev_priv, GT_PARITY_ERROR(dev_priv));
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	mutex_unlock(&dev_priv->drm.struct_mutex);
 }
@@ -1467,9 +1467,9 @@ static void ivybridge_parity_error_irq_handler(struct drm_i915_private *dev_priv
 	if (!HAS_L3_DPF(dev_priv))
 		return;
 
-	spin_lock(&dev_priv->irq_lock);
+	raw_spin_lock(&dev_priv->irq_lock);
 	gen5_disable_gt_irq(dev_priv, GT_PARITY_ERROR(dev_priv));
-	spin_unlock(&dev_priv->irq_lock);
+	raw_spin_unlock(&dev_priv->irq_lock);
 
 	iir &= GT_PARITY_ERROR(dev_priv);
 	if (iir & GT_RENDER_L3_PARITY_ERROR_INTERRUPT_S1)
@@ -1866,13 +1866,13 @@ static void gen6_rps_irq_handler(struct drm_i915_private *dev_priv, u32 pm_iir)
 	struct intel_rps *rps = &dev_priv->gt_pm.rps;
 
 	if (pm_iir & dev_priv->pm_rps_events) {
-		spin_lock(&dev_priv->irq_lock);
+		raw_spin_lock(&dev_priv->irq_lock);
 		gen6_mask_pm_irq(dev_priv, pm_iir & dev_priv->pm_rps_events);
 		if (rps->interrupts_enabled) {
 			rps->pm_iir |= pm_iir & dev_priv->pm_rps_events;
 			schedule_work(&rps->work);
 		}
-		spin_unlock(&dev_priv->irq_lock);
+		raw_spin_unlock(&dev_priv->irq_lock);
 	}
 
 	if (INTEL_GEN(dev_priv) >= 8)
@@ -1909,10 +1909,10 @@ static void i9xx_pipestat_irq_ack(struct drm_i915_private *dev_priv,
 {
 	int pipe;
 
-	spin_lock(&dev_priv->irq_lock);
+	raw_spin_lock(&dev_priv->irq_lock);
 
 	if (!dev_priv->display_irqs_enabled) {
-		spin_unlock(&dev_priv->irq_lock);
+		raw_spin_unlock(&dev_priv->irq_lock);
 		return;
 	}
 
@@ -1966,7 +1966,7 @@ static void i9xx_pipestat_irq_ack(struct drm_i915_private *dev_priv,
 			I915_WRITE(reg, enable_mask);
 		}
 	}
-	spin_unlock(&dev_priv->irq_lock);
+	raw_spin_unlock(&dev_priv->irq_lock);
 }
 
 static void i8xx_pipestat_irq_handler(struct drm_i915_private *dev_priv,
@@ -3087,14 +3087,14 @@ gen11_gt_irq_handler(struct drm_i915_private * const i915,
 {
 	unsigned int bank;
 
-	spin_lock(&i915->irq_lock);
+	raw_spin_lock(&i915->irq_lock);
 
 	for (bank = 0; bank < 2; bank++) {
 		if (master_ctl & GEN11_GT_DW_IRQ(bank))
 			gen11_gt_bank_handler(i915, bank);
 	}
 
-	spin_unlock(&i915->irq_lock);
+	raw_spin_unlock(&i915->irq_lock);
 }
 
 static u32
@@ -3187,9 +3187,9 @@ static int i8xx_enable_vblank(struct drm_device *dev, unsigned int pipe)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	i915_enable_pipestat(dev_priv, pipe, PIPE_VBLANK_INTERRUPT_STATUS);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 
 	return 0;
 }
@@ -3209,10 +3209,10 @@ static int i965_enable_vblank(struct drm_device *dev, unsigned int pipe)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	i915_enable_pipestat(dev_priv, pipe,
 			     PIPE_START_VBLANK_INTERRUPT_STATUS);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 
 	return 0;
 }
@@ -3224,9 +3224,9 @@ static int ironlake_enable_vblank(struct drm_device *dev, unsigned int pipe)
 	u32 bit = INTEL_GEN(dev_priv) >= 7 ?
 		DE_PIPE_VBLANK_IVB(pipe) : DE_PIPE_VBLANK(pipe);
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	ilk_enable_display_irq(dev_priv, bit);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 
 	/* Even though there is no DMC, frame counter can get stuck when
 	 * PSR is active as no frames are generated.
@@ -3242,9 +3242,9 @@ static int gen8_enable_vblank(struct drm_device *dev, unsigned int pipe)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	bdw_enable_pipe_irq(dev_priv, pipe, GEN8_PIPE_VBLANK);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 
 	/* Even if there is no DMC, frame counter can get stuck when
 	 * PSR is active as no frames are generated, so check only for PSR.
@@ -3263,9 +3263,9 @@ static void i8xx_disable_vblank(struct drm_device *dev, unsigned int pipe)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	i915_disable_pipestat(dev_priv, pipe, PIPE_VBLANK_INTERRUPT_STATUS);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 }
 
 static void i945gm_disable_vblank(struct drm_device *dev, unsigned int pipe)
@@ -3283,10 +3283,10 @@ static void i965_disable_vblank(struct drm_device *dev, unsigned int pipe)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	i915_disable_pipestat(dev_priv, pipe,
 			      PIPE_START_VBLANK_INTERRUPT_STATUS);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 }
 
 static void ironlake_disable_vblank(struct drm_device *dev, unsigned int pipe)
@@ -3296,9 +3296,9 @@ static void ironlake_disable_vblank(struct drm_device *dev, unsigned int pipe)
 	u32 bit = INTEL_GEN(dev_priv) >= 7 ?
 		DE_PIPE_VBLANK_IVB(pipe) : DE_PIPE_VBLANK(pipe);
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	ilk_disable_display_irq(dev_priv, bit);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 }
 
 static void gen8_disable_vblank(struct drm_device *dev, unsigned int pipe)
@@ -3306,9 +3306,9 @@ static void gen8_disable_vblank(struct drm_device *dev, unsigned int pipe)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, irqflags);
 	bdw_disable_pipe_irq(dev_priv, pipe, GEN8_PIPE_VBLANK);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, irqflags);
 }
 
 static void i945gm_vblank_work_func(struct work_struct *work)
@@ -3486,10 +3486,10 @@ static void valleyview_irq_reset(struct drm_device *dev)
 
 	gen5_gt_irq_reset(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (dev_priv->display_irqs_enabled)
 		vlv_display_irq_reset(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 static void gen8_gt_irq_reset(struct drm_i915_private *dev_priv)
@@ -3583,10 +3583,10 @@ void gen8_irq_power_well_post_enable(struct drm_i915_private *dev_priv,
 	u32 extra_ier = GEN8_PIPE_VBLANK | GEN8_PIPE_FIFO_UNDERRUN;
 	enum pipe pipe;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	if (!intel_irqs_enabled(dev_priv)) {
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 		return;
 	}
 
@@ -3595,7 +3595,7 @@ void gen8_irq_power_well_post_enable(struct drm_i915_private *dev_priv,
 				  dev_priv->de_irq_mask[pipe],
 				  ~dev_priv->de_irq_mask[pipe] | extra_ier);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 void gen8_irq_power_well_pre_disable(struct drm_i915_private *dev_priv,
@@ -3604,17 +3604,17 @@ void gen8_irq_power_well_pre_disable(struct drm_i915_private *dev_priv,
 	struct intel_uncore *uncore = &dev_priv->uncore;
 	enum pipe pipe;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	if (!intel_irqs_enabled(dev_priv)) {
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 		return;
 	}
 
 	for_each_pipe_masked(dev_priv, pipe, pipe_mask)
 		GEN8_IRQ_RESET_NDX(uncore, DE_PIPE, pipe);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	/* make sure we're done processing display irqs */
 	synchronize_irq(dev_priv->drm.irq);
@@ -3632,10 +3632,10 @@ static void cherryview_irq_reset(struct drm_device *dev)
 
 	GEN3_IRQ_RESET(uncore, GEN8_PCU_);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (dev_priv->display_irqs_enabled)
 		vlv_display_irq_reset(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 static u32 intel_hpd_enabled_irqs(struct drm_i915_private *dev_priv,
@@ -3997,9 +3997,9 @@ static int ironlake_irq_postinstall(struct drm_device *dev)
 		 * spinlocking not required here for correctness since interrupt
 		 * setup is guaranteed to run in single-threaded context. But we
 		 * need it to make the assert_spin_locked happy. */
-		spin_lock_irq(&dev_priv->irq_lock);
+		raw_spin_lock_irq(&dev_priv->irq_lock);
 		ilk_enable_display_irq(dev_priv, DE_PCU_EVENT);
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 	}
 
 	return 0;
@@ -4040,10 +4040,10 @@ static int valleyview_irq_postinstall(struct drm_device *dev)
 
 	gen5_gt_irq_postinstall(dev);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (dev_priv->display_irqs_enabled)
 		vlv_display_irq_postinstall(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	I915_WRITE(VLV_MASTER_IER, MASTER_INTERRUPT_ENABLE);
 	POSTING_READ(VLV_MASTER_IER);
@@ -4243,10 +4243,10 @@ static int cherryview_irq_postinstall(struct drm_device *dev)
 
 	gen8_gt_irq_postinstall(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (dev_priv->display_irqs_enabled)
 		vlv_display_irq_postinstall(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	I915_WRITE(GEN8_MASTER_IRQ, GEN8_MASTER_IRQ_CONTROL);
 	POSTING_READ(GEN8_MASTER_IRQ);
@@ -4289,10 +4289,10 @@ static int i8xx_irq_postinstall(struct drm_device *dev)
 
 	/* Interrupt setup is already guaranteed to be single-threaded, this is
 	 * just to make the assert_spin_locked check happy. */
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	i915_enable_pipestat(dev_priv, PIPE_A, PIPE_CRC_DONE_INTERRUPT_STATUS);
 	i915_enable_pipestat(dev_priv, PIPE_B, PIPE_CRC_DONE_INTERRUPT_STATUS);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	return 0;
 }
@@ -4467,10 +4467,10 @@ static int i915_irq_postinstall(struct drm_device *dev)
 
 	/* Interrupt setup is already guaranteed to be single-threaded, this is
 	 * just to make the assert_spin_locked check happy. */
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	i915_enable_pipestat(dev_priv, PIPE_A, PIPE_CRC_DONE_INTERRUPT_STATUS);
 	i915_enable_pipestat(dev_priv, PIPE_B, PIPE_CRC_DONE_INTERRUPT_STATUS);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	i915_enable_asle_pipestat(dev_priv);
 
@@ -4589,11 +4589,11 @@ static int i965_irq_postinstall(struct drm_device *dev)
 
 	/* Interrupt setup is already guaranteed to be single-threaded, this is
 	 * just to make the assert_spin_locked check happy. */
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	i915_enable_pipestat(dev_priv, PIPE_A, PIPE_GMBUS_INTERRUPT_STATUS);
 	i915_enable_pipestat(dev_priv, PIPE_A, PIPE_CRC_DONE_INTERRUPT_STATUS);
 	i915_enable_pipestat(dev_priv, PIPE_B, PIPE_CRC_DONE_INTERRUPT_STATUS);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	i915_enable_asle_pipestat(dev_priv);
 
diff --git a/drivers/gpu/drm/i915/intel_breadcrumbs.c b/drivers/gpu/drm/i915/intel_breadcrumbs.c
index 3eef6010ebf6..32ebbe887e61 100644
--- a/drivers/gpu/drm/i915/intel_breadcrumbs.c
+++ b/drivers/gpu/drm/i915/intel_breadcrumbs.c
@@ -34,9 +34,9 @@ static void irq_enable(struct intel_engine_cs *engine)
 		return;
 
 	/* Caller disables interrupts */
-	spin_lock(&engine->i915->irq_lock);
+	raw_spin_lock(&engine->i915->irq_lock);
 	engine->irq_enable(engine);
-	spin_unlock(&engine->i915->irq_lock);
+	raw_spin_unlock(&engine->i915->irq_lock);
 }
 
 static void irq_disable(struct intel_engine_cs *engine)
@@ -45,9 +45,9 @@ static void irq_disable(struct intel_engine_cs *engine)
 		return;
 
 	/* Caller disables interrupts */
-	spin_lock(&engine->i915->irq_lock);
+	raw_spin_lock(&engine->i915->irq_lock);
 	engine->irq_disable(engine);
-	spin_unlock(&engine->i915->irq_lock);
+	raw_spin_unlock(&engine->i915->irq_lock);
 }
 
 static void __intel_breadcrumbs_disarm_irq(struct intel_breadcrumbs *b)
@@ -70,10 +70,10 @@ void intel_engine_disarm_breadcrumbs(struct intel_engine_cs *engine)
 	if (!b->irq_armed)
 		return;
 
-	spin_lock_irq(&b->irq_lock);
+	raw_spin_lock_irq(&b->irq_lock);
 	if (b->irq_armed)
 		__intel_breadcrumbs_disarm_irq(b);
-	spin_unlock_irq(&b->irq_lock);
+	raw_spin_unlock_irq(&b->irq_lock);
 }
 
 static inline bool __request_completed(const struct i915_request *rq)
@@ -119,7 +119,7 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 	struct list_head *pos, *next;
 	LIST_HEAD(signal);
 
-	spin_lock(&b->irq_lock);
+	raw_spin_lock(&b->irq_lock);
 
 	if (b->irq_armed && list_empty(&b->signalers))
 		__intel_breadcrumbs_disarm_irq(b);
@@ -163,7 +163,7 @@ void intel_engine_breadcrumbs_irq(struct intel_engine_cs *engine)
 		}
 	}
 
-	spin_unlock(&b->irq_lock);
+	raw_spin_unlock(&b->irq_lock);
 
 	list_for_each_safe(pos, next, &signal) {
 		struct i915_request *rq =
@@ -198,22 +198,22 @@ void intel_engine_pin_breadcrumbs_irq(struct intel_engine_cs *engine)
 {
 	struct intel_breadcrumbs *b = &engine->breadcrumbs;
 
-	spin_lock_irq(&b->irq_lock);
+	raw_spin_lock_irq(&b->irq_lock);
 	if (!b->irq_enabled++)
 		irq_enable(engine);
 	GEM_BUG_ON(!b->irq_enabled); /* no overflow! */
-	spin_unlock_irq(&b->irq_lock);
+	raw_spin_unlock_irq(&b->irq_lock);
 }
 
 void intel_engine_unpin_breadcrumbs_irq(struct intel_engine_cs *engine)
 {
 	struct intel_breadcrumbs *b = &engine->breadcrumbs;
 
-	spin_lock_irq(&b->irq_lock);
+	raw_spin_lock_irq(&b->irq_lock);
 	GEM_BUG_ON(!b->irq_enabled); /* no underflow! */
 	if (!--b->irq_enabled)
 		irq_disable(engine);
-	spin_unlock_irq(&b->irq_lock);
+	raw_spin_unlock_irq(&b->irq_lock);
 }
 
 static void __intel_breadcrumbs_arm_irq(struct intel_breadcrumbs *b)
@@ -249,7 +249,7 @@ void intel_engine_init_breadcrumbs(struct intel_engine_cs *engine)
 {
 	struct intel_breadcrumbs *b = &engine->breadcrumbs;
 
-	spin_lock_init(&b->irq_lock);
+	raw_spin_lock_init(&b->irq_lock);
 	INIT_LIST_HEAD(&b->signalers);
 
 	init_irq_work(&b->irq_work, signal_irq_work);
@@ -260,14 +260,14 @@ void intel_engine_reset_breadcrumbs(struct intel_engine_cs *engine)
 	struct intel_breadcrumbs *b = &engine->breadcrumbs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&b->irq_lock, flags);
+	raw_spin_lock_irqsave(&b->irq_lock, flags);
 
 	if (b->irq_enabled)
 		irq_enable(engine);
 	else
 		irq_disable(engine);
 
-	spin_unlock_irqrestore(&b->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&b->irq_lock, flags);
 }
 
 void intel_engine_fini_breadcrumbs(struct intel_engine_cs *engine)
@@ -285,7 +285,7 @@ bool i915_request_enable_breadcrumb(struct i915_request *rq)
 		struct intel_context *ce = rq->hw_context;
 		struct list_head *pos;
 
-		spin_lock(&b->irq_lock);
+		raw_spin_lock(&b->irq_lock);
 		GEM_BUG_ON(test_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags));
 
 		__intel_breadcrumbs_arm_irq(b);
@@ -316,7 +316,7 @@ bool i915_request_enable_breadcrumb(struct i915_request *rq)
 			list_move_tail(&ce->signal_link, &b->signalers);
 
 		set_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags);
-		spin_unlock(&b->irq_lock);
+		raw_spin_unlock(&b->irq_lock);
 	}
 
 	return !__request_completed(rq);
@@ -336,7 +336,7 @@ void i915_request_cancel_breadcrumb(struct i915_request *rq)
 	 * the DMA_FENCE_FLAG_SIGNALED_BIT/I915_FENCE_FLAG_SIGNAL dance (if
 	 * required).
 	 */
-	spin_lock(&b->irq_lock);
+	raw_spin_lock(&b->irq_lock);
 	if (test_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags)) {
 		struct intel_context *ce = rq->hw_context;
 
@@ -346,7 +346,7 @@ void i915_request_cancel_breadcrumb(struct i915_request *rq)
 
 		clear_bit(I915_FENCE_FLAG_SIGNAL, &rq->fence.flags);
 	}
-	spin_unlock(&b->irq_lock);
+	raw_spin_unlock(&b->irq_lock);
 }
 
 void intel_engine_print_breadcrumbs(struct intel_engine_cs *engine,
@@ -361,7 +361,7 @@ void intel_engine_print_breadcrumbs(struct intel_engine_cs *engine,
 
 	drm_printf(p, "Signals:\n");
 
-	spin_lock_irq(&b->irq_lock);
+	raw_spin_lock_irq(&b->irq_lock);
 	list_for_each_entry(ce, &b->signalers, signal_link) {
 		list_for_each_entry(rq, &ce->signals, signal_link) {
 			drm_printf(p, "\t[%llx:%llx%s] @ %dms\n",
@@ -372,5 +372,5 @@ void intel_engine_print_breadcrumbs(struct intel_engine_cs *engine,
 				   jiffies_to_msecs(jiffies - rq->emitted_jiffies));
 		}
 	}
-	spin_unlock_irq(&b->irq_lock);
+	raw_spin_unlock_irq(&b->irq_lock);
 }
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 75105a2c59ea..6618a551fe09 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -3979,10 +3979,10 @@ void intel_finish_reset(struct drm_i915_private *dev_priv)
 		intel_modeset_init_hw(dev);
 		intel_init_clock_gating(dev_priv);
 
-		spin_lock_irq(&dev_priv->irq_lock);
+		raw_spin_lock_irq(&dev_priv->irq_lock);
 		if (dev_priv->display.hpd_irq_setup)
 			dev_priv->display.hpd_irq_setup(dev_priv);
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 		ret = __intel_display_resume(dev, state, ctx);
 		if (ret)
diff --git a/drivers/gpu/drm/i915/intel_engine_types.h b/drivers/gpu/drm/i915/intel_engine_types.h
index 4270ddb45f41..47e8e74b663e 100644
--- a/drivers/gpu/drm/i915/intel_engine_types.h
+++ b/drivers/gpu/drm/i915/intel_engine_types.h
@@ -307,7 +307,7 @@ struct intel_engine_cs {
 	 * the overhead of waking that client is much preferred.
 	 */
 	struct intel_breadcrumbs {
-		spinlock_t irq_lock;
+		raw_spinlock_t irq_lock;
 		struct list_head signalers;
 
 		struct irq_work irq_work; /* for use from inside irq_lock */
diff --git a/drivers/gpu/drm/i915/intel_fifo_underrun.c b/drivers/gpu/drm/i915/intel_fifo_underrun.c
index 74c8b0528294..9b6176f30e1e 100644
--- a/drivers/gpu/drm/i915/intel_fifo_underrun.c
+++ b/drivers/gpu/drm/i915/intel_fifo_underrun.c
@@ -293,10 +293,10 @@ bool intel_set_cpu_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
 	unsigned long flags;
 	bool ret;
 
-	spin_lock_irqsave(&dev_priv->irq_lock, flags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, flags);
 	ret = __intel_set_cpu_fifo_underrun_reporting(&dev_priv->drm, pipe,
 						      enable);
-	spin_unlock_irqrestore(&dev_priv->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, flags);
 
 	return ret;
 }
@@ -333,7 +333,7 @@ bool intel_set_pch_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
 	 * crtc on LPT won't cause issues.
 	 */
 
-	spin_lock_irqsave(&dev_priv->irq_lock, flags);
+	raw_spin_lock_irqsave(&dev_priv->irq_lock, flags);
 
 	old = !crtc->pch_fifo_underrun_disabled;
 	crtc->pch_fifo_underrun_disabled = !enable;
@@ -347,7 +347,7 @@ bool intel_set_pch_fifo_underrun_reporting(struct drm_i915_private *dev_priv,
 						pch_transcoder,
 						enable, old);
 
-	spin_unlock_irqrestore(&dev_priv->irq_lock, flags);
+	raw_spin_unlock_irqrestore(&dev_priv->irq_lock, flags);
 	return old;
 }
 
@@ -416,7 +416,7 @@ void intel_check_cpu_fifo_underruns(struct drm_i915_private *dev_priv)
 {
 	struct intel_crtc *crtc;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	for_each_intel_crtc(&dev_priv->drm, crtc) {
 		if (crtc->cpu_fifo_underrun_disabled)
@@ -428,7 +428,7 @@ void intel_check_cpu_fifo_underruns(struct drm_i915_private *dev_priv)
 			ivybridge_check_fifo_underruns(crtc);
 	}
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
 
 /**
@@ -443,7 +443,7 @@ void intel_check_pch_fifo_underruns(struct drm_i915_private *dev_priv)
 {
 	struct intel_crtc *crtc;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	for_each_intel_crtc(&dev_priv->drm, crtc) {
 		if (crtc->pch_fifo_underrun_disabled)
@@ -453,5 +453,5 @@ void intel_check_pch_fifo_underruns(struct drm_i915_private *dev_priv)
 			cpt_check_pch_fifo_underruns(crtc);
 	}
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
diff --git a/drivers/gpu/drm/i915/intel_guc.c b/drivers/gpu/drm/i915/intel_guc.c
index 3aabfa2d9198..b15463b937b0 100644
--- a/drivers/gpu/drm/i915/intel_guc.c
+++ b/drivers/gpu/drm/i915/intel_guc.c
@@ -68,7 +68,7 @@ void intel_guc_init_early(struct intel_guc *guc)
 	intel_guc_log_init_early(&guc->log);
 
 	mutex_init(&guc->send_mutex);
-	spin_lock_init(&guc->irq_lock);
+	raw_spin_lock_init(&guc->irq_lock);
 	guc->send = intel_guc_send_nop;
 	guc->handler = intel_guc_to_host_event_handler_nop;
 	guc->notify = gen8_guc_raise_irq;
@@ -478,11 +478,11 @@ void intel_guc_to_host_event_handler_mmio(struct intel_guc *guc)
 	 * clears out the bit on handling the 1st interrupt.
 	 */
 	disable_rpm_wakeref_asserts(dev_priv);
-	spin_lock(&guc->irq_lock);
+	raw_spin_lock(&guc->irq_lock);
 	val = I915_READ(SOFT_SCRATCH(15));
 	msg = val & guc->msg_enabled_mask;
 	I915_WRITE(SOFT_SCRATCH(15), val & ~msg);
-	spin_unlock(&guc->irq_lock);
+	raw_spin_unlock(&guc->irq_lock);
 	enable_rpm_wakeref_asserts(dev_priv);
 
 	intel_guc_to_host_process_recv_msg(guc, &msg, 1);
diff --git a/drivers/gpu/drm/i915/intel_guc.h b/drivers/gpu/drm/i915/intel_guc.h
index 2c59ff8d9f39..cd05df72eca3 100644
--- a/drivers/gpu/drm/i915/intel_guc.h
+++ b/drivers/gpu/drm/i915/intel_guc.h
@@ -54,7 +54,7 @@ struct intel_guc {
 	struct drm_i915_gem_object *load_err_log;
 
 	/* intel_guc_recv interrupt related state */
-	spinlock_t irq_lock;
+	raw_spinlock_t irq_lock;
 	bool interrupts_enabled;
 	unsigned int msg_enabled_mask;
 
@@ -182,16 +182,16 @@ static inline int intel_guc_sanitize(struct intel_guc *guc)
 
 static inline void intel_guc_enable_msg(struct intel_guc *guc, u32 mask)
 {
-	spin_lock_irq(&guc->irq_lock);
+	raw_spin_lock_irq(&guc->irq_lock);
 	guc->msg_enabled_mask |= mask;
-	spin_unlock_irq(&guc->irq_lock);
+	raw_spin_unlock_irq(&guc->irq_lock);
 }
 
 static inline void intel_guc_disable_msg(struct intel_guc *guc, u32 mask)
 {
-	spin_lock_irq(&guc->irq_lock);
+	raw_spin_lock_irq(&guc->irq_lock);
 	guc->msg_enabled_mask &= ~mask;
-	spin_unlock_irq(&guc->irq_lock);
+	raw_spin_unlock_irq(&guc->irq_lock);
 }
 
 int intel_guc_reset_engine(struct intel_guc *guc,
diff --git a/drivers/gpu/drm/i915/intel_hotplug.c b/drivers/gpu/drm/i915/intel_hotplug.c
index b8937c788f03..188633bd8c08 100644
--- a/drivers/gpu/drm/i915/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/intel_hotplug.c
@@ -231,7 +231,7 @@ static void intel_hpd_irq_storm_reenable_work(struct work_struct *work)
 
 	wakeref = intel_runtime_pm_get(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	for_each_hpd_pin(pin) {
 		struct drm_connector *connector;
 		struct drm_connector_list_iter conn_iter;
@@ -260,7 +260,7 @@ static void intel_hpd_irq_storm_reenable_work(struct work_struct *work)
 	}
 	if (dev_priv->display_irqs_enabled && dev_priv->display.hpd_irq_setup)
 		dev_priv->display.hpd_irq_setup(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	intel_runtime_pm_put(dev_priv, wakeref);
 }
@@ -303,12 +303,12 @@ static void i915_digport_work_func(struct work_struct *work)
 	struct intel_encoder *encoder;
 	u32 old_bits = 0;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	long_port_mask = dev_priv->hotplug.long_port_mask;
 	dev_priv->hotplug.long_port_mask = 0;
 	short_port_mask = dev_priv->hotplug.short_port_mask;
 	dev_priv->hotplug.short_port_mask = 0;
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	for_each_intel_encoder(&dev_priv->drm, encoder) {
 		struct intel_digital_port *dig_port;
@@ -335,9 +335,9 @@ static void i915_digport_work_func(struct work_struct *work)
 	}
 
 	if (old_bits) {
-		spin_lock_irq(&dev_priv->irq_lock);
+		raw_spin_lock_irq(&dev_priv->irq_lock);
 		dev_priv->hotplug.event_bits |= old_bits;
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 		schedule_work(&dev_priv->hotplug.hotplug_work);
 	}
 }
@@ -360,7 +360,7 @@ static void i915_hotplug_work_func(struct work_struct *work)
 	mutex_lock(&dev->mode_config.mutex);
 	DRM_DEBUG_KMS("running encoder hotplug functions\n");
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	hpd_event_bits = dev_priv->hotplug.event_bits;
 	dev_priv->hotplug.event_bits = 0;
@@ -368,7 +368,7 @@ static void i915_hotplug_work_func(struct work_struct *work)
 	/* Enable polling for connectors which had HPD IRQ storms */
 	intel_hpd_irq_storm_switch_to_polling(dev_priv);
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	drm_connector_list_iter_begin(dev, &conn_iter);
 	drm_for_each_connector_iter(connector, &conn_iter) {
@@ -421,7 +421,7 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 	if (!pin_mask)
 		return;
 
-	spin_lock(&dev_priv->irq_lock);
+	raw_spin_lock(&dev_priv->irq_lock);
 
 	/*
 	 * Determine whether ->hpd_pulse() exists for each pin, and
@@ -504,7 +504,7 @@ void intel_hpd_irq_handler(struct drm_i915_private *dev_priv,
 	 */
 	if (storm_detected && dev_priv->display_irqs_enabled)
 		dev_priv->display.hpd_irq_setup(dev_priv);
-	spin_unlock(&dev_priv->irq_lock);
+	raw_spin_unlock(&dev_priv->irq_lock);
 
 	/*
 	 * Our hotplug handler can grab modeset locks (by calling down into the
@@ -549,10 +549,10 @@ void intel_hpd_init(struct drm_i915_private *dev_priv)
 	 * just to make the assert_spin_locked checks happy.
 	 */
 	if (dev_priv->display_irqs_enabled && dev_priv->display.hpd_irq_setup) {
-		spin_lock_irq(&dev_priv->irq_lock);
+		raw_spin_lock_irq(&dev_priv->irq_lock);
 		if (dev_priv->display_irqs_enabled)
 			dev_priv->display.hpd_irq_setup(dev_priv);
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 	}
 }
 
@@ -644,13 +644,13 @@ void intel_hpd_init_work(struct drm_i915_private *dev_priv)
 
 void intel_hpd_cancel_work(struct drm_i915_private *dev_priv)
 {
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 
 	dev_priv->hotplug.long_port_mask = 0;
 	dev_priv->hotplug.short_port_mask = 0;
 	dev_priv->hotplug.event_bits = 0;
 
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	cancel_work_sync(&dev_priv->hotplug.dig_port_work);
 	cancel_work_sync(&dev_priv->hotplug.hotplug_work);
@@ -665,12 +665,12 @@ bool intel_hpd_disable(struct drm_i915_private *dev_priv, enum hpd_pin pin)
 	if (pin == HPD_NONE)
 		return false;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	if (dev_priv->hotplug.stats[pin].state == HPD_ENABLED) {
 		dev_priv->hotplug.stats[pin].state = HPD_DISABLED;
 		ret = true;
 	}
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	return ret;
 }
@@ -680,7 +680,7 @@ void intel_hpd_enable(struct drm_i915_private *dev_priv, enum hpd_pin pin)
 	if (pin == HPD_NONE)
 		return;
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	dev_priv->hotplug.stats[pin].state = HPD_ENABLED;
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 }
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 6150e35bf7b5..11c0f2a738cd 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -1324,9 +1324,9 @@ static void vlv_display_power_well_init(struct drm_i915_private *dev_priv)
 
 	vlv_init_display_clock_gating(dev_priv);
 
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	valleyview_enable_display_irqs(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	/*
 	 * During driver initialization/resume we can avoid restoring the
@@ -1350,9 +1350,9 @@ static void vlv_display_power_well_init(struct drm_i915_private *dev_priv)
 
 static void vlv_display_power_well_deinit(struct drm_i915_private *dev_priv)
 {
-	spin_lock_irq(&dev_priv->irq_lock);
+	raw_spin_lock_irq(&dev_priv->irq_lock);
 	valleyview_disable_display_irqs(dev_priv);
-	spin_unlock_irq(&dev_priv->irq_lock);
+	raw_spin_unlock_irq(&dev_priv->irq_lock);
 
 	/* make sure we're done processing display irqs */
 	synchronize_irq(dev_priv->drm.irq);
diff --git a/drivers/gpu/drm/i915/intel_tv.c b/drivers/gpu/drm/i915/intel_tv.c
index 5dbba33f4202..bb7dd33935a1 100644
--- a/drivers/gpu/drm/i915/intel_tv.c
+++ b/drivers/gpu/drm/i915/intel_tv.c
@@ -1574,11 +1574,11 @@ intel_tv_detect_type(struct intel_tv *intel_tv,
 
 	/* Disable TV interrupts around load detect or we'll recurse */
 	if (connector->polled & DRM_CONNECTOR_POLL_HPD) {
-		spin_lock_irq(&dev_priv->irq_lock);
+		raw_spin_lock_irq(&dev_priv->irq_lock);
 		i915_disable_pipestat(dev_priv, 0,
 				      PIPE_HOTPLUG_INTERRUPT_STATUS |
 				      PIPE_HOTPLUG_TV_INTERRUPT_STATUS);
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 	}
 
 	save_tv_dac = tv_dac = I915_READ(TV_DAC);
@@ -1646,11 +1646,11 @@ intel_tv_detect_type(struct intel_tv *intel_tv,
 
 	/* Restore interrupt config */
 	if (connector->polled & DRM_CONNECTOR_POLL_HPD) {
-		spin_lock_irq(&dev_priv->irq_lock);
+		raw_spin_lock_irq(&dev_priv->irq_lock);
 		i915_enable_pipestat(dev_priv, 0,
 				     PIPE_HOTPLUG_INTERRUPT_STATUS |
 				     PIPE_HOTPLUG_TV_INTERRUPT_STATUS);
-		spin_unlock_irq(&dev_priv->irq_lock);
+		raw_spin_unlock_irq(&dev_priv->irq_lock);
 	}
 
 	return type;
-- 
2.21.0

