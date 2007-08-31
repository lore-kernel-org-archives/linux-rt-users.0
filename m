From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: jitter bursts
Date: Fri, 31 Aug 2007 09:55:23 -0700
Message-ID: <1188579323.4002.1.camel@sven.thebigcorporation.com>
References: <20070831151727.GT23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: Robert Schwebel <r.schwebel@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([63.240.77.84]:44585 "EHLO
	sccrmhc14.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859AbXIBEMi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Sep 2007 00:12:38 -0400
In-Reply-To: <20070831151727.GT23573@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-31 at 17:17 +0200, Robert Schwebel wrote:
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


Can you eliminate the hub as a variable?

I have seen very similar experiments with multicast packets where the
hub delivered packets out of order, or in a delayed fashion on one port,
but not on the other.

Sven
