From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: jitter bursts
Date: Sat, 1 Sep 2007 11:15:30 +0200
Message-ID: <20070901091530.GW23573@pengutronix.de>
References: <20070831151727.GT23573@pengutronix.de> <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org,
	Michael Olbrich <m.olbrich@pengutronix.de>,
	kiszka@rts.uni-hannover.de
To: Girish kathalagiri <girish.sk@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:59304 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752738AbXIAJPg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 1 Sep 2007 05:15:36 -0400
Content-Disposition: inline
In-Reply-To: <34ac6d890708310855v413383cm2bd725501a685842@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Aug 31, 2007 at 09:25:08PM +0530, Girish kathalagiri wrote:
> We also had similar problems when where we face these kind of periodic
> jitter. In our case we used Intel 82551ER Fast Ethernet Controller(
> e100 driver). The problem with ours was the  with the microcode (in
> e100.c) of the adapter which had default algorithm where the hardware
> was holding of the interrupts until X packets or Y usecs have expired.
>
> This generated a periodic jitter that was 400-500 us more than the usual one.
> This was solved by making the hardware generate interrupt on every frame.
> In e100.c this can be done by changing the values of INTDELAY,
> BUNDDLEMAX and BUNDDLESMALL (CPU saver parameters)

Sounds good, we'll try that on monday. Although both boxes have e100
network cards, I think Michael has also tested with two other cards. But
we'll recheck.

Robert
-- 
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de
