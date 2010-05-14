From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Fri, 14 May 2010 22:53:23 +0200
Message-ID: <20100514205323.GF6055@pengutronix.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de> <20100513175842.GN6055@pengutronix.de> <4BED1937.6080907@steinhoff.de> <20100514114625.GA6055@pengutronix.de> <4BED42D6.3090303@steinhoff.de> <20100514163613.GE6055@pengutronix.de> <4BED7A75.9030508@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57139 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759673Ab0ENUxY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 May 2010 16:53:24 -0400
Content-Disposition: inline
In-Reply-To: <4BED7A75.9030508@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, May 14, 2010 at 06:29:41PM +0200, Armin Steinhoff wrote:
> > The kernel policy is to offer only one abstraction model for one
> > sort of hardware; SocketCAN is a native Linux implementation and has
> > no additional HAL.
>
> And how many different kinds of hardware do we have??

I've re-read the whole thread, and I must say that I don't understand
what you want to explain. What do you mean with "kinds of hardware"?
Talking about CAN, do you mean different CAN controllers? Or do you mean
different device classes, like in "can", "ethernet", ...?

> When you send every 100us a CAN frame and the response time of the
> real-time application to external events is 200us ... what would be
> happen? Hard to understand ??

I assume that with "send" you mean "receive", right? As long as you
don't have a closed loop scenario, nothing bad happens:

        ---------------  ------------------
        |  canframe   |  |   canframe     |
        |  received   |  |   processed    |
        | by hardware |  | by application |
        ---------------  ------------------
              |                   |
  0 us   canframe-1               |
              |                   |
100 us   canframe-2               |
              |                   |
200 us   canframe-3          canframe-1
              |                   |
300 us   canframe-4          canframe-2
              |                   |
400 us   canframe-5          canframe-3
              |                   |

If you FIFO is long enough, no frame gets lost. The driver might even
load canframe-1..3 out of the hardware at 200 us and push it forward.

Latencies do only hurt if you have a closed loop, i.e. if you want to
run a control program with a 100 us cycle:

        ---------------  ------------------ ---------------
        |  canframe   |  |                | |  canframe   |
        |  received   |  |   application  | |    sent     |
        | by hardware |  |                | | by hardware |
        ---------------  ------------------ ---------------
              |                   |               |
  0 us   canframe-1               |               |
              |            recv-canframe-1        |
              |             do-something          |
              |            send-canframe-2        |
              |                   |          canframe-2
              |                   |               |
100 us   canframe-3               |               |
              |            recv-canframe-3        |
              |             do-something          |
              |            send-canframe-4        |
              |                   |          canframe-4
              |                   |               |

I guess that's what you mean?

You answered "1000s of canframes per second" to a latency question.
"canframes per second" correlates to throughput, not response time.

> > > Why should we use FPGAs when a CPU has multiple cores? Every fast
> > > fieldbus (e.g. EtherCAT) needs a reaction time with less than
> > > 100us.
> >
> > Reaction time between *which events*? Sorry, I didn't understand
> > your use case yet.
>
> Never heard about bus scan cycles? In a range of e.g. 50us? Such bus
> cycles can't be handled with a latency of 100us ... isn't it?

If you need < 50 us roundtrip time than your worst case latencies have
to be lower, that's right. However, 50 us is a cycle time is close to
the lower limit of what normal processor hardware can provide. How close
depends on your actual hardware, but not even processors in the Atom
range might be able to provide this (from the hardware side) under all
operating conditions. It's a matter of how close to the limb you want to
walk. And it's not a matter of Xenomai vs. RT Preempt.

> PS: so langsam wird die Diskussion nun doch ein wenig albern ...

The original poster has requirements to run cyclic tasks every 2..10 ms,
which can be easily handled by today's hardware and by both, RT_PREEMPT
and Xenomai.

I agree that it's probably better to discuss things like CAN in
userspace, EtherCAT and cycles in the 50 us range separately (eventually
on the right lists) and with a clear statement about what the discussion
is.

Thanks,
rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
