From: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Thu, 13 May 2010 19:58:42 +0200
Message-ID: <20100513175842.GN6055@pengutronix.de>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com> <1273680443.27703.33.camel@gandalf.stny.rr.com> <4BEBB1C8.90606@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45941 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab0EMR6n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 13 May 2010 13:58:43 -0400
Content-Disposition: inline
In-Reply-To: <4BEBB1C8.90606@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, May 13, 2010 at 10:01:12AM +0200, Armin Steinhoff wrote:
> I did a test with user space based CAN driver.

The Linux CAN interface is SocketCAN. Do you see a usecase where this
doesn't fit?

> Already the standard distribution of SUSE 11.2 (non RT) was able to
> handle 1000 frames per seconds sent by a QNX6 machine !!

Realtime != fast.

> The latency test of PREEMPT_RT shows a latency of ~10us for a
> dual-core box at 1.8GHz.

It depends on the load.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
