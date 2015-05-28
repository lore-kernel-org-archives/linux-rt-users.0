From: Joakim Hernberg <jhernberg@alchemy.lu>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Thu, 28 May 2015 10:41:28 +0200
Message-ID: <20150528104128.6a7d0fb3@tor.valhalla.alchemy.lu>
References: <20150519213923.GA26363@linutronix.de>
	<20150526083449.5357059b@sluggy>
	<20150526093832.558e2e46@gandalf.local.home>
	<20150526084802.2cfd055b@sluggy>
	<20150526111924.20836deb@gandalf.local.home>
	<20150526104343.51fad474@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150526104343.51fad474@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 26 May 2015 10:43:43 -0500
Clark Williams <williams@redhat.com> wrote:

> On Tue, 26 May 2015 11:19:24 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 26 May 2015 08:48:02 -0500
> > Clark Williams <williams@redhat.com> wrote:
> > 
> > 
> > > Change the WARN_ON to WARN_ON_NORT
> > 
> > Do we have a WARN_ON_NORT? I see a WARN_ON_NONRT, but not a
> > WARN_ON_NORT. Does this compile?
> > 
> > -- Steve
> 
> Sigh. Of course not. Reupdated patch (and yes this one compiles):
> 
> From: Clark Williams <williams@redhat.com>
> Date: Thu, 21 May 2015 12:51:53 -0500
> Subject: [PATCH] [rt] i915: bogus warning from i915 when running on
> PREEMPT_RT
> 
> The i915 driver has a 'WARN_ON(!in_interrupt())' in the display
> handler, which whines constanly on the RT kernel (since the interrupt
> is actually handled in a threaded handler and not actual interrupt
> context).
> 
> Change the WARN_ON to WARN_ON_NORT
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  drivers/gpu/drm/i915/intel_display.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/intel_display.c
> b/drivers/gpu/drm/i915/intel_display.c index
> f75173c20f47..30b1d16caa0d 100644 ---
> a/drivers/gpu/drm/i915/intel_display.c +++
> b/drivers/gpu/drm/i915/intel_display.c @@ -9745,7 +9745,7 @@ void
> intel_check_page_flip(struct drm_device *dev, int pipe) struct
> drm_crtc *crtc = dev_priv->pipe_to_crtc_mapping[pipe]; struct
> intel_crtc *intel_crtc = to_intel_crtc(crtc); 
> -	WARN_ON(!in_interrupt());
> +	WARN_ON_NONRT(!in_interrupt());
>  
>  	if (crtc == NULL)
>  		return;

You can add my Tested-by: Joakim Hernberg <jhernberg@alchemy.lu>.
Seems to fix the problem on my systems too.

-- 

   Joakim
