From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [ANNOUNCE] 3.8.9-rt4
Date: Sat, 27 Apr 2013 23:44:54 +0200
Message-ID: <517C46D6.7030601@osadl.org>
References: <20130426222001.GH20927@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:50860 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753811Ab3D0VwN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Apr 2013 17:52:13 -0400
In-Reply-To: <20130426222001.GH20927@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

> I'm pleased to announce the 3.8.9-rt4 release. [..]
This patch is needed to prevent the compiler error
drivers/gpu/drm/i915/i915_gem_execbuffer.c:1072:27:
error: 'seqno' undeclared (first use in this function)

Signed-off-by: Carsten Emde <C.Emde@osadl.org>

Index: linux-3.8.4-rt2/drivers/gpu/drm/i915/i915_gem_execbuffer.c
===================================================================
--- linux-3.8.4-rt2.orig/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ linux-3.8.4-rt2/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -814,6 +814,7 @@ i915_gem_do_execbuffer(struct drm_device
  	struct intel_ring_buffer *ring;
  	u32 ctx_id = i915_execbuffer2_get_context_id(*args);
  	u32 exec_start, exec_len;
+	u32 seqno;
  	u32 mask;
  	u32 flags;
  	int ret, mode, i;
@@ -1068,7 +1069,8 @@ i915_gem_do_execbuffer(struct drm_device
  			goto err;
  	}

-	trace_i915_gem_ring_dispatch(ring, intel_ring_get_seqno(ring), flags);
+	seqno = intel_ring_get_seqno(ring);
+	trace_i915_gem_ring_dispatch(ring, seqno, flags);
  	i915_trace_irq_get(ring, seqno);

  	i915_gem_execbuffer_move_to_active(&objects, ring);

