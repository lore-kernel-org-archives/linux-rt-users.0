From: Stanislav Meduna <stano@meduna.org>
Subject: Re: scheduler clock for MXS
Date: Tue, 06 Nov 2012 23:30:44 +0100
Message-ID: <50998F94.8000908@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org> <20121105025753.GA26528@S2100-06.ap.freescale.net> <50978370.9060001@meduna.org> <20121105134655.GB27260@S2100-06.ap.freescale.net> <5097E4A9.3090008@meduna.org> <20121105222859.GI28327@n2100.arm.linux.org.uk> <5098CB9F.9030401@meduna.org> <20121106134630.GD27643@S2100-06.ap.freescale.net> <20121106202038.GB32398@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Shawn Guo <shawn.guo@linaro.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:42048 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab2KFWbG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Nov 2012 17:31:06 -0500
In-Reply-To: <20121106202038.GB32398@n2100.arm.linux.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06.11.2012 21:20, Russell King - ARM Linux wrote:

>> With the change, it still wraps at 2 seconds.
> 
> And there's no way that such a change could ever go into mainline; it
> can mean that the timer is registered into the timer subsystem before
> the timer subsystem has been initialised.  That's why we postpone that
> part to time_init().

Sure, I just wanted to quick-check whether it helps or not, this was
not meant as a solution for anything.

This gets interesting. The same code on slightly different hardware
(but using same source files), just 32-bits so it wraps around after
~1,5 days:

sched_clock: 32 bits at 32kHz, resolution 31250ns,
  wraps every 134217727ms

works without problem here:
  [134919.008468] PHY: imx28-fec-1:00 - Link is Up - 100/Full

(134919 > 134217).

The only difference is 32 bits instead of 16 and a different
function to read the hardware.

> Well.  I just tried an experiment with OMAP4:
> [    0.000000] sched_clock: 16 bits at 32kHz, resolution 30517ns,
wraps every 1999ms
> ...
> [    3.070404] Freeing init memory: 192K


OK, so it is not a 16-bit problem either. So where is the
difference? Could it be that HZ / NO_HZ is playing some
tricks here and need to be taken into consideration?

I'll try to artificially limit the counter-reading function
on my hardware to 16 bits and look whether I can also
reproduce this - probably on Thursday or Friday earliest
(busy with other tasks now).

If it works I'll resubmit for only the iMX.28 and someone
who actually has the iMX.23 hardware to experiment with has
to look at it; the best start is probably to start with
comparing it to the working OMAP4. If it does not I'll
try to find the culprit.

Thanks
-- 
                                    Stano

