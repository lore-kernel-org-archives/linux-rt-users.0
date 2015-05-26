From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [ANNOUNCE] 4.0.4-rt1
Date: Tue, 26 May 2015 16:49:46 +0200
Message-ID: <1432651786.3232.59.camel@gmail.com>
References: <20150519213923.GA26363@linutronix.de>
	 <20150526083449.5357059b@sluggy>
	 <20150526093832.558e2e46@gandalf.local.home>
	 <20150526084802.2cfd055b@sluggy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38304 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbbEZOtv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 26 May 2015 10:49:51 -0400
In-Reply-To: <20150526084802.2cfd055b@sluggy>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2015-05-26 at 08:48 -0500, Clark Williams wrote:
> On Tue, 26 May 2015 09:38:32 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 26 May 2015 08:34:49 -0500
> > Clark Williams <williams@redhat.com> wrote:
> >  
> > > diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> > > index f75173c20f47..f532b22f56ba 100644
> > > --- a/drivers/gpu/drm/i915/intel_display.c
> > > +++ b/drivers/gpu/drm/i915/intel_display.c
> > > @@ -9745,7 +9745,9 @@ void intel_check_page_flip(struct drm_device *dev, int pipe)
> > >  	struct drm_crtc *crtc = dev_priv->pipe_to_crtc_mapping[pipe];
> > >  	struct intel_crtc *intel_crtc = to_intel_crtc(crtc);
> > >  
> > > +#ifndef CONFIG_PREEMPT_RT_FULL
> > >  	WARN_ON(!in_interrupt());
> > > +#endif
> > 
> > Or just use our special WARN_ON() functions...
> > 
> > 
> > 	WARN_ON_NONRT(!in_interrupt());
> > 
> > -- Steve
> 
> good point. Updated patch:

That's one down.

# pending fixes
drm-i915-intel_check_page_flip-WARN_ON_NONRT-for-not-in_irq.patch
net-netpoll-WARN_ONCE_NONRT-for-irqs-non-disabled.patch
workqueue-fix-rescuer_thread-blocking-ops-while-not-TASK_RUNNING-splat.patch

There are a couple more little splats.  Been meaning to post them now
that 4.0-rt is out, but between the (alleged) 9->5 thing and whatnot...

	-Mike

