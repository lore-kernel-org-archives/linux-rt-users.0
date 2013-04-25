From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.8.4-rt2: (x86_64): BUG: scheduling while atomic
Date: Thu, 25 Apr 2013 17:50:18 +0200
Message-ID: <20130425155018.GB5561@linutronix.de>
References: <20130327131658.22aef026@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44910 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757199Ab3DYPuT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Apr 2013 11:50:19 -0400
Content-Disposition: inline
In-Reply-To: <20130327131658.22aef026@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Joakim Hernberg | 2013-03-27 13:16:58 [+0100]:

>[  618.783525] BUG: scheduling while atomic: X/630/0x00000003
>[  618.783597] [<ffffffffa00b2a33>] ftrace_raw_event_i915_gem_ring_dispatch+0xe3/0x100 [i915]

Please format your backtrace properl next time.
Can you re-produce this? If so, does this help:

diff --git a/drivers/gpu/drm/i915/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
index 26d08bb..7d56265 100644
--- a/drivers/gpu/drm/i915/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/i915_gem_execbuffer.c
@@ -1064,6 +1064,7 @@ i915_gem_do_execbuffer(struct drm_device *dev, void *data,
 	}
 
 	trace_i915_gem_ring_dispatch(ring, intel_ring_get_seqno(ring), flags);
+	i915_trace_irq_get(ring, seqno);
 
 	i915_gem_execbuffer_move_to_active(&objects, ring);
 	i915_gem_execbuffer_retire_commands(dev, file, ring);
diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index 3db4a68..29217db 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -244,7 +244,6 @@ TRACE_EVENT(i915_gem_ring_dispatch,
 			   __entry->ring = ring->id;
 			   __entry->seqno = seqno;
 			   __entry->flags = flags;
-			   i915_trace_irq_get(ring, seqno);
 			   ),
 
 	    TP_printk("dev=%u, ring=%u, seqno=%u, flags=%x",

Sebastian
