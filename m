Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:58442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSLcy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Dec 2018 06:32:54 -0500
Date: Wed, 19 Dec 2018 12:32:51 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH RT] drm/i915: skip DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE
Message-ID: <20181219113251.c4di2rlnet6ibm36@linutronix.de>
References: <CAJfkoWpnXJtTo2qkX2UkNeWX6Q7f2=g=sryi2HY1YZRtjSBVcg@mail.gmail.com>
 <20181206091008.62d7cwuwhxrx3s3b@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181206091008.62d7cwuwhxrx3s3b@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-users@vger.kernel.org, Luca Abeni <lucabe72@gmail.com>

The order of the header files is important. If this header file is
included after tracepoint.h was included then the NOTRACE here becomes a
nop. Currently this happens for two .c files which use the tracepoitns
behind DRM_I915_LOW_LEVEL_TRACEPOINTS.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/gpu/drm/i915/i915_trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_trace.h b/drivers/gpu/drm/i915/i915_trace.h
index cc54ec0ef75c1..33028d8f470e5 100644
--- a/drivers/gpu/drm/i915/i915_trace.h
+++ b/drivers/gpu/drm/i915/i915_trace.h
@@ -683,7 +683,7 @@ DEFINE_EVENT(i915_request, i915_request_add,
 	    TP_ARGS(rq)
 );
 
-#if defined(CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS)
+#if defined(CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS) && !defined(NOTRACE)
 DEFINE_EVENT(i915_request, i915_request_submit,
 	     TP_PROTO(struct i915_request *rq),
 	     TP_ARGS(rq)
-- 
2.20.1
