From: Mike Galbraith <bitbucket@online.de>
Subject: Re: 3.[68]-rt: CONFIG_PROVE_LOCKING +
 CONFIG_DEBUG_FORCE_WEAK_PER_CPU = boot time swap_lock deadlock
Date: Wed, 24 Apr 2013 07:47:24 +0200
Message-ID: <1366782444.5921.4.camel@marge.simpson.net>
References: <1365937652.4717.25.camel@marge.simpson.net>
	 <1366685096.9609.145.camel@gandalf.local.home>
	 <1366685257.9609.147.camel@gandalf.local.home>
	 <1366686791.4731.16.camel@marge.simpson.net>
	 <1366732855.9609.158.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61958 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab3DXFre (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Apr 2013 01:47:34 -0400
In-Reply-To: <1366732855.9609.158.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2013-04-23 at 12:00 -0400, Steven Rostedt wrote: 
> On Tue, 2013-04-23 at 05:13 +0200, Mike Galbraith wrote:
> > On Mon, 2013-04-22 at 22:47 -0400, Steven Rostedt wrote:
> > 
> > > Yeah, the bug is with the swap_lock not being unique (do a git grep
> > > swap_lock), and it being weak made that per_cpu swap_lock the same lock
> > > as the other locks.
> > > 
> > > Apply my patch and your bug should go away.
> > 
> > Aha, so the bug is certainly dead.  I'll test anyway, but you can take
> > no news as confirmation that it's dead.
> > 
> 
> Actually, I would feel more comfortable if I heard news that confirms
> its dead ;-)
> 
> /me hopes to hear "It's dead Jim".

It's-dead-Jim-by: Mike Galbraith <bitbucket@online.de>

For 3.6-rt tested, I added the hunk below, which isn't in 3.8-rt..

@@ -850,7 +850,7 @@ EXPORT_SYMBOL(pagevec_lookup_tag);
 static int __init swap_init_locks(void)
 {
 	local_irq_lock_init(rotate_lock);
-	local_irq_lock_init(swap_lock);
+	local_irq_lock_init(swapvec_lock);
 	return 1;
 }
 early_initcall(swap_init_locks);

..and build fix stolen from 3.8-rt.

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: gpu/i915: don't open code these things

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/i915/i915_gem.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -90,7 +90,6 @@ i915_gem_wait_for_error(struct drm_devic
 {
 	struct drm_i915_private *dev_priv = dev->dev_private;
 	struct completion *x = &dev_priv->error_completion;
-	unsigned long flags;
 	int ret;
 
 	if (!atomic_read(&dev_priv->mm.wedged))
@@ -115,9 +114,7 @@ i915_gem_wait_for_error(struct drm_devic
 		 * end up waiting upon a subsequent completion event that
 		 * will never happen.
 		 */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		x->done++;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		complete(x);
 	}
 	return 0;
 }
@@ -1884,12 +1881,9 @@ i915_gem_check_wedge(struct drm_i915_pri
 	if (atomic_read(&dev_priv->mm.wedged)) {
 		struct completion *x = &dev_priv->error_completion;
 		bool recovery_complete;
-		unsigned long flags;
 
 		/* Give the error handler a chance to run. */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		recovery_complete = x->done > 0;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		recovery_complete = completion_done(x);
 
 		/* Non-interruptible callers can't handle -EAGAIN, hence return
 		 * -EIO unconditionally for these. */


