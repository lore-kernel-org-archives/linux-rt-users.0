From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: BUG: sleeping function called from invalid context on 3.10.10-rt7
Date: Tue, 17 Sep 2013 15:50:32 -0400
Message-ID: <5238B288.3000704@hurleysoftware.com>
References: <20130911102809.GA31663@uudg.org> <20130911092623.42efd930@gandalf.local.home> <5230895B.5070400@hurleysoftware.com> <20130911113845.6d56a556@gandalf.local.home> <5230C52E.3050801@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Mario Kleiner <mario.kleiner@tuebingen.mpg.de>,
	Dave Airlie <airlied@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	intel-gfx@lists.freedesktop.org
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5230C52E.3050801@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 09/11/2013 03:31 PM, Peter Hurley wrote:
> [+cc dri-devel]
>
> On 09/11/2013 11:38 AM, Steven Rostedt wrote:
>> On Wed, 11 Sep 2013 11:16:43 -0400
>> Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>>>> The funny part is, there's a comment there that shows that this was
>>>> done even for "PREEMPT_RT". Unfortunately, the call to
>>>> "get_scanout_position()" can call functions that use the rt-mutex
>>>> "sleeping spin locks" and it breaks there.
>>>>
>>>> I guess we need to ask the authors of the mainline patch exactly why
>>>> that preempt_disable() is needed?
>>>
>>> The drm core associates a timestamp with each vertical blank frame #.
>>> Drm drivers can optionally support a 'high resolution' hw timestamp.
>>> The vblank frame #/timestamp tuple is user-space visible.
>>>
>>> The i915 drm driver supports a hw timestamp via this drm helper function
>>> which computes the timestamp from the crtc scan position (based on the
>>> pixel clock).
>>>
>>> For mainline, the preempt_disable/_enable() isn't actually necessary
>>> because every call tree that leads here already has preemption disabled.
>>>
>>> For -RT, the maybe i915 register spinlock (uncore.lock) should be raw?
>>>
>>
>> No, it should not. Note, any other lock that can be held when it is
>> held would also need to be raw.
>
> By that, you mean "any other lock" that might be claimed "would also need
> to be raw"?  Hopefully not "any other lock" already held?
>
>> And by taking a quick audit of the code, I see this:
>>
>>     spin_lock_irqsave(&dev_priv->uncore.lock, irqflags);
>>
>>     /* Reset the chip */
>>
>>     /* GEN6_GDRST is not in the gt power well, no need to check
>>      * for fifo space for the write or forcewake the chip for
>>      * the read
>>      */
>>     __raw_i915_write32(dev_priv, GEN6_GDRST, GEN6_GRDOM_FULL);
>>
>>     /* Spin waiting for the device to ack the reset request */
>>     ret = wait_for((__raw_i915_read32(dev_priv, GEN6_GDRST) & GEN6_GRDOM_FULL) == 0, 500);
>>
>> That spin is unacceptable in RT with preemption and interrupts disabled.
>
> Yep. That would be bad.
>
> AFAICT the registers read in i915_get_crtc_scanoutpos() aren't included
> in the force-wake set, so raw reads of the registers would
> probably be acceptable (thus obviating the need for claiming the uncore.lock).
>
> Except that _ALL_ register access is disabled with the uncore.lock
> during a gpu reset. Not sure if that's meant to include crtc registers
> or not, or what other synchronization/serialization issues are being
> handled/hidden by forcing all register accesses to wait during a gpu reset.
>
> Hopefully an i915 expert can weigh in here?


Daniel,

Can you shed some light on whether the i915+ crtc registers (specifically
those in i915_get_crtc_scanoutpos() and i915_/gm45_get_vblank_counter())
read as part of the vblank counter/timestamp handling need to
be prevented during gpu reset?

The implied wait with preemption and interrupts disabled is causing grief
in -RT, but also a 4ms wait inside an irq handler seems like a bad idea.

Regards,
Peter Hurley


>> What's the real issue here?
>
> That the vblank timestamp needs to be an accurate measurement of a
> realtime event. Sleeping/servicing interrupts while reading
> the registers necessary to compute the timestamp would be bad too.
>
> (edit: which hopefully Mario Kleiner clarified in his reply)
>
> My point earlier was three-fold:
> 1. Don't need the preempt_disable() for mainline: all callers are already
>     holding interrupt-disabling spinlocks.
> 2. -RT still needs to prevent scheduling there.
> 3. the problem is i915-specific.
>
> [update: the radeon driver should also BUG like the i915 driver but probably
> should have mmio_idx_lock spinlock as raw]
