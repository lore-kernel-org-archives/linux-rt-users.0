From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Tue, 26 May 2015 09:38:32 -0400
Message-ID: <20150526093832.558e2e46@gandalf.local.home>
References: <20150519213923.GA26363@linutronix.de>
	<20150526083449.5357059b@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150526083449.5357059b@sluggy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 26 May 2015 08:34:49 -0500
Clark Williams <williams@redhat.com> wrote:
 
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index f75173c20f47..f532b22f56ba 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -9745,7 +9745,9 @@ void intel_check_page_flip(struct drm_device *dev, int pipe)
>  	struct drm_crtc *crtc = dev_priv->pipe_to_crtc_mapping[pipe];
>  	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
>  
> +#ifndef CONFIG_PREEMPT_RT_FULL
>  	WARN_ON(!in_interrupt());
> +#endif

Or just use our special WARN_ON() functions...


	WARN_ON_NONRT(!in_interrupt());

-- Steve

>  
>  	if (crtc == NULL)
>  		return;
