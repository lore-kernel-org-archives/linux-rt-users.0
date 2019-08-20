Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA66C3A5A0
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C0F206DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 00:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLkIRzb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfHTAdf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:33:35 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37227 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbfHTAde (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 20:33:34 -0400
Received: by mail-yw1-f65.google.com with SMTP id u141so1637633ywe.4;
        Mon, 19 Aug 2019 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t8sqnAhn+rrb7hrg5cCGWFacN/PZj+xL1AM49sG4kYg=;
        b=mLkIRzb0hBe9lWKHmEl605yNT2LFcQv+ZuF7PKxbgryMRTPCreD11RF4j2W/5EkhnZ
         RDbNHa+IBer9qlCDIbYdflcRl+PBE3vynSr08vQ9zsjCqENdbeCv4Tsrzye+weRrU5wZ
         ow2CfrW31xEuVk0HRsSfsY1Nc88SFEFTjjJq5XHAHgfoZkU9RGR9q+bDA4KKDXtTUSjR
         wYza/EYWJ70KAJ8CmllEfRqVSIVnSV39RQbuTBp2rUi1es8uecaPxtRwiGlWRShUJBMm
         cFyRcbBbVSQof4s1cb106Oha2yTjTZApTRZJF2JH15THWiWwgFbiO5GiAAi7bMPkpau8
         qEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t8sqnAhn+rrb7hrg5cCGWFacN/PZj+xL1AM49sG4kYg=;
        b=RTdMjP8RPzQBvUYu6VOH6Vou29BgK9BI1NjiU18ufopRqN1upmmiA0oaKo+f0hzV/l
         3ziofMxiVd40Jcro2g2Azz8dNHfTT6/1rIDKLMFAPzAblN5bpwE651qWtRTe2gBh3vNj
         SSgwZwTrcSXIuwMIzZg4IPioyR5v72Z0d8dw+hN0DTSfqAp9R8BGlJhZj6K1F3J5DMhQ
         ZuDjMagCAYiE6dpaEWDzEPPqveYbekkpZX7iqPYDSMPE20bsP0QqOxU+C3Sw6XZajBla
         IvZtIDK1ria4JR2Fr0OqCAQ6C/xQKQB3yObC8V0h2AgjwrUjLeqibx5KTbyxe00FGg7T
         R9UA==
X-Gm-Message-State: APjAAAXS/dFp19gzvYYz/dKkhx/hy4KK44Izi6NG0A0wNcYpPN0C8xif
        ChFvoe40wXbDp62axpSDhlJ/hNVI
X-Google-Smtp-Source: APXvYqz3LMHfwdLnE0upFG0l6GHxgFVMuCOcKqV2p+VmVLEk9Oro2qpIPiXzskvQTc/1bPeCZnQpBg==
X-Received: by 2002:a81:9812:: with SMTP id p18mr19161510ywg.496.1566261212729;
        Mon, 19 Aug 2019 17:33:32 -0700 (PDT)
Received: from theseus.lan ([2604:2d80:b386:1f00::780])
        by smtp.gmail.com with ESMTPSA id 193sm3658853ywh.89.2019.08.19.17.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 17:33:32 -0700 (PDT)
From:   Clark Williams <clark.williams@gmail.com>
To:     bigeasy@linutronix.com
Cc:     tglx@linutronix.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PREEMPT_RT PATCH 3/3] i915: convert uncore lock to raw spinlock
Date:   Mon, 19 Aug 2019 19:33:19 -0500
Message-Id: <20190820003319.24135-4-clark.williams@gmail.com>
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

