From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.8.4-rt1
Date: Sat, 23 Mar 2013 19:38:27 +0100
Message-ID: <20130323183827.GA31738@linutronix.de>
References: <alpine.LFD.2.02.1303222301010.22263@ionos>
 <20130323013003.GU11538@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41123 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3CWSi2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Mar 2013 14:38:28 -0400
Content-Disposition: inline
In-Reply-To: <20130323013003.GU11538@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luis Claudio R. Goncalves | 2013-03-22 22:30:03 [-0300]:

What about this:

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i91=
5_gem.c
index de45b60..9b51712 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -91,7 +91,6 @@ i915_gem_wait_for_error(struct drm_device *dev)
 {
 	struct drm_i915_private *dev_priv =3D dev->dev_private;
 	struct completion *x =3D &dev_priv->error_completion;
-	unsigned long flags;
 	int ret;
=20
 	if (!atomic_read(&dev_priv->mm.wedged))
@@ -116,9 +115,7 @@ i915_gem_wait_for_error(struct drm_device *dev)
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
@@ -946,12 +943,9 @@ i915_gem_check_wedge(struct drm_i915_private *dev_=
priv,
 	if (atomic_read(&dev_priv->mm.wedged)) {
 		struct completion *x =3D &dev_priv->error_completion;
 		bool recovery_complete;
-		unsigned long flags;
=20
 		/* Give the error handler a chance to run. */
-		spin_lock_irqsave(&x->wait.lock, flags);
-		recovery_complete =3D x->done > 0;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		recovery_complete =3D completion_done(x);
=20
 		/* Non-interruptible callers can't handle -EAGAIN, hence return
 		 * -EIO unconditionally for these. */
@@ -4366,7 +4360,7 @@ static bool mutex_is_locked_by(struct mutex *mute=
x, struct task_struct *task)
 	if (!mutex_is_locked(mutex))
 		return false;
=20
-#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_MUTEXES)
+#if (defined(CONFIG_SMP) || defined(CONFIG_DEBUG_MUTEXES)) && !defined=
(CONFIG_PREEMPT_RT_BASE)
 	return mutex->owner =3D=3D task;
 #else
 	/* Since UP may be pre-empted, we cannot assume that we own the lock =
*/


I'm not very happy with the complete() here, I am not sure what kind of
problem they try to solve here=E2=80=A6

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
