From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] gpu: i915: allow the user not to do the wbinvd ("Was: Re:
 [ANNOUNCE] 3.8.13-rt11)
Date: Fri, 21 Jun 2013 11:49:01 +0200
Message-ID: <20130621094901.GA19015@linutronix.de>
References: <20130614193037.GC8597@linutronix.de>
 <51BB7A3D.8070305@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christoph Mathys <eraserix@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel@ffwll.ch>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38041 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730Ab3FUJtH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 05:49:07 -0400
Content-Disposition: inline
In-Reply-To: <51BB7A3D.8070305@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Carsten Emde | 2013-06-14 22:17:01 [+0200]:

>Hi Sebastian,
Hi Carsten,

>>     - a "fix" for i915 leads to high latencies due to wbinvd(). Not sure
>>       what is the best thing to do here.
>Even if we do not yet know what is the best final solution to this
>problem, there is no doubt that, for the time being, the patch in
>question has to be reverted - the earlier the better. Please
>understand that this RT kernel release it totally unusable on a
>system that is equipped with one of several widely used Intel
>graphics boards. It simply is a waste of time.

Yes but reverting causes problems for others. Anyway, in order to make
progress here and not break anything I include the patch below. So
everyone who does not want the expensive sync can specify
i915.do_wbinvd=no after they ensured that the same CPU is used for GPU
related operations.

Subject: [PATCH] gpu: i915: allow the user not to do the wbinvd

The wbinvd() renders the system with i915 unusable on RT. Using this
expensive instruction avoids GPU trouble according to
   https://bugs.freedesktop.org/show_bug.cgi?id=62191

As a workaround for RT it is recommended to pin each GPU related process
to the same CPU and then disable this instruction via the module
paramter.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/i915/i915_gem.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 339540d..dce41f4 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -35,6 +35,7 @@
 #include <linux/swap.h>
 #include <linux/pci.h>
 #include <linux/dma-buf.h>
+#include <linux/module.h>
 
 static void i915_gem_object_flush_gtt_write_domain(struct drm_i915_gem_object *obj);
 static void i915_gem_object_flush_cpu_write_domain(struct drm_i915_gem_object *obj);
@@ -2656,6 +2657,10 @@ static inline int fence_number(struct drm_i915_private *dev_priv,
 	return fence - dev_priv->fence_regs;
 }
 
+static bool do_wbinvd = true;
+module_param(do_wbinvd, bool, 0644);
+MODULE_PARM_DESC(do_wbinvd, "Do expensive synchronization. Say no after you pin each GPU process to the same CPU in order to lower the latency.");
+
 static void i915_gem_write_fence__ipi(void *data)
 {
 	wbinvd();
@@ -2679,8 +2684,16 @@ static void i915_gem_object_update_fence(struct drm_i915_gem_object *obj,
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
1.8.3.1


>
>	-Carsten.

Sebastian
