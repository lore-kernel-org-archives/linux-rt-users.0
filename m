From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Which version of preempt_realtime to use?
Date: Sun, 25 Jan 2009 12:08:56 +0100 (CET)
Message-ID: <alpine.LFD.2.00.0901251159240.3424@localhost.localdomain>
References: <1232366467.31686.10.camel@localhost.localdomain>  <49748567.30201@osadl.org> <4974E686.60105@hedrich-winders.com>  <20090120074903.GX29067@pengutronix.de> <6d09081c0901200030o3eeb9145m4540631a80f442bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	=?ISO-8859-15?Q?J=FCrgen_Mell?= <mell@hedrich-winders.com>,
	Carsten Emde <Carsten.Emde@osadl.org>, esn@terma.com,
	linux-rt-users@vger.kernel.org
To: Pradyumna Sampath <pradysam@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39213 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312AbZAYLJO (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 Jan 2009 06:09:14 -0500
In-Reply-To: <6d09081c0901200030o3eeb9145m4540631a80f442bb@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Prady,

On Tue, 20 Jan 2009, Pradyumna Sampath wrote:

> Hi Robert, Jurgen,
> 
> On Tue, Jan 20, 2009 at 1:19 PM, Robert Schwebel
> <r.schwebel@pengutronix.de> wrote:
> >
> > Can you reproduce these long latencies with cyclictest, or does it only
> > happen with your code?
> >
> 
> A few months ago, I had hit some really long latencies when ptpd (1588
> time synch) was trying to synchronize from 1970 to the current time.
> After the time change we could observe some really long latencies.
> Maybe, your device might also be
> 
> Here is the post I made about it.
> http://marc.info/?l=linux-rt-users&m=122111918015981&w=4

Fix for the kernel warning is below. The warning is a false positive
caused by the huge time jump.

You said that your application is showing weird behaviour after the
time was set. 

Is your application using CLOCK_REALTIME ABSTIME timers ? We have had
bug reports in the past where people run into problems with code like
that:

	while (1) {
	      clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);
	      ...
	      next += interval;
	}

If the clock is set into the future then the above loop will try to
catch up for quite a while until next is past now. Using
CLOCK_REALTIME/ABSTIME timers needs to be aware of the fact that
CLOCK_REALTIME can be set and handle such a case gracefully.

Thanks,

	tglx
---

Subject: hrtimer: prevent negative expiry value after clock_was_set()
From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 25 Jan 2009 11:31:36 +0100

Impact: prevent false positive WARN_ON() in clockevents_program_event()

clock_was_set() changes the base->offset of CLOCK_REALTIME and
enforces the reprogramming of the clockevent device to expire timers
which are based on CLOCK_REALTIME. If the clock change is large enough
then the subtraction of the timer expiry value and base->offset can
become negative which triggers the warning in
clockevents_program_event(). 

Check the subtraction result and set a negative value to 0.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/hrtimer.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux-2.6-rt/kernel/hrtimer.c
===================================================================
--- linux-2.6-rt.orig/kernel/hrtimer.c
+++ linux-2.6-rt/kernel/hrtimer.c
@@ -405,6 +405,13 @@ static void hrtimer_force_reprogram(stru
 			continue;
 		timer = rb_entry(base->first, struct hrtimer, node);
 		expires = ktime_sub(timer->expires, base->offset);
+		/*
+		 * clock_was_set has changed base->offset, so the
+		 * result might be negative. Fix it up to prevent a
+		 * false positive in clockevents_program_event()
+		 */
+		if (expires.tv64 < 0)
+			expires.tv64 = 0;
 		if (expires.tv64 < cpu_base->expires_next.tv64)
 			cpu_base->expires_next = expires;
 	}
