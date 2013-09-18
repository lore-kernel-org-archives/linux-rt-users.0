From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: BUG: sleeping function called from invalid context on 3.10.10-rt7
Date: Wed, 18 Sep 2013 20:03:41 +0300
Message-ID: <20130918170341.GF4531@intel.com>
References: <20130911102809.GA31663@uudg.org>
 <20130911092623.42efd930@gandalf.local.home>
 <5230895B.5070400@hurleysoftware.com>
 <20130911113845.6d56a556@gandalf.local.home>
 <5230C52E.3050801@hurleysoftware.com>
 <5238B288.3000704@hurleysoftware.com>
 <CAKMK7uG9s8W6yebkmuJe0XHGsoru4_9FzGqfmKWtMFyCAfQZqA@mail.gmail.com>
 <5239DA37.6090504@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mario Kleiner <mario.kleiner@tuebingen.mpg.de>,
	Dave Airlie <airlied@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Peter Hurley <peter@hurleysoftware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13291 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751542Ab3IRRDs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Sep 2013 13:03:48 -0400
Content-Disposition: inline
In-Reply-To: <5239DA37.6090504@hurleysoftware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Sep 18, 2013 at 12:52:07PM -0400, Peter Hurley wrote:
> On 09/17/2013 04:55 PM, Daniel Vetter wrote:
> > On Tue, Sep 17, 2013 at 9:50 PM, Peter Hurley <peter@hurleysoftware=
=2Ecom> wrote:
> >> On 09/11/2013 03:31 PM, Peter Hurley wrote:
> >>>
> >>> [+cc dri-devel]
> >>>
> >>> On 09/11/2013 11:38 AM, Steven Rostedt wrote:
> >>>>
> >>>> On Wed, 11 Sep 2013 11:16:43 -0400
> >>>> Peter Hurley <peter@hurleysoftware.com> wrote:
> >>>>
> >>>>>> The funny part is, there's a comment there that shows that thi=
s was
> >>>>>> done even for "PREEMPT_RT". Unfortunately, the call to
> >>>>>> "get_scanout_position()" can call functions that use the rt-mu=
tex
> >>>>>> "sleeping spin locks" and it breaks there.
> >>>>>>
> >>>>>> I guess we need to ask the authors of the mainline patch exact=
ly why
> >>>>>> that preempt_disable() is needed?
> >>>>>
> >>>>>
> >>>>> The drm core associates a timestamp with each vertical blank fr=
ame #.
> >>>>> Drm drivers can optionally support a 'high resolution' hw times=
tamp.
> >>>>> The vblank frame #/timestamp tuple is user-space visible.
> >>>>>
> >>>>> The i915 drm driver supports a hw timestamp via this drm helper=
 function
> >>>>> which computes the timestamp from the crtc scan position (based=
 on the
> >>>>> pixel clock).
> >>>>>
> >>>>> For mainline, the preempt_disable/_enable() isn't actually nece=
ssary
> >>>>> because every call tree that leads here already has preemption =
disabled.
> >>>>>
> >>>>> For -RT, the maybe i915 register spinlock (uncore.lock) should =
be raw?
> >>>>>
> >>>>
> >>>> No, it should not. Note, any other lock that can be held when it=
 is
> >>>> held would also need to be raw.
> >>>
> >>>
> >>> By that, you mean "any other lock" that might be claimed "would a=
lso need
> >>> to be raw"?  Hopefully not "any other lock" already held?
> >>>
> >>>> And by taking a quick audit of the code, I see this:
> >>>>
> >>>>      spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
> >>>>
> >>>>      /* Reset the chip */
> >>>>
> >>>>      /* GEN6_GDRST is not in the gt power well, no need to check
> >>>>       * for fifo space for the write or forcewake the chip for
> >>>>       * the read
> >>>>       */
> >>>>      __raw_i915_write32(dev_priv, GEN6_GDRST, GEN6_GRDOM_FULL);
> >>>>
> >>>>      /* Spin waiting for the device to ack the reset request */
> >>>>      ret =3D wait_for((__raw_i915_read32(dev_priv, GEN6_GDRST) &
> >>>> GEN6_GRDOM_FULL) =3D=3D 0, 500);
> >>>>
> >>>> That spin is unacceptable in RT with preemption and interrupts d=
isabled.
> >>>
> >>>
> >>> Yep. That would be bad.
> >>>
> >>> AFAICT the registers read in i915_get_crtc_scanoutpos() aren't in=
cluded
> >>> in the force-wake set, so raw reads of the registers would
> >>> probably be acceptable (thus obviating the need for claiming the
> >>> uncore.lock).
> >>>
> >>> Except that _ALL_ register access is disabled with the uncore.loc=
k
> >>> during a gpu reset. Not sure if that's meant to include crtc regi=
sters
> >>> or not, or what other synchronization/serialization issues are be=
ing
> >>> handled/hidden by forcing all register accesses to wait during a =
gpu
> >>> reset.
> >>>
> >>> Hopefully an i915 expert can weigh in here?
> >>
> >>
> >>
> >> Daniel,
> >>
> >> Can you shed some light on whether the i915+ crtc registers (speci=
fically
> >> those in i915_get_crtc_scanoutpos() and i915_/gm45_get_vblank_coun=
ter())
> >> read as part of the vblank counter/timestamp handling need to
> >> be prevented during gpu reset?
> >
> > The depency here in the locking is a recent addition:
> >
> > commit a7cd1b8fea2f341b626b255d9898a5ca5fabbf0a
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Fri Jul 19 20:36:51 2013 +0100
> >
> >      drm/i915: Serialize almost all register access
> >
> > It's a (slightly) oversized hammer to work around a hardware issue =
-
> > we could break it down to register blocks, which can be accessed
> > concurrently, but that tends to be more fragile. But the chip reall=
y
> > dies if you access (even just reads) the same block concurrently :(
>=20
> Ouch. But thanks for clarifying that.
>=20
> Ok, so register access needs to be serialized. And a separate but
> related concern is that gen6+ resets also need to hold-off register
> access where forcewake is required.
>=20
>=20
> While I was reviewing the registers that require forcewake handling,
> I saw this:
>=20
> from i915_reg.h:
> #define _DPLL_A	(dev_priv->info->display_mmio_offset + 0x6014)
> #define _DPLL_B	(dev_priv->info->display_mmio_offset + 0x6018)
>=20
> from i915_drv.c:
> static const struct intel_device_info intel_valleyview_m_info =3D {
> 	GEN7_FEATURES,
> 	.is_mobile =3D 1,
> 	.num_pipes =3D 2,
> 	.is_valleyview =3D 1,
> 	.display_mmio_offset =3D VLV_DISPLAY_BASE,     <<<-------
> 	.has_llc =3D 0, /* legal, last one wins */
> };
>=20
> from intel_uncore.c:
> #define NEEDS_FORCE_WAKE(dev_priv, reg) \
> 	((HAS_FORCE_WAKE((dev_priv)->dev)) && \
> 	 ((reg) < 0x40000) &&            \
> 	 ((reg) !=3D FORCEWAKE))
>=20
> Is this is a mistake or do the valleyview PLLs not require the
> same forcewake handling as the other intel gpus?

Display registers shouldn't need forcewake on any platform. I guess our
NEEDS_FORCE_WAKE() check is a bit too coarse and includes a bunch of
stuff doesn't need to be there. So sort of by accident we do the right
thing on VLV, and the "wrong" thing on other platforms.

--=20
Ville Syrj=E4l=E4
Intel OTC
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
