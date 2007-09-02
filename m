From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: jitter bursts
Date: Sun, 2 Sep 2007 14:05:51 +0200
Message-ID: <20070902120551.GF23573@pengutronix.de>
References: <20070831151727.GT23573@pengutronix.de> <1188579323.4002.1.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:34835 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965529AbXIBMF6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Sep 2007 08:05:58 -0400
Content-Disposition: inline
In-Reply-To: <1188579323.4002.1.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 31, 2007 at 09:55:23AM -0700, Sven-Thorsten Dietrich wrote:
> >  +--------+  +-----------+ +-----------+
> >  | PC EPL |  | Second PC | | EPL Clamp |
> >  +--------+  +-----------+ +-----------+
> >       |            |            |
> >        \     +----------+       /
> >         \----|    Hub   |------/
> >              +----------+
>
> Can you eliminate the hub as a variable?
>
> I have seen very similar experiments with multicast packets where the
> hub delivered packets out of order, or in a delayed fashion on one port,
> but not on the other.

We've tried it with two different hubs (one industrial DIN rail Phoenix
contact model and a standard netgeat one), without changes.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
