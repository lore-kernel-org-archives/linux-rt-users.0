From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH v2] drm/i915: Do not flush caches on RT, print a warning instead
Date: Sun, 09 Jun 2013 13:45:04 +0200
Message-ID: <51B46AC0.7050502@osadl.org>
References: <1369154725.6828.131.camel@gandalf.local.home>  <CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com> <1370637266.9844.95.camel@gandalf.local.home> <51B35727.6040907@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christoph Mathys <eraserix@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Daniel Vetter <daniel@ffwll.ch>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:46256 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360Ab3FILwY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 9 Jun 2013 07:52:24 -0400
In-Reply-To: <51B35727.6040907@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Invalidating and flushing all caches may introduce long latencies of up
to several milliseconds. Do not execute it in PREEMPT_RT_FULL kernels,
warn once instead and propose to pin all GPU renderering tasks to a
single CPU, if possible.

Original commit:
25ff1195f8a0b3724541ae7bbe331b4296de9c06 upstream.

Original log:
In order to fully serialize access to the fenced region and the update
to the fence register we need to take extreme measures on SNB+, and
manually flush writes to memory prior to writing the fence register in
conjunction with the memory barriers placed around the register write.

Cc: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
  i915_gem.c |   26 ++++----------------------
  1 file changed, 4 insertions(+), 22 deletions(-)

Index: linux-3.8.13-rt10/drivers/gpu/drm/i915/i915_gem.c
===================================================================
--- linux-3.8.13-rt10.orig/drivers/gpu/drm/i915/i915_gem.c
+++ linux-3.8.13-rt10/drivers/gpu/drm/i915/i915_gem.c
@@ -2656,10 +2656,12 @@ static inline int fence_number(struct dr
  	return fence - dev_priv->fence_regs;
  }

+#ifndef CONFIG_PREEMPT_RT_FULL
  static void i915_gem_write_fence__ipi(void *data)
  {
  	wbinvd();
  }
+#endif

  static void i915_gem_object_update_fence(struct drm_i915_gem_object *obj,
  					 struct drm_i915_fence_reg *fence,
@@ -2679,8 +2681,18 @@ static void i915_gem_object_update_fence
  	 * on each processor in order to manually flush all memory
  	 * transactions before updating the fence register.
  	 */
+#ifdef CONFIG_PREEMPT_RT_FULL
+	if (HAS_LLC(obj->base.dev)) {
+		WARN_ONCE(1, "Cannot flush caches on RT"
+#ifdef CONFIG_SMP
+		", please pin rendering tasks to a single CPU"
+#endif
+		"\n");
+	}
+#else
  	if (HAS_LLC(obj->base.dev))
  		on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
+#endif
  	i915_gem_write_fence(dev, fence_reg, enable ? obj : NULL);

  	if (enable) {

