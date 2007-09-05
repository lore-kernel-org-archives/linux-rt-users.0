From: Michael Olbrich <m.olbrich@pengutronix.de>
Subject: Re: jitter bursts
Date: Wed, 5 Sep 2007 10:14:02 +0200
Message-ID: <20070905081402.GA30955@pengutronix.de>
References: <20070831151727.GT23573@pengutronix.de> <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:50507 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755668AbXIEIOF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 04:14:05 -0400
Content-Disposition: inline
In-Reply-To: <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 31, 2007 at 09:25:08PM +0530, Girish kathalagiri wrote:
> We also had similar problems when where we face these kind of periodic
> jitter. In our case we used Intel 82551ER Fast Ethernet Controller(
> e100 driver ). The problem with ours was the  with the microcode (in
> e100.c) of the adapter which had default algorithm where the hardware
> was holding of the interrupts until X packets or Y usecs have expired.
> 
> This generated a periodic jitter that was 400-500 us more than the usual one.
> This was solved by making the hardware generate interrupt on every frame.
> In e100.c this can be done by changing the values of INTDELAY,
> BUNDDLEMAX and BUNDDLESMALL (CPU saver parameters)

Unfortunately not but it did get me on the right track. The problem is
caused by the e100_watchdog function. As far as I can tell e100_watchdog
is called from a timer queue and therefore runs with the priority of
that thread. And while I set higher priorities for softirq-net-rx and
the application I missed the thread for the hardware interrupt of the
network interface. So whenever a packet arived while e100_watchdog was
running it got delayed. The periodic pattern is a result of this and
speed difference of sender and receiver clocks.
The jitter is now <50us but still with some periodic patterns. So I'll
need to investigate further.

michael

-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
