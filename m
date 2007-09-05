From: Michael Olbrich <m.olbrich@pengutronix.de>
Subject: Re: jitter bursts
Date: Wed, 5 Sep 2007 11:01:47 +0200
Message-ID: <20070905090147.GA32165@pengutronix.de>
References: <20070831151727.GT23573@pengutronix.de> <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com> <20070905081402.GA30955@pengutronix.de> <34ac6d890709050136v2b061c76pfb149667faa82617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Schwebel <r.schwebel@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:33252 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756077AbXIEJBt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2007 05:01:49 -0400
Content-Disposition: inline
In-Reply-To: <34ac6d890709050136v2b061c76pfb149667faa82617@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Sep 05, 2007 at 02:06:36PM +0530, Girish kathalagiri wrote:
> > Unfortunately not but it did get me on the right track. The problem is
> > caused by the e100_watchdog function. As far as I can tell e100_watchdog
> > is called from a timer queue and therefore runs with the priority of
> > that thread. And while I set higher priorities for softirq-net-rx and
> > the application I missed the thread for the hardware interrupt of the
> > network interface. So whenever a packet arived while e100_watchdog was
> > running it got delayed. The periodic pattern is a result of this and
> > speed difference of sender and receiver clocks.
> > The jitter is now <50us but still with some periodic patterns. So I'll
> > need to investigate further.
> >
> There was some discussion going on this issue on netdev ....
> The below link might help you.
> http://www.nabble.com/Re%3A-My-vote-against-eepro*-removal-t954330.html#a2532617

Yes that's exactly the issue I've been experiencing. Thanks for the
link.

michael

-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
