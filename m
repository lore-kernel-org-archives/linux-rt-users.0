From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Fri, 14 May 2010 18:36:13 +0200
Message-ID: <20100514163613.GE6055@pengutronix.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de> <4BED1937.6080907@steinhoff.de> <20100514114625.GA6055@pengutronix.de> <4BED42D6.3090303@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:42827 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756431Ab0ENQgP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 12:36:15 -0400
Content-Disposition: inline
In-Reply-To: <4BED42D6.3090303@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 14, 2010 at 02:32:22PM +0200, Armin Steinhoff wrote:
> > Do you see a use case which shows that a reasonably modern CPU has
> > performance problems with SocketCAN, while it works fine with your
> > userspace driver? My impression from previous projects is that, for
> > all real life scenarios, the advantage of having a standard hardware
> > abstraction in the kernel
>
> How many "hardware abstractions" do you want in the kernel?

The kernel policy is to offer only one abstraction model for one sort of
hardware; SocketCAN is a native Linux implementation and has no
additional HAL.

> The response time of the whole real-time application
> (hardware/driver/application) is the point. If Linux wouldn't able to
> handle every 100us a CAN frame ... the whole real-time application
> would be useless.

I still don't understand your setup, can you elaborate?

> > Sending lots of frames works also if you have for example a CAN chip
> > with a long FIFO, push the frames in and wait forever.
>
> But every so called "long FIFO" is limited and can reach the overun
> state.

My point is to find out where you see a relation to "latency". Latency
has nothing to do with CAN frames per second. If you have a FIFO which
is long enough, feeding it every let's say 1 second with 1k messages is
enough to get 1k messages/s. So a system latency of 1 s would fulfill
your throughput requirements.

> > "Repsonse time" does involve some kind of round trip, which one do
> > you mean?
>
> Responses of an real-time application to external events ...
>
> > Can you elaborate where you see the need for us response times?
> >
> > As the minimum reaction time is limited by hardware constraints on
> > modern cpus anyway, I think that for most applications which require
> > sub 100 us response times, a hardware solution (microcontroller,
> > fpga) is a better way to achive things.
>
> Why should we use FPGAs when a CPU has multiple cores? Every fast
> fieldbus (e.g. EtherCAT) needs a reaction time with less than 100us.

Reaction time between *which events*? Sorry, I didn't understand your
use case yet.

Thanks,
rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
