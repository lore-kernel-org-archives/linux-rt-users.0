From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Fri, 14 May 2010 13:46:25 +0200
Message-ID: <20100514114625.GA6055@pengutronix.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de> <4BED1937.6080907@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49576 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0ENLq0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 07:46:26 -0400
Content-Disposition: inline
In-Reply-To: <4BED1937.6080907@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 14, 2010 at 11:34:47AM +0200, Armin Steinhoff wrote:
> > The Linux CAN interface is SocketCAN. Do you see a usecase where
> > this doesn't fit?
>
> IMHO, the SocketCAN interface is simply an overkill for the handling
> of small CAN messages. I estimate that the amount of executed code
> for handling of a single CAN frame is much bigger as the frame itself
> :) Every read and write action creates context switches ...
>
> This is not the case with the user space based driver. Same story
> with our PROFIBUS-DP drivers ...

Do you see a use case which shows that a reasonably modern CPU has
performance problems with SocketCAN, while it works fine with your
userspace driver? My impression from previous projects is that, for all
real life scenarios, the advantage of having a standard hardware
abstraction in the kernel overwhelms a few microseconds here and there
on the performance side.

> > > Already the standard distribution of SUSE 11.2 (non RT) was able
> > > to handle 1000 frames per seconds sent by a QNX6 machine!!
> >
> > Realtime != fast.
>
> But a small response time is a technological requirement in order to
> meet deadlines. The standard kernel is a _good base_ in order to
> implement predictive behavior ... this would not the case if the
> response time would be in the range of 100us. OK ... you can have
> real-time behavior with a response time of 100us .. but this would be
> useless for most real-time applications.

Above you state that you send "1000 frames per second", but that has
nothing to do with response times. Sending lots of frames works also if
you have for example a CAN chip with a long FIFO, push the frames in and
wait forever. "Repsonse time" does involve some kind of round trip,
which one do you mean? Can you elaborate where you see the need for us
response times?

As the minimum reaction time is limited by hardware constraints on
modern cpus anyway, I think that for most applications which require sub
100 us response times, a hardware solution (microcontroller, fpga) is a
better way to achive things.

>>> The latency test of PREEMPT_RT shows a latency of ~10us for a
>>> dual-core box at 1.8GHz.
>>
>> It depends on the load.
>
> It depends on the load and the used priorities.

For a given application, with predefined priorities, it depends on the
load :-)

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
