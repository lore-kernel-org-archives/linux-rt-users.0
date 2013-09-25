From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Intel-gfx] BUG: sleeping function called from invalid context
 on 3.10.10-rt7
Date: Wed, 25 Sep 2013 10:18:03 -0400
Message-ID: <20130925101803.2848fc3c@gandalf.local.home>
References: <20130911102809.GA31663@uudg.org>
	<20130911092623.42efd930@gandalf.local.home>
	<5230895B.5070400@hurleysoftware.com>
	<20130911113845.6d56a556@gandalf.local.home>
	<5230C52E.3050801@hurleysoftware.com>
	<5238B288.3000704@hurleysoftware.com>
	<CAKMK7uG9s8W6yebkmuJe0XHGsoru4_9FzGqfmKWtMFyCAfQZqA@mail.gmail.com>
	<523CC728.4040302@tuebingen.mpg.de>
	<20130923083841.GT4531@intel.com>
	<5242674A.8020100@tuebingen.mpg.de>
	<20130925074936.GI4531@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mario Kleiner <mario.kleiner@tuebingen.mpg.de>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Peter Hurley <peter@hurleysoftware.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Dave Airlie <airlied@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>
To: Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:39501 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754886Ab3IYOSG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Sep 2013 10:18:06 -0400
In-Reply-To: <20130925074936.GI4531@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 25 Sep 2013 10:49:36 +0300
Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com> wrote:

=20
> The preempt_disable/enable is not needed. The spinlock serves the sam=
e
> purpose already.

As stated, that was only for the -rt patch, as spin_lock_irqsave does
not disable preemption nor does it even disable interrupts.

But I agree, the added preempt_disable() should be sent to us to keep
in the -rt patch itself. We really appreciate that you are thinking
about us :-)  But something like this will just confuse the mainline
folks. Having a "preempt_disable_rt()" would make a lot more sense
(which exists in the -rt patch).

>=20
> As far as ktime_get(), I've used it from spinlocked/irq disabled sect=
ions
> and so far haven't seen it do bad things. But would be nice to get so=
me
> official statement to that effect.

It's just a read seqlock. It may do a few loops to get the correct
time, but it's fine to have in a preempt/irq disabled section.

-- Steve
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
