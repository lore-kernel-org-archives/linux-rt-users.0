From: "Girish kathalagiri" <girish.sk@gmail.com>
Subject: Re: jitter bursts
Date: Fri, 31 Aug 2007 21:25:08 +0530
Message-ID: <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com>
References: <20070831151727.GT23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	"Michael Olbrich" <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: "Robert Schwebel" <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.239]:28074 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbXHaPzJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Aug 2007 11:55:09 -0400
Received: by wr-out-0506.google.com with SMTP id 36so586663wra
        for <linux-rt-users@vger.kernel.org>; Fri, 31 Aug 2007 08:55:08 -0700 (PDT)
In-Reply-To: <20070831151727.GT23573@pengutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

We also had similar problems when where we face these kind of periodic
jitter. In our case we used Intel 82551ER Fast Ethernet Controller(
e100 driver ). The problem with ours was the  with the microcode (in
e100.c) of the adapter which had default algorithm where the hardware
was holding of the interrupts until X packets or Y usecs have expired.

This generated a periodic jitter that was 400-500 us more than the usual one.
This was solved by making the hardware generate interrupt on every frame.
In e100.c this can be done by changing the values of INTDELAY,
BUNDDLEMAX and BUNDDLESMALL (CPU saver parameters)

On 8/31/07, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> Hi,
>
> We are currently porting a userspace realtime network stack (Ethernet
> Powerlink -> EPL) to RT-Preempt, in order to play with the system and
> find out what is possible today with a standard linux-rt and userspace
> socket based stacks.
>
> We currently see a strange latency effect. The scenario is like this:
>
>  +--------+  +-----------+ +-----------+
>  | PC EPL |  | Second PC | | EPL Clamp |
>  +--------+  +-----------+ +-----------+
>       |            |            |
>        \     +----------+       /
>         \----|    Hub   |------/
>              +----------+
>
> EPL is a protocol where the Master (PC EPL) sends a cyclic Start-of-
> Cycle packet (SoC) to the network; our cycle time is 2 ms. To make sure
> we do not se effects from the stack itself, we have written a small
> program which sends a packet every 2 ms via raw socket.
>
> We have a second PC which listens to the same network; this box takes
> the packet time stamps (SO_TIMESTAMP), substracts the 2 ms cycle time
> since the last SoC and plots the resulting jitter:
>
> http://www.pengutronix.de/software/realtime-preempt/20070831-network-jitter/epl-jitter-log-20070831-1.png
>
> What we see is that most of the packet times stay within something
> around 10 us. However, there are periodic jitters which exceed that
> period by a huge factor; in that case the jitter is in the 200...400 us
> area, and notice the systematic patterns in the plots.
>
> The periodicity of the 200...400 us is fixed for an unchanged clock
> source (18 s in this example, we have seen values up to 200 s). The
> periodicy changes when the clock source is changed in
>
> /sys/devices/system/clocksource/clocksource0/current_clocksource
>
> Changing to another clock source and changing back changes the period,
> but it is not reproducable if you change back to the same source (hpet,
> acpi_pm, tsc). There is also no visible corellation between the concrete
> clocksource and the period.
>
> The periodicity is fairly precise, it varies with < 5 us.
>
> Has anyone seen a similar effect?
>
> Robert
> --
> Pengutronix - Linux Solutions for Science and Industry
> Entwicklungszentrum Nord     http://www.pengutronix.de
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Thanks
   Giri
