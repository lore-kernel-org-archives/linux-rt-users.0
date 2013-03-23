From: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [ANNOUNCE] 3.8.4-rt1
Date: Fri, 22 Mar 2013 22:30:03 -0300
Message-ID: <20130323013003.GU11538@uudg.org>
References: <alpine.LFD.2.02.1303222301010.22263@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Sebastian Sewior <bigeasy@linutronix.de>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gg0-f181.google.com ([209.85.161.181]:50158 "EHLO
	mail-gg0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422766Ab3CWBho (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Mar 2013 21:37:44 -0400
Received: by mail-gg0-f181.google.com with SMTP id e5so204511ggh.26
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Mar 2013 18:37:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1303222301010.22263@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Mar 22, 2013 at 11:10:11PM +0100, Thomas Gleixner wrote:
| Dear RT Folks,
| 
| I'm pleased to announce the 3.8.4-rt1 release.
| 
| Again the credit for the heavy lifting goes to Sebastian Siewior, AKA
| bigeasy, who took up most of the work to get this out. He's on my
| companies engineering team and I hope you trust him as much as I do.
| 
| Known issues:
| 
|       - SLUB behaves worse than SLAB on ARM
|       - SLAB is broken on PowerPC
| 
| Still we think that it's time to get out the stuff for broader
| testing. It's -rt1 and we need your help to get this stabilized.

Thomas, in order to build 3.8.4-rt1 I had to apply this little chenge:

As struct completion has a raw_spin_lock, we need to use the matching
(raw_*) locking funtions.

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index de45b60..817e60b 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -116,9 +116,9 @@ i915_gem_wait_for_error(struct drm_device *dev)
 		 * end up waiting upon a subsequent completion event that
 		 * will never happen.
 		 */
-		spin_lock_irqsave(&x->wait.lock, flags);
+		raw_spin_lock_irqsave(&x->wait.lock, flags);
 		x->done++;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 	}
 	return 0;
 }
@@ -949,9 +949,9 @@ i915_gem_check_wedge(struct drm_i915_private *dev_priv,
 		unsigned long flags;
 
 		/* Give the error handler a chance to run. */
-		spin_lock_irqsave(&x->wait.lock, flags);
+		raw_spin_lock_irqsave(&x->wait.lock, flags);
 		recovery_complete = x->done > 0;
-		spin_unlock_irqrestore(&x->wait.lock, flags);
+		raw_spin_unlock_irqrestore(&x->wait.lock, flags);
 
 		/* Non-interruptible callers can't handle -EAGAIN, hence return
 		 * -EIO unconditionally for these. */

-- 
[ Luis Claudio R. Goncalves                    Bass - Gospel - RT ]
[ Fingerprint: 4FDD B8C4 3C59 34BD 8BE9  2696 7203 D980 A448 C8F8 ]