The structure intel_uncore contains a spinlock member
named 'lock' which is used in multiple contexts. Convert
it to a raw spinlock so that lockdep and the lock debugging
code will be happy.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/i915_gem.c          |  4 +-
 drivers/gpu/drm/i915/i915_irq.c          | 12 +++---
 drivers/gpu/drm/i915/i915_pmu.c          |  4 +-
 drivers/gpu/drm/i915/intel_display.c     | 16 ++++----
 drivers/gpu/drm/i915/intel_engine_cs.c   |  4 +-
 drivers/gpu/drm/i915/intel_pm.c          |  8 ++--
 drivers/gpu/drm/i915/intel_sprite.c      | 32 +++++++--------
 drivers/gpu/drm/i915/intel_uncore.c      | 52 ++++++++++++------------
 drivers/gpu/drm/i915/intel_uncore.h      |  2 +-
 drivers/gpu/drm/i915/intel_workarounds.c |  4 +-
 10 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 2910a133077a..09e097f8aae2 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -726,11 +726,11 @@ void i915_gem_flush_ggtt_writes(struct drm_i915_private *dev_priv)
 	i915_gem_chipset_flush(dev_priv);
 
 	with_intel_runtime_pm(dev_priv, wakeref) {
-		spin_lock_irq(&dev_priv->uncore.lock);
+		raw_spin_lock_irq(&dev_priv->uncore.lock);
 
 		POSTING_READ_FW(RING_HEAD(RENDER_RING_BASE));
 
-		spin_unlock_irq(&dev_priv->uncore.lock);
+		raw_spin_unlock_irq(&dev_priv->uncore.lock);
 	}
 }
 
diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index 9b86926299b1..b19a630e78c7 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -914,7 +914,7 @@ static u32 i915_get_vblank_counter(struct drm_device *dev, unsigned int pipe)
 	high_frame = PIPEFRAME(pipe);
 	low_frame = PIPEFRAMEPIXEL(pipe);
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/*
 	 * High & low register fields aren't synchronized, so make sure
@@ -927,7 +927,7 @@ static u32 i915_get_vblank_counter(struct drm_device *dev, unsigned int pipe)
 		high2 = I915_READ_FW(high_frame) & PIPE_FRAME_HIGH_MASK;
 	} while (high1 != high2);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
 	high1 >>= PIPE_FRAME_HIGH_SHIFT;
 	pixel = low & PIPE_PIXEL_MASK;
@@ -1097,7 +1097,7 @@ static bool i915_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	 * register reads, potentially with preemption disabled, so the
 	 * following code must not block on uncore.lock.
 	 */
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
 	preempt_disable_rt();
@@ -1154,7 +1154,7 @@ static bool i915_get_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
 	preempt_enable_rt();
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
 	/*
 	 * While in vblank, position will be negative
@@ -1184,9 +1184,9 @@ int intel_get_crtc_scanline(struct intel_crtc *crtc)
 	unsigned long irqflags;
 	int position;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 	position = __intel_get_crtc_scanline(crtc);
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
 	return position;
 }
diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 46a52da3db29..1df197c160dc 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -172,7 +172,7 @@ engines_sample(struct drm_i915_private *dev_priv, unsigned int period_ns)
 	if (!wakeref)
 		return;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, flags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, flags);
 	for_each_engine(engine, dev_priv, id) {
 		struct intel_engine_pmu *pmu = &engine->pmu;
 		bool busy;
@@ -202,7 +202,7 @@ engines_sample(struct drm_i915_private *dev_priv, unsigned int period_ns)
 		if (busy)
 			add_sample(&pmu->sample[I915_SAMPLE_BUSY], period_ns);
 	}
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, flags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, flags);
 
 	intel_runtime_pm_put(dev_priv, wakeref);
 }
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index 6618a551fe09..1994876db6a2 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -3420,7 +3420,7 @@ static void i9xx_update_plane(struct intel_plane *plane,
 	else
 		dspaddr_offset = linear_offset;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(DSPSTRIDE(i9xx_plane), plane_state->color_plane[0].stride);
 
@@ -3462,7 +3462,7 @@ static void i9xx_update_plane(struct intel_plane *plane,
 			      intel_plane_ggtt_offset(plane_state) +
 			      dspaddr_offset);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void i9xx_disable_plane(struct intel_plane *plane,
@@ -3485,7 +3485,7 @@ static void i9xx_disable_plane(struct intel_plane *plane,
 	 */
 	dspcntr = i9xx_plane_ctl_crtc(crtc_state);
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(DSPCNTR(i9xx_plane), dspcntr);
 	if (INTEL_GEN(dev_priv) >= 4)
