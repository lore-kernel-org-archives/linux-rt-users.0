From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 12/17] drm,radeon,i915: Use preempt_disable/enable_rt() where recommended
Date: Wed, 02 Mar 2016 10:44:45 -0500
Message-ID: <20160302154501.720677791@goodmis.org>
References: <20160302154433.638594715@goodmis.org>
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
Content-Disposition: inline; filename=0012-drm-radeon-i915-Use-preempt_disable-enable_rt-where-.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

3.14.61-rt64-rc1 stable review patch.
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
index 40504504c9e2..a7368ce0e912 100644
--- a/drivers/gpu/drm/i915/i915_irq.c
+++ b/drivers/gpu/drm/i915/i915_irq.c
@@ -680,6 +680,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 	spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
 	
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -769,6 +770,7 @@ static int i915_get_crtc_scanoutpos(struct drm_device *dev, int pipe,
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	spin_unlock_irqrestore(&dev_priv->uncore.lock, irqflags);
 
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 1af604a4512a..444bc26e0dd1 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -1644,6 +1644,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 	struct radeon_device *rdev = dev->dev_private;
 
 	/* preempt_disable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_disable_rt();
 
 	/* Get optional system timestamp before query. */
 	if (stime)
@@ -1736,6 +1737,7 @@ int radeon_get_crtc_scanoutpos(struct drm_device *dev, int crtc, unsigned int fl
 		*etime = ktime_get();
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
+	preempt_enable_rt();
 
 	/* Decode into vertical and horizontal scanout position. */
 	*vpos = position & 0x1fff;
-- 
2.7.0
