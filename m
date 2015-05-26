From: Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Tue, 26 May 2015 08:34:49 -0500
Message-ID: <20150526083449.5357059b@sluggy>
References: <20150519213923.GA26363@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150519213923.GA26363@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 19 May 2015 23:39:23 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Dear RT folks!
> 
> I'm pleased to announce the v4.0.4-rt1 patch set.
> 

Sebastian,


The i915 driver has a 'WARN_ON(!in_interrupt())' in the display
handler, which whines constantly on the RT kernel (since the interrupt
is actually handled in a threaded handler and not actual interrupt
context).

Ifdef it out for PREEMPT_RT_FULL.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 drivers/gpu/drm/i915/intel_display.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
index f75173c20f47..f532b22f56ba 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -9745,7 +9745,9 @@ void intel_check_page_flip(struct drm_device *dev, int pipe)
 	struct drm_crtc *crtc = dev_priv->pipe_to_crtc_mapping[pipe];
 	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
 
+#ifndef CONFIG_PREEMPT_RT_FULL
 	WARN_ON(!in_interrupt());
+#endif
 
 	if (crtc == NULL)
 		return;