@@ -3493,7 +3493,7 @@ static void i9xx_disable_plane(struct intel_plane *plane,
 	else
 		I915_WRITE_FW(DSPADDR(i9xx_plane), 0);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static bool i9xx_plane_get_hw_state(struct intel_plane *plane,
@@ -10282,7 +10282,7 @@ static void i845_update_cursor(struct intel_plane *plane,
 		pos = intel_cursor_position(plane_state);
 	}
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/* On these chipsets we can only modify the base/size/stride
 	 * whilst the cursor is disabled.
@@ -10303,7 +10303,7 @@ static void i845_update_cursor(struct intel_plane *plane,
 		I915_WRITE_FW(CURPOS(PIPE_A), pos);
 	}
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void i845_disable_cursor(struct intel_plane *plane,
@@ -10507,7 +10507,7 @@ static void i9xx_update_cursor(struct intel_plane *plane,
 		pos = intel_cursor_position(plane_state);
 	}
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/*
 	 * On some platforms writing CURCNTR first will also
@@ -10549,7 +10549,7 @@ static void i9xx_update_cursor(struct intel_plane *plane,
 		I915_WRITE_FW(CURBASE(pipe), base);
 	}
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void i9xx_disable_cursor(struct intel_plane *plane,
diff --git a/drivers/gpu/drm/i915/intel_engine_cs.c b/drivers/gpu/drm/i915/intel_engine_cs.c
index 9d4f12e982c3..2e41b645d459 100644
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -932,7 +932,7 @@ read_subslice_reg(struct drm_i915_private *dev_priv, int slice,
 						     GEN8_MCR_SELECTOR,
 						     FW_REG_READ | FW_REG_WRITE);
 
-	spin_lock_irq(&uncore->lock);
+	raw_spin_lock_irq(&uncore->lock);
 	intel_uncore_forcewake_get__locked(uncore, fw_domains);
 
 	mcr = intel_uncore_read_fw(uncore, GEN8_MCR_SELECTOR);
@@ -952,7 +952,7 @@ read_subslice_reg(struct drm_i915_private *dev_priv, int slice,
 	intel_uncore_write_fw(uncore, GEN8_MCR_SELECTOR, mcr);
 
 	intel_uncore_forcewake_put__locked(uncore, fw_domains);
-	spin_unlock_irq(&uncore->lock);
+	raw_spin_unlock_irq(&uncore->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/intel_pm.c b/drivers/gpu/drm/i915/intel_pm.c
index 44be676fabd6..3911aa3e825b 100644
--- a/drivers/gpu/drm/i915/intel_pm.c
+++ b/drivers/gpu/drm/i915/intel_pm.c
@@ -1971,7 +1971,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 	 * intel_pipe_update_start() has already disabled interrupts
 	 * for us, so a plain spin_lock() is sufficient here.
 	 */
-	spin_lock(&dev_priv->uncore.lock);
+	raw_spin_lock(&dev_priv->uncore.lock);
 
 	switch (crtc->pipe) {
 		u32 dsparb, dsparb2, dsparb3;
@@ -2032,7 +2032,7 @@ static void vlv_atomic_update_fifo(struct intel_atomic_state *state,
 
 	POSTING_READ_FW(DSPARB);
 
-	spin_unlock(&dev_priv->uncore.lock);
+	raw_spin_unlock(&dev_priv->uncore.lock);
 }
 
 #undef VLV_FIFO
@@ -10060,7 +10060,7 @@ u64 intel_rc6_residency_ns(struct drm_i915_private *dev_priv,
 
 	fw_domains = intel_uncore_forcewake_for_reg(uncore, reg, FW_REG_READ);
 
-	spin_lock_irqsave(&uncore->lock, flags);
+	raw_spin_lock_irqsave(&uncore->lock, flags);
 	intel_uncore_forcewake_get__locked(uncore, fw_domains);
 
 	/* On VLV and CHV, residency time is in CZ units rather than 1.28us */
@@ -10103,7 +10103,7 @@ u64 intel_rc6_residency_ns(struct drm_i915_private *dev_priv,
 	dev_priv->gt_pm.rc6.cur_residency[i] = time_hw;
 
 	intel_uncore_forcewake_put__locked(uncore, fw_domains);
-	spin_unlock_irqrestore(&uncore->lock, flags);
+	raw_spin_unlock_irqrestore(&uncore->lock, flags);
 
 	return mul_u64_u32_div(time_hw, mul, div);
 }
diff --git a/drivers/gpu/drm/i915/intel_sprite.c b/drivers/gpu/drm/i915/intel_sprite.c
index eb4b0b31f6f0..87427c3b588a 100644
--- a/drivers/gpu/drm/i915/intel_sprite.c
+++ b/drivers/gpu/drm/i915/intel_sprite.c
@@ -541,7 +541,7 @@ skl_program_plane(struct intel_plane *plane,
 		crtc_y = 0;
 	}
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(PLANE_STRIDE(pipe, plane_id), stride);
 	I915_WRITE_FW(PLANE_POS(pipe, plane_id), (crtc_y << 16) | crtc_x);
@@ -601,7 +601,7 @@ skl_program_plane(struct intel_plane *plane,
 	if (!slave && plane_state->scaler_id >= 0)
 		skl_program_scaler(plane, crtc_state, plane_state);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void
@@ -638,7 +638,7 @@ skl_disable_plane(struct intel_plane *plane,
 	enum pipe pipe = plane->pipe;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	if (icl_is_hdr_plane(dev_priv, plane_id))
 		I915_WRITE_FW(PLANE_CUS_CTL(pipe, plane_id), 0);
@@ -648,7 +648,7 @@ skl_disable_plane(struct intel_plane *plane,
 	I915_WRITE_FW(PLANE_CTL(pipe, plane_id), 0);
 	I915_WRITE_FW(PLANE_SURF(pipe, plane_id), 0);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static bool
@@ -878,7 +878,7 @@ vlv_update_plane(struct intel_plane *plane,
 
 	linear_offset = intel_fb_xy_to_linear(x, y, plane_state, 0);
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(SPSTRIDE(pipe, plane_id),
 		      plane_state->color_plane[0].stride);
@@ -909,7 +909,7 @@ vlv_update_plane(struct intel_plane *plane,
 
 	vlv_update_clrc(plane_state);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void
@@ -921,12 +921,12 @@ vlv_disable_plane(struct intel_plane *plane,
 	enum plane_id plane_id = plane->id;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(SPCNTR(pipe, plane_id), 0);
 	I915_WRITE_FW(SPSURF(pipe, plane_id), 0);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static bool
@@ -1059,7 +1059,7 @@ ivb_update_plane(struct intel_plane *plane,
 
 	linear_offset = intel_fb_xy_to_linear(x, y, plane_state, 0);
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(SPRSTRIDE(pipe), plane_state->color_plane[0].stride);
 	I915_WRITE_FW(SPRPOS(pipe), (crtc_y << 16) | crtc_x);
@@ -1091,7 +1091,7 @@ ivb_update_plane(struct intel_plane *plane,
 	I915_WRITE_FW(SPRSURF(pipe),
 		      intel_plane_ggtt_offset(plane_state) + sprsurf_offset);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void
@@ -1102,7 +1102,7 @@ ivb_disable_plane(struct intel_plane *plane,
 	enum pipe pipe = plane->pipe;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(SPRCTL(pipe), 0);
 	/* Disable the scaler */
@@ -1110,7 +1110,7 @@ ivb_disable_plane(struct intel_plane *plane,
 		I915_WRITE_FW(SPRSCALE(pipe), 0);
 	I915_WRITE_FW(SPRSURF(pipe), 0);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static bool
@@ -1250,7 +1250,7 @@ g4x_update_plane(struct intel_plane *plane,
 
 	linear_offset = intel_fb_xy_to_linear(x, y, plane_state, 0);
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(DVSSTRIDE(pipe), plane_state->color_plane[0].stride);
 	I915_WRITE_FW(DVSPOS(pipe), (crtc_y << 16) | crtc_x);
@@ -1275,7 +1275,7 @@ g4x_update_plane(struct intel_plane *plane,
 	I915_WRITE_FW(DVSSURF(pipe),
 		      intel_plane_ggtt_offset(plane_state) + dvssurf_offset);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static void
@@ -1286,14 +1286,14 @@ g4x_disable_plane(struct intel_plane *plane,
 	enum pipe pipe = plane->pipe;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
+	raw_spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	I915_WRITE_FW(DVSCNTR(pipe), 0);
 	/* Disable the scaler */
 	I915_WRITE_FW(DVSSCALE(pipe), 0);
 	I915_WRITE_FW(DVSSURF(pipe), 0);
 
-	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
+	raw_spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 }
 
 static bool
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index d1d51e1121e2..e91502b99187 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -348,14 +348,14 @@ intel_uncore_fw_release_timer(struct hrtimer *timer)
 	if (xchg(&domain->active, false))
 		return HRTIMER_RESTART;
 
-	spin_lock_irqsave(&uncore->lock, irqflags);
+	raw_spin_lock_irqsave(&uncore->lock, irqflags);
 	if (WARN_ON(domain->wake_count == 0))
 		domain->wake_count++;
 
 	if (--domain->wake_count == 0)
 		uncore->funcs.force_wake_put(uncore, domain->mask);
 
-	spin_unlock_irqrestore(&uncore->lock, irqflags);
+	raw_spin_unlock_irqrestore(&uncore->lock, irqflags);
 
 	return HRTIMER_NORESTART;
 }
@@ -388,7 +388,7 @@ intel_uncore_forcewake_reset(struct intel_uncore *uncore)
 			intel_uncore_fw_release_timer(&domain->timer);
 		}
 
-		spin_lock_irqsave(&uncore->lock, irqflags);
+		raw_spin_lock_irqsave(&uncore->lock, irqflags);
 
 		for_each_fw_domain(domain, uncore, tmp) {
 			if (hrtimer_active(&domain->timer))
@@ -403,7 +403,7 @@ intel_uncore_forcewake_reset(struct intel_uncore *uncore)
 			break;
 		}
 
-		spin_unlock_irqrestore(&uncore->lock, irqflags);
+		raw_spin_unlock_irqrestore(&uncore->lock, irqflags);
 		cond_resched();
 	}
 
@@ -416,7 +416,7 @@ intel_uncore_forcewake_reset(struct intel_uncore *uncore)
 	fw_domains_reset(uncore, uncore->fw_domains);
 	assert_forcewakes_inactive(uncore);
 
-	spin_unlock_irqrestore(&uncore->lock, irqflags);
+	raw_spin_unlock_irqrestore(&uncore->lock, irqflags);
 
 	return fw; /* track the lost user forcewake domains */
 }
@@ -499,12 +499,12 @@ static void __intel_uncore_early_sanitize(struct intel_uncore *uncore,
 	iosf_mbi_punit_acquire();
 	intel_uncore_forcewake_reset(uncore);
 	if (restore_forcewake) {
-		spin_lock_irq(&uncore->lock);
+		raw_spin_lock_irq(&uncore->lock);
 		uncore->funcs.force_wake_get(uncore, restore_forcewake);
 
 		if (intel_uncore_has_fifo(uncore))
 			uncore->fifo_count = fifo_free_entries(uncore);
-		spin_unlock_irq(&uncore->lock);
+		raw_spin_unlock_irq(&uncore->lock);
 	}
 	iosf_mbi_punit_release();
 }
@@ -581,9 +581,9 @@ void intel_uncore_forcewake_get(struct intel_uncore *uncore,
 
 	__assert_rpm_wakelock_held(uncore->rpm);
 
-	spin_lock_irqsave(&uncore->lock, irqflags);
+	raw_spin_lock_irqsave(&uncore->lock, irqflags);
 	__intel_uncore_forcewake_get(uncore, fw_domains);
-	spin_unlock_irqrestore(&uncore->lock, irqflags);
+	raw_spin_unlock_irqrestore(&uncore->lock, irqflags);
 }
 
 /**
@@ -596,7 +596,7 @@ void intel_uncore_forcewake_get(struct intel_uncore *uncore,
  */
 void intel_uncore_forcewake_user_get(struct intel_uncore *uncore)
 {
-	spin_lock_irq(&uncore->lock);
+	raw_spin_lock_irq(&uncore->lock);
 	if (!uncore->user_forcewake.count++) {
 		intel_uncore_forcewake_get__locked(uncore, FORCEWAKE_ALL);
 
@@ -609,7 +609,7 @@ void intel_uncore_forcewake_user_get(struct intel_uncore *uncore)
 		uncore->unclaimed_mmio_check = 0;
 		i915_modparams.mmio_debug = 0;
 	}
-	spin_unlock_irq(&uncore->lock);
+	raw_spin_unlock_irq(&uncore->lock);
 }
 
 /**
@@ -621,7 +621,7 @@ void intel_uncore_forcewake_user_get(struct intel_uncore *uncore)
  */
 void intel_uncore_forcewake_user_put(struct intel_uncore *uncore)
 {
-	spin_lock_irq(&uncore->lock);
+	raw_spin_lock_irq(&uncore->lock);
 	if (!--uncore->user_forcewake.count) {
 		if (intel_uncore_unclaimed_mmio(uncore))
 			dev_info(uncore_to_i915(uncore)->drm.dev,
@@ -634,7 +634,7 @@ void intel_uncore_forcewake_user_put(struct intel_uncore *uncore)
 
 		intel_uncore_forcewake_put__locked(uncore, FORCEWAKE_ALL);
 	}
-	spin_unlock_irq(&uncore->lock);
+	raw_spin_unlock_irq(&uncore->lock);
 }
 
 /**
@@ -693,9 +693,9 @@ void intel_uncore_forcewake_put(struct intel_uncore *uncore,
 	if (!uncore->funcs.force_wake_put)
 		return;
 
-	spin_lock_irqsave(&uncore->lock, irqflags);
+	raw_spin_lock_irqsave(&uncore->lock, irqflags);
 	__intel_uncore_forcewake_put(uncore, fw_domains);
-	spin_unlock_irqrestore(&uncore->lock, irqflags);
+	raw_spin_unlock_irqrestore(&uncore->lock, irqflags);
 }
 
 /**
@@ -1093,12 +1093,12 @@ __gen2_read(64)
 	unsigned long irqflags; \
 	u##x val = 0; \
 	__assert_rpm_wakelock_held(uncore->rpm); \
-	spin_lock_irqsave(&uncore->lock, irqflags); \
+	raw_spin_lock_irqsave(&uncore->lock, irqflags); \
 	unclaimed_reg_debug(uncore, reg, true, true)
 
 #define GEN6_READ_FOOTER \
 	unclaimed_reg_debug(uncore, reg, true, false); \
-	spin_unlock_irqrestore(&uncore->lock, irqflags); \
+	raw_spin_unlock_irqrestore(&uncore->lock, irqflags); \
 	trace_i915_reg_rw(false, reg, val, sizeof(val), trace); \
 	return val
 
@@ -1205,12 +1205,12 @@ __gen2_write(32)
 	unsigned long irqflags; \
 	trace_i915_reg_rw(true, reg, val, sizeof(val), trace); \
 	__assert_rpm_wakelock_held(uncore->rpm); \
-	spin_lock_irqsave(&uncore->lock, irqflags); \
+	raw_spin_lock_irqsave(&uncore->lock, irqflags); \
 	unclaimed_reg_debug(uncore, reg, false, true)
 
 #define GEN6_WRITE_FOOTER \
 	unclaimed_reg_debug(uncore, reg, false, false); \
-	spin_unlock_irqrestore(&uncore->lock, irqflags)
+	raw_spin_unlock_irqrestore(&uncore->lock, irqflags)
 
 #define __gen6_write(x) \
 static void \
@@ -1423,11 +1423,11 @@ static void intel_uncore_fw_domains_init(struct intel_uncore *uncore)
 		fw_domain_init(uncore, FW_DOMAIN_ID_RENDER,
 			       FORCEWAKE_MT, FORCEWAKE_MT_ACK);
 
-		spin_lock_irq(&uncore->lock);
+		raw_spin_lock_irq(&uncore->lock);
 		fw_domains_get_with_thread_status(uncore, FORCEWAKE_RENDER);
 		ecobus = __raw_uncore_read32(uncore, ECOBUS);
 		fw_domains_put(uncore, FORCEWAKE_RENDER);
-		spin_unlock_irq(&uncore->lock);
+		raw_spin_unlock_irq(&uncore->lock);
 
 		if (!(ecobus & FORCEWAKE_MT_ENABLE)) {
 			DRM_INFO("No MT forcewake available on Ivybridge, this can result in issues\n");
@@ -1527,7 +1527,7 @@ static void uncore_mmio_cleanup(struct intel_uncore *uncore)
 
 void intel_uncore_init_early(struct intel_uncore *uncore)
 {
-	spin_lock_init(&uncore->lock);
+	raw_spin_lock_init(&uncore->lock);
 }
 
 int intel_uncore_init_mmio(struct intel_uncore *uncore)
@@ -1805,7 +1805,7 @@ int __intel_wait_for_register(struct intel_uncore *uncore,
 
 	might_sleep_if(slow_timeout_ms);
 
-	spin_lock_irq(&uncore->lock);
+	raw_spin_lock_irq(&uncore->lock);
 	intel_uncore_forcewake_get__locked(uncore, fw);
 
 	ret = __intel_wait_for_register_fw(uncore,
@@ -1813,7 +1813,7 @@ int __intel_wait_for_register(struct intel_uncore *uncore,
 					   fast_timeout_us, 0, &reg_value);
 
 	intel_uncore_forcewake_put__locked(uncore, fw);
-	spin_unlock_irq(&uncore->lock);
+	raw_spin_unlock_irq(&uncore->lock);
 
 	if (ret && slow_timeout_ms)
 		ret = __wait_for(reg_value = intel_uncore_read_notrace(uncore,
@@ -1840,7 +1840,7 @@ intel_uncore_arm_unclaimed_mmio_detection(struct intel_uncore *uncore)
 {
 	bool ret = false;
 
-	spin_lock_irq(&uncore->lock);
+	raw_spin_lock_irq(&uncore->lock);
 
 	if (unlikely(uncore->unclaimed_mmio_check <= 0))
 		goto out;
@@ -1857,7 +1857,7 @@ intel_uncore_arm_unclaimed_mmio_detection(struct intel_uncore *uncore)
 	}
 
 out:
-	spin_unlock_irq(&uncore->lock);
+	raw_spin_unlock_irq(&uncore->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/intel_uncore.h b/drivers/gpu/drm/i915/intel_uncore.h
index d6af3de70121..6518674b7871 100644
--- a/drivers/gpu/drm/i915/intel_uncore.h
+++ b/drivers/gpu/drm/i915/intel_uncore.h
@@ -99,7 +99,7 @@ struct intel_uncore {
 
 	struct i915_runtime_pm *rpm;
 
-	spinlock_t lock; /** lock is also taken in irq contexts. */
+	raw_spinlock_t lock; /** lock is also taken in irq contexts. */
 
 	unsigned int flags;
 #define UNCORE_HAS_FORCEWAKE		BIT(0)
diff --git a/drivers/gpu/drm/i915/intel_workarounds.c b/drivers/gpu/drm/i915/intel_workarounds.c
index 841b8e515f4d..47cb288f4154 100644
--- a/drivers/gpu/drm/i915/intel_workarounds.c
+++ b/drivers/gpu/drm/i915/intel_workarounds.c
@@ -928,7 +928,7 @@ wa_list_apply(struct intel_uncore *uncore, const struct i915_wa_list *wal)
 
 	fw = wal_get_fw_for_rmw(uncore, wal);
 
-	spin_lock_irqsave(&uncore->lock, flags);
+	raw_spin_lock_irqsave(&uncore->lock, flags);
 	intel_uncore_forcewake_get__locked(uncore, fw);
 
 	for (i = 0, wa = wal->list; i < wal->count; i++, wa++) {
@@ -936,7 +936,7 @@ wa_list_apply(struct intel_uncore *uncore, const struct i915_wa_list *wal)
 	}
 
 	intel_uncore_forcewake_put__locked(uncore, fw);
-	spin_unlock_irqrestore(&uncore->lock, flags);
+	raw_spin_unlock_irqrestore(&uncore->lock, flags);
 }
 
 void intel_gt_apply_workarounds(struct drm_i915_private *i915)
-- 
2.21.0

