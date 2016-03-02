From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 16/22] drm,radeon,i915: Use preempt_disable/enable_rt() where recommended
Date: Wed, 02 Mar 2016 10:09:15 -0500
Message-ID: <20160302151112.908005166@goodmis.org>
References: <20160302150859.204542604@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0016-drm-radeon-i915-Use-preempt_disable-enable_rt-where-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.1.15-rt18-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <umgwanakikbuti@gmail.com>

DRM folks identified the spots, so use them.

Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/gpu/drm/i915/i915_irq.c         | 2 ++
 drivers/gpu/drm/radeon/radeon_display.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_irq.c b/drivers/gpu/drm/i915/i915_irq.c
index b0df8d10482a..8d34df020842 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -676,6 +676,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -727,6 +728,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 6743174acdbc..8ad198bbc24d 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1798,6 +1798,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 	struct radeon_device *rdev = dev->dev_private;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -1890,6 +1891,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	/* Decode into vertical and horizontal scanout position. */
 	*vpos = position & 0x1fff;
-- 
2.7.0
