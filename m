From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: scheduler clock for MXS
Date: Wed, 7 Nov 2012 15:13:29 +0800
Message-ID: <20121107071327.GB30291@S2100-06.ap.freescale.net>
References: <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
 <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
 <20121106134630.GD27643@S2100-06.ap.freescale.net>
 <20121106202038.GB32398@n2100.arm.linux.org.uk>
 <50998F94.8000908@meduna.org>
 <20121106224624.GR28327@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Stanislav Meduna <stano@meduna.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from db3ehsobe001.messaging.microsoft.com ([213.199.154.139]:57963
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751031Ab2KGGrx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Nov 2012 01:47:53 -0500
Content-Disposition: inline
In-Reply-To: <20121106224624.GR28327@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 06, 2012 at 10:46:24PM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 06, 2012 at 11:30:44PM +0100, Stanislav Meduna wrote:
> > On 06.11.2012 21:20, Russell King - ARM Linux wrote:
> > > Well.  I just tried an experiment with OMAP4:
> > > [    0.000000] sched_clock: 16 bits at 32kHz, resolution 30517ns,
> > wraps every 1999ms
> > > ...
> > > [    3.070404] Freeing init memory: 192K
> > 
> > 
> > OK, so it is not a 16-bit problem either. So where is the
> > difference? Could it be that HZ / NO_HZ is playing some
> > tricks here and need to be taken into consideration?
> > 
> > I'll try to artificially limit the counter-reading function
> > on my hardware to 16 bits and look whether I can also
> > reproduce this - probably on Thursday or Friday earliest
> > (busy with other tasks now).
> > 
> > If it works I'll resubmit for only the iMX.28 and someone
> > who actually has the iMX.23 hardware to experiment with has
> > to look at it; the best start is probably to start with
> > comparing it to the working OMAP4. If it does not I'll
> > try to find the culprit.
> 
> I wonder if the NO_HZ slack is preventing the sched_clock epoch update
> from happening in time.  Hmm.
> 
>  * round_jiffies - function to round jiffies to a full second
> 
> This is probably it.  With mine, it's a 32.768kHz clock, so limiting
> it to 16-bit gives a wrap period of 2 seconds exactly.  We take 10%
> off, so the timer would be asked to fire every 1.8s, which would be
> rounded up to 2 seconds.  That's a little too close for comfort...
> 
> Yours on the other hand:
> 
> sched_clock: 16 bits at 32kHz, resolution 31250ns, wraps every 2047ms
> 
> says that this timer runs at _exactly_ 32kHz (are you sure?  If this is

It sources from 24 MHz crystal with a fixed divider 750, so it's
24000000 / 750 = 32000.

Shawn

> generated from a separate 32k crystal oscilator, it's most likely
> 32.768kHz because that's the standard crystal frequency.  In any case,
> this would give a wrap period of just over 2 seconds.
> 
> But remember, we take of 10%, so this would give 1843ms.  Jiffy
> conversion would give 185 jiffies, and rounded up to a second gives
> 200 jiffies, so again 2 seconds.
> 
> I suspect that your timer _does_ run at approximately 32768kHz, meaning
> that it _does_ roll over at 2 second intervals.  But maybe it's trimmed
> to be slightly fast or maybe your kernel's idea of time is slightly
> slow - either one of which would then give you this effect.
> 
> However, either way, rounding 1.8s up to 2s for a 16-bit 32768kHz
> counter isn't going to give reliable results.
> 
> I think in this case, we need a version of round_jiffies() which _always_
> rounds down.  Unfortunately, it doesn't exist.  Thomas?  What are the
> options here?

