From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 09/19] gpu: i915: allow the user not to do the wbinvd
Date: Sun, 08 Sep 2013 11:14:04 -0400
Message-ID: <20130908151447.241176823@goodmis.org>
References: <20130908151355.362583092@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>, <stable-rt@vger.kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0009-gpu-i915-allow-the-user-not-to-do-the-wbinvd.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The wbinvd() renders the system with i915 unusable on RT. Using this
expensive instruction avoids GPU trouble according to
   https://bugs.freedesktop.org/show_bug.cgi?id=62191

As a workaround for RT it is recommended to pin each GPU related process
to the same CPU and then disable this instruction via the module
paramter.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/i915/i915_gem.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 18da42c..a3f72cb 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -36,6 +36,7 @@
 #include <linux/swap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/module.h>
 
 static __must_check int i915_gem_object_flush_gpu_write_domain(struct drm_i915_gem_object *obj);
 static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
@@ -2525,6 +2526,10 @@ static inline int fence_number(struct drm_i915_private *dev_priv,
 	return fence - dev_priv->fence_regs;
 }
 
+static bool do_wbinvd = true;
+module_param(do_wbinvd, bool, 0644);
+MODULE_PARM_DESC(do_wbinvd, "Do expensive synchronization. Say no after you pin each GPU process to the same CPU in order to lower the latency.");
+
 static void i915_gem_write_fence__ipi(void *data)
 {
 	wbinvd();
@@ -2548,8 +2553,16 @@ static void i915_gem_object_update_fence(struct drm_i915_gem_object *obj,
 	 * on each processor in order to manually flush all memory
 	 * transactions before updating the fence register.
 	 */
-	if (HAS_LLC(obj->base.dev))
-		on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
+	if (HAS_LLC(obj->base.dev)) {
+		if (do_wbinvd) {
+#ifdef CONFIG_PREEMPT_RT_FULL
+			pr_err_once("WARNING! The i915 invalidates all caches which increases the latency.");
+			pr_err_once("As a workaround use 'i915.do_wbinvd=no' and PIN each process doing ");
+			pr_err_once("any kind of GPU activity to the same CPU to avoid problems.");
+#endif
+			on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
+		}
+	}
 	i915_gem_write_fence(dev, fence_reg, enable ? obj : NULL);
 
 	if (enable) {
-- 
1.7.10.4
