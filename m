From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: jitter bursts
Date: Fri, 31 Aug 2007 17:17:27 +0200
Message-ID: <20070831151727.GT23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: Michael Olbrich <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:44562 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932325AbXHaPRi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 31 Aug 2007 11:17:38 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

We are currently porting a userspace realtime network stack (Ethernet
Powerlink -> EPL) to RT-Preempt, in order to play with the system and
find out what is possible today with a standard linux-rt and userspace
socket based stacks.

We currently see a strange latency effect. The scenario is like this:

 +--------+  +-----------+ +-----------+
 | PC EPL |  | Second PC | | EPL Clamp |
 +--------+  +-----------+ +-----------+
      |            |            |
       \     +----------+       /
        \----|    Hub   |------/
             +----------+

EPL is a protocol where the Master (PC EPL) sends a cyclic Start-of-
Cycle packet (SoC) to the network; our cycle time is 2 ms. To make sure
we do not se effects from the stack itself, we have written a small
program which sends a packet every 2 ms via raw socket.

We have a second PC which listens to the same network; this box takes
the packet time stamps (SO_TIMESTAMP), substracts the 2 ms cycle time
since the last SoC and plots the resulting jitter:

http://www.pengutronix.de/software/realtime-preempt/20070831-network-jitter/epl-jitter-log-20070831-1.png

What we see is that most of the packet times stay within something
around 10 us. However, there are periodic jitters which exceed that
period by a huge factor; in that case the jitter is in the 200...400 us
area, and notice the systematic patterns in the plots.

The periodicity of the 200...400 us is fixed for an unchanged clock
source (18 s in this example, we have seen values up to 200 s). The
periodicy changes when the clock source is changed in

/sys/devices/system/clocksource/clocksource0/current_clocksource

Changing to another clock source and changing back changes the period,
but it is not reproducable if you change back to the same source (hpet,
acpi_pm, tsc). There is also no visible corellation between the concrete
clocksource and the period.

The periodicity is fairly precise, it varies with < 5 us.

Has anyone seen a similar effect?

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
