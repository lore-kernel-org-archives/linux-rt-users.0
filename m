From: Carsten Emde <C.Emde@osadl.org>
Subject: [PATCH] Re: [ANNOUNCE] 3.6.11.4-rt36
Date: Sat, 08 Jun 2013 18:09:11 +0200
Message-ID: <51B35727.6040907@osadl.org>
References: <1369154725.6828.131.camel@gandalf.local.home>  <CALqGcGop=cpgSvcdmwE6QOSjo-JHBDGYpe2qyy3cxULfamgy+w@mail.gmail.com> <1370637266.9844.95.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christoph Mathys <eraserix@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Jon Bloomfield <jon.bloomfield@intel.com>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:43176 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751566Ab3FHQMX (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 8 Jun 2013 12:12:23 -0400
In-Reply-To: <1370637266.9844.95.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/07/2013 10:34 PM, Steven Rostedt wrote:
> On Mon, 2013-05-27 at 09:34 +0200, Christoph Mathys wrote:
>> Just did a quick "smoketest" with cyclictest. This release spikes to
>> over 600us when opening other gnome-terminals or switching to a VTY
>> etc. I checked with 3.6.11.3-rt35, and the problem does not occur
>> there.
> I'm not able to reproduce this.
I am -> https://www.osadl.org/?id=1543#c7602. It is similarly
reproducible on current 3.6 and 3.8 RT kernels. You probably won't be
able to reproduce the regression unless you use an impacted graphics
adapter.

Please revert until Chris Wilson (or anybody else) finds a better
solution for the problem the patch wanted to fix.

<rogue>
It generally is not a good idea to unconditionally invalidate and flush
the entire cache, since this will finally get rid of any remaining
determinism. A mechanism must be used to ensure that only affected
cache lines are treated, if any. If this is not possible, then we simply
need to go without the original patch.
</rogue>

	-Carsten.


Subject: drm/i915: Revert workaround incoherence between fences and LLC 
across multiple CPUs

Originally from: Chris Wilson <chris@chris-wilson.co.uk>

Original commit 25ff1195f8a0b3724541ae7bbe331b4296de9c06 upstream.

In order to fully serialize access to the fenced region and the update
to the fence register we need to take extreme measures on SNB+, and
manually flush writes to memory prior to writing the fence register in
conjunction with the memory barriers placed around the register write.

Fixes i-g-t/gem_fence_thrash

v2: Bring a bigger gun
v3: Switch the bigger gun for heavier bullets (Arjan van de Ven)
v4: Remove changes for working generations.
v5: Reduce to a per-cpu wbinvd() call prior to updating the fences.
v6: Rewrite comments to ellide forgotten history.

Revert because it introduces long latencies of up to 2 milliseconds in
RT kernels until we find a better solution. No guns please.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=62191
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jon Bloomfield <jon.bloomfield@intel.com>
Tested-by: Jon Bloomfield <jon.bloomfield@intel.com> (v2)
Cc: stable@vger.kernel.org
Signed-off-by: Carsten Emde <C.Emde@osadl.org>

---
  i915_gem.c |   26 ++++----------------------
  1 file changed, 4 insertions(+), 22 deletions(-)

Index: linux-3.8.13-rt10/drivers/gpu/drm/i915/i915_gem.c
===================================================================
--- linux-3.8.13-rt10.orig/drivers/gpu/drm/i915/i915_gem.c
+++ linux-3.8.13-rt10/drivers/gpu/drm/i915/i915_gem.c
@@ -2656,35 +2656,17 @@ static inline int fence_number(struct dr
  	return fence - dev_priv->fence_regs;
  }

-static void i915_gem_write_fence__ipi(void *data)
-{
-	wbinvd();
-}
-
  static void i915_gem_object_update_fence(struct drm_i915_gem_object *obj,
  					 struct drm_i915_fence_reg *fence,
  					 bool enable)
  {
-	struct drm_device *dev = obj->base.dev;
-	struct drm_i915_private *dev_priv = dev->dev_private;
-	int fence_reg = fence_number(dev_priv, fence);
+	struct drm_i915_private *dev_priv = obj->base.dev->dev_private;
+	int reg = fence_number(dev_priv, fence);

-	/* In order to fully serialize access to the fenced region and
-	 * the update to the fence register we need to take extreme
-	 * measures on SNB+. In theory, the write to the fence register
-	 * flushes all memory transactions before, and coupled with the
-	 * mb() placed around the register write we serialise all memory
-	 * operations with respect to the changes in the tiler. Yet, on
-	 * SNB+ we need to take a step further and emit an explicit wbinvd()
-	 * on each processor in order to manually flush all memory
-	 * transactions before updating the fence register.
-	 */
-	if (HAS_LLC(obj->base.dev))
-		on_each_cpu(i915_gem_write_fence__ipi, NULL, 1);
-	i915_gem_write_fence(dev, fence_reg, enable ? obj : NULL);
+	i915_gem_write_fence(obj->base.dev, reg, enable ? obj : NULL);

  	if (enable) {
-		obj->fence_reg = fence_reg;
+		obj->fence_reg = reg;
  		fence->obj = obj;
  		list_move_tail(&fence->lru_list, &dev_priv->mm.fence_list);
  	} else {
