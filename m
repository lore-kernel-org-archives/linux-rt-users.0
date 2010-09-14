From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 11:44:11 +0200
Message-ID: <20100914094411.GB10841@pengutronix.de>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <201009141317.13439@zigzag.lvk.cs.msu.su> <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Raz <raziebe@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48887 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943Ab0INJoO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 05:44:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikCwVw9jsg+L_e-kHnhogSdgE+8rrO8O0gDMB5V@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Sep 14, 2010 at 11:24:21AM +0200, Raz wrote:
> anyone can say preempt rt is hard real time?

Hard realtime has something to do with how you define "missing the
deadline". If somebody cuts the cable of your roboter controller in the
factory hall, the system misses the deadline. So it is all about
probabilities: hard realtime systems have a very, very low probability
of missing the deadline. However, in real life systems, it is > 0%.

So yes, if you talk about real world, it is hard realtime.

> anyone knows preempt rt known bugs?

Like every software or every technical system it of course has bugs.

> why is it not mainline yet?

Large parts of the original patches are in the Linux mainline in the
mean time, and the rest is constantly being worked on, in order to bring
them into the official kernel as well.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
