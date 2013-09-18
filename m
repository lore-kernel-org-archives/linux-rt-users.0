From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: BUG: sleeping function called from invalid context on 3.10.10-rt7
Date: Wed, 18 Sep 2013 19:03:14 +0200
Message-ID: <CAKMK7uFDuPvAWZCi6=DYY_f27AjXsGKhn_i7Vh09MY9wBX2yvA@mail.gmail.com>
References: <20130911102809.GA31663@uudg.org>
	<20130911092623.42efd930@gandalf.local.home>
	<5230895B.5070400@hurleysoftware.com>
	<20130911113845.6d56a556@gandalf.local.home>
	<5230C52E.3050801@hurleysoftware.com>
	<5238B288.3000704@hurleysoftware.com>
	<CAKMK7uG9s8W6yebkmuJe0XHGsoru4_9FzGqfmKWtMFyCAfQZqA@mail.gmail.com>
	<5239DA37.6090504@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Mario Kleiner <mario.kleiner@tuebingen.mpg.de>,
	Dave Airlie <airlied@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Peter Hurley <peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5239DA37.6090504@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 18, 2013 at 6:52 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Ouch. But thanks for clarifying that.
>
> Ok, so register access needs to be serialized. And a separate but
> related concern is that gen6+ resets also need to hold-off register
> access where forcewake is required.
>
>
> While I was reviewing the registers that require forcewake handling,
> I saw this:
>
> from i915_reg.h:
> #define _DPLL_A (dev_priv->info->display_mmio_offset + 0x6014)
> #define _DPLL_B (dev_priv->info->display_mmio_offset + 0x6018)
>
> from i915_drv.c:
> static const struct intel_device_info intel_valleyview_m_info = {
>         GEN7_FEATURES,
>         .is_mobile = 1,
>         .num_pipes = 2,
>         .is_valleyview = 1,
>         .display_mmio_offset = VLV_DISPLAY_BASE,     <<<-------
>         .has_llc = 0, /* legal, last one wins */
> };
>
> from intel_uncore.c:
> #define NEEDS_FORCE_WAKE(dev_priv, reg) \
>         ((HAS_FORCE_WAKE((dev_priv)->dev)) && \
>          ((reg) < 0x40000) &&            \
>          ((reg) != FORCEWAKE))
>
> Is this is a mistake or do the valleyview PLLs not require the
> same forcewake handling as the other intel gpus?

The DPLL offset from the macro at 0x6000 is from older platforms which
lacked forcewake and where the display block started already on
0x6000.

On recent big core platforms we have the north display block at
0x40000 (i.e. forcewake is only used for the rendering side of
things). For those platforms the DPLL macro is called PCH_DPLL (and
it's in the south display range starting at 0xc0000. VLV itself
inherited the old display register blocks (mostly) but moved them all
by the vlv display base offset.

We have quite a bit of fun with hw engineers moving display blocks around ;-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
